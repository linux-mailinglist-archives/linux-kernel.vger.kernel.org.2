Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D84F335E188
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 16:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346438AbhDMObV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 10:31:21 -0400
Received: from mail.efficios.com ([167.114.26.124]:35852 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240161AbhDMO36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 10:29:58 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id E8DE7338DBE;
        Tue, 13 Apr 2021 10:29:38 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id GNMbJvh-04vH; Tue, 13 Apr 2021 10:29:38 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 3A85B33896A;
        Tue, 13 Apr 2021 10:29:38 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 3A85B33896A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1618324178;
        bh=m4g/8wNINmygDT/irkBjPuTYmIdbOKAJYHYYKCHbOPM=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Lf5L3R76i4/gGmSIkDOaQ9esCGWXd9ninp5R4OXRr7KRFOeAoYYnVl+8TKMJKTIwC
         yzOGvpYHax3ZVBi4pgzzmQ6UwRP9xf+AfH27l5JNuWymfGX180itAiayKkswkBua4H
         GZB68FfxgpCNwIWJZGV3qIunGalESpB1iPiTXV80j7l4J4tQ6M7aZP+rd/DNJgy+xD
         DHzp9ADmEsApMroEhqEIc7mkHwVXFV7dl7hD5WkvZd732VRt6RD0g1i+Rk6f7p6VUH
         BNOE8hzIML4eoYYPW9cTAVnn7brgZV5ScX0Q7Xhgx215K+1sPFOnfXXCugarPICows
         1CWK/UNb+yJ4A==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Pk3CEU5SqyVg; Tue, 13 Apr 2021 10:29:38 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 29CB8338DB5;
        Tue, 13 Apr 2021 10:29:38 -0400 (EDT)
Date:   Tue, 13 Apr 2021 10:29:38 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Arjun Roy <arjunroy@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>
Message-ID: <643243714.71310.1618324178021.JavaMail.zimbra@efficios.com>
In-Reply-To: <20210413073657.2308450-2-eric.dumazet@gmail.com>
References: <20210413073657.2308450-1-eric.dumazet@gmail.com> <20210413073657.2308450-2-eric.dumazet@gmail.com>
Subject: Re: [PATCH 1/3] rseq: optimize rseq_update_cpu_id()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF87 (Linux)/8.8.15_GA_4007)
Thread-Topic: rseq: optimize rseq_update_cpu_id()
Thread-Index: Kjhg1JGHu7tmu69Yv80ias0eQDavcg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Apr 13, 2021, at 3:36 AM, Eric Dumazet eric.dumazet@gmail.com wrote:

> From: Eric Dumazet <edumazet@google.com>
> 
> Two put_user() in rseq_update_cpu_id() are replaced
> by a pair of unsafe_put_user() with appropriate surroundings.
> 
> This removes one stac/clac pair on x86 in fast path.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Arjun Roy <arjunroy@google.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> ---
> kernel/rseq.c | 15 +++++++++++----
> 1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/rseq.c b/kernel/rseq.c
> index
> a4f86a9d6937cdfa2f13d1dcc9be863c1943d06f..d2689ccbb132c0fc8ec0924008771e5ee1ca855e
> 100644
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -84,13 +84,20 @@
> static int rseq_update_cpu_id(struct task_struct *t)
> {
> 	u32 cpu_id = raw_smp_processor_id();
> +	struct rseq *r = t->rseq;

AFAIU the variable above should be a struct rseq __user *.

Elsewhere in the file we use "rseq" rather than "r" for struct rseq __user *
variable name, it would be better to keep the naming consistent across the file
if possible.

Thanks,

Mathieu

> 
> -	if (put_user(cpu_id, &t->rseq->cpu_id_start))
> -		return -EFAULT;
> -	if (put_user(cpu_id, &t->rseq->cpu_id))
> -		return -EFAULT;
> +	if (!user_write_access_begin(r, sizeof(*r)))
> +		goto efault;
> +	unsafe_put_user(cpu_id, &r->cpu_id_start, efault_end);
> +	unsafe_put_user(cpu_id, &r->cpu_id, efault_end);
> +	user_write_access_end();
> 	trace_rseq_update(t);
> 	return 0;
> +
> +efault_end:
> +	user_write_access_end();
> +efault:
> +	return -EFAULT;
> }
> 
> static int rseq_reset_rseq_cpu_id(struct task_struct *t)
> --
> 2.31.1.295.g9ea45b61b8-goog

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
