Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC4542C4AC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 17:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhJMPTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 11:19:04 -0400
Received: from mga17.intel.com ([192.55.52.151]:40373 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229514AbhJMPTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 11:19:03 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10136"; a="208250992"
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="208250992"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 08:16:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="626379598"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.199]) ([10.237.72.199])
  by fmsmga001.fm.intel.com with ESMTP; 13 Oct 2021 08:16:57 -0700
Subject: Re: [PATCH] usb: xhci: Enable runtime-pm by default on AMD Yellow
 Carp platform
To:     "Shah, Nehal-bakulchandra" <nehal-bakulchandra.shah@amd.com>,
        mathias.nyman@intel.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>
References: <20210920154100.3195683-1-Nehal-Bakulchandra.shah@amd.com>
 <dce6c013-c2aa-aec6-a2c5-370e6c774e6f@amd.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <fd86d679-092b-532c-248e-ff8bfbff3af7@linux.intel.com>
Date:   Wed, 13 Oct 2021 18:18:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <dce6c013-c2aa-aec6-a2c5-370e6c774e6f@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.10.2021 15.59, Shah, Nehal-bakulchandra wrote:
> Hi
> 
> On 9/20/2021 9:11 PM, Nehal Bakulchandra Shah wrote:
>> AMD's Yellow Carp platform supports runtime power management for
>> XHCI Controllers, so enable the same by default for all XHCI Controllers.
>>
>> Signed-off-by: Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com>
>> Reviewed-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
>> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>> Reviewed-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
>> ---
>>   drivers/usb/host/xhci-pci.c | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
>> index 2c9f25ca8edd..0e571d6af2ab 100644
>> --- a/drivers/usb/host/xhci-pci.c
>> +++ b/drivers/usb/host/xhci-pci.c
>> @@ -69,6 +69,12 @@
>>   #define PCI_DEVICE_ID_ASMEDIA_1142_XHCI            0x1242
>>   #define PCI_DEVICE_ID_ASMEDIA_2142_XHCI            0x2142
>>   #define PCI_DEVICE_ID_ASMEDIA_3242_XHCI            0x3242
>> +#define PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_1    0x161a
>> +#define PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_2    0x161b
>> +#define PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_3    0x161d
>> +#define PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_4    0x161e
>> +#define PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_5    0x15d6
>> +#define PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_6    0x15d7
>>     static const char hcd_name[] = "xhci_hcd";
>>   @@ -313,6 +319,15 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
>>            pdev->device == PCI_DEVICE_ID_AMD_PROMONTORYA_4))
>>           xhci->quirks |= XHCI_NO_SOFT_RETRY;
>>   +    if (pdev->vendor == PCI_VENDOR_ID_AMD &&
>> +        (pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_1 ||
>> +        pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_2 ||
>> +        pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_3 ||
>> +        pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_4 ||
>> +        pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_5 ||
>> +        pdev->device == PCI_DEVICE_ID_AMD_YELLOW_CARP_XHCI_6))
>> +        xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
>> +
>>       if (xhci->quirks & XHCI_RESET_ON_RESUME)
>>           xhci_dbg_trace(xhci, trace_xhci_dbg_quirks,
>>                   "QUIRK: Resetting on resume");
>>
> 
> ping
> 

Now sent forward to Greg, thanks

-Mathias

