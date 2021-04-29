Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC3D36EA5D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 14:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236987AbhD2M06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 08:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234420AbhD2M05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 08:26:57 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9B2C06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 05:26:10 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id 10so3431837pfl.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 05:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DueM+S7Cf9EcplpCOQeY2DJIq6t19YVLSv6LlqGC5Ng=;
        b=cuZHu6tQwOg4DOHIJas2OAaXvxbmBbNao7PgRsI96JUV3QLyBFzl0qgFurZmaghPTd
         dzhWAXsRyWXnjv6BAkrgj3iSLxJEimgpGeW47j4K/EJga+T7RVbJGMtOS1mDvXqcexxu
         6UBbkCEiwvdW454LIbFYcFvZSADrG1znrNfMXtHS/ix9FU1pnrULwVrz8uS+0+Q+qjwq
         PgUM8tW2N0fr/20UBNn7CmgYS6/PhrAJjZCBaK+wYcQIlygNlvKa1SuZ4diC8+/HFQEA
         TAapkmmp7fGaIaU+wlvWfogJvaXuOHVixc6eyOxjYdCzED4OaXtyi45QdxB9izAuAS+9
         smwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DueM+S7Cf9EcplpCOQeY2DJIq6t19YVLSv6LlqGC5Ng=;
        b=XYj/6kRX9yq7ozBpXcvMQHqQXJfiAIe2qd1EJ3MfELWG4Avs2ljo5EgvLLEEwCWkmV
         fZuFl3srE7FyQ6gJknmapXOLdX9PubZ/cDCmZOESPkqBscXrFR9e7jvam1JPoMnX3K5e
         chV+CpKl0BJDkYbv5ei/cZdag2qScmtEsCp/hhrXQ720rDYkX1jh2t2srDCH7eOylrcE
         /apjaB30PlPArIg4KxGBHfkv3ZCcINQeXPz3uQyQuy2L/59Mmz8ToHiZ6OBlUqHVeKsc
         ASnQqCdrwTsfxRxG10pZMwRcp8CDwpeSv2ZonL75LzgPBGAeA2riEOZJggki5bXx5kGU
         A44g==
X-Gm-Message-State: AOAM531vYBKiTPgmNg9oDZ8fgSVug1E5Hy0Twph2vGYmtYlynmx3/GA6
        ddSZ5uAiCtTxoDVFBODwEJJLpg==
X-Google-Smtp-Source: ABdhPJwqvxaUb6kQTjfQnjgOZYzmBIaQHSa8VByqhlH+ZXfauiNOFn+CJ2skL2zOwPL72QS7QUHLww==
X-Received: by 2002:a05:6a00:1485:b029:272:f06c:9661 with SMTP id v5-20020a056a001485b0290272f06c9661mr25376172pfu.79.1619699170097;
        Thu, 29 Apr 2021 05:26:10 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([103.207.71.35])
        by smtp.gmail.com with ESMTPSA id l6sm2652127pgc.68.2021.04.29.05.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 05:26:09 -0700 (PDT)
Date:   Thu, 29 Apr 2021 20:26:05 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Subject: Re: [PATCH] arm64: stacktrace: Stop unwinding when the PC is zero
Message-ID: <20210429122605.GB214041@leoy-ThinkPad-X240s>
References: <20210429014321.196606-1-leo.yan@linaro.org>
 <20210429104813.GA33550@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429104813.GA33550@C02TD0UTHF1T.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Thu, Apr 29, 2021 at 11:48:13AM +0100, Mark Rutland wrote:

[...]

> > --- a/arch/arm64/kernel/stacktrace.c
> > +++ b/arch/arm64/kernel/stacktrace.c
> > @@ -145,7 +145,11 @@ void notrace walk_stackframe(struct task_struct *tsk, struct stackframe *frame,
> >  		if (!fn(data, frame->pc))
> >  			break;
> >  		ret = unwind_frame(tsk, frame);
> > -		if (ret < 0)
> > +		/*
> > +		 * When the frame->pc is zero, it has reached to the initial pc
> > +		 * and fp values; stop unwinding for this case.
> > +		 */
> > +		if (ret < 0 || !frame->pc)
> >  			break;
> 
> I don't think this is the right place for this, since we intend
> unwind_frame() to detect when unwinding is finished; see commit:
> 
>   3c02600144bdb0a1 ("arm64: stacktrace: Report when we reach the end of the stack")
> 
> I think we have three options for what to do here:
> 
> a) Revert 6106e1112cc69a36, and identify these cases as terminal records
>    where FP and LR are both NULL.
> 
> b) Have __primary_switched and __secondary_switched call start_kernel
>    and secondary_start_kernel with BL rather than B. The __*_switched
>    functions will show up in the trace, but we won't unwind any further
>    as the next record will have a NULL FP.
> 
> c) Revert 6106e1112cc69a36, create terminal records in
>    __primary_switched and __secondary_switched, and call start_kernel
>    and secondary_start_kernel with BL rather than B. The __*_switched
>    functions will show up in the trace, but we won't unwind any further
>    as the next record will be a terminal record.
> 
> For RELIABLE_STACKTRACE, we're going to have to do (c), I think, but for
> now we could do (a) so as to have a minimal fix, and we can build (c)
> atop that.
> 
> How about the patch below? I've tested it with your instructions and
> also by inspecting /proc/self/stack.

