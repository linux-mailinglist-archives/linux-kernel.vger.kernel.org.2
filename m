Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78883DDBE0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 17:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234749AbhHBPHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 11:07:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:59580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234291AbhHBPHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 11:07:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 716CA60FF2;
        Mon,  2 Aug 2021 15:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627916810;
        bh=NUdIGVwiZymoyNB/NN4kI7nxgXjg9XtLvBPXAOcs2bk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RR+g/cJtTrD9M2DX63ufO+0V+JDARSoR2JvxOBsY1rqroBmzmk093PDotL7P08gKC
         nqInY6k6+td0SvNsDxUmvXWb3BtFohQSqA6m6wLAXEnpq05klahF/gtakgaRfbHU39
         1yGwYLv+zRyCIFLRUPjJfY5hj5om3/VeOyu5IxvL3CNFrTqPiRo94w1D9isb9aIrX5
         7JigCMnsmAh+XK2t7U2xZ0aq5fCWPh38WRXwa3A6oVhKZLLbR+0u54i2JdQ/qRPVG4
         0zTls9MTaawy/8gxjrbUPApkwUbtY8s8x+y7IWwNjUsu+IMVoiLzBO6LgKIMTGmVIn
         O/+9pmIb1QJHg==
Date:   Mon, 2 Aug 2021 16:06:44 +0100
From:   Will Deacon <will@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     joro@8bytes.org, robin.murphy@arm.com, baolu.lu@linux.intel.com,
        iommu@lists.linux-foundation.org, linuxarm@huawei.com,
        thierry.reding@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        jonathanh@nvidia.com, sakari.ailus@linux.intel.com,
        bingbu.cao@intel.com, tian.shu.qiu@intel.com, mchehab@kernel.org,
        gregkh@linuxfoundation.org, digetx@gmail.com, mst@redhat.com,
        jasowang@redhat.com, linux-kernel@vger.kernel.org,
        chenxiang66@hisilicon.com
Subject: Re: [PATCH v4 5/6] iova: Add iova_len argument to init_iova_domain()
Message-ID: <20210802150644.GD28735@willie-the-truck>
References: <1626259003-201303-1-git-send-email-john.garry@huawei.com>
 <1626259003-201303-6-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626259003-201303-6-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 06:36:42PM +0800, John Garry wrote:
> Add max opt argument to init_iova_domain(), and use it to set the rcaches
> range.
> 
> Also fix up all users to set this value (at 0, meaning use default).

Wrap that in init_iova_domain_defaults() to avoid the mysterious 0?

Will
