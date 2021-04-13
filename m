Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0988D35E467
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 18:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346928AbhDMQzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 12:55:08 -0400
Received: from mail.efficios.com ([167.114.26.124]:55802 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbhDMQzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 12:55:07 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 402BC339BE6;
        Tue, 13 Apr 2021 12:54:47 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id WSEUydMmTHtt; Tue, 13 Apr 2021 12:54:45 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 8E3A6339C74;
        Tue, 13 Apr 2021 12:54:45 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 8E3A6339C74
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1618332885;
        bh=19r8E9l+nNtb+foE6hIEANruyXZGmyX4i3IECUfrxmA=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=RW0dSyPNY1QcYmrJPeU/gBXpB2gWJMXEPomOS+fZ7aeBnqK8X6TN9Ct0I7rdv8zVf
         Mth1fRxgMrHYZnzLbbRFikbUw8lh4p4vcJgvCWJOuB7uy/faxowNBwAqg4J1qm7X7V
         YqYfDHtJvbn8Ms0ZHWxqh430qhXm9ja07TB08fCx5Xp698cjp5XvmDtz/XN01ux6pd
         XfHHRt+NDYVXfAwLjO32rm998j8TTzFYTCxbbV6kfT+3PyB3Ra7B1smWZcvsiivr1C
         1duLm5QvRnrIaEcN1CQE0JSo5vUxMiAkCIC0C1n1oWWdy/lzAI44zTgs3C2BMSZozO
         7CdxoFve70DYA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0Oz4F5x51s9S; Tue, 13 Apr 2021 12:54:45 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 7B540339DB2;
        Tue, 13 Apr 2021 12:54:45 -0400 (EDT)
Date:   Tue, 13 Apr 2021 12:54:45 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Eric Dumazet <eric.dumazet@gmail.com>,
        David Laight <David.Laight@ACULAB.COM>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Arjun Roy <arjunroy@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>
Message-ID: <567941475.72456.1618332885342.JavaMail.zimbra@efficios.com>
In-Reply-To: <20210413162240.3131033-4-eric.dumazet@gmail.com>
References: <20210413162240.3131033-1-eric.dumazet@gmail.com> <20210413162240.3131033-4-eric.dumazet@gmail.com>
Subject: Re: [PATCH v2 3/3] rseq: optimise rseq_get_rseq_cs() and
 clear_rseq_cs()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF87 (Linux)/8.8.15_GA_4007)
Thread-Topic: rseq: optimise rseq_get_rseq_cs() and clear_rseq_cs()
Thread-Index: W0pbtVW2B+w+tUTMTDDH34Aw1yg2aQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 13, 2021, at 12:22 PM, Eric Dumazet eric.dumazet@gmail.com wrote:

> From: Eric Dumazet <edumazet@google.com>
> 
> Commit ec9c82e03a74 ("rseq: uapi: Declare rseq_cs field as union,
> update includes") added regressions for our servers.
> 
> Using copy_from_user() and clear_user() for 64bit values
> is suboptimal.
> 
> We can use faster put_user() and get_user().
> 
> 32bit arches can be changed to use the ptr32 field,
> since the padding field must always be zero.
> 
> v2: added ideas from Peter and Mathieu about making this
>    generic, since my initial patch was only dealing with
>    64bit arches.

Ah, now I remember the reason why reading and clearing the entire 64-bit
is important: it's because we don't want to allow user-space processes to
use this change in behavior to figure out whether they are running on a
32-bit or in a 32-bit compat mode on a 64-bit kernel.

So although I'm fine with making 64-bit kernels faster, we'll want to keep
updating the entire 64-bit ptr field on 32-bit kernels as well.

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
> kernel/rseq.c | 41 +++++++++++++++++++++++++++++++++--------
> 1 file changed, 33 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/rseq.c b/kernel/rseq.c
> index
> cfe01ab5253c1c424c0e8b25acbb6a8e1b41a5b6..f2eee3f7f5d330688c81cb2e57d47ca6b843873e
> 100644
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -119,23 +119,46 @@ static int rseq_reset_rseq_cpu_id(struct task_struct *t)
> 	return 0;
> }
> 
> +#ifdef CONFIG_64BIT
> +static int rseq_get_cs_ptr(struct rseq_cs __user **uptrp,
> +			   const struct rseq __user *rseq)
> +{
> +	u64 ptr;
> +
> +	if (get_user(ptr, &rseq->rseq_cs.ptr64))
> +		return -EFAULT;
> +	*uptrp = (struct rseq_cs __user *)ptr;
> +	return 0;
> +}
> +#else
> +static int rseq_get_cs_ptr(struct rseq_cs __user **uptrp,
> +			   const struct rseq __user *rseq)
> +{
> +	u32 ptr;
> +
> +	if (get_user(ptr, &rseq->rseq_cs.ptr.ptr32))
> +		return -EFAULT;
> +	*uptrp = (struct rseq_cs __user *)ptr;
> +	return 0;
> +}
> +#endif
> +
> static int rseq_get_rseq_cs(struct task_struct *t, struct rseq_cs *rseq_cs)
> {
> 	struct rseq_cs __user *urseq_cs;
> -	u64 ptr;
> 	u32 __user *usig;
> 	u32 sig;
> 	int ret;
> 
> -	if (copy_from_user(&ptr, &t->rseq->rseq_cs.ptr64, sizeof(ptr)))
> +	if (rseq_get_cs_ptr(&urseq_cs, t->rseq))
> 		return -EFAULT;
> -	if (!ptr) {
> +	if (!urseq_cs) {
> 		memset(rseq_cs, 0, sizeof(*rseq_cs));
> 		return 0;
> 	}
> -	if (ptr >= TASK_SIZE)
> +	if ((unsigned long)urseq_cs >= TASK_SIZE)
> 		return -EINVAL;
> -	urseq_cs = (struct rseq_cs __user *)(unsigned long)ptr;
> +
> 	if (copy_from_user(rseq_cs, urseq_cs, sizeof(*rseq_cs)))
> 		return -EFAULT;
> 
> @@ -211,9 +234,11 @@ static int clear_rseq_cs(struct task_struct *t)
> 	 *
> 	 * Set rseq_cs to NULL.
> 	 */
> -	if (clear_user(&t->rseq->rseq_cs.ptr64, sizeof(t->rseq->rseq_cs.ptr64)))
> -		return -EFAULT;
> -	return 0;
> +#ifdef CONFIG_64BIT
> +	return put_user(0UL, &t->rseq->rseq_cs.ptr64);
> +#else
> +	return put_user(0UL, &t->rseq->rseq_cs.ptr.ptr32);
> +#endif
> }
> 
> /*
> --
> 2.31.1.295.g9ea45b61b8-goog

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
