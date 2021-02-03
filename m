Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5517D30D03B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 01:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbhBCAVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 19:21:17 -0500
Received: from mga01.intel.com ([192.55.52.88]:18174 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229513AbhBCAVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 19:21:16 -0500
IronPort-SDR: BlMAyH8vCaC0cetxSOALP64TqgR6Y6p45vZQnGmOrVOrBYxI752gLl1ds9D7pFJKxqOexbDOp6
 XiSmGsdBdLRA==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="199896698"
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="199896698"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 16:19:28 -0800
IronPort-SDR: W5OFdWgXT0fIAnC/qdqVNgv32OuvqM3kS8gWPtpomchprrc/CG1wu8rqMfdIqdFV64JNO1zbkw
 XnzLAWpwh/Cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="406357196"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128]) ([10.239.159.128])
  by fmsmga004.fm.intel.com with ESMTP; 02 Feb 2021 16:19:27 -0800
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        Yian Chen <yian.chen@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iommu/vt-d: Add new enum value and structure for SATC
To:     Joerg Roedel <joro@8bytes.org>
References: <20210202044057.615277-1-baolu.lu@linux.intel.com>
 <20210202044057.615277-2-baolu.lu@linux.intel.com>
 <20210202135130.GV32671@8bytes.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <1dcd57e4-f2b3-d300-c6fe-7b6c6b41cb82@linux.intel.com>
Date:   Wed, 3 Feb 2021 08:11:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210202135130.GV32671@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

On 2/2/21 9:51 PM, Joerg Roedel wrote:
> Hi Baolu,
> 
> On Tue, Feb 02, 2021 at 12:40:55PM +0800, Lu Baolu wrote:
>> @@ -514,7 +514,8 @@ enum acpi_dmar_type {
>>   	ACPI_DMAR_TYPE_ROOT_ATS = 2,
>>   	ACPI_DMAR_TYPE_HARDWARE_AFFINITY = 3,
>>   	ACPI_DMAR_TYPE_NAMESPACE = 4,
>> -	ACPI_DMAR_TYPE_RESERVED = 5	/* 5 and greater are reserved */
>> +	ACPI_DMAR_TYPE_SATC = 5,
>> +	ACPI_DMAR_TYPE_RESERVED = 6	/* 5 and greater are reserved */
> 
> Nit: The comment needs to be updated too.
> 

Yes. Will update it.

Best regards,
baolu
