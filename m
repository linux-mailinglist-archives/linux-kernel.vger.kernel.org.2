Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 908F940FE42
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 18:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245723AbhIQQ7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 12:59:35 -0400
Received: from foss.arm.com ([217.140.110.172]:55566 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245009AbhIQQ7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 12:59:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4D07113E;
        Fri, 17 Sep 2021 09:57:57 -0700 (PDT)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 552BD3F59C;
        Fri, 17 Sep 2021 09:57:55 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
Subject: Re: [PATCH v1 06/20] x86/resctrl: Switch over to the resctrl mbps_val
 list
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
        lcherian@marvell.com, bobo.shaobowang@huawei.com
References: <20210729223610.29373-1-james.morse@arm.com>
 <20210729223610.29373-7-james.morse@arm.com>
 <5be446b6-d6f6-dacb-4368-7c1e7aedc6cf@intel.com>
Message-ID: <18228404-0f65-c5f5-4070-7ba256fb9b72@arm.com>
Date:   Fri, 17 Sep 2021 17:57:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <5be446b6-d6f6-dacb-4368-7c1e7aedc6cf@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 01/09/2021 22:25, Reinette Chatre wrote:
> On 7/29/2021 3:35 PM, James Morse wrote:
>> Updates to resctrl's software controller follow the same path as
>> other configuration updates, but they don't modify the hardware state.
>> rdtgroup_schemata_write() uses parse_line() and the resource's
>> ctrlval_parse function to stage the configuration.
>> resctrl_arch_update_domains() then updates the mbps_val[] array
>> instead, and resctrl_arch_update_domains() skips the rdt_ctrl_update()
>> call that would update hardware.
>>
>> This complicates the interface between resctrl's filesystem parts
>> and architecture specific code. It should be possible for mba_sc
>> to be completely implemented by the filesystem parts of resctrl. This
>> would allow it to work on a second architecture with no additional code.
>>
>> Change parse_bw() to write the configuration value directly to the
>> mba_sc[] array in the domain structure. Change rdtgroup_schemata_write()
>> to skip the call to resctrl_arch_update_domains(), meaning all the
>> mba_sc specific code in resctrl_arch_update_domains() can be removed.
>> On the read-side, show_doms() and update_mba_bw() are changed to read
>> the mba_sc[] array from the domain structure. With this,
>> resctrl_arch_get_config() no longer needs to consider mba_sc resources.
>>
>> Change parse_bw() to write these values directly, meaning
>> rdtgroup_schemata_write() never needs to call update_domains()
>> for mba_sc resources.

> The above paragraph seems to contain duplicate information from the paragraph that
> precedes it.

Looks like two commit messages got combined. I've removed this, and the below paragraphs
as its already covered.


>> Get show_doms() to test is_mba_sc() and retrieve the value
>> directly, instead of using get_config() for the hardware value.
>>
>> This means the arch code's resctrl_arch_get_config() and
>> resctrl_arch_update_domains() no longer need to be aware of
>> mba_sc, and we can get rid of the update_mba_bw() code that
>> reaches into the hw_dom to get the msr value.

>> @@ -406,6 +406,14 @@ ssize_t rdtgroup_schemata_write(struct kernfs_open_file *of,
>>         list_for_each_entry(s, &resctrl_schema_all, list) {
>>           r = s->res;
>> +
>> +        /*
>> +         * Writes to mba_sc resources update the software controller,
>> +         * not the control msr.
>> +         */
>> +        if (is_mba_sc(r))
>> +            continue;
>> +
> 
> A few resources can be updated in a single write to the schemata file. It is thus possible
> to update the cache allocation resource as well as memory bandwidth allocation in a single
> write.

i.e. echo "L3:0=7ff;1=7ff\nMB:0=100;1=50" > schemata

> As I understand this change in this scenario all configuration updates will be
> skipped, not just the memory bandwidth allocation ones.

The loop is per-schema, so its not a problem for L2/L3. This would only be a problem if
the is_mba_sc() resource had multiple schema. Only CDP does this, which the MBA controls
don't support.


Thanks,

James
