Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2CF3362328
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241947AbhDPOwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:52:44 -0400
Received: from mail.efficios.com ([167.114.26.124]:46056 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233916AbhDPOwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:52:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id E134C337C33;
        Fri, 16 Apr 2021 10:52:17 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id UbIckL3755HT; Fri, 16 Apr 2021 10:52:16 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id D6B0C337D2E;
        Fri, 16 Apr 2021 10:52:16 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com D6B0C337D2E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1618584736;
        bh=g0ai6snWg1lDRvmE/hHbxe1m+3pDLWhw8fngE/SLcKA=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=CseBk2MS2SPiUiyncAdh1UtyCTA2lF77Ob7wmxRKkDq02ohqOZzvEnzu+OgVzLyAW
         K22Yd/JgnlOJVPejDFn9MUFXpsdEcO4pnm1sqCs2tFR1srTCFPvWwhBohRR2ihsxmp
         0uXUsoxoOfkJLsqdky2h9lvdZ3wdWh/YP5E/wzc4HxmCVtv+kZIziHlzPj/z1wKJ2z
         p3o5ga+WFCLYFFW7HgkxGKue7aQlZ72USRxcm1AczWxkM5JcoPpUirFPaBaIvoq+xF
         CwVcV4G0buNIPMYTW++01XsVuxeqkcKRhUXsTAb8iIEwWn5nFtB+VYk5qn2wOXqvzW
         2HEYR/l3Zo0PA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id XPTxFdlzpXms; Fri, 16 Apr 2021 10:52:16 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id C6F9B337AF7;
        Fri, 16 Apr 2021 10:52:16 -0400 (EDT)
Date:   Fri, 16 Apr 2021 10:52:16 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     paulmck <paulmck@kernel.org>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        lttng-dev <lttng-dev@lists.lttng.org>
Message-ID: <1680415903.81652.1618584736742.JavaMail.zimbra@efficios.com>
Subject: liburcu: LTO breaking rcu_dereference on arm64 and possibly other
 architectures ?
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF87 (Linux)/8.8.15_GA_4007)
Thread-Index: WQ3F/UwlNJdCRe7pLcscx5UrzpNaiw==
Thread-Topic: liburcu: LTO breaking rcu_dereference on arm64 and possibly other architectures ?
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul, Will, Peter,

I noticed in this discussion https://lkml.org/lkml/2021/4/16/118 that LTO
is able to break rcu_dereference. This seems to be taken care of by
arch/arm64/include/asm/rwonce.h on arm64 in the Linux kernel tree.

In the liburcu user-space library, we have this comment near rcu_dereference() in
include/urcu/static/pointer.h:

 * The compiler memory barrier in CMM_LOAD_SHARED() ensures that value-speculative
 * optimizations (e.g. VSS: Value Speculation Scheduling) does not perform the
 * data read before the pointer read by speculating the value of the pointer.
 * Correct ordering is ensured because the pointer is read as a volatile access.
 * This acts as a global side-effect operation, which forbids reordering of
 * dependent memory operations. Note that such concern about dependency-breaking
 * optimizations will eventually be taken care of by the "memory_order_consume"
 * addition to forthcoming C++ standard.

(note: CMM_LOAD_SHARED() is the equivalent of READ_ONCE(), but was introduced in
liburcu as a public API before READ_ONCE() existed in the Linux kernel)

Peter tells me the "memory_order_consume" is not something which can be used today.
Any information on its status at C/C++ standard levels and implementation-wise ?

Pragmatically speaking, what should we change in liburcu to ensure we don't generate
broken code when LTO is enabled ? I suspect there are a few options here:

1) Fail to build if LTO is enabled,
2) Generate slower code for rcu_dereference, either on all architectures or only
   on weakly-ordered architectures,
3) Generate different code depending on whether LTO is enabled or not. AFAIU this would only
   work if every compile unit is aware that it will end up being optimized with LTO. Not sure
   how this could be done in the context of user-space.
4) [ Insert better idea here. ]

Thoughts ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
