Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD85C30C004
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 14:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbhBBNrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 08:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbhBBNoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 08:44:39 -0500
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD0EC061573
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 05:44:23 -0800 (PST)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 0ACDF3D4; Tue,  2 Feb 2021 14:44:20 +0100 (CET)
Date:   Tue, 2 Feb 2021 14:44:19 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix compile error
 [-Werror=implicit-function-declaration]
Message-ID: <20210202134419.GU32671@8bytes.org>
References: <20210130151907.3929148-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210130151907.3929148-1-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 30, 2021 at 11:19:07PM +0800, Lu Baolu wrote:
>  drivers/iommu/intel/Makefile       | 2 +-
>  drivers/iommu/intel/iommu.c        | 1 -
>  include/trace/events/intel_iommu.h | 2 --
>  3 files changed, 1 insertion(+), 4 deletions(-)

Applied, thanks.
