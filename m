Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43CC93E9465
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 17:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbhHKPRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 11:17:11 -0400
Received: from foss.arm.com ([217.140.110.172]:52758 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233155AbhHKPQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 11:16:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2045E1063;
        Wed, 11 Aug 2021 08:16:18 -0700 (PDT)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E8E453F718;
        Wed, 11 Aug 2021 08:16:15 -0700 (PDT)
Subject: Re: [PATCH v1 02/20] x86/resctrl: Merge mon_capable and mon_enabled
To:     Jamie Iles <jamie@nuviainc.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        lcherian@marvell.com, bobo.shaobowang@huawei.com
References: <20210729223610.29373-1-james.morse@arm.com>
 <20210729223610.29373-3-james.morse@arm.com> <YRO/ePm75ekuO+6j@hazel>
From:   James Morse <james.morse@arm.com>
Message-ID: <e3be6aa5-d43a-7545-8355-9e92eab39189@arm.com>
Date:   Wed, 11 Aug 2021 16:16:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YRO/ePm75ekuO+6j@hazel>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jamie,

On 11/08/2021 13:15, Jamie Iles wrote:
> On Thu, Jul 29, 2021 at 10:35:52PM +0000, James Morse wrote:
>> mon_enabled and mon_capable are always set as a pair by
>> rdt_get_mon_l3_config().
>>
>> There is no point having two values.
>>
>> Merge them together.

>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>> index ada0a02093a6..d715df9de37f 100644
>> --- a/include/linux/resctrl.h
>> +++ b/include/linux/resctrl.h
>> @@ -130,7 +130,7 @@ struct resctrl_schema;
>>  /**
>>   * struct rdt_resource - attributes of a resctrl resource
>>   * @rid:		The index of the resource
>> - * @mon_enabled:	Is monitoring enabled for this feature
>> + * @cdp_enabled		Is CDP enabled for this resource
>>   * @alloc_capable:	Is allocation available on this machine
>>   * @mon_capable:	Is monitor feature available on this machine
>>   * @num_rmid:		Number of RMIDs available
>> @@ -149,7 +149,7 @@ struct resctrl_schema;
>>   */
>>  struct rdt_resource {
>>  	int			rid;
>> -	bool			mon_enabled;
>> +	bool			cdp_enabled;
> 
> Nothing is setting cdp_enabled in this patch, is this intended to be 
> here?

Bother, that is the result of a merge conflict from changes from the previous series!

Thanks, I've removed it.


James
