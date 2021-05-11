Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2883537A820
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 15:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbhEKNun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 09:50:43 -0400
Received: from mail-il1-f174.google.com ([209.85.166.174]:41960 "EHLO
        mail-il1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbhEKNub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 09:50:31 -0400
Received: by mail-il1-f174.google.com with SMTP id v13so17198967ilj.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 06:49:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1d72fTnC6D6sy954r6wgqg5PV1w/QmBoE/c6bSmdBG4=;
        b=KSaTjnRYSILKCOQXhZWCtdnaGl5UetxuiaAqctOGFuZ0KmtnQeUgI9Qbd2Tzy9vYzc
         fyZ6HGtpEolenItkKFvQO/RE2U5tenCiBtof46W5Y6nDtMKWbhd7VJqyUWuNje4ESAFe
         g9WtH51Ry52c5TcscPnRjC7HnfXMB6P+9gwRfANlXlCpLCTGwXBzHXb1WRrtTXUEw2QH
         Eul/3M7aD52YZiYSpa3nuix2gh+zH70irxrXzea1E3qprhDRLOws12VYBrxRDitgwGk7
         gy/3fqzKXX2I8m1agqsXy8DS1EPFwM8/+PweG0Lmp6p8OWcdX6MbEX+Bv4bYM0pHPqu5
         wUrg==
X-Gm-Message-State: AOAM5303RFtu7jBGMY7KO+GFljFJmumDEq9HqkbHv+fGoQQtDRc4BeAN
        Hd//V/OgKIW+f8a66BeBueg25V39HD8=
X-Google-Smtp-Source: ABdhPJz8x0ql92qKWogv73BZICmsXMr4+uGHIdkPXbVfMDwNYREAkokhftwG/6bjc5mKEdUOEKSvSg==
X-Received: by 2002:a92:c544:: with SMTP id a4mr2022604ilj.207.1620740964636;
        Tue, 11 May 2021 06:49:24 -0700 (PDT)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id p5sm7636849iod.7.2021.05.11.06.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 06:49:24 -0700 (PDT)
Date:   Tue, 11 May 2021 13:49:23 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     tj@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] percpu_ref: Don't opencode percpu_ref_is_dying
Message-ID: <YJqLY1FsMSf1fDq3@google.com>
References: <20210511131633.185463-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511131633.185463-1-nborisov@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, May 11, 2021 at 04:16:33PM +0300, Nikolay Borisov wrote:
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
>  lib/percpu-refcount.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/percpu-refcount.c b/lib/percpu-refcount.c
> index a1071cdefb5a..af9302141bcf 100644
> --- a/lib/percpu-refcount.c
> +++ b/lib/percpu-refcount.c
> @@ -275,7 +275,7 @@ static void __percpu_ref_switch_mode(struct percpu_ref *ref,
>  	wait_event_lock_irq(percpu_ref_switch_waitq, !data->confirm_switch,
>  			    percpu_ref_switch_lock);
>  
> -	if (data->force_atomic || (ref->percpu_count_ptr & __PERCPU_REF_DEAD))
> +	if (data->force_atomic || percpu_ref_is_dying(ref))
>  		__percpu_ref_switch_to_atomic(ref, confirm_switch);
>  	else
>  		__percpu_ref_switch_to_percpu(ref);
> @@ -385,7 +385,7 @@ void percpu_ref_kill_and_confirm(struct percpu_ref *ref,
>  
>  	spin_lock_irqsave(&percpu_ref_switch_lock, flags);
>  
> -	WARN_ONCE(ref->percpu_count_ptr & __PERCPU_REF_DEAD,
> +	WARN_ONCE(percpu_ref_is_dying(ref),
>  		  "%s called more than once on %ps!", __func__,
>  		  ref->data->release);
>  
> @@ -465,7 +465,7 @@ void percpu_ref_resurrect(struct percpu_ref *ref)
>  
>  	spin_lock_irqsave(&percpu_ref_switch_lock, flags);
>  
> -	WARN_ON_ONCE(!(ref->percpu_count_ptr & __PERCPU_REF_DEAD));
> +	WARN_ON_ONCE(!percpu_ref_is_dying(ref));
>  	WARN_ON_ONCE(__ref_is_percpu(ref, &percpu_count));
>  
>  	ref->percpu_count_ptr &= ~__PERCPU_REF_DEAD;
> -- 
> 2.25.1
> 

If no one has any objections to me officially taking percpu_ref, I'll
pick this up.

Thanks,
Dennis
