Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25CF43A4460
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 16:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbhFKOxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 10:53:52 -0400
Received: from mga05.intel.com ([192.55.52.43]:61524 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230508AbhFKOxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 10:53:51 -0400
IronPort-SDR: yZjsHOyZIsO1P9UkcUKCCX1GQgEAdSi1qMn183fJVcnCtgXO3MU8jq0Dp/PBdCHRzTorLltZcb
 Cmg7HTz6YvTA==
X-IronPort-AV: E=McAfee;i="6200,9189,10012"; a="291169969"
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="291169969"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 07:51:52 -0700
IronPort-SDR: 5005IWZtchPfbvO3h+s9Ho6UAiMbo/xRefMxG2img6XhJgrpYvM6o/pYW+yIQIGMJIX9fAetOo
 xAkYoRi6H9+A==
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="638709464"
Received: from dcpalomx-mobl4.amr.corp.intel.com (HELO [10.209.153.29]) ([10.209.153.29])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 07:51:50 -0700
Subject: Re: [PATCH v4] soundwire: intel: move to auxiliary bus
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, Leon Romanovsky <leon@kernel.org>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        hui.wang@canonical.com, Jason Gunthorpe <jgg@nvidia.com>,
        Dave Ertman <david.m.ertman@intel.com>,
        sanyog.r.kale@intel.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        rander.wang@linux.intel.com, bard.liao@intel.com
References: <20210511052132.28150-1-yung-chuan.liao@linux.intel.com>
 <21002781-0b78-3b36-952f-683482a925d7@linux.intel.com>
 <YLS4N2KgzfsMBD1c@vkoul-mobl.Dlink>
 <b316763b-d219-6ea3-401e-3eb9718aabf3@linux.intel.com>
 <YMBHj6PBzeHexXJb@vkoul-mobl>
 <07dbe0a2-0abb-810b-ef39-b83511d3f3e0@linux.intel.com>
 <YMNQBpFX9DXcoGAc@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <be440569-e18b-b079-2795-0af1e6812935@linux.intel.com>
Date:   Fri, 11 Jun 2021 09:51:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YMNQBpFX9DXcoGAc@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Vinod for your feedback,

>> If you look at the *existing* code, we don't handle any "resources" with the
>> platform devices, we use the platform_device_info.data to pass the link
>> information. It's a void pointer. We do not touch the resource field in the
>> platform_device_into at all.
> 
> Yes that is true I dont disagree on that part. My ask here is to make it
> better, it can be followed up after this but I would at least like to
> agree on the direction.

[...]

>> That's it. We did not change anything else, all the other fields are
>> identical. We are only changing the TYPE of device and the interfaces for
>> probe/remove but using the same information and the same device hierarchy.
> 
> The move in itself is okay but I dont think that should be the end goal.

What we suggested in this patch is only an iso-functionality change. I 
believe from Greg's and your feedback that there is no objection on that 
small step.

This is not the end-goal indeed. The second step would be to remove the 
intel_init.c file. I fully agree with you Vinod that this can be moved 
into the SOF driver, and we could do this in a follow-up step. We can 
also improve the partition between 'context' used by the child driver 
and information passed by the parent on SHIM registers and bases.

I think we'd need to agree on the details of the second step, Bard and I 
can work on a proposal, but I don't see a disconnect on the direction to 
simplify the interface. That's the right thing to do.




