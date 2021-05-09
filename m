Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF5A37785C
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 22:05:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbhEIUG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 16:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbhEIUG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 16:06:27 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEC3C061573
        for <linux-kernel@vger.kernel.org>; Sun,  9 May 2021 13:05:23 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id z13so20276396lft.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 May 2021 13:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=npmUVefuE46eM3ogeUz4VwY3gJhf4/3KKClnpwMMoeY=;
        b=XxexnP8+u5CnpofwBxpa1i9ih0aC8zaFXlwzuBjK+mbLPXhqjnXTtfUTGmBlRux1LU
         svH5YyQN/SrZewXJnGDZaMOnzgqjsBS45hxr1soQA9o+ISdFKYCEhkYWE3ue7g5FJIcp
         VkHbqQ1NF1dnr0mAANRxU+Kvc1tz9cn+nWNjZA/3wUPU2pOdTtA2G2qvkOdEUx8aU3tY
         P94ldTSdLyxtQZ3S1EuKj7L6CY9hcLCOGNo9M1mgTbs8/mYGexyLyaAV1fz55vdUbvtG
         axFv2MX8DTkHUs/OaMSOLWushKwQn8lg8mV5VHHykglBPiZWwwZZKRZ9PcdMAGAIV21U
         pBrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=npmUVefuE46eM3ogeUz4VwY3gJhf4/3KKClnpwMMoeY=;
        b=ky3Yew32UDx2bIderliU1aN0UmwdJv61URgIs8gTKr7deuO5QCo14KtJd7Op5NTGqE
         05l5z9iddtFimIXVrX5wJJ5adgSQvtYftZgmMKVyR3gGZc0Morejd+tnFGuMPz+CZ9x7
         hiu0R+2LjFMBNf2RU0U8jwT8oEtVbjVA/3x0u/0pTb4WpNnZVxVnICMHqii2t8bHJ6tO
         mAgkhJ1gSwqRdKEyeWqzHTBqImuhIxKdQFSKVvhbypvCNoAuOgKnZM78AK9VRKNRcKpO
         OfcSHvqmWfg6SwyZTbxLr3RZ5piO2l3WaQ7F4xrb6bfzHWbO+cak0NNk7L3nFjTTZpzv
         84BA==
X-Gm-Message-State: AOAM533dRwa0Hk/i0PV5Gp4nUK5YBomBMv7lshmGXgiUmFWa0Pzd/lyT
        ODo6zwUjZbC+VtOOFtWla1u8Mnjsa7Y=
X-Google-Smtp-Source: ABdhPJx6HdRQ64D88RqxJGC6OleuSYWafTfE90HTmpGcenBo4GKy2UbDjLVR3y4ASLvyl2EbFaRqBQ==
X-Received: by 2002:a05:6512:149:: with SMTP id m9mr14065946lfo.157.1620590721858;
        Sun, 09 May 2021 13:05:21 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id z11sm2003605lfr.73.2021.05.09.13.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 13:05:21 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Sun, 9 May 2021 22:05:19 +0200
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mel Gorman <mgorman@suse.de>, Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 2/2] mm/vmalloc: Print a warning message first on
 failure
Message-ID: <20210509200519.GA3016@pc638.lan>
References: <20210509193844.2562-1-urezki@gmail.com>
 <20210509193844.2562-2-urezki@gmail.com>
 <YJg8QO2JXm0+8UH6@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJg8QO2JXm0+8UH6@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 09, 2021 at 08:47:12PM +0100, Matthew Wilcox wrote:
> On Sun, May 09, 2021 at 09:38:44PM +0200, Uladzislau Rezki (Sony) wrote:
> >  export KBUILD_USERCFLAGS := -Wall -Wmissing-prototypes -Wstrict-prototypes \
> > -			      -O2 -fomit-frame-pointer -std=gnu89
> > +			      -O0 -g -fomit-frame-pointer -std=gnu89
> 
> You clearly didn't intend to submit this portion ...
> 
I sent a v3 that does not include it. That was added accidentally.

> > +++ b/mm/vmalloc.c
> > @@ -2781,11 +2781,11 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
> >  	}
> >  
> >  	if (!area->pages) {
> > -		free_vm_area(area);
> >  		warn_alloc(gfp_mask, NULL,
> >  			   "vmalloc size %lu allocation failure: "
> >  			   "page array size %lu allocation failed",
> >  			   nr_small_pages * PAGE_SIZE, array_size);
> > +		free_vm_area(area);
> >  		return NULL;
> >  	}
> 
> I think this is a bad idea.  We're clearly low on memory (a memory
> allocation just failed).  We should free the memory we have allocated
> to improve the chances of the warning message making it out.
Not sure if i fully follow you here. We do free the memory. The intention
was to print a warning message first because, if, potentially, the
free_vm_area(area) also does some prints it would be a bit messy from the
point what has been broken first.

So, could you please clarify what was your concern?

--
Vlad Rezki
