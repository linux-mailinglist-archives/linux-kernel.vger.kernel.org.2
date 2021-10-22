Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD7DC437C93
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 20:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbhJVScc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 14:32:32 -0400
Received: from foss.arm.com ([217.140.110.172]:57552 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231472AbhJVScb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 14:32:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5874E1063;
        Fri, 22 Oct 2021 11:30:13 -0700 (PDT)
Received: from [10.1.196.28] (eglon.cambridge.arm.com [10.1.196.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 54EE53F73D;
        Fri, 22 Oct 2021 11:30:11 -0700 (PDT)
Subject: Re: [PATCH v2 05/23] x86/resctrl: Add domain online callback for
 resctrl work
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
        lcherian@marvell.com, bobo.shaobowang@huawei.com,
        tan.shaopeng@fujitsu.com
References: <20211001160302.31189-1-james.morse@arm.com>
 <20211001160302.31189-6-james.morse@arm.com>
 <8b414a4d-899b-b784-5b0a-21f1b41349eb@intel.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <4d4f5830-dcf9-1904-9cc2-4e50860ff571@arm.com>
Date:   Fri, 22 Oct 2021 19:30:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <8b414a4d-899b-b784-5b0a-21f1b41349eb@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 15/10/2021 23:19, Reinette Chatre wrote:
> On 10/1/2021 9:02 AM, James Morse wrote:
> 
>> @@ -527,21 +492,15 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
>>           return;
>>       }
>>   -    if (r->mon_capable && domain_setup_mon_state(r, d)) {
>> -        kfree(hw_dom->ctrl_val);
>> -        kfree(hw_dom->mbps_val);
>> -        kfree(hw_dom);
>> -        return;
>> -    }
>> -
>>       list_add_tail(&d->list, add_pos);
>>   -    /*
>> -     * If resctrl is mounted, add
>> -     * per domain monitor data directories.
>> -     */
>> -    if (static_branch_unlikely(&rdt_mon_enable_key))
>> -        mkdir_mondata_subdir_allrdtgrp(r, d);
>> +    err = resctrl_online_domain(r, d);
>> +    if (err) {
>> +        list_del(&d->list);
>> +        kfree(hw_dom->ctrl_val);
>> +        kfree(hw_dom->mbps_val);
>> +        kfree(d);
> 
> Even though this goes away in next patch I think this should rather be kfree(hw_dom).


Whoops, that's a rebase artefact from patch 2. Fixed.


Thanks!

James
