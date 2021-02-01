Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7DE30ABED
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 16:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbhBAPvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 10:51:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:47962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231556AbhBAPvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 10:51:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A91A464DE1;
        Mon,  1 Feb 2021 15:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612194626;
        bh=LPWd8gDhHLYrCTwScMmESUyKBXeoErabGVfpRcQJr+U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u/FlsACD4oNtPFVRFroArwrcZsqrjWj44oS3N5mE1F7BdrVdQnBCjSNm2Oa+s8k6r
         2WDU8laRguhCNh5YydQb6iyWj1cse4ICOgIjDJ58M+NSYAuA0mxbMzYDG6Q1iYo39P
         C5YepY1LzPeUNLz9+ooUGgO7Eq/MhEfESftRaxYgck8GzsTaE22n/HJxa8I9O3I/nu
         58Jx2bUa1UWE81F1LiKhPzsX096hCd9UF+Nh4K3HrIIgDFU1e8hQd2+q0F92KkCq+5
         saxOHhCgU1glFPBjXFGO4seBSpeDUdl3N8wdbdj8z6lH6QAo+yAKy6JUBJs58pTycY
         25G+SpNrAjjtg==
Date:   Mon, 1 Feb 2021 15:50:21 +0000
From:   Will Deacon <will@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v5 0/1] perf/smmuv3: Don't reserve the PMCG register
 spaces
Message-ID: <20210201155021.GD15263@willie-the-truck>
References: <20210201132750.1709-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201132750.1709-1-thunder.leizhen@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 09:27:49PM +0800, Zhen Lei wrote:
> v4 --> v5:
> 1. Give up doing the mapping for the entire SMMU register space.
> 2. Fix some compile warnings. Sorry. So sorry.

That's alright, these things happen. However, this came in slightly too
late for 5.12, so please resend at -rc1 and we'll aim for 5.13.

Will
