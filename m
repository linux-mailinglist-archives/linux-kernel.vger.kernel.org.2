Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2C2A41F1B0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 18:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355160AbhJAQDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 12:03:23 -0400
Received: from foss.arm.com ([217.140.110.172]:46238 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355164AbhJAQDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 12:03:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0DA4113E;
        Fri,  1 Oct 2021 09:01:35 -0700 (PDT)
Received: from [10.1.196.28] (eglon.cambridge.arm.com [10.1.196.28])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF75C3F766;
        Fri,  1 Oct 2021 09:01:33 -0700 (PDT)
Subject: Re: [PATCH v1 09/20] x86/resctrl: Abstract and use
 supports_mba_mbps()
To:     "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
        "'x86@kernel.org'" <x86@kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Cc:     'Fenghua Yu' <fenghua.yu@intel.com>,
        'Reinette Chatre' <reinette.chatre@intel.com>,
        'Thomas Gleixner' <tglx@linutronix.de>,
        'Ingo Molnar' <mingo@redhat.com>,
        'Borislav Petkov' <bp@alien8.de>,
        'H Peter Anvin' <hpa@zytor.com>,
        'Babu Moger' <Babu.Moger@amd.com>,
        "'shameerali.kolothum.thodi@huawei.com'" 
        <shameerali.kolothum.thodi@huawei.com>,
        'Jamie Iles' <jamie@nuviainc.com>,
        'D Scott Phillips OS' <scott@os.amperecomputing.com>,
        "'lcherian@marvell.com'" <lcherian@marvell.com>,
        "'bobo.shaobowang@huawei.com'" <bobo.shaobowang@huawei.com>
References: <20210729223610.29373-10-james.morse@arm.com>
 <TYAPR01MB63305E4A3128B7CDF84F86538BA49@TYAPR01MB6330.jpnprd01.prod.outlook.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <21e71153-a134-b553-785d-2264fa3f0327@arm.com>
Date:   Fri, 1 Oct 2021 17:01:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <TYAPR01MB63305E4A3128B7CDF84F86538BA49@TYAPR01MB6330.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=iso-2022-jp
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi  Shaopeng Tan,

On 24/09/2021 07:23, tan.shaopeng@fujitsu.com wrote:
>> To determine whether the mba_mbps option to resctrl should be supported,
>> resctrl tests the boot cpus' x86_vendor.
>>
>> This isn't portable, and needs abstracting behind a helper so this check can be
>> part of the filesystem code that moves to /fs/.
>>
>> Re-use the tests set_mba_sc() does to determine if the mba_sc is supported
>> on this system. An 'alloc_capable' test is added so that this property isn't
>> implied by 'linear'.

>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index e321ea5de562..4388685548a0 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -2317,7 +2326,7 @@ static int rdt_parse_param(struct fs_context *fc,
>> struct fs_parameter *param)
>>  		ctx->enable_cdpl2 = true;
>>  		return 0;
>>  	case Opt_mba_mbps:
>> -		if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
>> +		if (supports_mba_mbps())
>>  			return -EINVAL;
> I think if(!supports_mba_mbps()) is correct, isn't it? 

Ooops!

(looks like I messed this up when fixing the name)


Thanks,

James
