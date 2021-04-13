Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 311F835E1AC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 16:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343861AbhDMOfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 10:35:02 -0400
Received: from mail.efficios.com ([167.114.26.124]:38176 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239584AbhDMOen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 10:34:43 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 696AC338DCD;
        Tue, 13 Apr 2021 10:34:23 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 8qyx6gKrlPMl; Tue, 13 Apr 2021 10:34:22 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 18875338DCC;
        Tue, 13 Apr 2021 10:34:22 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 18875338DCC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1618324462;
        bh=hc8m6wpSE2+B61sL0/f4cUKx6jMuXKRnIXtHUW2VmxU=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=bVeTi3jz+VX/HIEAAXDhqYkdcrJai9iyYvVXqitGKMCm9cWD0eLqtGxcWYmWHJGCu
         5I9keDORpnAPrR55vBPmIRcY6dVpBGtpjQx4uts3H5uwDv9ro0op7IF1jD+1OBHu5h
         fHbqNbdK/icrDtmDgr8OvaOZyOOMDHzzuDXp0Orb6rnEL3lUNa4embv9IrnqdlyViL
         yZdciRXZIGU9C7pv532VDv2/bTvy4wnRrm7RF1e1G/+rGFjswnV0C3dzAJVxAsEfhB
         OnrJTgPB4uq0ui8EA1tfqbtnNbDfBejncXDpwC7YGT+5K2WMdX6UG1hizPp8igGFTD
         wNzwQIpmiwKoQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vxF9vAXLhUX6; Tue, 13 Apr 2021 10:34:22 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 0988F338E1F;
        Tue, 13 Apr 2021 10:34:22 -0400 (EDT)
Date:   Tue, 13 Apr 2021 10:34:21 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Arjun Roy <arjunroy@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>
Message-ID: <1578770214.71411.1618324461988.JavaMail.zimbra@efficios.com>
In-Reply-To: <20210413073657.2308450-3-eric.dumazet@gmail.com>
References: <20210413073657.2308450-1-eric.dumazet@gmail.com> <20210413073657.2308450-3-eric.dumazet@gmail.com>
Subject: Re: [PATCH 2/3] rseq: remove redundant access_ok()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF87 (Linux)/8.8.15_GA_4007)
Thread-Topic: rseq: remove redundant access_ok()
Thread-Index: pBoSJiVP0zhPstQas4t/3NbUqJRJSA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 13, 2021, at 3:36 AM, Eric Dumazet eric.dumazet@gmail.com wrote:

> From: Eric Dumazet <edumazet@google.com>
> 
> After commit 8f2817701492 ("rseq: Use get_user/put_user rather
> than __get_user/__put_user") we no longer need
> an access_ok() call from __rseq_handle_notify_resume()

While we are doing that, should we also remove the access_ok() check in
rseq_syscall() ? It look like it can also be removed for the exact same
reason outlined here.

Thanks,

Mathieu

> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Arjun Roy <arjunroy@google.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> ---
> kernel/rseq.c | 2 --
> 1 file changed, 2 deletions(-)
> 
> diff --git a/kernel/rseq.c b/kernel/rseq.c
> index
> d2689ccbb132c0fc8ec0924008771e5ee1ca855e..57344f9abb43905c7dd2b6081205ff508d963e1e
> 100644
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -273,8 +273,6 @@ void __rseq_handle_notify_resume(struct ksignal *ksig,
> struct pt_regs *regs)
> 
> 	if (unlikely(t->flags & PF_EXITING))
> 		return;
> -	if (unlikely(!access_ok(t->rseq, sizeof(*t->rseq))))
> -		goto error;
> 	ret = rseq_ip_fixup(regs);
> 	if (unlikely(ret < 0))
> 		goto error;
> --
> 2.31.1.295.g9ea45b61b8-goog

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
