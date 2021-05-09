Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72E03377850
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 21:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhEITsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 15:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbhEITrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 15:47:55 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721E1C06138B
        for <linux-kernel@vger.kernel.org>; Sun,  9 May 2021 12:46:47 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id h4so20274624lfv.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 May 2021 12:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J5xkVzV7RCvJKU/cDfVWEQRX8bcS2/bdI/mYc7oqbjk=;
        b=a8JyeEZVROM1ZYkc+yK6BGEr7p9caD6Q+gCsq066EVpuowIdBAqMRcoxQbUY5FgXWc
         /n1stQFhNNHwivYkVbCFP50GkpvEYT7FCVE59YYgDYBSA4CgbNIzuLskqPxelDxgfpBr
         ObKINSNdnvU2IebHrOHfG7DyvqSp1kCs48JHv8MtWXUdtBxMieUKDrsahKBk2N/VFlJA
         +U+oRe9dsw18Co0g2NRaTHn3q8ODJa5s+v0Zj3QZKDTucJ9UdaYDku0UVao/WLNq322N
         LYEt/lcYw5jhD6yQVqKhnT8MDaI/xfbDZGeCSZtp+Nmk5biTQw2oGAVguwQBbZ3pCbwL
         HJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J5xkVzV7RCvJKU/cDfVWEQRX8bcS2/bdI/mYc7oqbjk=;
        b=PdOYCocYXM5H9X97NC3Xu4Gzb3GiJOgrJgw2ZOAumd+jTj7r2E3E3tznrQmLZ+6jjG
         iJxEijRqOJdy9Nl8UbuQx7ZT1EshDx4p9hjeSlLTvNrd14KicXRXoO3DMnTXNa9fotqL
         /D2jwEX2Xw5BLrRV0kshhgZoEBTIGmDXspOmnyb8T/H6zdxjuNahRpLfoA8wKnZdhn9+
         ZN5fe5961O7jD35z/jQ942zSOComW6Rna4ezioka+D/OCs2fn4Oho4yGJ7CuPEz7codM
         Bt0QdvVTgys1tb1zMG3IOy5vELDUpbw3iLFahKYbx1A+YqUfd8C+PyH1v3GQoJzsoD7/
         EeFw==
X-Gm-Message-State: AOAM532Uj7Q2RydGybgLGATJt5bsFOxKANZGR2JNcs0YHm5A6HkO0rwa
        k/jMQ/JUSOBVwq+MrNyigLU=
X-Google-Smtp-Source: ABdhPJx79E1ePHhQjaGYXAVmdeX06IeBWNzrKgcX+WLJrqSBszuZRJGhCuT+0UeEkuoTK6bgClgR/w==
X-Received: by 2002:ac2:42cd:: with SMTP id n13mr14565330lfl.427.1620589605971;
        Sun, 09 May 2021 12:46:45 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id z21sm1976970lfq.164.2021.05.09.12.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 12:46:45 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Sun, 9 May 2021 21:46:43 +0200
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mel Gorman <mgorman@suse.de>, Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2 2/2] mm/vmalloc: Print a warning message first on
 failure
Message-ID: <20210509194643.GA2999@pc638.lan>
References: <20210509193844.2562-1-urezki@gmail.com>
 <20210509193844.2562-2-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210509193844.2562-2-urezki@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> When a memory allocation for array of pages are not succeed
> emit a warning message as a first step and then perform the
> further cleanup.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  Makefile     | 2 +-
>  mm/vmalloc.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index bb50a5ac2e13..1d658e171495 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -430,7 +430,7 @@ HOSTCXX	= g++
>  endif
>  
>  export KBUILD_USERCFLAGS := -Wall -Wmissing-prototypes -Wstrict-prototypes \
> -			      -O2 -fomit-frame-pointer -std=gnu89
> +			      -O0 -g -fomit-frame-pointer -std=gnu89
>  export KBUILD_USERLDFLAGS :=
>  
>  KBUILD_HOSTCFLAGS   := $(KBUILD_USERCFLAGS) $(HOST_LFS_CFLAGS) $(HOSTCFLAGS)
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index dbc6744400d5..1f664a17d9ea 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2781,11 +2781,11 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  	}
>  
>  	if (!area->pages) {
> -		free_vm_area(area);
>  		warn_alloc(gfp_mask, NULL,
>  			   "vmalloc size %lu allocation failure: "
>  			   "page array size %lu allocation failed",
>  			   nr_small_pages * PAGE_SIZE, array_size);
> +		free_vm_area(area);
>  		return NULL;
>  	}
>  
> -- 
> 2.20.1
> 
Please consider a V3 of this patch. Apparently a modification of
Makefile was included in the patch. What is wrong :)

From 9c484d83a630c4430dcb055a26c879d8e3c5cae1 Mon Sep 17 00:00:00 2001
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Date: Sat, 8 May 2021 23:41:21 +0200
Subject: [PATCH v3 2/2] mm/vmalloc: Print a warning message first on failure

When a memory allocation for array of pages are not succeed
emit a warning message as a first step and then perform the
further cleanup.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index dbc6744400d5..1f664a17d9ea 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2781,11 +2781,11 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	}
 
 	if (!area->pages) {
-		free_vm_area(area);
 		warn_alloc(gfp_mask, NULL,
 			   "vmalloc size %lu allocation failure: "
 			   "page array size %lu allocation failed",
 			   nr_small_pages * PAGE_SIZE, array_size);
+		free_vm_area(area);
 		return NULL;
 	}
 
-- 
2.20.1

--
Vlad Rezki
