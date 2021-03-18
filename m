Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0B2340191
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 10:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhCRJND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 05:13:03 -0400
Received: from 8bytes.org ([81.169.241.247]:59534 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229564AbhCRJMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 05:12:53 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id BF6D82D8; Thu, 18 Mar 2021 10:12:47 +0100 (CET)
Date:   Thu, 18 Mar 2021 10:12:46 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     "Raj, Ashok" <ashok.raj@intel.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>, Will Deacon <will@kernel.org>,
        kevin.tian@intel.com, jacob.jun.pan@intel.com, yi.l.liu@intel.com,
        sanjay.k.kumar@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] iommu/vt-d: Remove WO permissions on second-level
 paging entries
Message-ID: <YFMZjiGT13S2TZ6H@8bytes.org>
References: <20210225062654.2864322-1-baolu.lu@linux.intel.com>
 <20210225062654.2864322-3-baolu.lu@linux.intel.com>
 <20210304122623.GD26414@8bytes.org>
 <c7bffaee-6c3c-3254-a71a-d66d023d1e58@linux.intel.com>
 <20210308194746.GA15436@otc-nc-03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308194746.GA15436@otc-nc-03>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Mar 08, 2021 at 11:47:46AM -0800, Raj, Ashok wrote:
> That is the primary motivation, given that we have moved to 1st level for
> general IOVA, first level doesn't have a WO mapping. I didn't know enough
> about the history to determine if a WO without a READ is very useful. I
> guess the ZLR was invented to support those cases without a READ in PCIe. I

Okay, please update the commit message and re-send. I guess these
patches are 5.13 stuff. In that case, Baolu can include them into his
pull request later this cycle.

Regards,

	Joerg
