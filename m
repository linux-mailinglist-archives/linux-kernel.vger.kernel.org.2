Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 974D6364B3C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 22:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237827AbhDSUjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 16:39:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55764 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232217AbhDSUjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 16:39:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618864741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jFcfADdReYDV23uSItauKX3LP1+td5MJJyNjkvs+t+E=;
        b=d2jy4XdzOQMsHaN+DVyMWoaGVbu9RAzC3Ru0FISb1VhgL2UQ1sELP1bAvsDWVFyISj4KAa
        cYAZXZi4RwakQWI5cK3bPiBh/0V+kO/S1snSWiz279ZSD7iKlo79jCGn1zqFxv3l66ZslP
        5ybuSBmxfToI53iqhYoU5J6vuyQWMSY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-34uGC0NWOyCVNRA477tCUw-1; Mon, 19 Apr 2021 16:38:59 -0400
X-MC-Unique: 34uGC0NWOyCVNRA477tCUw-1
Received: by mail-qk1-f197.google.com with SMTP id g184-20020a3784c10000b02902e385de9adaso5159313qkd.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 13:38:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jFcfADdReYDV23uSItauKX3LP1+td5MJJyNjkvs+t+E=;
        b=a4PB3PlCNDjaD52LLMlCwsUfN9dUrnVCNI/NvDNl0YmLVVlLOElAVvG5KsJvplg2uw
         rdyeW3BD29dIGd1/GGmj2Mwblsoww/nh74+2D3Ax6NHf+2Ubr/tmXgqK5Os8CFh70Owi
         qR0+QZnielmhi378qyI0rw1j0ggffNIR0ET7dueqeOPZWOJ5xcFTz59DMQu060bJQCT2
         u6lbg5T+b48EYNrJJSLWWgRFZ41UN1fY0FxR7BpT+S2K7LIWRwsV9K4q1CaTbmyphEf4
         WogCZcs7LKKdhteqL5Up+dNpxxAUgJ4X1PaYvHD5mxusSW1XXOFOU3AwtInarHEdycw9
         hcFw==
X-Gm-Message-State: AOAM532n3GWfzo6vYwIcNUSrKYpbGMMO9dWo8l1FM8yZ/s3jwK+vTnpP
        QGqnsjTs1cHvr0RjFJpn1FG4jBGyhB2TXJhQR6jLQBPscpXopetQyzzNLRlPoD0gdwIVuKL6rgS
        IVDiDF0gH735pOTy+qfq40ajA
X-Received: by 2002:ac8:109a:: with SMTP id a26mr13180000qtj.156.1618864738303;
        Mon, 19 Apr 2021 13:38:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxBJ+RukPJ+xxSlK13BEkXFvWbrPpBhhl0uJoo2T7kzfbUf2TmhEGQM/znsYA8ca4LP/ew1VA==
X-Received: by 2002:ac8:109a:: with SMTP id a26mr13179972qtj.156.1618864738015;
        Mon, 19 Apr 2021 13:38:58 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-88-174-93-75-154.dsl.bell.ca. [174.93.75.154])
        by smtp.gmail.com with ESMTPSA id m2sm10622082qkc.14.2021.04.19.13.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 13:38:57 -0700 (PDT)
Date:   Mon, 19 Apr 2021 16:38:55 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH] sched/isolation: don't do unbounded chomp on bootarg
 string
Message-ID: <20210419203855.GX4440@xz-x1>
References: <20210418215426.1086941-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210418215426.1086941-1-paul.gortmaker@windriver.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 18, 2021 at 05:54:26PM -0400, Paul Gortmaker wrote:
> After commit 3662daf02350 ("sched/isolation: Allow "isolcpus=" to skip
> unknown sub-parameters") the isolcpus= string is walked to skip over what
> might be any future flag comma separated additions.
> 
> However, there is a logic error, and so as can clearly be seen below, it
> will ignore its own arg len and search to the end of the bootarg string.
> 
>  $ dmesg|grep isol
>  Command line: BOOT_IMAGE=/boot/bzImage isolcpus=xyz pleasedontparseme=1 root=/dev/sda1 ro
>  isolcpus: Skipped unknown flag xyz
>  isolcpus: Invalid flag pleasedontparseme=1 root=/dev/sda1 ro
> 
> This happens because the flag "skip" code does an unconditional
> increment, which skips over the '\0' check the loop body looks for. If
> the isolcpus= happens to be the last bootarg, then you'd never notice?
> 
> So we only increment if the skipped flag is followed by a comma, as per
> what the existing "continue" flag matching code does.
> 
> Note that isolcpus= was declared deprecated as of v4.15 (b0d40d2b22fe),
> so we might want to revisit that if we are trying to future-proof it
> as recently as a year ago for as yet unseen new flags.

Thanks for report the issue.

Is cpuset going to totally replace "isolcpus="?  It seems most hk_flags will be
handled by nohz_full=, and HK_FLAG_DOMAIN can be done by cpuset.  However it
seems still the only place to set the new flag HK_FLAG_MANAGED_IRQ.  If one day
we'll finally obsolete isolcpus= we may need to think about where to put it?

When I looked at it, I also noticed I see no caller to set HK_FLAG_SCHED at
all.  Is it really used anywhere?

Regarding this patch...

> 
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Fixes: 3662daf02350 ("sched/isolation: Allow "isolcpus=" to skip unknown sub-parameters")
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> 
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index 5a6ea03f9882..9652dba7e938 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -188,7 +188,8 @@ static int __init housekeeping_isolcpus_setup(char *str)
>  		}
>  
>  		pr_info("isolcpus: Skipped unknown flag %.*s\n", len, par);
> -		str++;
> +		if (str[1] == ',')	/* above continue; match on "flag," */

.. wondering why it is not "str[0] == ','" instead?

Thanks,

> +			str++;
>  	}
>  
>  	/* Default behaviour for isolcpus without flags */
> -- 
> 2.25.1
> 

-- 
Peter Xu

