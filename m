Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10E863ABA2D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 19:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhFQRFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 13:05:13 -0400
Received: from foss.arm.com ([217.140.110.172]:56726 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229683AbhFQRFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 13:05:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2736D13D5;
        Thu, 17 Jun 2021 10:03:03 -0700 (PDT)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B91D3F694;
        Thu, 17 Jun 2021 10:03:01 -0700 (PDT)
Subject: Re: [PATCH v4 03/24] x86/resctrl: Add a separate schema list for
 resctrl
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
 <20210614200941.12383-4-james.morse@arm.com>
 <8626fde4-ed22-be80-e36f-45a16e5eceaa@amd.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <1de354b1-63f7-5098-6468-96509eddf956@arm.com>
Date:   Thu, 17 Jun 2021 18:02:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <8626fde4-ed22-be80-e36f-45a16e5eceaa@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 15/06/2021 18:51, Babu Moger wrote:
> On 6/14/21 3:09 PM, James Morse wrote:
>> Resctrl exposes schemata to user-space, which allow the control values
>> to be specified for a group of tasks.
>>
>> User-visible properties of the interface, (such as the schemata names
>> and how the values are parsed) are rooted in a struct provided by the
>> architecture code. (struct rdt_hw_resource). Once a second architecture
>> uses resctrl, this would allow user-visible properties to diverge
>> between architectures.
>>
>> These properties should come from the resctrl code that will be common
>> to all architectures. Resctrl has no per-schema structure, only struct
>> rdt_{hw_,}resource. Create a struct resctrl_schema to hold the
>> rdt_resource. Before a second architecture can be supported, this
>> structure will also need to hold the schema name visible to user-space
>> and the type of configuration values for resctrl.

>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>> index be6f5df78e31..425e7913dc8d 100644
>> --- a/include/linux/resctrl.h
>> +++ b/include/linux/resctrl.h
>> @@ -154,4 +154,15 @@ struct rdt_resource {
>>  
>>  };
>>  
>> +/**
>> + * struct resctrl_schema - configuration abilities of a resource presented to
>> + *			   user-space
>> + * @list:	Member of resctrl_schema_all.
>> + * @res:	The resource structure exported by the architecture to describe
>> + *		the hardware that is configured by this schema.
>> + */
>> +struct resctrl_schema {
>> +	struct list_head		list;
>> +	struct rdt_resource		*res;

> It will be better to be consistent with the naming.
>         struct rdt_resource		*resctrl;

Consistent with what? The rest of the code base conventionally calls a resource 'r'.

The structures with '_hw_' are private to the architecture, the 'resctrl' structure there
is the part of the struct that the architecture makes visible to the filesystem of that name.

That pattern doesn't apply here, 'struct resctrl_schema' is an invention of the
filesystem, the architecture code doesn't need to know anything about it. (this is why it
goes in include/linux from the beginning).


I think the choices are 'r', (too terse), 'resource' (too much typing, obvious from the
type), or 'res'...


Thanks!

James
