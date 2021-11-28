Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E330F4602E0
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 02:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236400AbhK1B4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 20:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbhK1ByN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 20:54:13 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE67FC061574;
        Sat, 27 Nov 2021 17:50:58 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso12548904pji.0;
        Sat, 27 Nov 2021 17:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ys5xSp8TMHje4lkwagfboQK99rlmdyclUqc40aH5Xfc=;
        b=JJOISWgIQ7wesuYZIUyZ8YTvD93vtYYWCXpfoY5Xjiptsb/c/6A8Qt0ghl68FPzuuW
         RcHn3i6d+k+aYpTNzHFoicSvQWW1IaZ/fNNkcM0PpOn2zy/M9mFyuhc8vIeDm9liWaCt
         H16c8kzlw5FLBZaGYeNosXob9TEcToUUr/mHUnmdiFCbaeCoiQuyTQjYV5GdrTasP7II
         bw60jyoMg6YcXpFUW5X7r1FzNUeZmQszk455JFn+kbjr2shcdZVhqayQwih2uqXXwuzc
         JIA2RCCN0BqI59sdeGLuAwHBkfAMzPAdR7xh2WEB5stJk1x6S/XlLMQpQ9UuxV1xRNYO
         N1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ys5xSp8TMHje4lkwagfboQK99rlmdyclUqc40aH5Xfc=;
        b=B82063aAdV2uYcDnA3P1QxUTPML+WMK4zureZvCM5b2tALfA/IPNiSN1k5eX4Al12K
         1sEmWw1crXKCmiitxuIPq8tPYacmCrlRSGLSVZKhRvfOTJ3k/EbAoL4kM0EsxrHOu0b1
         CDzf96VFQio9Mb8J7mad3iz040LB+U0+0+HaKYkQZGijPsqOygZwfyAITDJBsEtSOI4u
         dcqEGOvuX2X7jMGaJqYEMaLM+U0UOoV7891qnXerqYzwfb4kejFQT5jaiyUNjOjB9azQ
         NEI8fsDz67OHejAHZ76ZZLPnwbJWj3LSVnfiNnt8+kmDQ4df3H48Y8awwjwK+EvyqEJe
         P32Q==
X-Gm-Message-State: AOAM531AbscMvObx/AB7JP1AabAmdUH6uUsqj8Y+WvKrRjwae3NEkWgL
        96fqN7qU3z5cRI6U3snzdBs=
X-Google-Smtp-Source: ABdhPJwRmBN5bgq7gesTKrXdzGhmnX4TF8GBRT5ARwRzCP8r0GrmW5VR1rkYDfo3JlQIN/mpfZD2Ow==
X-Received: by 2002:a17:903:245:b0:143:c5ba:8bd8 with SMTP id j5-20020a170903024500b00143c5ba8bd8mr50486892plh.64.1638064258317;
        Sat, 27 Nov 2021 17:50:58 -0800 (PST)
Received: from localhost ([103.99.179.247])
        by smtp.gmail.com with ESMTPSA id f21sm12503537pfe.69.2021.11.27.17.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 17:50:57 -0800 (PST)
Date:   Sun, 28 Nov 2021 09:50:53 +0800
From:   Calvin Zhang <calvinzhang.cool@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org
Subject: Re: [PATCH] mm: kmemleak: Ignore kmemleak scanning on CMA regions
Message-ID: <YaLgfYzxFRVamvdI@debian>
References: <20211126024711.54937-1-calvinzhang.cool@gmail.com>
 <20211127160718.54e82aa93c977a367404a9e3@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211127160718.54e82aa93c977a367404a9e3@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 27, 2021 at 04:07:18PM -0800, Andrew Morton wrote:
>On Fri, 26 Nov 2021 10:47:11 +0800 Calvin Zhang <calvinzhang.cool@gmail.com> wrote:
>
>> Just like this:
>> commit 620951e27457 ("mm/cma: make kmemleak ignore CMA regions").
>> 
>> Add kmemleak_ignore_phys() for CMA created from of reserved node.
>
>Could we please have a full, standalone changelog for this patch?

Yes, I will add.

>
>The 620951e27457 changelog says "Without this, the kernel crashes...". 
>Does your patch also fix a crash?  If so under what circumstances and
>should we backport this fix into -stable kernels?

No crash occurred. 620951e27457 avoids crashes caused by accessing
highmem and it was fixed later. Now kmemleak_alloc_phys() and
kmemleak_ignore_phys() skip highmem. This patch is based on the
point that CMA regions don't contain pointers to other kmemleak
objects, and ignores CMA regions from reserved memory as what
620951e27457 did.

--
Thanks
Calvin
