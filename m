Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF2434E976
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 15:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbhC3NnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 09:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbhC3Nmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 09:42:44 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6D9C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 06:42:43 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id z6-20020a1c4c060000b029010f13694ba2so8427924wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 06:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pnUANKY68LFCHKnXAlNl92vZ5QNwZhc3rycWb9aJ4U4=;
        b=cXrleCcTe2edFKE7JXHrs9Bj1XROOQncYe9/RXuKuyYfg1oiY9hkloCupeUygrymIP
         9ayZSOUA/kzg9omudYLIbfliaSwzsF8t2WjsUk7aasxaQAZ65kiYcqVsJssvwnbqXWaQ
         7tP999kzGqM64anG+FHHGrYwPo3CD/MmoJSW67AsljQ3h4bpd7h5J0oHBBrJFcYhNPQZ
         jSvprN5HGew9kx/NPjUMKVuGbUtOweyWIunsFY/SwCVoa+64VGBhAnUWkD+o4ORO7eF3
         KDrvwGNAF2EaQH0lzuiBF6N51eP9jHBLGYuCYZ1yO4oXRNlIuT6R6Tj2RPOAmd0YGpIB
         8yZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pnUANKY68LFCHKnXAlNl92vZ5QNwZhc3rycWb9aJ4U4=;
        b=tskG1yCZWqgisfBfEDzWO8DLJ51sL5N4NAS/bh5qDaHywX/If4R6We9Cyr0E8NCI7M
         tKgfYqlEWqALQ5E38U3e5z1ONST9A3OKEVOSq/HQI5Chr5HJ3bNBFYAXeTxIjiIprV4w
         sWIy/YwuvxQeGyiK2mgM3YpcaqYgrhuBRnQw5IZW4n3yMp7+SJy+tNb6O39tG58Fptmd
         8Tbh4zrjgmE8v/SKgmBCDxacKyA0g4fipA5prRjFHLCgcmnOOfYQ0NbdYLA/SqL+QCq6
         hFG+tHJk8P1ZAxxBBG4AeHCk2wCV/az506QSpijhLrv7vHn95xMQrL341srBH0bSV4E2
         TURw==
X-Gm-Message-State: AOAM530q8emva/ue+wpA706vM70iG6zJLhIepFzdq0EN7LHiISmv+Ub6
        UcrS9n/digjfL3HJqJYkFx88MZ/WkwO1hA==
X-Google-Smtp-Source: ABdhPJyEaNmHwXDqXeg3ddAYPI76jKgTBEKWlhppYOYHuQly+QNGJJ3PVIlHNTsLl1NMwgMgoe4Ywg==
X-Received: by 2002:a1c:7905:: with SMTP id l5mr4234551wme.181.1617111762614;
        Tue, 30 Mar 2021 06:42:42 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id u20sm36588716wru.6.2021.03.30.06.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 06:42:42 -0700 (PDT)
Date:   Tue, 30 Mar 2021 15:42:24 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, cgroups@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Message-ID: <YGMqwPnYjSfV+Cbr@myrica>
References: <20210319112221.5123b984@jacob-builder>
 <YFhiMLR35WWMW/Hu@myrica>
 <20210324100246.4e6b8aa1@jacob-builder>
 <20210324170338.GM2356281@nvidia.com>
 <20210324151230.466fd47a@jacob-builder>
 <YFxkNEz3THJKzW0b@myrica>
 <20210325100236.17241a1c@jacob-builder>
 <20210325171645.GF2356281@nvidia.com>
 <YF2WEmfXsXKCkCDb@myrica>
 <20210330130755.GN2356281@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330130755.GN2356281@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 10:07:55AM -0300, Jason Gunthorpe wrote:
> On Fri, Mar 26, 2021 at 09:06:42AM +0100, Jean-Philippe Brucker wrote:
> 
> > It's not inconceivable to have a control queue doing DMA tagged with
> > PASID. The devices I know either use untagged DMA, or have a choice to use
> > a PASID.
> 
> I don't think we should encourage that. A PASID and all the related is
> so expensive compared to just doing normal untagged kernel DMA.

How is it expensive?  Low number of PASIDs, or slowing down DMA
transactions?  PASIDs aren't a scarce resource on Arm systems, they have
almost 1M unused PASIDs per VM.

Thanks,
Jean

> I assume HW has these features because virtualization use cases might
> use them, eg by using mdev to assign a command queue - then it would
> need be be contained by a PASID.
> 
> Jason
