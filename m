Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF531360A72
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 15:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbhDONYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 09:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233160AbhDONYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 09:24:11 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 829F5C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 06:23:47 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id s7so23190569wru.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 06:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2byzceuK3pVnwSQR1hAUK7MTfgfE49ObHg97SKhpp+I=;
        b=gHz5ulHPjyGzx58KOs2I/mZratDDUnZQOXLx9H13nEFfFB0VM2EOH/+jYdoTdG2PIG
         pffpmQSF4ayc1tfeq4wD4h4xXvNv2TUObtoDg15v74rarty49XSTnlKwrG1dG2ZTzAgD
         YHWbQC6nuAhLI2DHeIww6BVzA82BI5DiI8m3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=2byzceuK3pVnwSQR1hAUK7MTfgfE49ObHg97SKhpp+I=;
        b=UJY8VRipkuIc08OwgUsF9+oQlmQZBVXo5s0dt82eBUURvIJKAV5QtQXdzV0vTuPF3B
         yEQW78XAtKi3hyQRZCfcn4RGuIMzY6H2rt5RZTO1PvJz02ViqHZtkC286NbiSXRjS1BS
         8VAyLC/Rpaajo1mJRuvHZRcwYr58ey/uIdTRrUN1EljalcWbPb1FZ1WDDlRvcl0l9Wtp
         a8zGYv+q9oGoGzLQOvzNVrhAcdXniZhUwekdLlYax4x4DjGt+d5sSfQ7Bnie92FeS8ql
         Fg2q7m4bWkQDq/1zed4y/C3aA71SwBLBYP7H+UQ9e6eunT3+QLCeN2v2haV9jdHBjbFQ
         lLeg==
X-Gm-Message-State: AOAM530D3/+CNW9oWetCJJbywDR0v0ifiI/rFvUjW+9BEnZeySD5phnj
        3kqLPhMcE1OVIfpcxdmyU116Fw==
X-Google-Smtp-Source: ABdhPJxk1bRa6Yg4LDCIMkLe5Y4AfcZMposl53lwQa5X8eeL0yZm+SFvcApMmBpSk+Vtic4l7YLXIA==
X-Received: by 2002:adf:fdc3:: with SMTP id i3mr3457489wrs.385.1618493026340;
        Thu, 15 Apr 2021 06:23:46 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id u14sm3290214wrq.65.2021.04.15.06.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 06:23:45 -0700 (PDT)
Date:   Thu, 15 Apr 2021 15:23:43 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, vbabka@suse.cz, daniel@ffwll.ch,
        ray.huang@amd.com, akpm@linux-foundation.org
Subject: Re: [PATCH 1/2] mm/vmscan: add sync_shrinkers function
Message-ID: <YHg+X7KLCmn2+yqw@phenom.ffwll.local>
Mail-Followup-To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, vbabka@suse.cz, ray.huang@amd.com,
        akpm@linux-foundation.org
References: <20210415115624.2904-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210415115624.2904-1-christian.koenig@amd.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 01:56:23PM +0200, Christian König wrote:
> To be able to switch to a spinlock and reduce lock contention in the TTM
> shrinker we don't want to hold a mutex while unmapping and freeing pages
> from the pool.
> 
> But then we somehow need to prevent a race between (for example) the shrinker
> trying to free pages and hotplug trying to remove the device which those pages
> belong to.
> 
> Taking and releasing the shrinker semaphore on the write side after
> unmapping and freeing all pages should make sure that no shrinker is running in
> paralell any more.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>  include/linux/shrinker.h |  1 +
>  mm/vmscan.c              | 10 ++++++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
> index 0f80123650e2..6b75dc372fce 100644
> --- a/include/linux/shrinker.h
> +++ b/include/linux/shrinker.h
> @@ -92,4 +92,5 @@ extern void register_shrinker_prepared(struct shrinker *shrinker);
>  extern int register_shrinker(struct shrinker *shrinker);
>  extern void unregister_shrinker(struct shrinker *shrinker);
>  extern void free_prealloced_shrinker(struct shrinker *shrinker);
> +extern void sync_shrinkers(void);
>  #endif
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 562e87cbd7a1..46cd9c215d73 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -408,6 +408,16 @@ void unregister_shrinker(struct shrinker *shrinker)
>  }
>  EXPORT_SYMBOL(unregister_shrinker);
>  
> +/**
> + * sync_shrinker - Wait for all running shrinkers to complete.

Maybe make it clear this is a barrier type thing, it wont stop shrinkers
at all, just synchronize with them.

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

But needs an ack from Andrew for merging through drm-misc-next before we
push it there.
-Daniel

> + */
> +void sync_shrinkers(void)
> +{
> +	down_write(&shrinker_rwsem);
> +	up_write(&shrinker_rwsem);
> +}
> +EXPORT_SYMBOL(sync_shrinkers);
> +
>  #define SHRINK_BATCH 128
>  
>  static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
