Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31D5A332D59
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 18:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbhCIRen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 12:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbhCIReP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 12:34:15 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B61CC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 09:34:15 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 124-20020a1c00820000b029010b871409cfso7243547wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 09:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=u2Jgq2SnEUtYvh+N+tLW1yt3xw0hfp1QxcwgyedJ7ds=;
        b=qJyWMJ60xOqK0ZUsA2dlaXWSGFKGH3Yvm6uAgMQJAXNEPWydlYRk8aq9iAaoFgqdm4
         KfHU/rYSqzlLw6DjYgzy+0ubuR3EQHX0GgxFtDVTL8pmxBv2t62G2xik5b026iT+pt+S
         E36q/xu+DnxEGX31iTZRh5KQT4wWhdovQaUJEG9KQtEtF0JbMy5LIqdi14SepZWK4+7b
         j/ZPgEOWBqH6kCWswHqw+3kWCGIdkXwpJPN3wYXXstSKWTjL9Ev6jN4USnUz/FMlvuE4
         +yH3FHbcxiopniS/RMPTfquoFNP+16GDnuM55pO1njHe2VqIUOrdXiRw13CaLmROpLav
         BVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u2Jgq2SnEUtYvh+N+tLW1yt3xw0hfp1QxcwgyedJ7ds=;
        b=ORTNCLJd3CHxgFc0jRQeuDJioM60viF/svcviaQdRGOBUv497r54fzX7CG/Ys6wNeo
         GaFTDsySuuOz5LmrvFVbES86NFMvWtx9hb1VE5jiEMbG97sq1I5UVHd1vZaSEpHa+xHt
         1XqF/Oz5VjvY3/o2ReHUgIhtdJPUgqMhP92iYg+l3NYqPuIW032WcuSIn+hLNHHzRN8s
         zoARLbDB+cY0v+WzezLAByjsgn3ULEzW8XQSIlHSoqeiWTiDoB37Wj2ApTfIY6yUL7ip
         SnTxIvEoaJfcl8h5gRk6/CMHGR901Kbnh7notI8YbIT/GYUJmHUKvFQkFKxKY7PoMARf
         GzUQ==
X-Gm-Message-State: AOAM531hB82F039TvKzjl182xfTFkT/tuQCkzxjXe/PadiCwWG7jxbzo
        Fy5YJqF0jSXkQu0WctURKXuNxA==
X-Google-Smtp-Source: ABdhPJx6ZdYnpNQLX/O7M2VYIdw9Lzlp44StIKqfq7yUlf4Hzk6VAEa3cWvsT55R4PRXOBUooXO2sQ==
X-Received: by 2002:a1c:e912:: with SMTP id q18mr5325693wmc.59.1615311254016;
        Tue, 09 Mar 2021 09:34:14 -0800 (PST)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id w6sm25973243wrl.49.2021.03.09.09.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 09:34:13 -0800 (PST)
Date:   Tue, 9 Mar 2021 18:33:51 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Felix Kuehling <felix.kuehling@amd.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        David Airlie <airlied@linux.ie>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Will Deacon <will@kernel.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: Re: [PATCH 1/1] drm/amdkfd: fix build error with AMD_IOMMU_V2=m
Message-ID: <YEexf0/V/YF394bf@myrica>
References: <4c692eff-9d57-278e-8da4-36bc2c293506@amd.com>
 <20210309032356.20800-1-Felix.Kuehling@amd.com>
 <CAK8P3a1EeHimbufajcHzV+-bBarWtLHzzFSsa=qdUDsip=Wz_A@mail.gmail.com>
 <8023bb6b-b6aa-230c-afa5-871ce32782c6@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8023bb6b-b6aa-230c-afa5-871ce32782c6@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felix,

On Tue, Mar 09, 2021 at 11:30:19AM -0500, Felix Kuehling wrote:
> > I think the proper fix would be to not rely on custom hooks into a particular
> > IOMMU driver, but to instead ensure that the amdgpu driver can do everything
> > it needs through the regular linux/iommu.h interfaces. I realize this
> > is more work,
> > but I wonder if you've tried that, and why it didn't work out.
> 
> As far as I know this hasn't been tried. I see that intel-iommu has its
> own SVM thing, which seems to be similar to what our IOMMUv2 does. I
> guess we'd have to abstract that into a common API.

The common API was added in 26b25a2b98e4 and implemented by the Intel
driver in 064a57d7ddfc. To support it an IOMMU driver implements new IOMMU
ops:
	.dev_has_feat()
	.dev_feat_enabled()
	.dev_enable_feat()
	.dev_disable_feat()
	.sva_bind()
	.sva_unbind()
	.sva_get_pasid()

And a device driver calls iommu_dev_enable_feature(IOMMU_DEV_FEAT_SVA)
followed by iommu_sva_bind_device().

If I remember correctly the biggest obstacle for KFD is the PASID
allocation, done by the GPU driver instead of the IOMMU driver, but there
may be others.

Thanks,
Jean
