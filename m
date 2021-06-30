Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF7D3B828E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 14:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234817AbhF3M6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 08:58:48 -0400
Received: from mga03.intel.com ([134.134.136.65]:55567 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234718AbhF3M6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 08:58:41 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10030"; a="208381394"
X-IronPort-AV: E=Sophos;i="5.83,312,1616482800"; 
   d="scan'208";a="208381394"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2021 05:56:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,312,1616482800"; 
   d="scan'208";a="455246908"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 30 Jun 2021 05:56:12 -0700
Received: from [10.209.45.119] (kliang2-MOBL.ccr.corp.intel.com [10.209.45.119])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 1F5EB58086A;
        Wed, 30 Jun 2021 05:56:11 -0700 (PDT)
Subject: Re: [PATCH V3 1/6] perf/x86/intel/uncore: Add Sapphire Rapids server
 support
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com
References: <1624990443-168533-1-git-send-email-kan.liang@linux.intel.com>
 <1624990443-168533-2-git-send-email-kan.liang@linux.intel.com>
 <YNw7KorfwK/OcrTw@kroah.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <1b7ecd8e-ba0d-5448-5c43-f730ec7e5b35@linux.intel.com>
Date:   Wed, 30 Jun 2021 08:56:10 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNw7KorfwK/OcrTw@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/30/2021 5:36 AM, Greg KH wrote:
> On Tue, Jun 29, 2021 at 11:13:58AM -0700, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> Intel Sapphire Rapids supports a discovery mechanism, that allows an
>> uncore driver to discover the different components ("boxes") of the
>> chip.
>>
>> All the generic information of the uncore boxes should be retrieved from
>> the discovery tables. This has been enabled with the commit edae1f06c2cd
>> ("perf/x86/intel/uncore: Parse uncore discovery tables"). Add
>> use_discovery to indicate the case. The uncore driver doesn't need to
>> hard code the generic information for each uncore box.
>>
>> But we still need to enable various functionality that cannot be
>> directly discovered. This is done here.
>>   - Add a meaningful name for each uncore block.
>>   - Add CHA filter support.
>>   - The layout of the control registers for each uncore block is a little
>>     bit different from the generic one. Set the platform specific format
>>     and ops. Expose the common ops which can be reused.
>>   - Add a fixed counter for IMC
>>
>> All the undiscovered platform-specific features are hard code in the
>> spr_uncores[]. Add uncore_type_customized_copy(), instead of the memcpy,
>> to only overwrite these features.
>>
>> Only the uncore blocks which are inculded in the discovery tables are
>> enabled here. Other uncore blocks, e.g., free-running counters, will be
>> supported in the following patch.
>>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> ---
> 
> Why is there no other intel.com review on this before sending it out?
> 

For the perf related code, currently I follow a loose internal review 
process. Before posting any patches to LKML, I start an internal review 
process by sending the patches to an internal mailing list. People 
(mainly Andi) will review the patches and give some comments.
After several rounds of reviews, the reviewers may give a reviewed-by 
tag or just keep silent. I usually wait for several days. If there is no 
objection, I will post the patches in LKML for further review. That's 
why some patches have a reviewed-by, some doesn't in this patchset.
But for the patches which you are the key maintainer, I followed the 
standard internal review process. As you can see, the reviewed-by from 
Rafael is tagged in the first patch of V1.

Please let me know if you'd like me to follow the standard internal 
review process in the future.

Thanks,
Kan
