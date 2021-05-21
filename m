Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 128D838C048
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 09:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbhEUHEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 03:04:45 -0400
Received: from mga17.intel.com ([192.55.52.151]:51704 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235015AbhEUHEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 03:04:43 -0400
IronPort-SDR: QIBnY5y8Hu0bqSI3SSvfRCvuMLF6afIWatu4i1A38BtverXWyHOvXSZf6nkJinlXU4KilNw8Vn
 PXXufE7o4c2A==
X-IronPort-AV: E=McAfee;i="6200,9189,9990"; a="181712471"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="181712471"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 00:03:19 -0700
IronPort-SDR: 5UNqd8GbHaSlRSFz7jFi0GD2g7d7HT+PElXXnbCro3PtL6H1P0R5p8l+ung57gYdebTdzQIZfj
 jwKH9GDiBUoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="462371543"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128]) ([10.239.159.128])
  by fmsmga004.fm.intel.com with ESMTP; 21 May 2021 00:03:15 -0700
Cc:     baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/vt-d: Fix sysfs leak in alloc_domain()
To:     Rolf Eike Beer <eb@emlix.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>
References: <1716403.SmlLz2RZUD@devpool47>
 <17411490.HIIP88n32C@mobilepool36.emlix.com>
 <b13c4073-5976-b4e0-4dc7-4e07e68cbb5f@linux.intel.com>
 <1889881.5hqWi3GpDC@devpool47>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <29767d37-f8ea-b201-bef8-3bb2f6933bc2@linux.intel.com>
Date:   Fri, 21 May 2021 15:02:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1889881.5hqWi3GpDC@devpool47>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

On 5/21/21 2:53 PM, Rolf Eike Beer wrote:
> Am Donnerstag, 22. April 2021, 07:34:17 CEST schrieb Lu Baolu:
>> Hi Rolf,
>>
>> On 4/22/21 1:39 PM, Rolf Eike Beer wrote:
>>> iommu_device_sysfs_add() is called before, so is has to be cleaned on
>>> subsequent errors.
>>>
>>> Fixes: 39ab9555c2411 ("iommu: Add sysfs bindings for struct iommu_device")
>>> Cc: stable@vger.kernel.org # 4.11.x
>>> Signed-off-by: Rolf Eike Beer <eb@emlix.com>
>>
>> Acked-by: Lu Baolu <baolu.lu@linux.intel.com>
> 
> Ping. Who is going to pick this up, please?

I forgot to put this fix in my last pull request. Could you please pick
it up? Or, I can send another pull request the next week.

Best regards,
baolu
