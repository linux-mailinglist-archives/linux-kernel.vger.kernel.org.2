Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C21FB30C4E0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 17:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236035AbhBBQFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 11:05:23 -0500
Received: from mga05.intel.com ([192.55.52.43]:1115 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235200AbhBBQDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 11:03:39 -0500
IronPort-SDR: 9f71r4br8p4SwWmWvqGFHL66BQdyE3DpSRTpoPcYeSzOy0fMtjD1NsPs4PTwucpKtJEzfm1DSn
 u19hYlJvR7jw==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="265708737"
X-IronPort-AV: E=Sophos;i="5.79,395,1602572400"; 
   d="scan'208";a="265708737"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 08:02:05 -0800
IronPort-SDR: WcdYkPRXUqohBorHCWPa39uqCYS2UNGPfQBCshTFXwH9yhdYaBrdh0uXR/pGgbkychYHIhgkmo
 v3VNEOM9HDWA==
X-IronPort-AV: E=Sophos;i="5.79,395,1602572400"; 
   d="scan'208";a="391535200"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 08:02:05 -0800
Date:   Tue, 2 Feb 2021 08:02:03 -0800
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org, Yian Chen <yian.chen@intel.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH 1/3] iommu/vt-d: Add new enum value and structure for SATC
Message-ID: <20210202160203.GC39643@otc-nc-03>
References: <20210202044057.615277-1-baolu.lu@linux.intel.com>
 <20210202044057.615277-2-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202044057.615277-2-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 12:40:55PM +0800, Lu Baolu wrote:
> From: Yian Chen <yian.chen@intel.com>
> 
> Starting from Intel Platform VT-d v3.2, BIOS may provide new remapping
> structure SATC for SOC integrated devices, according to section 8.8 of
> Intel VT-d architecture specification v3.2. The SATC structure reports
> a list of the devices that require SATC enabling via ATS capacity.

nit: s/require SATC/require ATS for normal device operation. This is a
functional requirement that these devices will not work without OS enabling
ATS capability.

> 
> This patch introduces the new enum value and structure to represent the
> remapping information. Kernel should parse the information from the
> reporting structure and enable ATC for the devices as needed.
> 
> Signed-off-by: Yian Chen <yian.chen@intel.com>
> ---
>  include/acpi/actbl1.h | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> index 43549547ed3e..b7ca802b66d2 100644
> --- a/include/acpi/actbl1.h
> +++ b/include/acpi/actbl1.h
> @@ -514,7 +514,8 @@ enum acpi_dmar_type {
>  	ACPI_DMAR_TYPE_ROOT_ATS = 2,
>  	ACPI_DMAR_TYPE_HARDWARE_AFFINITY = 3,
>  	ACPI_DMAR_TYPE_NAMESPACE = 4,
> -	ACPI_DMAR_TYPE_RESERVED = 5	/* 5 and greater are reserved */
> +	ACPI_DMAR_TYPE_SATC = 5,
> +	ACPI_DMAR_TYPE_RESERVED = 6	/* 5 and greater are reserved */
>  };
>  

Think Joerg spotted the comment update.
