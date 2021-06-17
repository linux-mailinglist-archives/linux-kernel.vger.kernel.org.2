Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 646143ABA2C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 19:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbhFQREc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 13:04:32 -0400
Received: from foss.arm.com ([217.140.110.172]:56698 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230526AbhFQREb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 13:04:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5068613D5;
        Thu, 17 Jun 2021 10:02:23 -0700 (PDT)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C0E23F694;
        Thu, 17 Jun 2021 10:02:21 -0700 (PDT)
Subject: Re: [PATCH v4 02/24] x86/resctrl: Split struct rdt_domain
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
        lcherian@marvell.com
References: <20210614200941.12383-1-james.morse@arm.com>
 <20210614200941.12383-3-james.morse@arm.com>
 <ac2a3f6e-ef49-5770-7886-c3f813659d06@amd.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <707378c3-1ce1-12d7-e35d-8c8d4650340e@arm.com>
Date:   Thu, 17 Jun 2021 18:02:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <ac2a3f6e-ef49-5770-7886-c3f813659d06@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 15/06/2021 18:51, Babu Moger wrote:
> On 6/14/21 3:09 PM, James Morse wrote:
>> resctrl is the defacto Linux ABI for SoC resource partitioning features.
>>
>> To support it on another architecture, it needs to be abstracted from
>> the features provided by Intel RDT and AMD PQoS, and moved to /fs/.
>> struct rdt_resource contains a mix of architecture private details
>> and properties of the filesystem interface user-space users.
>>
>> Continue by splitting struct rdt_domain, into an architecture private
>> 'hw' struct, which contains the common resctrl structure that would be
>> used by any architecture. The hardware values in ctrl_val and mbps_val
>> need to be accessed via helpers to allow another architecture to convert
>> these into a different format if necessary. After this split, filesystem
>> code paths touching a 'hw' struct indicates where an abstraction
>> is needed.
>>
>> Splitting this structure only moves types around, and should not lead
>> to any change in behaviour.

>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index 43c8cf6b2b12..235cf621c878 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -299,44 +299,25 @@ struct mbm_state {

>> -struct rdt_domain {
>> -	struct list_head		list;
>> -	int				id;
>> -	struct cpumask			cpu_mask;
>> -	unsigned long			*rmid_busy_llc;
>> -	struct mbm_state		*mbm_total;
>> -	struct mbm_state		*mbm_local;
>> -	struct delayed_work		mbm_over;
>> -	struct delayed_work		cqm_limbo;
>> -	int				mbm_work_cpu;
>> -	int				cqm_work_cpu;
>> +struct rdt_hw_domain {
>> +	struct rdt_domain		resctrl;


> Naming is bit confusing here. There is another field with the same
> name(patch1).

But a totally different type, you'd only access its members via the resource or domain, so
its always clear which it is. (and if you get them wrong, it won't build)


> +struct rdt_hw_resource {
> +	struct rdt_resource	resctrl;
> 
> I think we should make this bit more clearer. May be or something similar.
> 
> struct rdt_hw_domain {
>     struct rdt_domain		d_resctrl;
Sure, I guess it makes it clear when quoting something.


Thanks,

James
