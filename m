Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F176037BA4A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 12:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhELKZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 06:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbhELKZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 06:25:54 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE77C061574
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 03:24:45 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id f24so34200296ejc.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 03:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D5hbwLxFDNI5eCJ1EIHByvg5+72F3NmUyyX75vpDxZY=;
        b=sxtTbR1fRqaEwgYzNbx5fzx6gem73axRM0aRweqyX7Mdga9w+G4CWAy7FssbRTG73/
         Cl6Pg7ikFO9DV1HbR7nVr1u7qf7ExGU5a7TbOs9p3j5C7mmDkDfkvQsjksL1J8J+JAAe
         QdVqXaXeljUuwO3Bv5lxVvhgce6Y8vzF7EQOXw+yCdN/UVPbSlW6/GffBrYneJ27qYep
         jJQ0xky7kLMVG/Pgq0LMaFY1K7pabtiT+lYEHEQr7aX8AJ+SfY7FhISNigp5FXIsyuGI
         jOoGgp6FnCBMqQeZBZBl0gtUWetGJumS8yWW8oHlKW1HezL/321Hx+//C12zroitE1f0
         Yjdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D5hbwLxFDNI5eCJ1EIHByvg5+72F3NmUyyX75vpDxZY=;
        b=Xj5bICkq7EKa7qrJoLlqswhO4SXQ8npplfbPawCQYcowoEiCMhbgf2Tj105eQIozaS
         jYEn2k5BNnzQmBdSW9y80zuJvuUaqOw3GEQT5gixobMJctdWjfpsU5RXdm9RDDeiIyQv
         o9qM5mD0N4h9jwqM7s46X6JbyuKHkcNWPnQYmwJIX6ZaFxexRZAUu35Lhk1t/PjZUshB
         cM58RrJXUu4HEUGIV36KLNwdEOAnrjACl3MaL/HK/GAyJICjwJYtP4b7QW1aiGMHRjXa
         lOtvmpzaY5Vt8kElhvbEKLKxnHE5skJoNsqoY9etNJLLElmItt869H/MuGeQMY+Mj00R
         n6xg==
X-Gm-Message-State: AOAM531JFfiODd1hpsTpue5+jTgMpxi1Wrf3D3cQIV9f9xhSg7rk9oGY
        u3lX1iRA341umksjI2EkDnUMgg==
X-Google-Smtp-Source: ABdhPJw/qvzNJC4HUtIWyY8rJmCv8CfFPERoCFAnqifvkhD3ocl8UdpbWAib8ErpdB5JILxmzdzsTw==
X-Received: by 2002:a17:906:b7d9:: with SMTP id fy25mr18736304ejb.156.1620815084018;
        Wed, 12 May 2021 03:24:44 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id c5sm11674591eds.94.2021.05.12.03.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 03:24:43 -0700 (PDT)
Date:   Wed, 12 May 2021 12:24:26 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Christoph Hellwig <hch@infradead.org>,
        Yi Liu <yi.l.liu@intel.com>, Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Dave Jiang <dave.jiang@intel.com>, wangzhou1@hisilicon.com,
        zhangfei.gao@linaro.org, vkoul@kernel.org
Subject: Re: [PATCH v4 2/2] iommu/sva: Remove mm parameter from SVA bind API
Message-ID: <YJus2jvUBfx6ZSVf@myrica>
References: <1620653108-44901-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1620653108-44901-3-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620653108-44901-3-git-send-email-jacob.jun.pan@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 06:25:08AM -0700, Jacob Pan wrote:
> The mm parameter in iommu_sva_bind_device() is intended for privileged
> process perform bind() on behalf of other processes. This use case has
> yet to be materialized, let alone potential security implications of
> adding kernel hooks without explicit user consent.
> In addition, with the agreement that IOASID allocation shall be subject
> cgroup limit. It will be inline with misc cgroup proposal if IOASID
> allocation as part of the SVA bind is limited to the current task.
> 
> Link: https://lore.kernel.org/linux-iommu/20210303160205.151d114e@jacob-builder/
> Link: https://lore.kernel.org/linux-iommu/YFhiMLR35WWMW%2FHu@myrica/
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

I'm not particularly enthusiastic about this change, because restoring the
mm parameter will be difficult after IOMMU drivers start assuming
everything is on current. Regardless, it looks correct and makes my life
easier (and lightens my test suite quite a bit).

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
