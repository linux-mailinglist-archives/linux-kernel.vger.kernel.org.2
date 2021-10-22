Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEDD437C95
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 20:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233861AbhJVScj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 14:32:39 -0400
Received: from foss.arm.com ([217.140.110.172]:57604 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233803AbhJVScf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 14:32:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C74713A1;
        Fri, 22 Oct 2021 11:30:17 -0700 (PDT)
Received: from [10.1.196.28] (eglon.cambridge.arm.com [10.1.196.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8743F3F99C;
        Fri, 22 Oct 2021 11:30:15 -0700 (PDT)
Subject: Re: [PATCH v2 04/23] x86/resctrl: Merge mon_capable and mon_enabled
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
 <20211001160302.31189-5-james.morse@arm.com>
 <44ce43de-b6d9-cfbf-b991-0b7cfd819d39@amd.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <ab2864e4-d2cd-c0a6-b745-65a7919bac63@arm.com>
Date:   Fri, 22 Oct 2021 19:30:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <44ce43de-b6d9-cfbf-b991-0b7cfd819d39@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 20/10/2021 00:18, Babu Moger wrote:
> On 10/1/21 11:02 AM, James Morse wrote:
>> mon_enabled and mon_capable are always set as a pair by
>> rdt_get_mon_l3_config().
>>
>> There is no point having two values.
>>
>> Merge them together.

>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>> index 386ab3a41500..8180c539800d 100644
>> --- a/include/linux/resctrl.h
>> +++ b/include/linux/resctrl.h
>> @@ -130,7 +130,6 @@ struct resctrl_schema;
>>  /**
>>   * struct rdt_resource - attributes of a resctrl resource
>>   * @rid:		The index of the resource
>> - * @mon_enabled:	Is monitoring enabled for this feature
>>   * @alloc_capable:	Is allocation available on this machine
>>   * @mon_capable:	Is monitor feature available on this machine
>>   * @num_rmid:		Number of RMIDs available
>> @@ -149,7 +148,6 @@ struct resctrl_schema;
>>   */
>>  struct rdt_resource {
>>  	int			rid;
>> -	bool			mon_enabled;
>>  	bool			alloc_capable;
>>  	bool			mon_capable;
> 
> Also we should probably rename alloc_capable and mon_capable to
> alloc_supported and mon_supported respectively. We dont have an option to
> enable and disable these feature. If it is supported, it is always supported.

Does 'capable' imply the feature was enabled? I agree 'supported' is clearer now that the
schema/resource enable step has been folded away.

I'll put this on the TODO list...


Thanks,

James
