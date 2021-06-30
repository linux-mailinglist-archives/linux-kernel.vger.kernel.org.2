Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED703B82A8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 15:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234869AbhF3NJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 09:09:07 -0400
Received: from mga09.intel.com ([134.134.136.24]:43434 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234679AbhF3NJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 09:09:04 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10030"; a="208291367"
X-IronPort-AV: E=Sophos;i="5.83,312,1616482800"; 
   d="scan'208";a="208291367"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2021 06:06:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,312,1616482800"; 
   d="scan'208";a="626004088"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 30 Jun 2021 06:06:32 -0700
Received: from [10.209.45.119] (kliang2-MOBL.ccr.corp.intel.com [10.209.45.119])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 059D058086A;
        Wed, 30 Jun 2021 06:06:30 -0700 (PDT)
Subject: Re: [PATCH V3 2/6] perf/x86/intel/uncore: Add alias PMU name
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com
References: <1624990443-168533-1-git-send-email-kan.liang@linux.intel.com>
 <1624990443-168533-3-git-send-email-kan.liang@linux.intel.com>
 <YNw76ZUUUG+qUyP2@kroah.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <bc46391e-5029-56a5-5a8a-51e16a62dab7@linux.intel.com>
Date:   Wed, 30 Jun 2021 09:06:29 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNw76ZUUUG+qUyP2@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/30/2021 5:39 AM, Greg KH wrote:
> On Tue, Jun 29, 2021 at 11:13:59AM -0700, kan.liang@linux.intel.com wrote:
>> From: Kan Liang <kan.liang@linux.intel.com>
>>
>> A perf PMU may have two PMU names. For example, Intel Sapphire Rapids
>> server supports the discovery mechanism. Without the platform-specific
>> support, an uncore PMU is named by a type ID plus a box ID, e.g.,
>> uncore_type_0_0, because the real name of the uncore PMU cannot be
>> retrieved from the discovery table. With the platform-specific support
>> later, perf has the mapping information from a type ID to a specific
>> uncore unit. Just like the previous platforms, the uncore PMU is named
>> by the real PMU name, e.g., uncore_cha_0. The user scripts which work
>> well with the old numeric name may not work anymore.
>>
>> Add a new attribute "alias" to indicate the old numeric name. The
>> following userspace perf tool patch will handle both names. The user
>> scripts should work properly with the updated perf tool.
>>
>> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
>> Cc: gregkh@linuxfoundation.org
>> ---
>>   arch/x86/events/intel/uncore.c       | 19 +++++++++++++------
>>   arch/x86/events/intel/uncore.h       |  1 +
>>   arch/x86/events/intel/uncore_snbep.c | 28 +++++++++++++++++++++++++++-
>>   3 files changed, 41 insertions(+), 7 deletions(-)
> 
> No Documentation/ABI/ update for your new sysfs file?
> 
> :(
> 

Ah, I forgot to git add the new file. Sorry for it.
I will resend the V4.

Thanks,
Kan
