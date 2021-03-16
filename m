Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDFB33DB06
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 18:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236034AbhCPRbd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 13:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbhCPRaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 13:30:52 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB9EC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 10:30:52 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id r15-20020a05600c35cfb029010e639ca09eso1928484wmq.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 10:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ure8kWkdZ5geLP/9Lu+/xSmpVEu0DA6buPVci38aSj0=;
        b=Z678/QuLnZrG4E0wQ6JR1/nIGj9Fs7Z8+aAZt8Mz8sYdje6igCKN2utV2igPfamrt3
         ozvC+EoHpQ6EwT08H/KYiIED6ErrciMFxaQijeEGnrXKFlq2jVTYkwhxwFNNL73ZuXNE
         xNv7p0SDTg0Uv1pWfryHD6ci4FsT4tdONtkEhM1pE1cUFpsPmgdp1umhgu4KJG3vWW5t
         cWA4iUaDeT8XBmj08MWPoEi/wvTWp6syClumigtyAGVLiHq7G4kDn/y/CllVFlhSnXnP
         +vRXmM9mX1XZTlXN5/2u5jfOqHTpJ4Wmem107KL0SZARCwPvJACOoO4qe9HzSh/c2wBP
         4vng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ure8kWkdZ5geLP/9Lu+/xSmpVEu0DA6buPVci38aSj0=;
        b=AeM1RhkzhfzjPicetlwKzKJibk0zJA5NXUm9vgx/c2EsZZM81XhT4fbAVN74JtDGMj
         6/uj7dIh78WJjZFiGMmGTb4AyBwVP2ga+n8sQO5WzM+NQaPppFjcYt7KSHRM5e1ABcYa
         SgCsVyQpMEF/Xkt/5p2IZEJDect/rxq9dHpZLHdQyChazCVdexCMVlcF5dAiU+sGvygt
         r5Cb/9/ENIxHiocdDs/NS+cEoZ+0zfHRVRqoAoueVW2vQ4cCudeshU2CXZs5S5d1bhsC
         k0LkutowYIbJ84Raq3NeelFxOLYKOnzqszU4knkjonFj8OTBz09icrjk6oIfUppX+r2G
         bqHw==
X-Gm-Message-State: AOAM530Pzq4fJaBvRNwvta1sn/+MDHaIEIm3508MM8uCT233QwU98w8E
        s7ULv2jm/A4ZOkiqcQYUxh452g==
X-Google-Smtp-Source: ABdhPJytNagM4AIbMoENHxcjBnrn4JxwikwNeiZ2SKxSVH/A1ANipTJtB19WZ+2dS+sc8ya4+f0huw==
X-Received: by 2002:a05:600c:1548:: with SMTP id f8mr135921wmg.81.1615915850632;
        Tue, 16 Mar 2021 10:30:50 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:1d09:9676:5eaa:550])
        by smtp.gmail.com with ESMTPSA id b65sm101820wmh.4.2021.03.16.10.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 10:30:49 -0700 (PDT)
Date:   Tue, 16 Mar 2021 18:30:00 +0100
From:   Marco Elver <elver@google.com>
To:     Luis Henriques <lhenriques@suse.de>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: Issue with kfence and kmemleak
Message-ID: <YFDrGL45JxFHyajD@elver.google.com>
References: <YFDf6iKH1p/jGnM0@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFDf6iKH1p/jGnM0@suse.de>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 16, 2021 at 04:42PM +0000, Luis Henriques wrote:
> Hi!
> 
> This is probably a known issue, but just in case: looks like it's not
> possible to use kmemleak when kfence is enabled:

Thanks for spotting this.

> [    0.272136] kmemleak: Cannot insert 0xffff888236e02f00 into the object search tree (overlaps existing)
> [    0.272136] CPU: 0 PID: 8 Comm: kthreadd Not tainted 5.12.0-rc3+ #92
> [    0.272136] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a-rebuilt.opensuse.org 04/01/2014
> [    0.272136] Call Trace:
> [    0.272136]  dump_stack+0x6d/0x89
> [    0.272136]  create_object.isra.0.cold+0x40/0x62
> [    0.272136]  ? process_one_work+0x5a0/0x5a0
> [    0.272136]  ? process_one_work+0x5a0/0x5a0
> [    0.272136]  kmem_cache_alloc_trace+0x110/0x2f0
> [    0.272136]  ? process_one_work+0x5a0/0x5a0
> [    0.272136]  kthread+0x3f/0x150
> [    0.272136]  ? lockdep_hardirqs_on_prepare+0xd4/0x170
> [    0.272136]  ? __kthread_bind_mask+0x60/0x60
> [    0.272136]  ret_from_fork+0x22/0x30
> [    0.272136] kmemleak: Kernel memory leak detector disabled
> [    0.272136] kmemleak: Object 0xffff888236e00000 (size 2097152):
> [    0.272136] kmemleak:   comm "swapper", pid 0, jiffies 4294892296
> [    0.272136] kmemleak:   min_count = 0
> [    0.272136] kmemleak:   count = 0
> [    0.272136] kmemleak:   flags = 0x1
> [    0.272136] kmemleak:   checksum = 0
> [    0.272136] kmemleak:   backtrace:
> [    0.272136]      memblock_alloc_internal+0x6d/0xb0
> [    0.272136]      memblock_alloc_try_nid+0x6c/0x8a
> [    0.272136]      kfence_alloc_pool+0x26/0x3f
> [    0.272136]      start_kernel+0x242/0x548
> [    0.272136]      secondary_startup_64_no_verify+0xb0/0xbb
> 
> I've tried the hack below but it didn't really helped.  Obviously I don't
> really understand what's going on ;-)  But I think the reason for this
> patch not working as (I) expected is because kfence is initialised
> *before* kmemleak.
> 
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index 3b8ec938470a..b4ffd7695268 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -631,6 +631,9 @@ void __init kfence_alloc_pool(void)
>  
>  	if (!__kfence_pool)
>  		pr_err("failed to allocate pool\n");
> +	kmemleak_no_scan(__kfence_pool);
>  }

Can you try the below patch?

Thanks,
-- Marco

------ >8 ------

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index f7106f28443d..5891019721f6 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -12,6 +12,7 @@
 #include <linux/debugfs.h>
 #include <linux/kcsan-checks.h>
 #include <linux/kfence.h>
+#include <linux/kmemleak.h>
 #include <linux/list.h>
 #include <linux/lockdep.h>
 #include <linux/memblock.h>
@@ -481,6 +482,13 @@ static bool __init kfence_init_pool(void)
 		addr += 2 * PAGE_SIZE;
 	}
 
+	/*
+	 * The pool is live and will never be deallocated from this point on;
+	 * tell kmemleak this is now free memory, so that later allocations can
+	 * correctly be tracked.
+	 */
+	kmemleak_free_part_phys(__pa(__kfence_pool), KFENCE_POOL_SIZE);
+
 	return true;
 
 err:
