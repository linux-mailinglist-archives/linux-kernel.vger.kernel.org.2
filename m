Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4773437C96
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 20:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233917AbhJVScl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 14:32:41 -0400
Received: from foss.arm.com ([217.140.110.172]:57634 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233685AbhJVSch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 14:32:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 98BE81474;
        Fri, 22 Oct 2021 11:30:19 -0700 (PDT)
Received: from [10.1.196.28] (eglon.cambridge.arm.com [10.1.196.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D66C3F73D;
        Fri, 22 Oct 2021 11:30:17 -0700 (PDT)
Subject: Re: [PATCH v2 07/23] x86/resctrl: Add domain offline callback for
 resctrl work
To:     Babu Moger <babu.moger@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        lcherian@marvell.com, bobo.shaobowang@huawei.com,
        tan.shaopeng@fujitsu.com
References: <20211001160302.31189-1-james.morse@arm.com>
 <20211001160302.31189-8-james.morse@arm.com>
 <47b1bfc9-1b31-d905-955d-638f3504778f@amd.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <a67d75da-3d35-7121-bbb2-87335c3b4950@arm.com>
Date:   Fri, 22 Oct 2021 19:30:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <47b1bfc9-1b31-d905-955d-638f3504778f@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 20/10/2021 00:19, Babu Moger wrote:
> On 10/1/21 11:02 AM, James Morse wrote:
>> Because domains are exposed to user-space via resctrl, the filesystem
>> must update its state when CPU hotplug callbacks are triggered.
>>
>> Some of this work is common to any architecture that would support
>> resctrl, but the work is tied up with the architecture code to
>> free the memory.
>>
>> Move the monitor subdir removal and the cancelling of the mbm/limbo
>> works into a new resctrl_offline_domain() call. These bits are not
>> specific to the architecture. Grouping them in one function allows
>> that code to be moved to /fs/ and re-used by another architecture.

>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 19691f9ab061..38670bb810cb 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -2499,14 +2499,12 @@ static int mon_addfile(struct kernfs_node *parent_kn, const char *name,
>>   * Remove all subdirectories of mon_data of ctrl_mon groups
>>   * and monitor groups with given domain id.
>>   */
>> -void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r, unsigned int dom_id)
>> +static void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
>> +					   unsigned int dom_id)
>>  {
>>  	struct rdtgroup *prgrp, *crgrp;
>>  	char name[32];

>> -	if (!r->mon_capable)
>> -		return;

>>  	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
>>  		sprintf(name, "mon_%s_%02d", r->name, dom_id);
>>  		kernfs_remove_by_name(prgrp->mon.mon_data_kn, name);
>> @@ -3233,6 +3231,39 @@ static int __init rdtgroup_setup_root(void)
>>  	return ret;
>>  }
>>  
>> +void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
>> +{
>> +	lockdep_assert_held(&rdtgroup_mutex);
> 
> Is this really required?

It documents that the caller must take the lock. Its not so clear how walking
rdt_all_groups in rmdir_mondata_subdir_allrdtgrp() is safe now that the logic has moved to
another file. (and these helpers will eventually move out to /fs/).

Who takes what lock changes later in the tree, (after this series), these annotations make
it a lot clearer that these functions are changing from caller-takes-the-lock to
callee-takes-the-new-lock. Otherwise that patch would be much harder to review.


>> +
>> +	if (!r->mon_capable)
>> +		return;
> 
> I don't see the need for this check either.

It moved up from rmdir_mondata_subdir_allrdtgrp(), quoted above.
All of the work that moved from domain_remove_cpu() to resctrl_offline_domain() is about
monitors.

Sure, calling is_mbm_enabled(), is_llc_occupancy_enabled(), bitmap_free(NULL), and
kfree(NULL) twice isn't harmful in this case, but its quicker to check the flag on the
resource and return early if nothing else needs doing.


Thanks,

James
