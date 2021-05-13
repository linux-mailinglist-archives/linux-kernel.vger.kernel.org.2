Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7DD37F18D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 05:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbhEMDNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 23:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbhEMDNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 23:13:36 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3645C061574
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 20:12:26 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id i5so15252287pgm.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 20:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SS5OHlXmmSNON5KatgyYnmlWm3dX+R80ppvdDgNsI1I=;
        b=hLIBicSaBf1Lm6AE3HsEV8jzzJrDDMDzlf/h+lonjSqFXlkDEDMYFWoikLpcOvu7Rl
         jIfWTCGeYZnBaztMzq7peZ/CDhAxMO7k9jDtmlBEcD9BkrtMb2jk1YAewJ6/KKFudNh7
         uqNioDipTn0ALysnZwqT6Tu55SZQTEz8L670sO15O9io4BpvQUQn5rzP0sw4cVs57xUs
         oGO44BTcbVanHwZA5KZLiY68tT/VjDFbWx3qEJPKZX1HxYLNS1pkxFj4FbQ4klf6fltU
         Xb3zQo59EwfsZsGk0fKP8iv6pOfyn4DcH1UD3oQdnqdUDqm3z8Y5YKO57BPtYKLK0soi
         jZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SS5OHlXmmSNON5KatgyYnmlWm3dX+R80ppvdDgNsI1I=;
        b=AOcxgQ1G2BdzLTBHtb8MqqWhAgTuGn78TQ6PhTwpON9tD3W+GDrBG3baEino6p3hWJ
         0NKrsQlvSRvSE2r0iZktbHZsbCqLMx+0kwRphl9VOFNkFa2FZhhavSNrVuF+PzWjxKQG
         3qjIBMvRchUB83fm2giud2tKGfBZ0LJrrgWyxWynVpF74qNJ7PX/k3t6OBaGSz+a4UuO
         iDSBFoPdPq6ClI+EFf4hQLUJHVIcl2X410eckHke35zBFJ0Liz9bfJueSx/8S4QJhBgY
         8/lbTOWcA+oACqPcaR2fqumeUxSuecZV8IBsNZUYuTuNgmtsvzV4OuwsrBvYqbQ9KlKa
         R8ow==
X-Gm-Message-State: AOAM533D6CoOY6pxF6l8H967aKMTO56YGyRABYxYTmMU7S2T7E6tmeov
        Lw/uQ+oApvkcWptQIrxjjlY=
X-Google-Smtp-Source: ABdhPJzStzG/udPZzt469bOoqFcBL73cSbisYcGoO+yQpZx+qdgmsOKXlt8LoDRNYLiKXovFhdvXlw==
X-Received: by 2002:a62:ce8c:0:b029:28e:cc4c:3b7e with SMTP id y134-20020a62ce8c0000b029028ecc4c3b7emr38109419pfg.67.1620875546300;
        Wed, 12 May 2021 20:12:26 -0700 (PDT)
Received: from hyeyoo ([183.99.11.150])
        by smtp.gmail.com with ESMTPSA id x6sm874969pfu.120.2021.05.12.20.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 20:12:26 -0700 (PDT)
Date:   Thu, 13 May 2021 12:12:20 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     vbabka@suse.cz, iamjoonsoo.kim@lge.com, rientjes@google.com,
        penberg@kernel.org, cl@linux.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Marco Elver <elver@google.com>
Subject: Re: [PATCH v3] mm, slub: change run-time assertion in
 kmalloc_index() to compile-time
Message-ID: <20210513031220.GA133011@hyeyoo>
References: <20210511173448.GA54466@hyeyoo>
 <20210512195227.245000695c9014242e9a00e5@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512195227.245000695c9014242e9a00e5@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 07:52:27PM -0700, Andrew Morton wrote:
> This explodes in mysterious ways.  The patch as I have it is appended,
> for reference.
> 
> gcc-10.3.0 allmodconfig.
> 
> This patch suppresses the error:
> 
> --- a/mm/kfence/kfence_test.c~a
> +++ a/mm/kfence/kfence_test.c
> @@ -318,13 +318,13 @@ static void test_out_of_bounds_read(stru
>  
>  	/* Test both sides. */
>  
> -	buf = test_alloc(test, size, GFP_KERNEL, ALLOCATE_LEFT);
> +	buf = test_alloc(test, 32, GFP_KERNEL, ALLOCATE_LEFT);
>  	expect.addr = buf - 1;
>  	READ_ONCE(*expect.addr);
>  	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
>  	test_free(buf);
>
> -	buf = test_alloc(test, size, GFP_KERNEL, ALLOCATE_RIGHT);
> +	buf = test_alloc(test, 32, GFP_KERNEL, ALLOCATE_RIGHT);
>  	expect.addr = buf + size;
>  	READ_ONCE(*expect.addr);
>  	KUNIT_EXPECT_TRUE(test, report_matches(&expect));
> @@ -519,11 +519,11 @@ static void test_free_bulk(struct kunit
>  		const size_t size = setup_test_cache(test, 8 + prandom_u32_max(300), 0,
>  						     (iter & 1) ? ctor_set_x : NULL);
>  		void *objects[] = {
> -			test_alloc(test, size, GFP_KERNEL, ALLOCATE_RIGHT),
> -			test_alloc(test, size, GFP_KERNEL, ALLOCATE_NONE),
> -			test_alloc(test, size, GFP_KERNEL, ALLOCATE_LEFT),
> -			test_alloc(test, size, GFP_KERNEL, ALLOCATE_NONE),
> -			test_alloc(test, size, GFP_KERNEL, ALLOCATE_NONE),
> +			test_alloc(test, 32, GFP_KERNEL, ALLOCATE_RIGHT),
> +			test_alloc(test, 32, GFP_KERNEL, ALLOCATE_NONE),
> +			test_alloc(test, 32, GFP_KERNEL, ALLOCATE_LEFT),
> +			test_alloc(test, 32, GFP_KERNEL, ALLOCATE_NONE),
> +			test_alloc(test, 32, GFP_KERNEL, ALLOCATE_NONE),
>  		};
>  
>  		kmem_cache_free_bulk(test_cache, ARRAY_SIZE(objects), objects);
>
>
> Is gcc-10.3.0 simply confused?  test_out_of_bounds_read() is clearly
> calling kmalloc_index(32) which is OK.
>
> Anyway, I'll drop this patch for now so I can compile a kernel!
>

The error messages isn't so clear to me.
but one problem I can see is in kfence_test.c, there are many places that
are using size which is not constant.

in kmalloc if size is not constant, it calls dummy function __kmalloc
which does not make use of size.
