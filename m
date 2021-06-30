Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 103EB3B82A7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 15:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234861AbhF3NIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 09:08:47 -0400
Received: from mga04.intel.com ([192.55.52.120]:28281 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234851AbhF3NIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 09:08:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10030"; a="206521186"
X-IronPort-AV: E=Sophos;i="5.83,312,1616482800"; 
   d="scan'208";a="206521186"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2021 06:06:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,312,1616482800"; 
   d="scan'208";a="408553000"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 30 Jun 2021 06:06:16 -0700
Received: from [10.209.45.119] (kliang2-MOBL.ccr.corp.intel.com [10.209.45.119])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id BA59E58086A;
        Wed, 30 Jun 2021 06:06:15 -0700 (PDT)
Subject: Re: [PATCH V3 1/6] perf/x86/intel/uncore: Add Sapphire Rapids server
 support
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com
References: <1624990443-168533-1-git-send-email-kan.liang@linux.intel.com>
 <1624990443-168533-2-git-send-email-kan.liang@linux.intel.com>
 <YNw7xwyWGVwRroNi@kroah.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <38d7030d-131d-c10d-aeb2-ba669ef11cc6@linux.intel.com>
Date:   Wed, 30 Jun 2021 09:06:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNw7xwyWGVwRroNi@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/30/2021 5:39 AM, Greg KH wrote:
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
> 
> Shouldn't this all be individual patches, one per new feature added?
> There's a lot of stuff happening all at once here, maybe the perf
> maintainers are more lax about this type of thing than other
> subsystems...
> 

These features are similar to the previous platforms. The implementation 
is very similar, so I put them in one patch.

I will split the patch and make one patch for each unit in v4.

Thanks,
Kan
