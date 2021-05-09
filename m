Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF703778A5
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 23:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhEIVSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 17:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbhEIVST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 17:18:19 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2CBC061573
        for <linux-kernel@vger.kernel.org>; Sun,  9 May 2021 14:17:16 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id z16so11906622pga.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 May 2021 14:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6shXq3lguQ3/lmI/1zOEwQpY1lYG83HevdlxUdGp6B4=;
        b=urrXzvOLg5/BsYoTh3as+hPn1xC55f7KTNxPj7L//gy81mymM6vdN8+CagpCaoEQmA
         NW5c7jlFWcul9pUSGxFdp8hH0TqWeDuxlvqAa0poFjo/x1Tu0tZfQWElXuVHHklpsjN3
         Kh68CUXj5tJN7pw89l9l+JK0RB2KxGt+1UKoMbLAbIH6nO5QSZ/SqRRyCnTfZLAPkOmt
         UzllGmCozj0mmWR5OBI8kkZL9f6QoCA8/5qQF4aRXffPdWjr9ZD/6JYLPQRAQHjcbksK
         W89iudMypFDwK4lCXnNopuxFyf+qF55YG7zndRnLmb660sNd9Att2C/4uACxjI2VWrN3
         ANmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6shXq3lguQ3/lmI/1zOEwQpY1lYG83HevdlxUdGp6B4=;
        b=SVmMYw1Sj2v/nCG0inHZmXzZFVyTOcw94z2c0PKcNtab7f0HFDDyKnYitBHfdYbAfm
         HLgG6maDFvT9y6Bfl1oMOR4PYqohQ12af2S/QYCmcD4TVabj7HB+hFVkgS/1cwDlBY38
         awsWP0XS/lw6na5wDcrxy57CFoAKh10DHF2Ryt8uAD2Zod/x3cydKOd8J78GJpM90bFN
         snoNp2IFJNPvBlHPG7YgOCwH/WaJeXy26d8CpF+WsgvSROShGcEvNp1OHuiTpxyUB/SM
         WF1Xg3WSyWkif8JLzFRmBnbDp60929egqjxxWio/UNYd3Db3ZTkQuIP8PznI8n1uhsvw
         s3ig==
X-Gm-Message-State: AOAM532KlDbLUlINoobqSswstRPqHOKmOJi2ST/NsaDhzZTr87NFbu8K
        oME+A9SJypWfjwbBlYo+70Y=
X-Google-Smtp-Source: ABdhPJzCExpTFYh3ZxRC7di/xqLLX147xbMP6vTSDXsRQIYBj8WcnnUaNrnIocagjg655MDYAXWBUQ==
X-Received: by 2002:a63:524e:: with SMTP id s14mr15596094pgl.403.1620595035804;
        Sun, 09 May 2021 14:17:15 -0700 (PDT)
Received: from localhost (g1.222-224-229.ppp.wakwak.ne.jp. [222.224.229.1])
        by smtp.gmail.com with ESMTPSA id a16sm9442473pfc.37.2021.05.09.14.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 14:17:15 -0700 (PDT)
Date:   Mon, 10 May 2021 06:17:13 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Mike Rapoport <rppt@linux.ibm.com>,
        openrisc@lists.librecores.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/2] openrisc: mm/init.c: remove unused memblock_region
 variable in map_ram()
Message-ID: <YJhRWQEy2Cpd1sKy@antec>
References: <20210509091103.7985-1-rppt@kernel.org>
 <20210509091103.7985-2-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210509091103.7985-2-rppt@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 09, 2021 at 12:11:02PM +0300, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Kernel test robot reports:
> 
> cppcheck possible warnings: (new ones prefixed by >>, may not real problems)
> 
> >> arch/openrisc/mm/init.c:125:10: warning: Uninitialized variable: region [uninitvar]
>             region->base, region->base + region->size);
>             ^
> 
> Replace usage of memblock_region fields with 'start' and 'end' variables
> that are initialized in for_each_mem_range() and remove the declaration of
> region.
> 
> Fixes: b10d6bca8720 ("arch, drivers: replace for_each_membock() with for_each_mem_range()")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/openrisc/mm/init.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/openrisc/mm/init.c b/arch/openrisc/mm/init.c
> index bf9b2310fc93..f3fa02b8838a 100644
> --- a/arch/openrisc/mm/init.c
> +++ b/arch/openrisc/mm/init.c
> @@ -75,7 +75,6 @@ static void __init map_ram(void)
>  	/* These mark extents of read-only kernel pages...
>  	 * ...from vmlinux.lds.S
>  	 */
> -	struct memblock_region *region;
>  
>  	v = PAGE_OFFSET;
>  
> @@ -121,7 +120,7 @@ static void __init map_ram(void)
>  		}
>  
>  		printk(KERN_INFO "%s: Memory: 0x%x-0x%x\n", __func__,
> -		       region->base, region->base + region->size);
> +		       start, end);
>  	}
>  }

Thanks I will queue this.

-Stafford
