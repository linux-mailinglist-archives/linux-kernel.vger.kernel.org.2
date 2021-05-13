Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5434537F75D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 14:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbhEMMFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 08:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233392AbhEMMEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 08:04:55 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A79C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 05:03:46 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id b21so14427526pft.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 05:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MSS7S19GIheJCojXinCjc0bxlDfjXvzH1jhMmBksG28=;
        b=dL0GTbObknuHhTyeEqSbGxG0erlud97IeNV5uSvHpDV6kX/0juDFihkz+0wdo3BYkH
         m2p0rCJAQRB/WLcIL/LMH6r1aJqgmWIT7NZFCoisXZvgSLv59nHBpgs8THzykOywhEVE
         B421KTmNWQXKh6MR4WF3SWMfb4vJz0dPGgW0+rvC3trTKP748d2bSsVXhUV5L5QyTKx+
         yCM0ASdmaHDzh6TjVtK4tJGO8wocizdFT5cV9W+Wpd5cYDSs+CEHi2HjQKLTPc3MYhRM
         Kf0UAfW88A6StvSOIWm+i+U407oX74UVZ24hx144XwoYnTmHBcsGuRtEq8ktH6pWOz/S
         MtuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MSS7S19GIheJCojXinCjc0bxlDfjXvzH1jhMmBksG28=;
        b=Hlg8P3JIDHaNa+Slt3wSjWQwUW4VJLlOgY3JIYvgHSYvpb7Wt9jIBpLEIgKMemo4IX
         0DmS/oYHRBrvKdFMobjfOq8UWRSTxYOHf8yD3bu+yIHvGd8uqFl6N+TtdqKKOlNIyH+M
         fsmKsEPUSdMoaZKCTTFunbpq9jzDKLk9R0RMTTDfyImGs8piaSk2DszNetPyl9QNmDKx
         8ea71hFRTX5M94GMEMcEEufl0ZahY4spn/FwuRVXV3/T85COTSkgVjsPJMKJt0ygQCMF
         k5PPYOvwZw42eN4rhCJFhd0wt+2ktVHeJevWh/kX5V7PkOot6JvnpmzIX7uQexB8nJ+P
         fsYQ==
X-Gm-Message-State: AOAM533TtOXs3kU8AEP870DXq2PdR+8+kmKd4c+9y2jHSC5aDem3Y02Z
        JnTLjdWyQMfmmskcy80AJMmnTR5QXmU=
X-Google-Smtp-Source: ABdhPJxS/zijkmIAsXioCRDBn2qPsq6noLJWy31LwPUaUjYmgW5Omw8uDdFRlcGP6Vp5net4btNK/g==
X-Received: by 2002:a05:6a00:ccd:b029:28e:d682:cc66 with SMTP id b13-20020a056a000ccdb029028ed682cc66mr40129149pfv.53.1620907425661;
        Thu, 13 May 2021 05:03:45 -0700 (PDT)
Received: from hyeyoo ([121.135.181.35])
        by smtp.gmail.com with ESMTPSA id j7sm1889872pfc.164.2021.05.13.05.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 05:03:45 -0700 (PDT)
Date:   Thu, 13 May 2021 21:03:39 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Marco Elver <elver@google.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        iamjoonsoo.kim@lge.com, rientjes@google.com, penberg@kernel.org,
        cl@linux.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        42.hyeyoo@gmail.com
Subject: Re: [PATCH v3] mm, slub: change run-time assertion in
 kmalloc_index() to compile-time
Message-ID: <20210513120339.GA772931@hyeyoo>
References: <20210511173448.GA54466@hyeyoo>
 <20210512195227.245000695c9014242e9a00e5@linux-foundation.org>
 <20210513031220.GA133011@hyeyoo>
 <20210512204024.401ff3de38649d7d0f5a45e8@linux-foundation.org>
 <20210513062809.GA319973@hyeyoo>
 <a36ab9a1-f07a-42ca-bb11-5bd0c70660bb@suse.cz>
 <YJ0ACtMpasnoZdUp@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJ0ACtMpasnoZdUp@elver.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 12:31:38PM +0200, Marco Elver wrote:

> ------ >8 ------
> 
> From: Marco Elver <elver@google.com>
> Subject: [PATCH] kfence: test: fix for "mm, slub: change run-time assertion in
>  kmalloc_index() to compile-time"
> 
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  include/linux/slab.h    | 9 +++++++--
>  mm/kfence/kfence_test.c | 5 +++--
>  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 27d142564557..7a10bdc4b7a9 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -350,7 +350,8 @@ static __always_inline enum kmalloc_cache_type kmalloc_type(gfp_t flags)
>   * Note: there's no need to optimize kmalloc_index because it's evaluated
>   * in compile-time.
>   */
> -static __always_inline unsigned int kmalloc_index(size_t size)
> +static __always_inline unsigned int __kmalloc_index(size_t size,
> +						    bool size_is_constant)
>  {
>  	if (!size)
>  		return 0;
> @@ -386,11 +387,15 @@ static __always_inline unsigned int kmalloc_index(size_t size)
>  	if (size <=  16 * 1024 * 1024) return 24;
>  	if (size <=  32 * 1024 * 1024) return 25;
>  
> -	BUILD_BUG_ON_MSG(1, "unexpected size in kmalloc_index()");
> +	if (size_is_constant)
> +		BUILD_BUG_ON_MSG(1, "unexpected size in kmalloc_index()");
> +	else
> +		BUG();

what about checking size it on top of kmalloc_index? because by definition of 
KMALLOC_SHIFT_HIGH, it's not always 25. it can be less than 25. for some
situations.

below is what I suggested beofre. for just reference:

--- include/linux/slab.h.orig   2021-05-12 17:56:54.504738768 +0900
+++ include/linux/slab.h        2021-05-13 15:06:25.724565850 +0900
@@ -346,9 +346,18 @@ static __always_inline enum kmalloc_cach
  * 1 =  65 .. 96 bytes
  * 2 = 129 .. 192 bytes
  * n = 2^(n-1)+1 .. 2^n
+ *
+ * Note: there's no need to optimize kmalloc_index because it's evaluated
+ * in compile-time.
  */
 static __always_inline unsigned int kmalloc_index(size_t size)
 {
+       if (__builtin_constant_p(size)) {
+               BUILD_BUG_ON_MSG(size > KMALLOC_MAX_CACHE_SIZE , "unexpected size in kmalloc_index()");
+       } else if (size > KMALLOC_MAX_CACHE_SIZE) {
+               BUG();
+       }
+
        if (!size)
                return 0;

@@ -382,8 +391,6 @@ static __always_inline unsigned int kmal
        if (size <=  8 * 1024 * 1024) return 23;
        if (size <=  16 * 1024 * 1024) return 24;
        if (size <=  32 * 1024 * 1024) return 25;
-       if (size <=  64 * 1024 * 1024) return 26;
-       BUG();

        /* Will never be reached. Needed because the compiler may complain */
        return -1;
