Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 549AE314595
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 02:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbhBIBZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 20:25:01 -0500
Received: from mga03.intel.com ([134.134.136.65]:13938 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229854AbhBIBYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 20:24:55 -0500
IronPort-SDR: D4zFAxwnk1X3dydwdAptcbSuRiwfDqxu59JEjPRcqSPGHuz5QfS3pMNTn33H8EehPkp8BZEgCl
 u8EQJRQrYZzw==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="181875281"
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; 
   d="scan'208";a="181875281"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 17:24:14 -0800
IronPort-SDR: Je3cvQ9ZoFLq4CMuUUNj6fBeq4wwv61EmGO3g7kMzGSLVRCAJNsRTzRoZbEIdt2cu3QTIQS/a6
 NIbmJNVFRSIQ==
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; 
   d="scan'208";a="395838752"
Received: from shuo-intel.sh.intel.com (HELO localhost) ([10.239.154.30])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 17:24:10 -0800
Date:   Tue, 9 Feb 2021 09:24:07 +0800
From:   Shuo A Liu <shuo.a.liu@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>, Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Sen Christopherson <sean.j.christopherson@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fengwei Yin <fengwei.yin@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [PATCH v9 01/18] docs: acrn: Introduce ACRN
Message-ID: <20210209012407.GC15601@shuo-intel.sh.intel.com>
References: <20210207031040.49576-1-shuo.a.liu@intel.com>
 <20210207031040.49576-2-shuo.a.liu@intel.com>
 <6ae2679c-e172-a955-9df5-2b54b79dd854@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <6ae2679c-e172-a955-9df5-2b54b79dd854@infradead.org>
User-Agent: Mutt/1.8.3 (2017-05-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Mon  8.Feb'21 at 11:48:07 -0800, Randy Dunlap wrote:
>On 2/6/21 7:10 PM, shuo.a.liu@intel.com wrote:
>> From: Shuo Liu <shuo.a.liu@intel.com>
>>
>> Add documentation on the following aspects of ACRN:
>>
>>   1) A brief introduction on the architecture of ACRN.
>>   2) I/O request handling in ACRN.
>>   3) CPUID functions of ACRN.
>
>> ---
>
>> diff --git a/Documentation/virt/acrn/io-request.rst b/Documentation/virt/acrn/io-request.rst
>> new file mode 100644
>> index 000000000000..6cc3ea0fa1f5
>> --- /dev/null
>> +++ b/Documentation/virt/acrn/io-request.rst
>> @@ -0,0 +1,97 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +I/O request handling
>> +====================
>> +
>...
>> +
>> +1. I/O request
>> +--------------
>> +
>> +For each User VM, there is a shared 4-KByte memory region used for I/O requests
>> +communication between the hypervisor and Service VM. An I/O request is a
>> +256-byte structure buffer, which is 'struct acrn_io_request', that is filled by
>> +an I/O handler of the hypervisor when a trapped I/O access happens in a User
>> +VM. ACRN userspace in the Service VM first allocates a 4-KByte page and passes
>> +the GPA (Guest Physical Address) of the buffer to the hypervisor. The buffer is
>> +used as an array of 16 I/O request slots with each I/O request slot being 256
>> +bytes. This array is indexed by vCPU ID.
>
>Does this mean that ACRN has a limit of 16 vCPUs ?

Yes. Now it is a limitation.

Thanks
shuo
