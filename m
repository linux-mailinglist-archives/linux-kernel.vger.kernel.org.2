Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3A953D58E9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 13:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbhGZLQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 07:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233522AbhGZLQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 07:16:21 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4D7C061757
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 04:56:49 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 70E9B2B0; Mon, 26 Jul 2021 13:56:48 +0200 (CEST)
Date:   Mon, 26 Jul 2021 13:56:45 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     will@kernel.org, robin.murphy@arm.com,
        Georgi Djakov <quic_c_gdjako@quicinc.com>,
        chenxiang <chenxiang66@hisilicon.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] iommu/vt-d: Implement [map/unmap]_pages callbacks
Message-ID: <YP6i/SlNCBKNtqZb@8bytes.org>
References: <20210720020615.4144323-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720020615.4144323-1-baolu.lu@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2021 at 10:06:12AM +0800, Lu Baolu wrote:
> Lu Baolu (3):
>   iommu/vt-d: Report real pgsize bitmap to iommu core
>   iommu/vt-d: Implement map/unmap_pages() iommu_ops callback
>   iommu/vt-d: Move clflush'es from iotlb_sync_map() to map_pages()

Applied to iommu/core, thanks.
