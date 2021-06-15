Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 473B23A86D6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 18:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbhFOQu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 12:50:56 -0400
Received: from foss.arm.com ([217.140.110.172]:40768 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229931AbhFOQuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 12:50:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C12213A1;
        Tue, 15 Jun 2021 09:48:50 -0700 (PDT)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 44E133F694;
        Tue, 15 Jun 2021 09:48:48 -0700 (PDT)
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
From:   James Morse <james.morse@arm.com>
Message-ID: <4d2ba7c1-395b-d1ec-c92b-f906e2a551a1@arm.com>
Date:   Tue, 15 Jun 2021 17:48:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <cc452592-491f-3ddf-983a-8669ad12df9a@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 15/06/2021 17:16, Reinette Chatre wrote:
> On 6/14/2021 1:09 PM, James Morse wrote:
>> This series re-folds the resctrl code so the CDP resources (L3CODE et al)
>> behaviour is all contained in the filesystem parts, with a minimum amount
>> of arch specific code.

[..]

>> This series collapses the CODE/DATA resources, moving all the user-visible
>> resctrl ABI into what becomes the filesystem code. CDP becomes the type of
>> configuration being applied to a cache. This is done by adding a
>> struct resctrl_schema to the parts of resctrl that will move to fs. This
>> holds the arch-code resource that is in use for this schema, along with
>> other properties like the name, and whether the configuration being applied
>> is CODE/DATA/BOTH.
>>
>> This lets us fold the extra resources out of the arch code so that they
>> don't need to be duplicated if the equivalent feature to CDP is missing, or
>> implemented in a different way.

[...]

>> This series is based on v5.12-rc6, and can be retrieved from:
>> git://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/resctrl_merge_cdp/v4


> For the most part I think this series looks good. The one thing I am concerned about is
> the resctrl user interface change. On a system that supports L3 CDP there is a visible
> change when CDP is not enabled:
> 
> Before this series:
> # cat schemata
>    L3:0=fffff;1=fffff
> 
> After this series:
> # cat schemata
> L3:0=fffff;1=fffff

Hmm, I thought I'd fixed this with v2, ... I see this is subtly different.

This could be tweaked by getting schemata_list_add() to include the length of the longest
suffix if the resource supports CDP, but its not enabled. (Discovering that means
cdp_capable moves to be something the 'fs' bits of resctrl can see.)

I'm a little nervous 'adding 4 spaces' because user-space expects them. (I agree if it
breaks user-space it has to be done). I guess this is the problem with string parsing as
part of the interface!

I assume that in the (distant) future having CDP capable resources with names more than 2
characters isn't going to be a problem. (I don't have an example)


> There are a few user space tools that parse the resctrl schemata file and it may be easier
> to keep the interface consistent than to find and audit them all to ensure they will keep
> working.


> Apart from that, I do think that the dmesg change that Babu pointed out deserves a mention
> in the cover letter. I agree with your response in this regard but this is indeed a user
> visible change and if anybody has issue with that then mentioning it in the cover letter
> will hopefully catch it sooner.

Ah, okay.


> A heads-up is that there are some kernel-doc fixups in the works that will conflict with
> your series. You yourself fix at least one of these kernel-doc issues in this series - the
> description of mbm_width in the first patch. I will ask the submitter of the kernel-doc
> fixups to use your text to help with the merging.

Please point me at something to rebase onto!
(as far as I can see, tip/x86/cache hasn't moved)


> Finally, I did catch a few typos that I will respond to individually.

Thanks!

James
