Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95C053B34C6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 19:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbhFXRbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 13:31:01 -0400
Received: from mga06.intel.com ([134.134.136.31]:15611 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231895AbhFXRa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 13:30:57 -0400
IronPort-SDR: zxY2z98lR9Q6OOYBZOjzUsb871GI4+A5+gauT4TsqSr3CvgdiOKtzwqBWMga5pFwadPPzpXFGn
 kcmdCUXJ6xvw==
X-IronPort-AV: E=McAfee;i="6200,9189,10025"; a="268655974"
X-IronPort-AV: E=Sophos;i="5.83,296,1616482800"; 
   d="scan'208";a="268655974"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2021 10:28:37 -0700
IronPort-SDR: pfqi8IyNc1kLyRraXJy4cf9ux2sSSTnXkaeEdhiUSIjkj6PPI7+6RdoFYzxCrJM1FD11phBTSK
 FnpIf0hZm45A==
X-IronPort-AV: E=Sophos;i="5.83,296,1616482800"; 
   d="scan'208";a="406715603"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.74.185]) ([10.209.74.185])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2021 10:28:36 -0700
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
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <29d5f315-578f-103c-9523-ae890e29c7e7@linux.intel.com>
Date:   Thu, 24 Jun 2021 10:28:36 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNSlVPcjHInk4un6@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> But this is NOT how busses work in the driver model.
>
> PCI classes are great, but we do NOT suddenly add a symlink in sysfs if
> a driver goes from being handled by "generic_pci_type_foo" to
> "vendor_foo".  Userspace can handle the change and life goes on.

In perf this is exposed to the user command line, and lots of people 
configure their own events, so it's very common in scripts. To use the 
pmu you have to use something like perf stat -a -e uncore_foo/.../. So 
it's not a single thing that could be patched up.

The perf tools supports PMUs abstractly and doesn't have special 
handling for every PMU. Also the perf design was always that the kernel 
should provide these abstractions with the user tool being (mostly) 
generic and abstract.


> So a device name will move from "generic" to "specific", right?
>
> Why does a bus have to do with any of this?

The perf pmus are in /sys/devices, so the symlinks for compatibility 
have to be created there.


> But a driver does not caer.  And if perf does not care, who cares?


The users who write scripts that specify the perf events on the perf 
command line.


-Andi


