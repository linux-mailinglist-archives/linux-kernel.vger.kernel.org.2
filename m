Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B93AD3C8344
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 12:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbhGNKzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 06:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbhGNKzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 06:55:17 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BFAC06175F;
        Wed, 14 Jul 2021 03:52:26 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 753AD352; Wed, 14 Jul 2021 12:52:24 +0200 (CEST)
Date:   Wed, 14 Jul 2021 12:52:23 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krishna Reddy <vdumpa@nvidia.com>,
        Will Deacon <will@kernel.org>, linux-tegra@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] iommu/tegra-smmu: Change debugfs directory name
Message-ID: <YO7B56Mkz3kx5U5Q@8bytes.org>
References: <20210712001341.11166-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210712001341.11166-1-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2021 at 03:13:41AM +0300, Dmitry Osipenko wrote:
> -	err = iommu_device_sysfs_add(&smmu->iommu, dev, NULL, dev_name(dev));
> +	err = iommu_device_sysfs_add(&smmu->iommu, dev, NULL, "smmu");

Are you sure no one is relying on the old name so that this change
breaks ABI? Also this change means that there is always be only one SMMU
per system. Is that guaranteed too?

Regards,

	Joerg
