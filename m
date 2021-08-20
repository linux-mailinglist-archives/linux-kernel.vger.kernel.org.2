Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A163F2C37
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 14:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237924AbhHTMjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 08:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233303AbhHTMjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 08:39:41 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB56C061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 05:39:04 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id F13D630F; Fri, 20 Aug 2021 14:39:01 +0200 (CEST)
Date:   Fri, 20 Aug 2021 14:38:55 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Will Deacon <will@kernel.org>
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, vdumpa@nvidia.com
Subject: Re: [PATCH -next] iommu/arm-smmu: Fix missing unlock on error in
 arm_smmu_device_group()
Message-ID: <YR+iX0HQrr0Un2Kl@8bytes.org>
References: <20210820074949.1946576-1-yangyingliang@huawei.com>
 <20210820104111.GC17267@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820104111.GC17267@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 11:41:11AM +0100, Will Deacon wrote:
> Joerg -- please can you throw this on top?

Sure, now applied, thanks.
