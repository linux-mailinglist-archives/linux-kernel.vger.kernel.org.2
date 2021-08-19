Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 045503F21C2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 22:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235210AbhHSUrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 16:47:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:45154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230052AbhHSUrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 16:47:39 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F0866108E;
        Thu, 19 Aug 2021 20:47:01 +0000 (UTC)
Date:   Thu, 19 Aug 2021 16:46:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     penguin-kernel@I-love.SAKURA.ne.jp, tglx@linutronix.de,
        linux-kernel@vger.kernel.org,
        syzbot+e68c89a9510c159d9684@syzkaller.appspotmail.com,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] profiling: fix shift-out-of-bounds bugs
Message-ID: <20210819164655.6efe096b@oasis.local.home>
In-Reply-To: <20210813140022.5011-1-paskripkin@gmail.com>
References: <99b9e091-9e95-5e45-5914-38a938840aa6@i-love.sakura.ne.jp>
        <20210813140022.5011-1-paskripkin@gmail.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Who's taking this patch? Or should Andrew just take it through his tree?

-- Steve


On Fri, 13 Aug 2021 17:00:22 +0300
Pavel Skripkin <paskripkin@gmail.com> wrote:

> Syzbot reported shift-out-of-bounds bug in profile_init().
> The problem was in incorrect prof_shift. Since prof_shift value comes from
> userspace we need to clamp this value into [0, BITS_PER_LONG -1]
> boundaries.
> 
> Second possible shiht-out-of-bounds was found by Tetsuo:
> sample_step local variable in read_profile() had "unsigned int" type,
> but prof_shift allows to make a BITS_PER_LONG shift. So, to prevent
> possible shiht-out-of-bounds sample_step type was changed to
> "unsigned long".
> 
> Also, "unsigned short int" will be sufficient for storing
> [0, BITS_PER_LONG] value, that's why there is no need for
> "unsigned long" prof_shift.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-and-tested-by: syzbot+e68c89a9510c159d9684@syzkaller.appspotmail.com
> Suggested-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> ---
> 
> Changes in v2:
> 	1. Fixed possible shiht-out-of-bounds in read_profile()
> 	   (Reported by Tetsuo)
> 
> 	2. Changed prof_shift type from "unsigned long" to
> 	   "unsigned short int"
> 
> ---
>  kernel/profile.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/profile.c b/kernel/profile.c
> index c2ebddb5e974..eb9c7f0f5ac5 100644
> --- a/kernel/profile.c
> +++ b/kernel/profile.c
> @@ -41,7 +41,8 @@ struct profile_hit {
>  #define NR_PROFILE_GRP		(NR_PROFILE_HIT/PROFILE_GRPSZ)
>  
>  static atomic_t *prof_buffer;
> -static unsigned long prof_len, prof_shift;
> +static unsigned long prof_len;
> +static unsigned short int prof_shift;
>  
>  int prof_on __read_mostly;
>  EXPORT_SYMBOL_GPL(prof_on);
> @@ -67,8 +68,8 @@ int profile_setup(char *str)
>  		if (str[strlen(sleepstr)] == ',')
>  			str += strlen(sleepstr) + 1;
>  		if (get_option(&str, &par))
> -			prof_shift = par;
> -		pr_info("kernel sleep profiling enabled (shift: %ld)\n",
> +			prof_shift = clamp(par, 0, BITS_PER_LONG - 1);
> +		pr_info("kernel sleep profiling enabled (shift: %u)\n",
>  			prof_shift);
>  #else
>  		pr_warn("kernel sleep profiling requires CONFIG_SCHEDSTATS\n");
> @@ -78,21 +79,21 @@ int profile_setup(char *str)
>  		if (str[strlen(schedstr)] == ',')
>  			str += strlen(schedstr) + 1;
>  		if (get_option(&str, &par))
> -			prof_shift = par;
> -		pr_info("kernel schedule profiling enabled (shift: %ld)\n",
> +			prof_shift = clamp(par, 0, BITS_PER_LONG - 1);
> +		pr_info("kernel schedule profiling enabled (shift: %u)\n",
>  			prof_shift);
>  	} else if (!strncmp(str, kvmstr, strlen(kvmstr))) {
>  		prof_on = KVM_PROFILING;
>  		if (str[strlen(kvmstr)] == ',')
>  			str += strlen(kvmstr) + 1;
>  		if (get_option(&str, &par))
> -			prof_shift = par;
> -		pr_info("kernel KVM profiling enabled (shift: %ld)\n",
> +			prof_shift = clamp(par, 0, BITS_PER_LONG - 1);
> +		pr_info("kernel KVM profiling enabled (shift: %u)\n",
>  			prof_shift);
>  	} else if (get_option(&str, &par)) {
> -		prof_shift = par;
> +		prof_shift = clamp(par, 0, BITS_PER_LONG - 1);
>  		prof_on = CPU_PROFILING;
> -		pr_info("kernel profiling enabled (shift: %ld)\n",
> +		pr_info("kernel profiling enabled (shift: %u)\n",
>  			prof_shift);
>  	}
>  	return 1;
> @@ -468,7 +469,7 @@ read_profile(struct file *file, char __user *buf, size_t count, loff_t *ppos)
>  	unsigned long p = *ppos;
>  	ssize_t read;
>  	char *pnt;
> -	unsigned int sample_step = 1 << prof_shift;
> +	unsigned long sample_step = 1UL << prof_shift;
>  
>  	profile_flip_buffers();
>  	if (p >= (prof_len+1)*sizeof(unsigned int))

