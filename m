Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79FC83B327B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 17:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbhFXP0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 11:26:51 -0400
Received: from mga06.intel.com ([134.134.136.31]:4331 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230267AbhFXP0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 11:26:50 -0400
IronPort-SDR: E+Y0tTwqkK5cdEMvcEBHn5GFK7Hz3U5GjxfXeJeh9nX1EVA+Bdh9de8sjMsC2GI4lGLz7sHvqk
 sh+WcOxY+Fww==
X-IronPort-AV: E=McAfee;i="6200,9189,10025"; a="268624437"
X-IronPort-AV: E=Sophos;i="5.83,296,1616482800"; 
   d="scan'208";a="268624437"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2021 08:24:31 -0700
IronPort-SDR: WeYcpIYIGZ0Iolpx3hu1/ws0feOR88g8kF9VpgvlgGBiihVEUUbjt8ao/KONBna1qfDcQy3DqS
 fpA2RtakuTeA==
X-IronPort-AV: E=Sophos;i="5.83,296,1616482800"; 
   d="scan'208";a="406676683"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.74.185]) ([10.209.74.185])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2021 08:24:30 -0700
Subject: Re: [PATCH 2/7] perf: Create a symlink for a PMU
To:     Greg KH <greg@kroah.com>
Cc:     kan.liang@linux.intel.com, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, eranian@google.com,
        namhyung@kernel.org, acme@kernel.org, jolsa@redhat.com
References: <1624497729-158864-1-git-send-email-kan.liang@linux.intel.com>
 <1624497729-158864-3-git-send-email-kan.liang@linux.intel.com>
 <YNQckpOuw80uCUa1@kroah.com>
 <d25a0556-325f-9af0-a495-b9f222d63e10@linux.intel.com>
 <YNSWtCSjJy8CytOL@kroah.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <1e536604-cf93-0f09-401e-2073924c5582@linux.intel.com>
Date:   Thu, 24 Jun 2021 08:24:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNSWtCSjJy8CytOL@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/24/2021 7:29 AM, Greg KH wrote:
> On Thu, Jun 24, 2021 at 07:24:31AM -0700, Andi Kleen wrote:
>>> But first off, why is this symlink suddenly needed?  What is so special
>>> about this new hardware that it breaks the existing model?
>> The driver can be in two modes:
>>
>> - Driver fully knows the hardware and puts in the correct Linux names
>>
>> - Driver doesn't know the hardware but is in a fallback mode where it only
>> looks at a discovery table. There we don't have the correct names, just an
>> numeric identifier for the different hardware sub components.
> Why does this matter?  Why would the driver not "know" the hardware?  If
> it doesn't know it, why would it bind to it?

It's a similar concept as a PCI class. How to have a driver that can 
handle future hardware, but with some restrictions

The perf CPU PMU has had a similar concept for a long time. The driver 
can be either in architectural mode (with a subset of features), or be 
fully enabled. This allows users who are on an older kernel to still use 
at least a subset of the functionality.

It will bind as long as the discovery table is there.

>
>> In the later mode the numeric identifier is used in sysfs, in the former
>> case the full Linux name. But we want to keep some degree of Linux user
>> space compatibility between the two, that is why the full mode creates a
>> symlink from the "numeric" name. This way the (ugly) identifiers needed for
>> the fallback mode work everywhere.
> So what _exactly_ does the symlink do here?  What is it from->to?

It's from numeric identifier to full perf name

In fallback mode there is no symlink, only the numeric identifier.


>
> And where is it being documented?  What userspace tool needs to be fixed
> up so that the symlink can be removed?

The names are visible in the perf command lines. Perf supports either 
name without changes. So it's not about fixing a specific tool, but 
about using the drivers in both modes, with limited compatibility 
between the two.

Yes probably it needs better documentation.

-Andi

