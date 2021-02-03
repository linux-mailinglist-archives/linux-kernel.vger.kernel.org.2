Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB7B130D6AC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 10:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbhBCJu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 04:50:29 -0500
Received: from mga18.intel.com ([134.134.136.126]:49792 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233439AbhBCJuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 04:50:25 -0500
IronPort-SDR: H8aBzOwgwvL0Qehtjy/r9mlDrYGDpwaWGX4S59CUYtWaocog0OCOu9wKlgVFk5y4+G3htwUAMm
 l/a9dtzJFbFw==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="168695234"
X-IronPort-AV: E=Sophos;i="5.79,398,1602572400"; 
   d="scan'208";a="168695234"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 01:48:38 -0800
IronPort-SDR: z7L5sj5sm456OIh0RnRHAfZ7lYa+DIEDxbjIPakmowt1eQjPoMxpFsbihLkOHIdqSuCyEZB1SC
 ruJsaFLXSn+A==
X-IronPort-AV: E=Sophos;i="5.79,398,1602572400"; 
   d="scan'208";a="371356323"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.210.211]) ([10.254.210.211])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 01:48:36 -0800
Cc:     baolu.lu@linux.intel.com, Will Deacon <will@kernel.org>,
        Yian Chen <yian.chen@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] iommu/vt-d: Add support for ACPI/SATC table
To:     Joerg Roedel <joro@8bytes.org>
References: <20210203093329.1617808-1-baolu.lu@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <7217f395-4998-ae81-8e9d-a08bc49956a7@linux.intel.com>
Date:   Wed, 3 Feb 2021 17:48:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210203093329.1617808-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the change log. Sorry for the quick sent.

On 2021/2/3 17:33, Lu Baolu wrote:
> The Intel VT-d specification v3.2 comes with a new ACPI SATC (SoC-
> Integrated Address Translation Cache) reporting structure. The SoC
> integrated device enumerated in this table has a functional
> requirement to enable its ATC (Address Translation Cache) via the
> ATS capability for device operation.
> 
> This patch set adds the code to parse the SATC table, enumerates the
> devices in it and satisfies the ATS requirement for them. Please help
> to review. I will queue it in VT-d update for v5.12 if no objection.
> 

Change log:
v1->v2:
  - Rephrase some words in the cover letter, commit message and
    code comments.
  - Refactored a code style to make it look nicer.

Best regards,
baolu

> Yian Chen (3):
>    iommu/vt-d: Add new enum value and structure for SATC
>    iommu/vt-d: Parse SATC reporting structure
>    iommu/vt-d: Apply SATC policy
> 
>   drivers/iommu/intel/dmar.c  |   8 ++
>   drivers/iommu/intel/iommu.c | 162 +++++++++++++++++++++++++++++++++++-
>   include/acpi/actbl1.h       |  11 ++-
>   include/linux/dmar.h        |   2 +
>   4 files changed, 178 insertions(+), 5 deletions(-)
> 
