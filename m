Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E31AE31516E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 15:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhBIOU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 09:20:56 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2526 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhBIOUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 09:20:54 -0500
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DZlHJ4mmCz67mSQ;
        Tue,  9 Feb 2021 22:13:32 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 9 Feb 2021 15:20:05 +0100
Received: from [10.47.2.44] (10.47.2.44) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 9 Feb 2021
 14:20:03 +0000
Subject: Re: [PATCH] perf tools: Fix arm64 build error with gcc-11
To:     Leo Yan <leo.yan@linaro.org>, Jianlin Lv <Jianlin.Lv@arm.com>
CC:     <will@kernel.org>, <mathieu.poirier@linaro.org>,
        <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20210209113357.1535104-1-Jianlin.Lv@arm.com>
 <20210209121728.GA12546@leoy-ThinkPad-X240s>
From:   John Garry <john.garry@huawei.com>
Message-ID: <66c8385e-b9fb-4a5b-a55e-e1543ad3d3c3@huawei.com>
Date:   Tue, 9 Feb 2021 14:18:26 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20210209121728.GA12546@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.2.44]
X-ClientProxiedBy: lhreml718-chm.china.huawei.com (10.201.108.69) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/2021 12:17, Leo Yan wrote:
> Hi Jianlin,
> 
> On Tue, Feb 09, 2021 at 07:33:57PM +0800, Jianlin Lv wrote:
>> gcc version: 11.0.0 20210208 (experimental) (GCC)
>>
>> Following build error on arm64:
>>
>> .......
>> In function ‘printf’,
>>      inlined from ‘regs_dump__printf’ at util/session.c:1141:3,
>>      inlined from ‘regs__printf’ at util/session.c:1169:2:
>> /usr/include/aarch64-linux-gnu/bits/stdio2.h:107:10: \
>>    error: ‘%-5s’ directive argument is null [-Werror=format-overflow=]
>>
>> 107 |   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, \
>>                  __va_arg_pack ());
>>
>> ......
>> In function ‘fprintf’,
>>    inlined from ‘perf_sample__fprintf_regs.isra’ at \
>>      builtin-script.c:622:14:
>> /usr/include/aarch64-linux-gnu/bits/stdio2.h:100:10: \
>> 	error: ‘%5s’ directive argument is null [-Werror=format-overflow=]
>>    100 |   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
>>    101 |                         __va_arg_pack ());
>>
>> cc1: all warnings being treated as errors
>> .......
>>
>> This patch fixes Wformat-overflow warnings by replacing the return
>> value NULL of perf_reg_name with "unknown".
>>
>> Signed-off-by: Jianlin Lv <Jianlin.Lv@arm.com>
>> ---
>>   tools/perf/arch/arm64/include/perf_regs.h | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/arch/arm64/include/perf_regs.h b/tools/perf/arch/arm64/include/perf_regs.h
>> index baaa5e64a3fb..901419f907c0 100644
>> --- a/tools/perf/arch/arm64/include/perf_regs.h
>> +++ b/tools/perf/arch/arm64/include/perf_regs.h
>> @@ -85,10 +85,10 @@ static inline const char *perf_reg_name(int id)
>>   	case PERF_REG_ARM64_PC:
>>   		return "pc";
>>   	default:
>> -		return NULL;
>> +		return "unknown";
>>   	}
>>   
>> -	return NULL;
>> +	return "unknown";
> 
> This issue is a common issue crossing all archs.  So it's better to
> change the code in the places where calls perf_reg_name(), e.g. in
> util/session.c:
> 
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1135,12 +1135,14 @@ static void branch_stack__printf(struct perf_sample *sample, bool callstack)
>   static void regs_dump__printf(u64 mask, u64 *regs)
>   {
>          unsigned rid, i = 0;
> +       char *reg_name;
>   
>          for_each_set_bit(rid, (unsigned long *) &mask, sizeof(mask) * 8) {
>                  u64 val = regs[i++];
>   
> +               reg_name = perf_reg_name(rid);
>                  printf(".... %-5s 0x%016" PRIx64 "\n",
> -                      perf_reg_name(rid), val);
> +                      reg_name ?: "Unknown", val);
>          }
>   }
> 
> And another potential issue is the format specifier "%-5s", it prints
> out maximum to 5 chars, 

Doesn't the width field specify the min, not max, number of characters?

Cheers,
John

> but actually string "Unknown" has 7 chars.
> Actually the format specifier breaks other archs register names, e.g.
> [1][2], seems to me, it's better to change as "%-8s", you might need
> to use a dedicated patch for format specifier changes.
> 
> Thanks,
> Leo
> 
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/arch/powerpc/include/perf_regs.h#n57
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/perf/arch/csky/include/perf_regs.h#n83
> .
> 

