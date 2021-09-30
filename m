Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D611741D5AF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 10:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348785AbhI3IvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 04:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348233AbhI3IvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 04:51:21 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9324C06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 01:49:38 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id l18-20020a05600c4f1200b002f8cf606262so7725593wmq.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 01:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W9cgTk6h0wqbwfayatXQtxHz8mob4jZCCoq7sCyhp1s=;
        b=eDUuL0ja//PuyQ4fz3l1hxyHwsDpNJ5f3l6+0Y2z6OfrW7O1uddJSWX4e7FGcFAMa1
         9LYUj8wO2yxSk/JUNdXvJq7aO5QrczADrIhrCk9uRBbQ4qb4YCaYdI/OVVhhAhSc5G8s
         f38pfWZD4da7JbtDolq6vbv3GKZ8vfXXVer4xPD4lYLWQ17RIz8v2SSckshCMfFywrWM
         UiwZcc3qwiw681dRJuv/gMZBn7y8RLyJtR85zXh0uCuxlNfSC+P54nKcc5Y5Owgqqw+o
         iI8GiFwU1oejKRoluZVITVWv/sZQoKnvBqERIZpoi/u+vWuFOaaQQIMW5dUWY+SfYO6U
         lExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W9cgTk6h0wqbwfayatXQtxHz8mob4jZCCoq7sCyhp1s=;
        b=OonP8b6nxD5w9GXNoxsZungW/FKKTmKUT8l0Yn/Ll3m0V925gMU5qCEHrNI6TgzHNS
         2V+GdmMbJkadVEc48u3o/Olh/hMUDT6b8Hy93ewxpcBF7IARseZMQI/0kkWIhU/MohjZ
         Fjm4T+aY5/ibJ2B1ps4Dzil2rmyqBJTJfJJlejAGOhFC9HcOX3+3miqJy81V2CEttu4z
         KABfcQQ4O1FkmZDxr415AbQ8N58Keii5TxjWO+DBB4n/lEpSZyVJGUkkVnmpvp3XVroF
         9H2Ddnk7R4TFFQ7+TSiXEKgvqe5kvehxrn9d7RYLlw7b3AIYIYX3WAWRb7n3uUsaX07/
         1mCQ==
X-Gm-Message-State: AOAM532ZAjnCo/HPvjxKSB1VAA3No7fvKoc45KEsDrWeLUwUoRx/Jsyt
        ZHvgTw7aru9DGZGxZQhki8/2yw==
X-Google-Smtp-Source: ABdhPJx7UmI5t0e1WRrw+EyEdQREOHgR4PKY+8e7EznFDej38q+RoHIFqgsrXw9rDiLo5EFXAV7sIg==
X-Received: by 2002:a7b:c948:: with SMTP id i8mr14365780wml.193.1632991777323;
        Thu, 30 Sep 2021 01:49:37 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id n66sm2295448wmn.2.2021.09.30.01.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 01:49:36 -0700 (PDT)
Date:   Thu, 30 Sep 2021 09:49:16 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Vivek Kumar Gautam <vivek.gautam@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org, joro@8bytes.org,
        will.deacon@arm.com, mst@redhat.com, robin.murphy@arm.com,
        eric.auger@redhat.com, kevin.tian@intel.com,
        jacob.jun.pan@linux.intel.com, yi.l.liu@intel.com,
        Lorenzo.Pieralisi@arm.com, shameerali.kolothum.thodi@huawei.com,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH RFC v1 01/11] uapi/virtio-iommu: Add page request grp-id
 and flags information
Message-ID: <YVV6DD7zmy1MKva0@myrica>
References: <20210423095147.27922-1-vivek.gautam@arm.com>
 <20210423095147.27922-2-vivek.gautam@arm.com>
 <YUoBHA6NZaz8wlkA@myrica>
 <3b490967-58b5-7c4a-2275-250e26d24aeb@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b490967-58b5-7c4a-2275-250e26d24aeb@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 10:26:35AM +0530, Vivek Kumar Gautam wrote:
> > I'm not sure why we made it 32-bit in Linux UAPI, it's a little wasteful.
> > PCIe PRGI is 9-bits and SMMU STAG is 16-bits. Since the scope of the grpid
> > is the endpoint, 16-bit means 64k in-flight faults per endpoint, which
> > seems more than enough.
> 
> Right, I will update this to 16-bits field. It won't be okay to update the
> iommu uAPI now, right?

Since there is no UAPI transport for the fault request/response at the
moment, it should be possible to update it.

Thanks,
Jean
