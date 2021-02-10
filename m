Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB64531628F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 10:44:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbhBJJnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 04:43:25 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2527 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhBJJk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 04:40:56 -0500
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DbF3c1hXSz67ll2;
        Wed, 10 Feb 2021 17:35:08 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 10 Feb 2021 10:40:03 +0100
Received: from [10.210.168.117] (10.210.168.117) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 10 Feb 2021 09:40:01 +0000
Subject: Re: [PATCH v2] perf tools: Fix arm64 build error with gcc-11
To:     Jianlin Lv <Jianlin.Lv@arm.com>, <will@kernel.org>,
        <mathieu.poirier@linaro.org>, <leo.yan@linaro.org>,
        <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <irogers@google.com>,
        <agerstmayr@redhat.com>, <kan.liang@linux.intel.com>,
        <adrian.hunter@intel.com>
CC:     <linux-kernel@vger.kernel.org>
References: <20210210032447.2248255-1-Jianlin.Lv@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <5db96a5f-3749-7f54-15ce-27b932bcbca6@huawei.com>
Date:   Wed, 10 Feb 2021 09:38:27 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20210210032447.2248255-1-Jianlin.Lv@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.210.168.117]
X-ClientProxiedBy: lhreml748-chm.china.huawei.com (10.201.108.198) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2021 03:24, Jianlin Lv wrote:
> gcc version: 11.0.0 20210208 (experimental) (GCC)
> 
> Following build error on arm64:
> 
> .......
> In function ‘printf’,
>      inlined from ‘regs_dump__printf’ at util/session.c:1141:3,
>      inlined from ‘regs__printf’ at util/session.c:1169:2:
> /usr/include/aarch64-linux-gnu/bits/stdio2.h:107:10: \
>    error: ‘%-5s’ directive argument is null [-Werror=format-overflow=]
> 
> 107 |   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, \
>                  __va_arg_pack ());
> 
> ......
> In function ‘fprintf’,
>    inlined from ‘perf_sample__fprintf_regs.isra’ at \
>      builtin-script.c:622:14:
> /usr/include/aarch64-linux-gnu/bits/stdio2.h:100:10: \
>      error: ‘%5s’ directive argument is null [-Werror=format-overflow=]
>    100 |   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
>    101 |                         __va_arg_pack ());
> 
> cc1: all warnings being treated as errors
> .......
> 
> This patch fixes Wformat-overflow warnings. Add ternary operator,
> The statement evaluates to "Unknown" if reg_name==NULL is met.
> 
> Signed-off-by: Jianlin Lv <Jianlin.Lv@arm.com>
> ---
> v2: Add ternary operator to avoid similar errors in other arch.
> ---
>   tools/perf/builtin-script.c                            | 4 +++-
>   tools/perf/util/scripting-engines/trace-event-python.c | 4 +++-
>   tools/perf/util/session.c                              | 5 +++--
>   3 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 42dad4a0f8cf..d59da3a063d0 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -635,6 +635,7 @@ static int perf_sample__fprintf_regs(struct regs_dump *regs, uint64_t mask,
>   {
>   	unsigned i = 0, r;
>   	int printed = 0;
> +	const char *reg_name;
>   
>   	if (!regs || !regs->regs)
>   		return 0;
> @@ -643,7 +644,8 @@ static int perf_sample__fprintf_regs(struct regs_dump *regs, uint64_t mask,
>   
>   	for_each_set_bit(r, (unsigned long *) &mask, sizeof(mask) * 8) {
>   		u64 val = regs->regs[i++];
> -		printed += fprintf(fp, "%5s:0x%"PRIx64" ", perf_reg_name(r), val);
> +		reg_name = perf_reg_name(r);
> +		printed += fprintf(fp, "%5s:0x%"PRIx64" ", reg_name ?: "Unknown", val);

is it possible not have to do this check for NULL and reassignment 
everywhere?

>   	}
>   
>   	return printed;
> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
> index c83c2c6564e0..e1222cc6a699 100644
> --- a/tools/perf/util/scripting-engines/trace-event-python.c
> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> @@ -691,6 +691,7 @@ static int regs_map(struct regs_dump *regs, uint64_t mask, char *bf, int size)
>   {
>   	unsigned int i = 0, r;
>   	int printed = 0;
> +	const char *reg_name;
>   
>   	bf[0] = 0;
>   
> @@ -700,9 +701,10 @@ static int regs_map(struct regs_dump *regs, uint64_t mask, char *bf, int size)
>   	for_each_set_bit(r, (unsigned long *) &mask, sizeof(mask) * 8) {

a good practice is to limit scope of variables as much as possible, so 
reg_name could be declared here
	
>   		u64 val = regs->regs[i++];
>   
> +		reg_name = perf_reg_name(r);
>   		printed += scnprintf(bf + printed, size - printed,
>   				     "%5s:0x%" PRIx64 " ",
> -				     perf_reg_name(r), val);
> +				     reg_name ?: "Unknown", val);
>   	}
>   
>   	return printed;
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 25adbcce0281..1058d8487e98 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1135,12 +1135,13 @@ static void branch_stack__printf(struct perf_sample *sample, bool callstack)
>   static void regs_dump__printf(u64 mask, u64 *regs)
>   {
>   	unsigned rid, i = 0;
> +	const char *reg_name;
>   
>   	for_each_set_bit(rid, (unsigned long *) &mask, sizeof(mask) * 8) {
>   		u64 val = regs[i++];
> -
> +		reg_name = perf_reg_name(rid);
>   		printf(".... %-5s 0x%016" PRIx64 "\n",
> -		       perf_reg_name(rid), val);
> +		       reg_name ?: "Unknown", val);

super nit: it's "unknown" in util/perf_regs.h::perf_reg_name(), so nice 
to be consistent


>   	}
>   }
>   
> 

thanks,
John
