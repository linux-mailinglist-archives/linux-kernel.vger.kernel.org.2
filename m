Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78D813D66E1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 20:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbhGZSDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 14:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbhGZSD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 14:03:29 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECBEC061757
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 11:43:57 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id E049E59F; Mon, 26 Jul 2021 20:43:52 +0200 (CEST)
Date:   Mon, 26 Jul 2021 20:43:28 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     will@kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
        john.garry@huawei.com, dianders@chromium.org
Subject: Re: [PATCH 16/23] iommu/arm-smmu: Prepare for multiple DMA domain
 types
Message-ID: <YP8CUAl0IDO3wOhx@8bytes.org>
References: <cover.1626888444.git.robin.murphy@arm.com>
 <04220b3420c2c513490450f37de109182364f235.1626888445.git.robin.murphy@arm.com>
 <YP6ukfewNVjgS/bt@8bytes.org>
 <a0689d30-2214-c92e-8387-8f1d3b22909b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a0689d30-2214-c92e-8387-8f1d3b22909b@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 02:09:00PM +0100, Robin Murphy wrote:
> Ha, I had exactly that at one point, except I think in the order of
> iommu_is_dma_domain() :)

That name is fine too :)

> The end result didn't seem to give enough extra clarity to justify the
> header churn for me, but I'm happy to be wrong about that if you prefer.

Developers look more into the code than into headers, so I think the
header churn is worth it to improve code readability. But we can do that
on-top of these changes in an extra patch-set which also introduces
helpers for other domain types (if it is worth it).

Regards,

	Jörg
