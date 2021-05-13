Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A70EB37F268
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 06:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbhEMEtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 00:49:25 -0400
Received: from mail-io1-f41.google.com ([209.85.166.41]:35407 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhEMEtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 00:49:18 -0400
Received: by mail-io1-f41.google.com with SMTP id d24so13968958ios.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 21:48:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yoz12x1QRqBVwNhioqF/aqV5rL835RXzGI5rD5tQwJc=;
        b=oUCgGxvDzNVi3l1QoXKffle5ztnDK+M10j6qhhjdGLoODPD/HplJc5sZqMQhKsodKi
         etxNrLpw+w5M2Fm0VfDzaCKxJ449gp5s8jrWiiCy0yBTskiPWS4SLgXjUZ2LNfPYTJf4
         BXB/4bV43TXiGkczAg36mgKbuMI4H02Rzbdv4Y+BKixaFnCQHke4s0QX1BnaYFBzALzt
         dVIafzmcq6rpKBsLmuPO6uwIjltH4K6P1R1fdz00mBFW45VSl0D8m9quTH4BCeei/ZIM
         okVOAEIbWA5T4DJW9ogfaoo6XXZubo1Rn5f6BaGyKytiNj1wUDNQm0GycMM9pEFl6KSQ
         z8vA==
X-Gm-Message-State: AOAM5331whKggCprBgOVyIeHSwQwE/8M5VkTg8mvUZ6kXyaZr8zhTy+F
        08S71vekQ5LzeGx7GE9Mwjhp7P5MYuc=
X-Google-Smtp-Source: ABdhPJxKnWiAuybrPJsK5nxuIQJHp5GxIOPs/1VTigNybi2ANrOcrlZSKLSHKYdzJaj1BurWC9ZcRQ==
X-Received: by 2002:a5d:9b03:: with SMTP id y3mr8720284ion.191.1620881289051;
        Wed, 12 May 2021 21:48:09 -0700 (PDT)
Received: from google.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id i131sm779451iof.15.2021.05.12.21.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 21:48:08 -0700 (PDT)
Date:   Thu, 13 May 2021 04:48:07 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     tj@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] percpu_ref: Don't opencode percpu_ref_is_dying
Message-ID: <YJyvh4iE6sVEEaHD@google.com>
References: <20210511131633.185463-1-nborisov@suse.com>
 <YJqLY1FsMSf1fDq3@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJqLY1FsMSf1fDq3@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 01:49:23PM +0000, Dennis Zhou wrote:
> Hello,
> 
> On Tue, May 11, 2021 at 04:16:33PM +0300, Nikolay Borisov wrote:
> > Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> > ---
> >  lib/percpu-refcount.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/lib/percpu-refcount.c b/lib/percpu-refcount.c
> > index a1071cdefb5a..af9302141bcf 100644
> > --- a/lib/percpu-refcount.c
> > +++ b/lib/percpu-refcount.c
> > @@ -275,7 +275,7 @@ static void __percpu_ref_switch_mode(struct percpu_ref *ref,
> >  	wait_event_lock_irq(percpu_ref_switch_waitq, !data->confirm_switch,
> >  			    percpu_ref_switch_lock);
> >  
> > -	if (data->force_atomic || (ref->percpu_count_ptr & __PERCPU_REF_DEAD))
> > +	if (data->force_atomic || percpu_ref_is_dying(ref))
> >  		__percpu_ref_switch_to_atomic(ref, confirm_switch);
> >  	else
> >  		__percpu_ref_switch_to_percpu(ref);
> > @@ -385,7 +385,7 @@ void percpu_ref_kill_and_confirm(struct percpu_ref *ref,
> >  
> >  	spin_lock_irqsave(&percpu_ref_switch_lock, flags);
> >  
> > -	WARN_ONCE(ref->percpu_count_ptr & __PERCPU_REF_DEAD,
> > +	WARN_ONCE(percpu_ref_is_dying(ref),
> >  		  "%s called more than once on %ps!", __func__,
> >  		  ref->data->release);
> >  
> > @@ -465,7 +465,7 @@ void percpu_ref_resurrect(struct percpu_ref *ref)
> >  
> >  	spin_lock_irqsave(&percpu_ref_switch_lock, flags);
> >  
> > -	WARN_ON_ONCE(!(ref->percpu_count_ptr & __PERCPU_REF_DEAD));
> > +	WARN_ON_ONCE(!percpu_ref_is_dying(ref));
> >  	WARN_ON_ONCE(__ref_is_percpu(ref, &percpu_count));
> >  
> >  	ref->percpu_count_ptr &= ~__PERCPU_REF_DEAD;
> > -- 
> > 2.25.1
> > 
> 
> If no one has any objections to me officially taking percpu_ref, I'll
> pick this up.
> 
> Thanks,
> Dennis

I've applied this to for-5.13-fixes.

Thanks,
Dennis
