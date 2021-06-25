Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7A13B461D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 16:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbhFYOv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 10:51:59 -0400
Received: from mga17.intel.com ([192.55.52.151]:37215 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229653AbhFYOv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 10:51:58 -0400
IronPort-SDR: KV8xG4BHhN5xpoPjl5UW3ysmV+JBHiyHDsSMB0aKSC4jfG2gz8nrcdAG5DWF4d8sv3NAHySmoT
 meIOs6uwLJRg==
X-IronPort-AV: E=McAfee;i="6200,9189,10026"; a="188063324"
X-IronPort-AV: E=Sophos;i="5.83,299,1616482800"; 
   d="scan'208";a="188063324"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 07:49:37 -0700
IronPort-SDR: xRNmGZ16A0y4EtE2kDvY9yuKIaJViN3e4VeN9K2AyzaJivMjOg/hLj7o0G4HRZ53PBEC3Er6Gp
 Hfwm64jnCLmQ==
X-IronPort-AV: E=Sophos;i="5.83,299,1616482800"; 
   d="scan'208";a="488207947"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.62.195]) ([10.209.62.195])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 07:49:37 -0700
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
 <1e536604-cf93-0f09-401e-2073924c5582@linux.intel.com>
 <YNSlVPcjHInk4un6@kroah.com>
 <29d5f315-578f-103c-9523-ae890e29c7e7@linux.intel.com>
 <YNVneO6exCS4ETRt@kroah.com>
 <540d8a38-da12-56c8-8306-8d3d61ae1d6b@linux.intel.com>
 <YNXqXwq1+o09eHox@kroah.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <e670abe2-67b9-a602-410a-0c4170796ec7@linux.intel.com>
Date:   Fri, 25 Jun 2021 07:49:36 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNXqXwq1+o09eHox@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Device names will change, that's always a given, as the kernel can never
> always make them the same.  That's why userspace needs to scan the bus
> for all devices and then pick out the one that it wants to look at.

In perf the tool doesn't normally know what devices (= pmu) the users 
want to look at. It's all specified on the command line depending on 
what events you want to measure. There's no way for the tool to figure 
that out on its own.


> Don't hard-encode device names into userspace tools, that way lies
> madness.

There's no hard coding in the tools (or at least not for the non json 
event list case). It all comes from the command line. But that is where 
the problem comes from.

>
>> Anyways thinking about it if Greg doesn't want symlinks (even though sysfs
>> already has symlinks elsewhere), maybe we could just create two devices
>> without symlinks. Kan, do you think that would work?
> Do not have 2 different structures represent the same hardware device,
> that too is a shortcut to madness.
>
> What prevents userspace from handling device names changing today?  Why
> are you forcing userspace to pick a specific device name at all?

The way the perf tool works is that you have to specify the names on the 
command line:

perf stat -a -e uncore_cha/event=1/ ...

With the numeric identifiers it would be

perf stat -a -e uncore_type_X_Y/event=1/

The tool handles it all abstractly.

So yes the user tools itself can handle it. But the problem is that it 
is directly exposed to the users, so the users would need to change all 
their scripts when switching between the two cases. That is what we're 
trying to avoid -- provide them a way that works on both.

-Andi


