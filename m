Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4433BE633
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 12:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhGGKPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 06:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhGGKPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 06:15:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19788C061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 03:12:54 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625652767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e3T0vy5Ozkp7gou1cPpGjvAJK9fzQXPbfdcBROxPKxA=;
        b=xXYMVZfGgYYm7sqnyWibSfkPVgm1DANzxwcOLpugxB/GY+Q1GABWzyviykSFP672W2BYmU
        s7xPaWJAmy9uSE3weKTJgEm0VVoxo7JdMOkvpFr3c56lTWiiA6PcjZYXJmiO8WGMhrk3+M
        guaroZJKOLY/wsJ2m95h2wto2ngBDhL1upmaXpbZWkJ6LmuW+ECAzNwyLNvKNBgOMv0IK4
        Ee6hcr0oe4OAvnMb6dhLK2/wjZoGqzMqwiHpVt0Ef0APOuqZ92vuV9RFSrJfNXmpJ1ZXWJ
        AJTjfQEaOXSdvXQPC7nHFlKTNXLsoFOZfg+RCwSarBh/W/S3uZTTeThUkPCzMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625652767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e3T0vy5Ozkp7gou1cPpGjvAJK9fzQXPbfdcBROxPKxA=;
        b=h8ucLeinHi6MttnAUyjFlvOqy7IfC6AM3/dvSrT6twTqmOiJHgwBx6VfKwuRlqAUyXK7cb
        dWg3jY5nk8YCpyDg==
To:     Ani Sinha <ani@anisinha.ca>, linux-kernel@vger.kernel.org
Cc:     anirban.sinha@nokia.com, Ani Sinha <ani@anisinha.ca>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH v1] Print a log when the sched clock is marked unstable
In-Reply-To: <20210627064911.2179786-1-ani@anisinha.ca>
References: <20210627064911.2179786-1-ani@anisinha.ca>
Date:   Wed, 07 Jul 2021 12:12:46 +0200
Message-ID: <8735sqqvoh.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ani,

On Sun, Jun 27 2021 at 12:19, Ani Sinha wrote:

I asked you to read Documentation/process carefully and I told you:

        Also your subject line want's a proper prefix.

Your patch is missing a prefix again. Hint:

  git log kernel/sched/clock.c

> In other parts of the kernel when the sched clock transitions from
> stable to unstable and vice versa, a kernel info log is printed.  When
> the sched clock is marked explicitly as unstable, we should print an
> information log as well. This patch addresses this. It is useful in

git grep 'This patch' Documentation/process/

Also please avoid the 'we' wording. 'We should print' does not make
sense if you really think about it.

> cases where for example, we want to understand why a certain feature
> like NOHZ, which depends on a stable sched clock, is not available.
>
> Signed-off-by: Ani Sinha <ani@anisinha.ca>
> ---
>  kernel/sched/clock.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> See also thread
> https://lkml.org/lkml/2021/6/20/32
>
> diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
> index c2b2859ddd82..5a403b2c9b3f 100644
> --- a/kernel/sched/clock.c
> +++ b/kernel/sched/clock.c
> @@ -192,8 +192,10 @@ void clear_sched_clock_stable(void)
>  
>  	smp_mb(); /* matches sched_clock_init_late() */
>  
> -	if (static_key_count(&sched_clock_running.key) == 2)
> +	if (static_key_count(&sched_clock_running.key) == 2) {
> +		pr_info("sched_clock: Marking unstable.\n");
>  		__clear_sched_clock_stable();

Why isn't that in __clear_sched_clock_stable() ?

Thanks,

        tglx
