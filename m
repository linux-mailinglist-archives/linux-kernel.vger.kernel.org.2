Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABF3235F945
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 18:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351997AbhDNQuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 12:50:22 -0400
Received: from mga05.intel.com ([192.55.52.43]:42935 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351931AbhDNQuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 12:50:12 -0400
IronPort-SDR: FgXR3MER/1SDktpzznjO6mrYrizKuz6PQu0nf6pVCZVVn+FIUvnDHLIhQ7wos+S2NX8+HH55ES
 vq25CN61DwBw==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="279996222"
X-IronPort-AV: E=Sophos;i="5.82,222,1613462400"; 
   d="scan'208";a="279996222"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 09:49:49 -0700
IronPort-SDR: igAmzAAo/FJDmriHHUS8QC7V6dn9mRoV5uvgJTZ4aiORgcqQwoaDwAkig4ElpBe7Yb97aRgibk
 CRfIMyOJUBSA==
X-IronPort-AV: E=Sophos;i="5.82,222,1613462400"; 
   d="scan'208";a="532839445"
Received: from abilling-mobl.amr.corp.intel.com (HELO [10.212.79.142]) ([10.212.79.142])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 09:49:47 -0700
Subject: Re: [PATCH v2 2/3] soundwire: Intel: introduce DMI quirks for HP
 Spectre x360 Convertible
To:     Vinod Koul <vkoul@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, hui.wang@canonical.com,
        sanyog.r.kale@intel.com, rander.wang@linux.intel.com,
        bard.liao@intel.com
References: <20210302075105.11515-1-yung-chuan.liao@linux.intel.com>
 <20210302075105.11515-3-yung-chuan.liao@linux.intel.com>
 <de65866a-bb8f-f5c6-2829-42b561f282f7@intel.com>
 <YHZqqjUSJvYxhEw6@vkoul-mobl.Dlink>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <403e8645-f823-22f6-7003-3b62962dcf01@linux.intel.com>
Date:   Wed, 14 Apr 2021 10:21:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YHZqqjUSJvYxhEw6@vkoul-mobl.Dlink>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/13/21 11:08 PM, Vinod Koul wrote:
> On 12-04-21, 14:37, Dave Hansen wrote:
>> On 3/1/21 11:51 PM, Bard Liao wrote:
>>> +++ b/drivers/soundwire/dmi-quirks.c
>>> @@ -0,0 +1,66 @@
>>> +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
>>> +// Copyright(c) 2021 Intel Corporation.
>>
>> It looks like this is already in intel-next, so this may be moot.  But,
>> is there a specific reason this is dual licensed?  If so, can you please
>> include information about the license choice in the cover letter of any
>> future version?
> 
> The soundwire module from Intel and core soundwire core was always dual
> licensed, so it kind of followed that..
> 
>> If there is no specific reason for this contribution to be dual
>> licensed, please make it GPL-2.0 only.
> 
> This module, I would say NO. Unless someone from Intel disagree..
> Pierre/Bard..?
> 
> If all agree I dont see a reason why this cant be updated to GPL only.

The initial version of those quirks was contributed as a change to 
drivers/soundwire/slave.c, which is dual-licensed. the code was split to 
a different file and the dual-license followed.

I am personally favorable to keeping the code as is, the quirks are just 
referring to low-level hardware descriptors that are not aligned with 
DevID hardware registers in external SoundWire devices. If enumeration 
was handled at a lower level, e.g. in DSP firmware the same information 
would be quite useful.

That said, it's been agreed with Dave that moving forward all new 
contributions from Intel with a dual-license would include an explicit 
statement in the commit message as to why it was selected over plain 
vanilla GPL-2.0-only.



