Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E05EB341200
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 02:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbhCSBRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 21:17:20 -0400
Received: from mga12.intel.com ([192.55.52.136]:65016 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232294AbhCSBRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 21:17:10 -0400
IronPort-SDR: h6kow5YS7Z3Z7uF9S5JbhhoZkt54ZAzjT4YSLt2mceYBOXCweP0u2HLph7FoaVWbDpa2yfG1lV
 mM0WL/XacEhg==
X-IronPort-AV: E=McAfee;i="6000,8403,9927"; a="169099095"
X-IronPort-AV: E=Sophos;i="5.81,259,1610438400"; 
   d="scan'208";a="169099095"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2021 18:17:10 -0700
IronPort-SDR: EZxk9hyQ01Dram0VtQCI65jzNEPNaWLaxQpwmj69Fobyw5TK0Be4rvPzSGzUE4pccInPp4Bu0R
 CYyskGyJIL7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,259,1610438400"; 
   d="scan'208";a="434080025"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128]) ([10.239.159.128])
  by fmsmga004.fm.intel.com with ESMTP; 18 Mar 2021 18:17:07 -0700
Cc:     baolu.lu@linux.intel.com, Will Deacon <will@kernel.org>,
        ashok.raj@intel.com, kevin.tian@intel.com, jacob.jun.pan@intel.com,
        yi.l.liu@intel.com, sanjay.k.kumar@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: Don't set then immediately clear in
 prq_event_thread()
To:     Joerg Roedel <joro@8bytes.org>
References: <20210309004641.3809653-1-baolu.lu@linux.intel.com>
 <YFMm/+JMfySWPzZR@8bytes.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <db5fb311-b4c2-471e-713a-408061a6ba28@linux.intel.com>
Date:   Fri, 19 Mar 2021 09:07:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YFMm/+JMfySWPzZR@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

On 3/18/21 6:10 PM, Joerg Roedel wrote:
> Hi Baolu,
> 
> On Tue, Mar 09, 2021 at 08:46:41AM +0800, Lu Baolu wrote:
>> The private data field of a page group response descriptor is set then
>> immediately cleared in prq_event_thread(). Fix this by moving clearing
>> code up.
>>
>> Fixes: 5b438f4ba315d ("iommu/vt-d: Support page request in scalable mode")
>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Reviewed-by: Liu Yi L <yi.l.liu@intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> 
> Does this fix an actual bug? If so, please state it in the commit

It will cause real problem according to the VT-d spec. I haven't got a
chance run this on a real hardware yet. I'll add a commit message to
explain why this will cause problem.

> message and also fix the subject line to state what is set/cleared.
> 

Sure!

> Thanks,
> 
> 	Joerg
> 

Best regards,
baolu
