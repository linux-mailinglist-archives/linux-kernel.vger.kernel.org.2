Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9F038111D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 21:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbhENTyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 15:54:01 -0400
Received: from mail.efficios.com ([167.114.26.124]:34460 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbhENTyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 15:54:00 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 4C77E2B81CE;
        Fri, 14 May 2021 15:52:48 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id S2ANtn8JU_DC; Fri, 14 May 2021 15:52:47 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id D27E02B81CD;
        Fri, 14 May 2021 15:52:47 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com D27E02B81CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1621021967;
        bh=aCGMeRffw29+0q9FT8t+w01O6x8nGzRb1Pl30xP7c7g=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=NWTtqRyn6M/5V/fPEUlfK3ihRCJc27ljfUaqTkmJFuiMm07mqZpOp8SqpSY4/XA+s
         /rQpq3GtIYeLKKuRLBeilTfAivkZnWXn8LEzib03dx+wX+DVwmy2cfz7J3umQANSb4
         CHzcwuPFdF14pgCqXutZ9s+l6/e8HPI15e/Mm/hCbS11sBg2pPbUEkfSaGY6kwPlmr
         oJ8UD1VpaskgOu8iK4XwA8fe+/9q3lhO5xDrzi6D9uq6Heu2hq20/VHiJxtznw77JM
         aFDoliBJgxoSWcvfp54Ugp8bbGXnS2VEVoM6C9BoCdFLCXwj4VhiNbEtUT7pUIWQ0z
         36iD5eg+oROjg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YQ5j_0FY7UXp; Fri, 14 May 2021 15:52:47 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id C52D22B81CC;
        Fri, 14 May 2021 15:52:47 -0400 (EDT)
Date:   Fri, 14 May 2021 15:52:47 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     lttng-dev@lists.lttng.org,
        diamon-discuss@lists.linuxfoundation.org,
        linux-trace-users@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <1336422991.46023.1621021967687.JavaMail.zimbra@efficios.com>
Subject: [RELEASE] LTTng-modules 2.11.9 and 2.12.6 (Linux kernel tracer)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - FF88 (Linux)/8.8.15_GA_4007)
Thread-Index: 7GWFwXFXkLY7KtGgWu1JPUyXPl1Bvg==
Thread-Topic: LTTng-modules 2.11.9 and 2.12.6 (Linux kernel tracer)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The 2.11.9 and 2.12.6 releases of the LTTng kernel tracer are the latest bug fix releases
of the 2.11 and 2.12 stable branches of the LTTng modules project.

There are a few minor bug fixes, but those are the noteworthy changes:

- Support for 5.12 Linux kernels,
- Support recent stable kernel branches 4.14, 4.19, 5.4,
- Support for newer Ubuntu 4.15, 5.4 and RHEL 8.2/8.3 kernels,
- Fix: increment buffer offset when failing to copy from user-space:

    Upon failure to copy from user-space due to failing access ok check, the
    ring buffer offset is not incremented, which could generate unreadable
    traces because we don't account for the padding we write into the ring
    buffer.
    
    Note that this typically won't affect a common use-case of copying
    strings from user-space, because unless mprotect is invoked within a
    narrow race window (between user strlen and user strcpy), the strlen
    will fail on access ok when calculating the space to reserve, which will
    match what happens on strcpy.

Thanks,

Mathieu

Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
