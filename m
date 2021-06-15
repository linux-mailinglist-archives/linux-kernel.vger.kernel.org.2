Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 254DC3A883B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 20:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhFOSHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 14:07:49 -0400
Received: from mga18.intel.com ([134.134.136.126]:45308 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229494AbhFOSHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 14:07:48 -0400
IronPort-SDR: bttR9m1eVwvJHIWCWmMJEC1cfN3YJSeUafDn8OfAwHlwdQ1WOD+BF59X3v3/bssgNMzFj7cqvB
 l508sRzOUfkQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="193353254"
X-IronPort-AV: E=Sophos;i="5.83,275,1616482800"; 
   d="scan'208";a="193353254"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 11:05:42 -0700
IronPort-SDR: 2N/l5LhLf0+u/ms+a/+jvi4jI1LWnY1wfdnPO9wsf4GtaWoxxn50ugJ6xhNhpSsulP39f4t/Gf
 vl0qpU9xaquw==
X-IronPort-AV: E=Sophos;i="5.83,275,1616482800"; 
   d="scan'208";a="554527948"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.212.184.247]) ([10.212.184.247])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 11:05:41 -0700
Subject: Re: [PATCH v4 00/24] x86/resctrl: Merge the CDP resources
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        lcherian@marvell.com, "Luck, Tony" <tony.luck@intel.com>
References: <20210614200941.12383-1-james.morse@arm.com>
 <cc452592-491f-3ddf-983a-8669ad12df9a@intel.com>
 <4d2ba7c1-395b-d1ec-c92b-f906e2a551a1@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <f0f112c3-e17d-958f-2378-b73643c7ca58@intel.com>
Date:   Tue, 15 Jun 2021 11:05:40 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <4d2ba7c1-395b-d1ec-c92b-f906e2a551a1@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 6/15/2021 9:48 AM, James Morse wrote:
> On 15/06/2021 17:16, Reinette Chatre wrote:
>> On 6/14/2021 1:09 PM, James Morse wrote:

>> For the most part I think this series looks good. The one thing I am concerned about is
>> the resctrl user interface change. On a system that supports L3 CDP there is a visible
>> change when CDP is not enabled:
>>
>> Before this series:
>> # cat schemata
>>     L3:0=fffff;1=fffff
>>
>> After this series:
>> # cat schemata
>> L3:0=fffff;1=fffff
> 
> Hmm, I thought I'd fixed this with v2, ... I see this is subtly different.
> 
> This could be tweaked by getting schemata_list_add() to include the length of the longest
> suffix if the resource supports CDP, but its not enabled. (Discovering that means
> cdp_capable moves to be something the 'fs' bits of resctrl can see.)
> 
> I'm a little nervous 'adding 4 spaces' because user-space expects them. (I agree if it
> breaks user-space it has to be done). I guess this is the problem with string parsing as
> part of the interface!

This is a tricky and interesting one. It seems that the original 
intended behavior is indeed the way you changed it to. By originally 
using for_each_enabled_rdt_resource() to determine the maximum width in 
de016df88f23 ("x86/intel_rdt: Update schemata read to show data in 
tabular format"). This was added in v4.12 and dictated the interface 
until v4.13. This was changed in 1b5c0b758317 ("x86/intel_rdt: Cleanup 
namespace to support RDT monitoring") when it used 
for_each_alloc_capable_rdt_resource(r) instead, added in v4.14 that is a 
stable kernel and the most likely interface used by users.

To me the less risky change is to maintain the existing interface, but 
perhaps there are some other guidance in this regard?

> I assume that in the (distant) future having CDP capable resources with names more than 2
> characters isn't going to be a problem. (I don't have an example)

The last statement is not clear to me. Could you please elaborate why 
two characters would be significant? From what I understand the 
expectation would be that the width is the maximum name length of all 
possible schema, whether they are enabled or not.

>> There are a few user space tools that parse the resctrl schemata file and it may be easier
>> to keep the interface consistent than to find and audit them all to ensure they will keep
>> working.

To me this continues the biggest hurdle in maintaining the behavior as 
you have it in this series.


>> A heads-up is that there are some kernel-doc fixups in the works that will conflict with
>> your series. You yourself fix at least one of these kernel-doc issues in this series - the
>> description of mbm_width in the first patch. I will ask the submitter of the kernel-doc
>> fixups to use your text to help with the merging.
> 
> Please point me at something to rebase onto!
> (as far as I can see, tip/x86/cache hasn't moved)

These patches have not yet been merged. The most recent version was sent 
yesterday. Your current base is good.

Reinette
