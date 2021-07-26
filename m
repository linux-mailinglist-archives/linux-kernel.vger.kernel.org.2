Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F8A3D646C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 18:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239808AbhGZP6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 11:58:15 -0400
Received: from mail.efficios.com ([167.114.26.124]:51300 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238907AbhGZPrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 11:47:53 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id B4FBF307BCA;
        Mon, 26 Jul 2021 12:28:21 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id TanED9noy71Y; Mon, 26 Jul 2021 12:28:20 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 72DE7307F1D;
        Mon, 26 Jul 2021 12:28:20 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 72DE7307F1D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1627316900;
        bh=eXIl1sJc07bWbXlDszc1Jt9Q7njYaYD3DWYUoFLXtfM=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=nXxwf0TBn7n73J0eGt1iSA/bilN6B9GMX8buP6YgXxv1aYlUaITnLzFbKXabfbgGb
         AWJ/zBUiflonUhYrRYFoSJAF3LDPxwo9LWCu8IE0pvuf1cbp9g//hduj8rec+Rnt9W
         Xi6SUWtUdoYtyCFuBv0oDqIimjEK1wKjtMwedmc30mkCz6NRNbWrZ8rhrdBgbm2DYr
         JyCaPX+vvH+yjEcoJ23o2zMzbqv4KzhWbw4HNhsEkkUb5Mt/XpKLOwEq1/6IubR81t
         RiOXq1tF4fvOWea2kR4VhkqS63S4txdOiFBzbotj7TIQuf8XCjNJVRcWGKGawQSHCi
         trYU4jojOsdGg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JGv5rfZBMZfS; Mon, 26 Jul 2021 12:28:20 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 661AF307B64;
        Mon, 26 Jul 2021 12:28:20 -0400 (EDT)
Date:   Mon, 26 Jul 2021 12:28:20 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Guo Ren <guoren@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-csky@vger.kernel.org
Message-ID: <2070284546.6496.1627316900287.JavaMail.zimbra@efficios.com>
In-Reply-To: <CAJF2gTR9_SzAm2kPXyP+xJDVmdvM=XSm7kJn_eNq-wQmhLqTeg@mail.gmail.com>
References: <20210723161600.19688-1-mathieu.desnoyers@efficios.com> <20210723161600.19688-2-mathieu.desnoyers@efficios.com> <CAJF2gTR9_SzAm2kPXyP+xJDVmdvM=XSm7kJn_eNq-wQmhLqTeg@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] Revert "csky: Add support for restartable
 sequence"
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4059 (ZimbraWebClient - FF90 (Linux)/8.8.15_GA_4059)
Thread-Topic: Revert "csky: Add support for restartable sequence"
Thread-Index: cGqphh5zwS0KS34HbGuSoLaovrzIqA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jul 26, 2021, at 12:10 PM, Guo Ren guoren@kernel.org wrote:

> Hi Mathieu,
> 
> Sorry for forgetting to CC you in the last patch, and that patch has
> been merged into master which has the problem of syscall restart.
> 
> I still want to keep rseq feature for csky, and implement the
> RSEQ_SKIP_FASTPATH for self-test, it that okay?

No, the RSEQ_SKIP_FASTPATH is the one special-case of test build which
skips building rseq critical sections entirely. This leaves out any
relevant testing of rseq per-se. With what we have in the upstream
selftests, I expect this test configuration to abort at runtime because
no slow-path fallbacks are available when the fastpath is disabled.

The asm glue to test rseq user-space really needs to be implemented
for any useful testing to be done here.

Unless that asm glue is contributed, none of the rseq logic is actually
tested on that architecture.

Considering the extremely-hard-to-debug nature of races with a broken
rseq kernel implementation, proper testing coverage is paramount, so I
still recommend the revert unless the selftests user-space asm glue is
contributed for C-Sky.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
