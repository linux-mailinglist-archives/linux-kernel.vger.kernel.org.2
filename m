Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA116360ACE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 15:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233355AbhDONoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 09:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233454AbhDONoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 09:44:11 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD95C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 06:43:48 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 17ED5387; Thu, 15 Apr 2021 15:43:47 +0200 (CEST)
Date:   Thu, 15 Apr 2021 15:43:45 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Sanjay Kumar <sanjay.k.kumar@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix build error of pasid_enable_wpe()
 with !X86
Message-ID: <YHhDEfcxBrn898eW@8bytes.org>
References: <20210411062312.3057579-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210411062312.3057579-1-baolu.lu@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 11, 2021 at 02:23:12PM +0800, Lu Baolu wrote:
>  drivers/iommu/intel/pasid.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.
