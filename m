Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81AA539BC17
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 17:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbhFDPkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 11:40:11 -0400
Received: from 8bytes.org ([81.169.241.247]:42382 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230108AbhFDPkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 11:40:11 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 1CCB73A9; Fri,  4 Jun 2021 17:38:24 +0200 (CEST)
Date:   Fri, 4 Jun 2021 17:38:22 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Nadav Amit <namit@vmware.com>, Will Deacon <will@kernel.org>,
        Jiajun Cao <caojiajun@vmware.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 0/4] iommu/amd: Enable page-selective flushes
Message-ID: <YLpI7tKtsf4l5MlN@8bytes.org>
References: <20210524224159.32807-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210524224159.32807-1-namit@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nadav,

[Adding Robin]

On Mon, May 24, 2021 at 03:41:55PM -0700, Nadav Amit wrote:
> Nadav Amit (4):
>   iommu/amd: Fix wrong parentheses on page-specific invalidations

This patch is already upstream in v5.13-rc4. Please rebase to that
version.

>   iommu/amd: Selective flush on unmap
>   iommu/amd: Do not sync on page size changes
>   iommu/amd: Do not use flush-queue when NpCache is on

And I think there have been objections from Robin Murphy on Patch 3,
have those been worked out?

Regards,

	Joerg
