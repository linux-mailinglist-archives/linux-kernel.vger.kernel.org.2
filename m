Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD16834D4DB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 18:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbhC2QX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 12:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbhC2QXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 12:23:22 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A15CC061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 09:23:22 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id y124-20020a1c32820000b029010c93864955so8805976wmy.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 09:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KPclp6vfsh1l0llxq/9bcQXpgR0clJ6jmS6dVL/hig8=;
        b=bj77tl0OjsgCgZLbOb3u3k145orUo71nkMcisB/6plOzX/M2mg3Z4Yb5uDisu9c4pB
         Y53SOJe4s4v6Mhp+CFbq6aMAtV0YnUliuYDu7EDJkfI1uYn+lEi44BJeUdxqKS/tx3ru
         OfU2m9joLw9o3CyDSRJhRXWyX6CADErtPac4qLPNqMsBYAMl4Ls7CdOHxBs62aYJ4XaJ
         yUgTz5aupJxIno4XKcDiaBivqeoEJ6rRqOkSeKzkD+lCKQV3ESKONlrbQU0ZLjQ3/915
         /Mff3SI799c/P5lsfxlGS62u7OScJZG9l13uwvkzhwn9CM6+aup1yF/Jf4SM0qj4lLMj
         WW+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KPclp6vfsh1l0llxq/9bcQXpgR0clJ6jmS6dVL/hig8=;
        b=A2NrdyyKOiFaE7RWbNbGH6YFJ8aED7zPkEjgc+VgBKhcG2l+BuPL30ZEvr+z+6VAfn
         OZsEsZxPVF8wr5HT+PYG8+GYp7VX1GdWvvnyze8SYcCbdORmZRjJtBbuUv/QuZk85cTT
         KdyZn4pFe11L6hMEP+nPBKmQ2wrKkRPp0v9el+SBU8x/V3gAdMifbUxlbflQHkNiRbUs
         XUVST6gP0Li5TyoYTsa4UozJg00tNQkc8f1AXs5YkxDHJftnUbYCqGTGryKTPAR/68qv
         RfZVKIvvq/qL/B6ycZGaIroabTMFpLPZ2vFvcrHdB18D8hAAN5kkcy+m3O5W9H6Dq3Hk
         nlPA==
X-Gm-Message-State: AOAM5315G5M646rweYmXjUz+RSvsYioJOnh0AHbHInm84aO1+6zXF9Y9
        Kjo7ckM+nUho66K42OvmidIyuA==
X-Google-Smtp-Source: ABdhPJwFilW/ot1hZMhT/JWnG2uNUr6y5QBKqC9sEGMBX6tvcW+gfCS/ourdvz2bsJ56tuVkYTAQEw==
X-Received: by 2002:a7b:c2f7:: with SMTP id e23mr26138332wmk.30.1617035001094;
        Mon, 29 Mar 2021 09:23:21 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id i8sm29594538wrx.43.2021.03.29.09.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 09:23:20 -0700 (PDT)
Date:   Mon, 29 Mar 2021 18:23:02 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Vivek Kumar Gautam <vivek.gautam@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org, joro@8bytes.org,
        will.deacon@arm.com, mst@redhat.com, robin.murphy@arm.com,
        eric.auger@redhat.com, alex.williamson@redhat.com,
        kevin.tian@intel.com, jacob.jun.pan@linux.intel.com,
        yi.l.liu@intel.com, lorenzo.pieralisi@arm.com,
        shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH RFC v1 15/15] iommu/virtio: Update fault type and reason
 info for viommu fault
Message-ID: <YGH+5pHtR6gWnimB@myrica>
References: <20210115121342.15093-1-vivek.gautam@arm.com>
 <20210115121342.15093-16-vivek.gautam@arm.com>
 <YD/GjQIKkaJ5+UJM@myrica>
 <d8a81406-12c6-a5e1-7297-49c1a0a800ab@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8a81406-12c6-a5e1-7297-49c1a0a800ab@arm.com>
X-TUID: vOigyBwZv6w+
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 06:39:05PM +0530, Vivek Kumar Gautam wrote:
> To complete the page request we would also need to send the response back to
> the host from virtio backend when handling page request. So the virtio
> command should also be accompanied with a vfio api to send the page request
> response back to the host. Isn't it?
> This is where the host smmuv3 can send PRI_RESP command to the device to
> complete the page fault.

It looks like Eric already has this in the VFIO series:
https://lore.kernel.org/linux-iommu/20210223210625.604517-14-eric.auger@redhat.com/

Thanks,
Jean
