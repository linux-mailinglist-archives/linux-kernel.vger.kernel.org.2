Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 556CC32D2C5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 13:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240400AbhCDMWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 07:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240387AbhCDMWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 07:22:15 -0500
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B905C061574;
        Thu,  4 Mar 2021 04:21:35 -0800 (PST)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 342BF22E; Thu,  4 Mar 2021 13:21:33 +0100 (CET)
Date:   Thu, 4 Mar 2021 13:21:31 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     thierry.reding@gmail.com, will@kernel.org,
        guillaume.tucker@collabora.com, vdumpa@nvidia.com,
        jonathanh@nvidia.com, digetx@gmail.com,
        linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/tegra-smmu: Fix mc errors on tegra124-nyan
Message-ID: <20210304122131.GC26414@8bytes.org>
References: <20210218220702.1962-1-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218220702.1962-1-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 18, 2021 at 02:07:02PM -0800, Nicolin Chen wrote:
>  drivers/iommu/tegra-smmu.c | 72 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 71 insertions(+), 1 deletion(-)

Applied for v5.12, thanks.
