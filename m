Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B2D3316F4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 20:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhCHTF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 14:05:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:44782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229701AbhCHTFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 14:05:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6005265296
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 19:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615230343;
        bh=R1rZmVaVvjoZHSq0MeocIwyK7X5t9Cgt5fsNcUmcg0w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vQ85r2gJhzWZyS3Z1Gzr29JNh8EbH0qMgxZ9jya/fCUyWXfvtdt48O6UpSHSB/gvN
         ZKcdaAoD1wuApWyzJIuj96JOgDmAmpTa2w8C2L7Wc5nDGrp8K7eji0pTuaudKDcsXG
         +MZm3M6fj3nrvq4WNDwIoCN0TQQ57axE2xZIGWyiGI9N01VKp+6MvDLRJXelfE0Whr
         shrFaVnIogkBWlyBKnku4IUfqAweDPsMVpPi1s2gbIsI2VLJb/haLqZ/sopiQgane4
         PoLYZIEGR/Zfv4xaca1Woh9/lODGkAb9oBFTcZFsU7EL1Q7qahG5vn2nUYF98DXy8e
         7heL5AhQV7SOw==
Received: by mail-ot1-f53.google.com with SMTP id j8so10331233otc.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 11:05:43 -0800 (PST)
X-Gm-Message-State: AOAM531wosBIqznUqOrUThF1e69Pmu9lsYRQzfexivE57daYG4v2i/ad
        /nH3P35tjPUp+9YXVHOQ7opZseW2hPdGkDfaHo0=
X-Google-Smtp-Source: ABdhPJxO5GgsPMAdySatZEpnLT5ES1NNv5sH2i/FK9scIBoJLHmJYX1m+WNKtYZ9Jv1tGw1FZ/zrD77JQAREU7zsxeA=
X-Received: by 2002:a05:6830:148c:: with SMTP id s12mr3345826otq.251.1615230342591;
 Mon, 08 Mar 2021 11:05:42 -0800 (PST)
MIME-Version: 1.0
References: <20210308153359.2513446-1-arnd@kernel.org> <176cae4d-33bc-1d51-a7d7-58eeeea5180e@amd.com>
In-Reply-To: <176cae4d-33bc-1d51-a7d7-58eeeea5180e@amd.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 8 Mar 2021 20:05:25 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0nUKSJ2+knM6+REp8HXRFbz5-DmNRAusezkT+XzZQa7Q@mail.gmail.com>
Message-ID: <CAK8P3a0nUKSJ2+knM6+REp8HXRFbz5-DmNRAusezkT+XzZQa7Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: fix build error with missing AMD_IOMMU_V2
To:     Felix Kuehling <felix.kuehling@amd.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Philip Yang <philip.yang@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 8, 2021 at 5:24 PM Felix Kuehling <felix.kuehling@amd.com> wrote:
>
> The driver build should work without IOMMUv2. In amdkfd/Makefile, we
> have this condition:
>
> ifneq ($(CONFIG_AMD_IOMMU_V2),)
> AMDKFD_FILES += $(AMDKFD_PATH)/kfd_iommu.o
> endif
>
> In amdkfd/kfd_iommu.h we define inline stubs of the functions that are
> causing your link-failures if IOMMU_V2 is not enabled:
>
> #if defined(CONFIG_AMD_IOMMU_V2_MODULE) || defined(CONFIG_AMD_IOMMU_V2)
> ... function declarations ...
> #else
> ... stubs ...
> #endif

Right, that is the problem I tried to explain in my patch description.

Should we just drop the 'imply' then and add a proper dependency like this?

      depends on DRM_AMDGPU && (X86_64 || ARM64 || PPC64)
      depends on AMD_IOMMU_V2=y || DRM_AMDGPU=m

I can send a v2 after some testing if you prefer this version.

        Arnd
