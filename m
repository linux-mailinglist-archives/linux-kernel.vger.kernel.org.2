Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07F2236C1F6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 11:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235220AbhD0JnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 05:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbhD0JnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 05:43:13 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA43C061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 02:42:30 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id x14so5350004qvr.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 02:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xZp+omIfpjqx0dOZjT8YOPOoTGLrVGaiXPBJR5pJjuM=;
        b=TNxknECt4W/zYw9tFnsMVcw53SpOaMiuMBNjLnRaB3s4VR2BcWbXiey7UpRFMnziG2
         Pnx75BRSOcxMeQfBB05Q1OSfty1M+ZcSQml7RON27tpl2dWSk1N9Y3hbKSSqJkZ4N750
         kO50D46i8NzCQenZg3IAFeGAMdBWp/gIa68A0FTLmbS3nTQzz5p3XJi/br6zXugC9YYC
         tHIKDr/8VDTud1fLMTiNLQfdpdgadYLxTbOtCTjzkWzoJXEjUBxqWhbf4+Zm9CPNW5yG
         6ZiFKXXqE9liPfYp4W+2k0N/5XJ07c3lmDzMeflN9LiMvDIuP7bYZjoDEYY7x63bhXe8
         9WmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xZp+omIfpjqx0dOZjT8YOPOoTGLrVGaiXPBJR5pJjuM=;
        b=qRt7XuA2UvV/GjMrxHN+sX2mKfNBx6YjftxOrU4zA6En0Np6Hl2gkjyO7p2tMKnElO
         uikgUPju6cpGoth0X9sfZpyAHYYArMiHlIzZWcYAwa4G/QkDIf+z7cT/N1rXa5PY9dsl
         exRGFiEmxo1KIjqgcsU7fDmRe/PREnHnyWK0ioJIZirPQZdql4tFxo4WkOs3AzRUgk9/
         ic0n454PEA6L+4LrOAJ3Npjge2KDGj8i3r43xiThf2HKBLgLp0NLSm7StZSRIllLY9TG
         7Q1nOeVg6pH/YC9MYZF6D6AtbUAMroA7pXLNPA90OQvUr2RG6BVkPsEtx4asVBD8Wzz4
         wOXQ==
X-Gm-Message-State: AOAM530/JFJ4CWGV+PEDYXjABGnw+iog06YY3OWKPE1ho3+B/LJNGD6w
        CpW6RdTD2fZAl3LvwkeIMoRHGbf/kDX2hn/i5I0=
X-Google-Smtp-Source: ABdhPJw1i5Ej085FKx+9AZJe13/YmFRyDry5nNqfqusksuz2dBIfZ+nFvKDw46T8C00sEUQkZUoeAJQAVGRBxNjms2Q=
X-Received: by 2002:a05:6214:da7:: with SMTP id h7mr22459682qvh.48.1619516549875;
 Tue, 27 Apr 2021 02:42:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210426124340.4238-1-lyl2019@mail.ustc.edu.cn>
In-Reply-To: <20210426124340.4238-1-lyl2019@mail.ustc.edu.cn>
From:   Matthew Auld <matthew.william.auld@gmail.com>
Date:   Tue, 27 Apr 2021 10:42:03 +0100
Message-ID: <CAM0jSHN3niCs2bQ6bsP1YmdmWcQS17wt-Yo=730q9f_zES=dBQ@mail.gmail.com>
Subject: Re: [PATCH] drm/i9i5/gt: Fix a double free in gen8_preallocate_top_level_pdp
To:     Lv Yunlong <lyl2019@mail.ustc.edu.cn>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Apr 2021 at 13:44, Lv Yunlong <lyl2019@mail.ustc.edu.cn> wrote:
>
> Our code analyzer reported a double free bug.
>
> In gen8_preallocate_top_level_pdp, pde and pde->pt.base are allocated
> via alloc_pd(vm) with one reference. If pin_pt_dma() failed, pde->pt.base
> is freed by i915_gem_object_put() with a reference dropped. Then free_pd
> calls free_px() defined in intel_ppgtt.c, which calls i915_gem_object_put()
> to put pde->pt.base again.
>
> As pde->pt.base is protected by refcount, so the second put will not free
> pde->pt.base actually. But, maybe it is better to remove the first put?
>
> Fixes: 82adf901138cc ("drm/i915/gt: Shrink i915_page_directory's slab bucket")
> Signed-off-by: Lv Yunlong <lyl2019@mail.ustc.edu.cn>

Yes, it looks like this fixes a potential use-after-free. Thanks for the patch,
Reviewed-by: Matthew Auld <matthew.auld@intel.com>

Pushed to drm-intel-gt-next.
