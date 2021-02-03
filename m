Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD01E30D041
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 01:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbhBCAZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 19:25:32 -0500
Received: from mga11.intel.com ([192.55.52.93]:27365 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232055AbhBCAZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 19:25:29 -0500
IronPort-SDR: jeyCDb4cHDCCB6phAd99vyAXDRMdSf7TqdEjlGys2ZzTDZEP12EaufgR2dSkc6wT9oGaILyz18
 R4NSOsLuU+sw==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="177451202"
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="177451202"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 16:23:42 -0800
IronPort-SDR: 1ykg705sIja9b9AQIo1Q7F1qWP1UNi9q4rK2gxd6XTTufpFXg5thWZad1Dz+CFV7v5mOdmTVmB
 4G7fALrQa4CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="406357919"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128]) ([10.239.159.128])
  by fmsmga004.fm.intel.com with ESMTP; 02 Feb 2021 16:23:40 -0800
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        Yian Chen <yian.chen@intel.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iommu/vt-d: Add new enum value and structure for SATC
To:     "Raj, Ashok" <ashok.raj@intel.com>
References: <20210202044057.615277-1-baolu.lu@linux.intel.com>
 <20210202044057.615277-2-baolu.lu@linux.intel.com>
 <20210202160203.GC39643@otc-nc-03>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <2d623a51-f9ed-b955-4bc0-aed5ad6a4cef@linux.intel.com>
Date:   Wed, 3 Feb 2021 08:15:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210202160203.GC39643@otc-nc-03>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ashok,

On 2/3/21 12:02 AM, Raj, Ashok wrote:
> On Tue, Feb 02, 2021 at 12:40:55PM +0800, Lu Baolu wrote:
>> From: Yian Chen <yian.chen@intel.com>
>>
>> Starting from Intel Platform VT-d v3.2, BIOS may provide new remapping
>> structure SATC for SOC integrated devices, according to section 8.8 of
>> Intel VT-d architecture specification v3.2. The SATC structure reports
>> a list of the devices that require SATC enabling via ATS capacity.
> 
> nit: s/require SATC/require ATS for normal device operation. This is a
> functional requirement that these devices will not work without OS enabling
> ATS capability.
> 

Yes. This looks clearer.

Best regards,
baolu

>>
>> This patch introduces the new enum value and structure to represent the
>> remapping information. Kernel should parse the information from the
>> reporting structure and enable ATC for the devices as needed.
>>
>> Signed-off-by: Yian Chen <yian.chen@intel.com>
>> ---
>>   include/acpi/actbl1.h | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
>> index 43549547ed3e..b7ca802b66d2 100644
>> --- a/include/acpi/actbl1.h
>> +++ b/include/acpi/actbl1.h
>> @@ -514,7 +514,8 @@ enum acpi_dmar_type {
>>   	ACPI_DMAR_TYPE_ROOT_ATS = 2,
>>   	ACPI_DMAR_TYPE_HARDWARE_AFFINITY = 3,
>>   	ACPI_DMAR_TYPE_NAMESPACE = 4,
>> -	ACPI_DMAR_TYPE_RESERVED = 5	/* 5 and greater are reserved */
>> +	ACPI_DMAR_TYPE_SATC = 5,
>> +	ACPI_DMAR_TYPE_RESERVED = 6	/* 5 and greater are reserved */
>>   };
>>   
> 
> Think Joerg spotted the comment update.
> 
