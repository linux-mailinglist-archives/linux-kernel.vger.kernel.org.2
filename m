Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E966630D067
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 01:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbhBCAoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 19:44:21 -0500
Received: from mga07.intel.com ([134.134.136.100]:57323 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233127AbhBCAoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 19:44:19 -0500
IronPort-SDR: A3b2UJzlBC79VhudCtAeNq/wXYCx7+qBTZjbftKv98QWbYr/ZVTe1yJ1jRwsE5GtOWLIxBhrt0
 Qf9tYs7vBM1Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="245036883"
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="245036883"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 16:42:23 -0800
IronPort-SDR: MMKNBch+1mmOdmWJTo+x57VCujaG3b48l/M96+PWoodyq4a31cr3LEkCDmFuMiT5MNDd7vIzh7
 hekzoLknfkfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="406362278"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128]) ([10.239.159.128])
  by fmsmga004.fm.intel.com with ESMTP; 02 Feb 2021 16:42:22 -0800
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        Yian Chen <yian.chen@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iommu/vt-d: Apply SATC policy
To:     Joerg Roedel <joro@8bytes.org>
References: <20210202044057.615277-1-baolu.lu@linux.intel.com>
 <20210202044057.615277-4-baolu.lu@linux.intel.com>
 <20210202135501.GX32671@8bytes.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <698a0a53-d0f4-cee2-03d7-4e914276737e@linux.intel.com>
Date:   Wed, 3 Feb 2021 08:33:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210202135501.GX32671@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/21 9:55 PM, Joerg Roedel wrote:
> On Tue, Feb 02, 2021 at 12:40:57PM +0800, Lu Baolu wrote:
>> +	list_for_each_entry_rcu(satcu, &dmar_satc_units, list) {
>> +		satc = container_of(satcu->hdr, struct acpi_dmar_satc, header);
>> +		if (satc->segment == pci_domain_nr(dev->bus) && satcu->atc_required) {
> 
> You can safe a level of indentation and make this look nicer if you do:
> 
> 		if (satc->segment != pci_domain_nr(dev->bus) || !satcu->atc_required)
> 			continue;
> 
> 

Yes. Thanks!

Best regards,
baolu

>> +			for_each_dev_scope(satcu->devices, satcu->devices_cnt, i, tmp)
>> +				if (to_pci_dev(tmp) == dev)
>> +					goto out;
>> +		}
>> +	}
>> +	ret = 0;
>> +out:
>> +	rcu_read_unlock();
>> +	return ret;
>> +}
