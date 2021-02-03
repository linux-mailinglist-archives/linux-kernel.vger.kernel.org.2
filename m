Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D32BD30D060
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 01:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbhBCAky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 19:40:54 -0500
Received: from mga01.intel.com ([192.55.52.88]:19542 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232921AbhBCAkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 19:40:52 -0500
IronPort-SDR: hZ3f0MFH6D6n7xaZhBVX8bTN46nbvrWFYmhOEoH03KfPT4/d8K+nDPjrs17oo0JnvWxnDHKGYP
 RtTazyHPClIA==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="199899804"
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="199899804"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 16:39:06 -0800
IronPort-SDR: f308Kp4TYGqdN1tyw7K0eIM7AJym0KHs+cYDzK1wXHHnVW23Ndl/3dkIUSpPYfnWq2tFkd0354
 WuoQGAsbTxWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="406361276"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128]) ([10.239.159.128])
  by fmsmga004.fm.intel.com with ESMTP; 02 Feb 2021 16:38:22 -0800
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        Yian Chen <yian.chen@intel.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iommu/vt-d: Parse SATC reporting structure
To:     "Raj, Ashok" <ashok.raj@intel.com>
References: <20210202044057.615277-1-baolu.lu@linux.intel.com>
 <20210202044057.615277-3-baolu.lu@linux.intel.com>
 <20210202164102.GD39643@otc-nc-03>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <28583efc-1a3a-a863-fb68-cfe3afa9d68a@linux.intel.com>
Date:   Wed, 3 Feb 2021 08:29:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210202164102.GD39643@otc-nc-03>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ashok,

On 2/3/21 12:41 AM, Raj, Ashok wrote:
> On Tue, Feb 02, 2021 at 12:40:56PM +0800, Lu Baolu wrote:
>> From: Yian Chen <yian.chen@intel.com>
>>
>> Software should parse every SATC table and all devices in the tables
>> reported by the BIOS and keep the information in kernel list for further
>> SATC policy deployment.
>>
> The last part seems bit vague? Are you trying to imply,
> 
> if kernel is booted with noats for instance, a device listed in SATC table
> as "requires ATS" will fail to load?
> 
> Otherwise its not clear what the policy enforcement means.
> 

Yes. This is a bit vague. The ATS policy is out of the purpose of this
patch. It only parses the table and keep the device list for further
reference.

Best regards,
baolu
