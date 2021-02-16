Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFB431C800
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 10:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbhBPJZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 04:25:21 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2566 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbhBPJZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 04:25:18 -0500
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DfwQh4xyPz67pYb;
        Tue, 16 Feb 2021 17:19:24 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 16 Feb 2021 10:24:32 +0100
Received: from [10.210.171.197] (10.210.171.197) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 16 Feb 2021 09:24:31 +0000
Subject: Re: [PATCH v3] perf tools: Fix arm64 build error with gcc-11
To:     Jiri Olsa <jolsa@redhat.com>, Jianlin Lv <Jianlin.Lv@arm.com>
CC:     <will@kernel.org>, <mathieu.poirier@linaro.org>,
        <leo.yan@linaro.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <namhyung@kernel.org>,
        <irogers@google.com>, <agerstmayr@redhat.com>,
        <kan.liang@linux.intel.com>, <adrian.hunter@intel.com>,
        <iecedge@gmail.com>, <linux-kernel@vger.kernel.org>
References: <20210213050516.1221523-1-Jianlin.Lv@arm.com>
 <YCpnji8ukXa06iBU@krava>
From:   John Garry <john.garry@huawei.com>
Message-ID: <a6da023a-6476-fc20-9488-f129fde930fb@huawei.com>
Date:   Tue, 16 Feb 2021 09:22:51 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <YCpnji8ukXa06iBU@krava>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.171.197]
X-ClientProxiedBy: lhreml711-chm.china.huawei.com (10.201.108.62) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> ---
>>   tools/perf/builtin-script.c                            | 4 +++-
>>   tools/perf/util/scripting-engines/trace-event-python.c | 3 ++-
>>   tools/perf/util/session.c                              | 3 ++-
>>   3 files changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
>> index 42dad4a0f8cf..0d52dc45b1c7 100644
>> --- a/tools/perf/builtin-script.c
>> +++ b/tools/perf/builtin-script.c
>> @@ -643,7 +643,9 @@ static int perf_sample__fprintf_regs(struct regs_dump *regs, uint64_t mask,
>>   
>>   	for_each_set_bit(r, (unsigned long *) &mask, sizeof(mask) * 8) {
>>   		u64 val = regs->regs[i++];
>> -		printed += fprintf(fp, "%5s:0x%"PRIx64" ", perf_reg_name(r), val);
>> +		const char *reg_name = perf_reg_name(r);
>> +
>> +		printed += fprintf(fp, "%5s:0x%"PRIx64" ", reg_name ?: "unknown", val);
>>   	}
>>   
>>   	return printed;
>> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
>> index c83c2c6564e0..768bdd4240f4 100644
>> --- a/tools/perf/util/scripting-engines/trace-event-python.c
>> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
>> @@ -699,10 +699,11 @@ static int regs_map(struct regs_dump *regs, uint64_t mask, char *bf, int size)
>>   
>>   	for_each_set_bit(r, (unsigned long *) &mask, sizeof(mask) * 8) {
>>   		u64 val = regs->regs[i++];
>> +		const char *reg_name = perf_reg_name(r);
>>   
>>   		printed += scnprintf(bf + printed, size - printed,
>>   				     "%5s:0x%" PRIx64 " ",
>> -				     perf_reg_name(r), val);
>> +				     reg_name ?: "unknown", val);

what I was trying to suggest previously was to add a small helper 
function for this, like:

------- >8 --------

diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
index a45499126184..2663daf4122c 100644
--- a/tools/perf/util/perf_regs.h
+++ b/tools/perf/util/perf_regs.h
@@ -28,18 +28,25 @@ uint64_t arch__user_reg_mask(void);
  extern const struct sample_reg sample_reg_masks[];

  #include <perf_regs.h>

  #define DWARF_MINIMAL_REGS ((1ULL << PERF_REG_IP) | (1ULL << PERF_REG_SP))

  int perf_reg_value(u64 *valp, struct regs_dump *regs, int id);

+static inline const char *perf_reg_name_str(int id)
+{
+	const char *str = perf_reg_name(id);
+	if (!str)
+		return "unknown";
+	return str;
+}
+
  #else
  #define PERF_REGS_MASK	0
  #define PERF_REGS_MAX	0

  #define DWARF_MINIMAL_REGS PERF_REGS_MASK

-static inline const char *perf_reg_name(int id __maybe_unused)
+static inline const char *perf_reg_name_str(int id __maybe_unused)
  {
  	return "unknown";
  }

----8<----

So if someone were to make a change to use perf_reg_name() directly 
later and do not compile with gcc-11, then they may break the build. 
Hence the helper.

No big deal, though.

>>   	}
>>   
>>   	return printed;
>> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
>> index 25adbcce0281..2b40f1c431a3 100644
>> --- a/tools/perf/util/session.c
>> +++ b/tools/perf/util/session.c
>> @@ -1138,9 +1138,10 @@ static void regs_dump__printf(u64 mask, u64 *regs)
>>   
>>   	for_each_set_bit(rid, (unsigned long *) &mask, sizeof(mask) * 8) {
>>   		u64 val = regs[i++];
>> +		const char *reg_name = perf_reg_name(rid);
>>   
>>   		printf(".... %-5s 0x%016" PRIx64 "\n",
>> -		       perf_reg_name(rid), val);
>> +		       reg_name ?: "unknown", val);
>>   	}
>>   }
>>   
>> -- 
>> 2.25.1
>>
> 
> .
> 

