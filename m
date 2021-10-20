Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED5B434A74
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 13:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbhJTLtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 07:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbhJTLs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 07:48:58 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520B7C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 04:46:44 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id y7so2731897pfg.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 04:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/CtzRUum4TEm7dhVCZPF7Qv3OkcjTAJgigCewjxDris=;
        b=aaqCctI/JXU0ho9YJ2RGMRHqvwSupruDY3wXfD1/865eGLLD9vQnlwktuNYIO5RMVi
         pOm+f/QhQeohQWnt0SZWCBv9/9ozJdQzIOwpqc45H0IXuRE2FlU+xb8wPC8gm2kSMcmy
         x4gO31h56mNIoNm2rFa/aoCukvo2GThMPTMLE8lkrWmhrJP9o3xnnQIEg5xtrloVW2IH
         eAvrG5f8GwkCE6sj5IxyGYZQDeVNnjUIFCkIF72jiJeITM1YFKiSG7fvpNwPQv/35lml
         ntwOc6jvGdzPIK9+rxsF3t08ogOMQGg5TuLDycIX8DQTZrAnnPpwE7kAU3slQF1UCUz7
         UyNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/CtzRUum4TEm7dhVCZPF7Qv3OkcjTAJgigCewjxDris=;
        b=ysCD/cGHTa4/1Q4d9Qp89zqGb1e3VSA0E3wdq0zTfIBHvHY7pnu2SZGvyQKoXBLfj/
         I/xYzZUzWvK7jFxRrDOgehx/7HNzEl32NlLSt9tI/VksSKbglWXvSMopgwO4HGeucSMR
         I4aQj7kiJlE5Nq5fXxMUNVU4hBsrL3QufYaXxwE3EklMDkKv6Ky7Z+clUr/1UF1ke3+V
         4ngfm1uGlHNgXeVdNdUjOG9OZW1hMyRGCFqeA50TJrCL1aJ6EKyifVRF+oYDIIWhb2z8
         3lxQNkFQPQThsDwMS+FGadb1LtFqqvXMvKCiMZfBkD0k+0qV6DLgb1Cf+IJvXGg292mU
         Qx8Q==
X-Gm-Message-State: AOAM532iXPiuydVTa+mX7LVlzBTgpyExKVihleCPXjXO5DKDVSYjB+lu
        opJWrJsOO1q3dUV3kcWMinU=
X-Google-Smtp-Source: ABdhPJxc7MdkcNH3vp2JLHAexDGsSQHeFiIFMAFvqxlRvhRMHK8rnR7chMyocY10Zg9HkdDDhNBwUQ==
X-Received: by 2002:a05:6a00:234f:b0:3eb:3ffd:6da2 with SMTP id j15-20020a056a00234f00b003eb3ffd6da2mr5787974pfj.15.1634730403839;
        Wed, 20 Oct 2021 04:46:43 -0700 (PDT)
Received: from kvm.asia-northeast3-a.c.our-ratio-313919.internal (21.210.64.34.bc.googleusercontent.com. [34.64.210.21])
        by smtp.gmail.com with ESMTPSA id v22sm2393547pff.93.2021.10.20.04.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 04:46:43 -0700 (PDT)
Date:   Wed, 20 Oct 2021 11:46:38 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Rustam Kovhaev <rkovhaev@gmail.com>
Cc:     vbabka@suse.cz, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, djwong@kernel.org, david@fromorbit.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk,
        dvyukov@google.com
Subject: Re: [PATCH] slob: add size header to all allocations
Message-ID: <20211020114638.GA378758@kvm.asia-northeast3-a.c.our-ratio-313919.internal>
References: <20211015005729.GD24333@magnolia>
 <20211018033841.3027515-1-rkovhaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018033841.3027515-1-rkovhaev@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 17, 2021 at 08:38:41PM -0700, Rustam Kovhaev wrote:
> Let's prepend all  allocations of (PAGE_SIZE - align_offset) and less
> with the size header. This way kmem_cache_alloc() memory can be freed
> with kfree() and the other way around, as long as they are less than
> (PAGE_SIZE - align_offset).

Hello Rustam, I measured its impact on memory usage on
tiny kernel configuration as SLOB is used in very small machine.

on x86 32 bit + tinyconfig:
    Before:
    Slab:                668 kB

    After:
    Slab:                688~692 kB

it adds 20~24kB.

> 
> The main reason for this change is to simplify SLOB a little bit, make
> it a bit easier to debug whenever something goes wrong.
>

It seems acceptable But I wonder it is worth to increase memory usage
to allow freeing kmem_cache_alloc-ed objects by kfree()?

Thanks,
Hyeonggon

> meminfo right after the system boot, without the patch:
> Slab:              35500 kB
> 
> the same, with the patch:
> Slab:              36396 kB
> 
