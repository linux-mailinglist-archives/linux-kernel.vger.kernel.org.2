Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A95F330D058
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 01:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbhBCAhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 19:37:02 -0500
Received: from mga12.intel.com ([192.55.52.136]:16931 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232354AbhBCAhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 19:37:01 -0500
IronPort-SDR: aZlpP+F/Znsh/tzhEzuTv3VhJ556e8mt9DjY1PbrqZxM9Z/UsPvhR9fHWMZAhLRlRSBFgjr5M7
 z0l7raMymnsQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="160125444"
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="160125444"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 16:35:16 -0800
IronPort-SDR: e0b6PI9U7DrCgZmVszAo9xeNxmMhntUio8uRLfgVa9xQIUawRHJEMp13YmkFDc13A4FpVbySu0
 dGenMmxrY8bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="406360451"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128]) ([10.239.159.128])
  by fmsmga004.fm.intel.com with ESMTP; 02 Feb 2021 16:35:14 -0800
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        Yian Chen <yian.chen@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iommu/vt-d: Parse SATC reporting structure
To:     Joerg Roedel <joro@8bytes.org>
References: <20210202044057.615277-1-baolu.lu@linux.intel.com>
 <20210202044057.615277-3-baolu.lu@linux.intel.com>
 <20210202135305.GW32671@8bytes.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <7650bd0f-7084-fd2c-d197-239dffdd7923@linux.intel.com>
Date:   Wed, 3 Feb 2021 08:26:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210202135305.GW32671@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

On 2/2/21 9:53 PM, Joerg Roedel wrote:
> On Tue, Feb 02, 2021 at 12:40:56PM +0800, Lu Baolu wrote:
>> +	case ACPI_DMAR_TYPE_SATC:
>> +		satc = container_of(header, struct acpi_dmar_satc, header);
>> +		pr_info("SATC flags: 0x%x\n", satc->flags);
>> +		break;
> 
> Did the pr_info() slip through or is there a real purpose for having
> this information in the kernel log?
> 

Here is just the easiest way for users to know SATC: system has SATC?
ATS is required?

Best regards,
baolu
