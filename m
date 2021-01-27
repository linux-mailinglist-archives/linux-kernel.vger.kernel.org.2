Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26C62305AE7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 13:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235339AbhA0MKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 07:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237641AbhA0MHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 07:07:24 -0500
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A264C061573
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 04:06:44 -0800 (PST)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 14E8F303; Wed, 27 Jan 2021 13:06:42 +0100 (CET)
Date:   Wed, 27 Jan 2021 13:06:40 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        will@kernel.org
Subject: Re: [PATCH v4 00/13] iommu/amd: Add Generic IO Page Table Framework
 Support
Message-ID: <20210127120640.GF32671@8bytes.org>
References: <20201215073705.123786-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215073705.123786-1-suravee.suthikulpanit@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suravee,

On Tue, Dec 15, 2020 at 01:36:52AM -0600, Suravee Suthikulpanit wrote:
 
> Suravee Suthikulpanit (13):
>   iommu/amd: Re-define amd_iommu_domain_encode_pgtable as inline
>   iommu/amd: Prepare for generic IO page table framework
>   iommu/amd: Move pt_root to struct amd_io_pgtable
>   iommu/amd: Convert to using amd_io_pgtable
>   iommu/amd: Declare functions as extern
>   iommu/amd: Move IO page table related functions
>   iommu/amd: Restructure code for freeing page table
>   iommu/amd: Remove amd_iommu_domain_get_pgtable
>   iommu/amd: Rename variables to be consistent with struct
>     io_pgtable_ops
>   iommu/amd: Refactor fetch_pte to use struct amd_io_pgtable
>   iommu/amd: Introduce iommu_v1_iova_to_phys
>   iommu/amd: Introduce iommu_v1_map_page and iommu_v1_unmap_page
>   iommu/amd: Adopt IO page table framework for AMD IOMMU v1 page table

Applied this series, thanks for the work! Given testing goes well you
can consider this queued for 5.12.

Thanks,

	Joerg
