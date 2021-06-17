Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A013ABA33
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 19:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbhFQRGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 13:06:09 -0400
Received: from foss.arm.com ([217.140.110.172]:56788 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231148AbhFQRGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 13:06:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BB2913D5;
        Thu, 17 Jun 2021 10:04:00 -0700 (PDT)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 895DB3F694;
        Thu, 17 Jun 2021 10:03:58 -0700 (PDT)
Subject: Re: [PATCH v4 00/24] x86/resctrl: Merge the CDP resources
To:     Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
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
 <f0f112c3-e17d-958f-2378-b73643c7ca58@intel.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <6bf16e35-003a-0847-c15e-ed66fb302390@arm.com>
Date:   Thu, 17 Jun 2021 18:03:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <f0f112c3-e17d-958f-2378-b73643c7ca58@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 15/06/2021 19:05, Reinette Chatre wrote:
> On 6/15/2021 9:48 AM, James Morse wrote:
>> On 15/06/2021 17:16, Reinette Chatre wrote:
>>> On 6/14/2021 1:09 PM, James Morse wrote:
>>> For the most part I think this series looks good. The one thing I am concerned about is
>>> the resctrl user interface change. On a system that supports L3 CDP there is a visible
>>> change when CDP is not enabled:
>>>
>>> Before this series:
>>> # cat schemata
>>>     L3:0=fffff;1=fffff
>>>
>>> After this series:
>>> # cat schemata
>>> L3:0=fffff;1=fffff
>>
>> Hmm, I thought I'd fixed this with v2, ... I see this is subtly different.
>>
>> This could be tweaked by getting schemata_list_add() to include the length of the longest
>> suffix if the resource supports CDP, but its not enabled. (Discovering that means
>> cdp_capable moves to be something the 'fs' bits of resctrl can see.)

>> I'm a little nervous 'adding 4 spaces' because user-space expects them. (I agree if it
>> breaks user-space it has to be done). I guess this is the problem with string parsing as
>> part of the interface!

> This is a tricky and interesting one. It seems that the original intended behavior is
> indeed the way you changed it to. By originally using for_each_enabled_rdt_resource() to
> determine the maximum width in de016df88f23 ("x86/intel_rdt: Update schemata read to show
> data in tabular format"). This was added in v4.12 and dictated the interface until v4.13.
> This was changed in 1b5c0b758317 ("x86/intel_rdt: Cleanup namespace to support RDT
> monitoring") when it used for_each_alloc_capable_rdt_resource(r) instead, added in v4.14
> that is a stable kernel and the most likely interface used by users.
> 
> To me the less risky change is to maintain the existing interface, but perhaps there are
> some other guidance in this regard?

I think this is just the problem with having anything other than 'one value per file', as
sysfs does. Maintaining it involves getting painted into a corner by the worst parser
user-space manages to come up with!


>> I assume that in the (distant) future having CDP capable resources with names more than 2
>> characters isn't going to be a problem. (I don't have an example)
> 
> The last statement is not clear to me. Could you please elaborate why two characters would
> be significant? From what I understand the expectation would be that the width is the
> maximum name length of all possible schema, whether they are enabled or not.

Great - I was nervous that if shorter strings are a problem, what about longer?

( Arm SoCs often have a system-cache that lives between the LLC and DRAM. Its not a CPU
cache, so its not really L4. Because of the way CDP gets emulated it affects all caches.
If people build these things with MPAM support - and we choose to add a schema for them:
you'd end up with 'SYSTEM-CACHECODE' and 'SYSTEM-CACHEDATA'. Its not a real example as if
its needed, 'SC' is probably acceptable.)


>>> There are a few user space tools that parse the resctrl schemata file and it may be easier
>>> to keep the interface consistent than to find and audit them all to ensure they will keep
>>> working.
> 
> To me this continues the biggest hurdle in maintaining the behavior as you have it in this
> series.

No problem - I've changed it as described.


>>> A heads-up is that there are some kernel-doc fixups in the works that will conflict with
>>> your series. You yourself fix at least one of these kernel-doc issues in this series - the
>>> description of mbm_width in the first patch. I will ask the submitter of the kernel-doc
>>> fixups to use your text to help with the merging.
>>
>> Please point me at something to rebase onto!
>> (as far as I can see, tip/x86/cache hasn't moved)
> 
> These patches have not yet been merged. The most recent version was sent yesterday. Your
> current base is good.

I've based on tip/master, which merged rc6....


Thanks,

James
