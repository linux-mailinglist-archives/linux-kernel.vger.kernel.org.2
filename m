Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E621339455
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 18:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbhCLRLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 12:11:38 -0500
Received: from foss.arm.com ([217.140.110.172]:57590 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232342AbhCLRLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 12:11:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 014F211FB;
        Fri, 12 Mar 2021 09:11:09 -0800 (PST)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 73FF33F7D7;
        Fri, 12 Mar 2021 09:11:07 -0800 (PST)
From:   James Morse <james.morse@arm.com>
Subject: Re: [PATCH 05/24] x86/resctrl: Pass the schema in resdir's private
 pointer
To:     Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>
References: <20201030161120.227225-1-james.morse@arm.com>
 <20201030161120.227225-6-james.morse@arm.com>
 <f2726df3-a694-3265-16e3-057f8b7e2d92@intel.com>
Message-ID: <892c8c20-92e3-750f-00cf-8d559b0d181b@arm.com>
Date:   Fri, 12 Mar 2021 17:11:06 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <f2726df3-a694-3265-16e3-057f8b7e2d92@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 17/11/2020 21:49, Reinette Chatre wrote:
> It is not clear what "resdir" mentioned in subject line refers to.

rdtgroup_mkdir_info_resdir(), it looks I picked the wrong bit to identify it.
('info' in a name usually conveys no information at all!)


> Could it be changed to "info dir"?

Sure,


> On 10/30/2020 9:11 AM, James Morse wrote:
>> Moving properties that resctrl exposes to user-space into the core
>> 'fs' code, (e.g. the name of the schema), means some of the functions
>> that back the filesystem need the schema struct, but currently take the
>> resource.
> 
> I think a simple addition would help to parse the above ...
> 
> " ... need the schema struct (to where the properties are moved), ..."
> 
>>
>> Once the CDP resources are merged, the resource doesn't reflect the
>> right level of information.
>>
>> For the info dirs that represent a control, the information needed
>> is in the schema, as this is how the resource is being used. For the
>> monitors, its the resource as L3CODE_MON doesn't make sense, and would
>> monitor data too.
>>
>> This difference means the type of the private pointers varies
>> between control and monitor info dirs.
>>
>> If the flags are RF_MON_INFO, its a struct rdt_resource. If the
>> flags are RF_CTRL_INFO, its a struct resctrl_schema. Nothing in
>> res_common_files[] has both flags.

>> @@ -1794,6 +1803,7 @@ static int rdtgroup_mkdir_info_resdir(struct rdt_resource *r, char
>> *name,
>>     static int rdtgroup_create_info_dir(struct kernfs_node *parent_kn)
>>   {
>> +    struct resctrl_schema *s;
>>       struct rdt_resource *r;
>>       unsigned long fflags;
>>       char name[32];
>> @@ -1809,9 +1819,10 @@ static int rdtgroup_create_info_dir(struct kernfs_node *parent_kn)
>>       if (ret)
>>           goto out_destroy;
>>   -    for_each_alloc_enabled_rdt_resource(r) {
>> +    list_for_each_entry(s, &resctrl_all_schema, list) {
>> +        r = s->res;
>>           fflags =  r->fflags | RF_CTRL_INFO;
>> -        ret = rdtgroup_mkdir_info_resdir(r, r->name, fflags);
>> +        ret = rdtgroup_mkdir_info_resdir(s, r->name, fflags);
>>           if (ret)
>>               goto out_destroy;
>>       }

> I think it would be helpful to add a comment here to compensate for the symmetry that is
> removed ("for_each_alloc_enabled_rdt_resource()" followed by a
> "for_each_mon_enabled_rdt_resource()").

Sure, the thing to convey is the first loop is for 'alloc_enabled' controls.


Thanks,

James