Thanks a lot for the quick fixing, and appreciate for sharing the
background knowledge!

> ---->8----
> From b99e647b34b74059f3013c09f12fbd542c7679fd Mon Sep 17 00:00:00 2001
> From: Mark Rutland <mark.rutland@arm.com>
> Date: Thu, 29 Apr 2021 11:20:04 +0100
> Subject: [PATCH] arm64: stacktrace: restore terminal records
> 
> We removed the terminal frame records in commit:
> 
>    6106e1112cc69a36 ("arm64: remove EL0 exception frame record")
> 
> ... on the assumption that as we no longer used them to find the pt_regs
> at exception boundaries, they were no longer necessary.
> 
> However, Leo reports that as an unintended side-effect, this causes
> traces which cross secondary_start_kernel to terminate one entry too
> late, with a spurious "0" entry.
> 
> There are a few ways we could sovle this, but as we're planning to use
> terminal records for RELIABLE_STACKTRACE, let's revert the logic change
> for now, keeping the update comments and accounting for the changes in
> commit:
> 
>   3c02600144bdb0a1 ("arm64: stacktrace: Report when we reach the end of the stack")
> 
> This is effectively a partial revert of commit:
> 
>   6106e1112cc69a36 ("arm64: remove EL0 exception frame record")
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Fixes: 6106e1112cc69a36 ("arm64: remove EL0 exception frame record")
> Reported-by: Leo Yan <leo.yan@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>

For this patch, I tested at my side and it works as expected.  Though I
don't have complete knowledge for reviewing this patch, I went through
the history commits your mentioned and connected with this patch, it
looks good to me:

Tested-by: Leo Yan <leo.yan@linaro.org>

> ---
>  arch/arm64/kernel/entry.S      |  6 +++---
>  arch/arm64/kernel/stacktrace.c | 10 ++++++----
>  2 files changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 6acfc5e6b5e0..9b205744a233 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -263,16 +263,16 @@ alternative_else_nop_endif
>  	stp	lr, x21, [sp, #S_LR]
>  
>  	/*
> -	 * For exceptions from EL0, terminate the callchain here.
> +	 * For exceptions from EL0, create a terminal frame record.
>  	 * For exceptions from EL1, create a synthetic frame record so the
>  	 * interrupted code shows up in the backtrace.
>  	 */
>  	.if \el == 0
> -	mov	x29, xzr
> +	stp	xzr, xzr, [sp, #S_STACKFRAME]
>  	.else
>  	stp	x29, x22, [sp, #S_STACKFRAME]
> -	add	x29, sp, #S_STACKFRAME
>  	.endif
> +	add	x29, sp, #S_STACKFRAME
>  
>  #ifdef CONFIG_ARM64_SW_TTBR0_PAN
>  alternative_if_not ARM64_HAS_PAN
> diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
> index d55bdfb7789c..7032a5f9e624 100644
> --- a/arch/arm64/kernel/stacktrace.c
> +++ b/arch/arm64/kernel/stacktrace.c
> @@ -44,10 +44,6 @@ int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
>  	unsigned long fp = frame->fp;
>  	struct stack_info info;
>  
> -	/* Terminal record; nothing to unwind */
> -	if (!fp)
> -		return -ENOENT;
> -
>  	if (fp & 0xf)
>  		return -EINVAL;
>  
> @@ -108,6 +104,12 @@ int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
>  
>  	frame->pc = ptrauth_strip_insn_pac(frame->pc);
>  
> +	/*
> +	 * This is a terminal record, so we have finished unwinding.
> +	 */
> +	if (!frame->fp && !frame->pc)
> +		return -ENOENT;
> +
>  	return 0;
>  }
>  NOKPROBE_SYMBOL(unwind_frame);
> -- 
> 2.11.0
> 
> 
>  
