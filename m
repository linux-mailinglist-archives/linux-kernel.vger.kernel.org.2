Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89ED03B46D2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 17:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhFYPqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 11:46:32 -0400
Received: from mga01.intel.com ([192.55.52.88]:62970 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229630AbhFYPqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 11:46:31 -0400
IronPort-SDR: Lps/CfaG0jrd6eQIFEoZJLK3akLn2Nv5+ZHY81DihrSrqtzNnTzv5RwXHvTuAhYw3WO0YyJz+2
 ZBcCcKvxtsnA==
X-IronPort-AV: E=McAfee;i="6200,9189,10026"; a="229289098"
X-IronPort-AV: E=Sophos;i="5.83,299,1616482800"; 
   d="scan'208";a="229289098"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 08:44:10 -0700
IronPort-SDR: 5bPanxU12mvPDvTlogfFG4dT8fLYFZ/4BLxZD6jKIRYjohTxacPTaNXDYBN7cLfG4BblN1XeSg
 aLAdvnmOh4QA==
X-IronPort-AV: E=Sophos;i="5.83,299,1616482800"; 
   d="scan'208";a="488228748"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.62.195]) ([10.209.62.195])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 08:44:10 -0700
Subject: Re: [PATCH 2/7] perf: Create a symlink for a PMU
To:     "Liang, Kan" <kan.liang@linux.intel.com>, Greg KH <greg@kroah.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
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
 <e670abe2-67b9-a602-410a-0c4170796ec7@linux.intel.com>
 <c3ffcdd4-fabb-38fd-6ccd-3497389f94ec@linux.intel.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <6f2941a4-4a32-ea09-bbc6-5a8e4836411b@linux.intel.com>
Date:   Fri, 25 Jun 2021 08:44:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <c3ffcdd4-fabb-38fd-6ccd-3497389f94ec@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> We have an attribute "caps/pmu_name" for the core PMU. Maybe we should 
> add it for uncore PMU as well. For example,
>
> $ cat /sys/devices/uncore_type_0_0/caps/pmu_name
> cha_0
>
> Userspace tool can get clues about what type_0_0 is.

It would break all the old tools, but I suppose it could work for 
updated tools.

It isn't only perf that is parsing this, but some other libraries too. 
They all would need to be updated too.

I think I still prefer the symlink. It would just work and keep full 
compatibility.

But yes maybe there is no choice.

-Andi


