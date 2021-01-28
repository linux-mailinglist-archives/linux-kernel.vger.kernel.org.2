Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A227B3073F7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 11:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbhA1Knx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 05:43:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:32776 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231231AbhA1Knu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 05:43:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F3195AC45;
        Thu, 28 Jan 2021 10:43:07 +0000 (UTC)
Subject: Re: [PATCH] perf tools: Resolve symbols against debug file first
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>
References: <20210113080128.10286-1-jslaby@suse.cz>
 <20210113104618.GB1331835@krava>
From:   Jiri Slaby <jslaby@suse.cz>
Message-ID: <d6001540-c028-8728-413b-273a11d00ffe@suse.cz>
Date:   Thu, 28 Jan 2021 11:43:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210113104618.GB1331835@krava>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13. 01. 21, 11:46, Jiri Olsa wrote:
> On Wed, Jan 13, 2021 at 09:01:28AM +0100, Jiri Slaby wrote:
>> With LTO, there are symbols like these:
>> /usr/lib/debug/usr/lib64/libantlr4-runtime.so.4.8-4.8-1.4.x86_64.debug
>>   10305: 0000000000955fa4     0 NOTYPE  LOCAL  DEFAULT   29 Predicate.cpp.2bc410e7
>>
>> This comes from a runtime/debug split done by the standard way:
>> objcopy --only-keep-debug $runtime $debug
>> objcopy --add-gnu-debuglink=$debugfn -R .comment -R .GCC.command.line --strip-all $runtime
>>
>> perf currently cannot resolve such symbols (relicts of LTO), as section
>> 29 exists only in the debug file (29 is .debug_info). And perf resolves
>> symbols only against runtime file. This results in all symbols from such
>> a library being unresolved:
>>       0.38%  main2    libantlr4-runtime.so.4.8  [.] 0x00000000000671e0
>>
>> So try resolving against the debug file first. And only if it fails (the
>> section has NOBITS set), try runtime file. We can do this, as "objcopy
>> --only-keep-debug" per documentation preserves all sections, but clears
>> data of some of them (the runtime ones) and marks them as NOBITS.
>>
>> The correct result is now:
>>       0.38%  main2    libantlr4-runtime.so.4.8  [.] antlr4::IntStream::~IntStream
>>
>> Note that these LTO symbols are properly skipped anyway as they belong
>> neither to *text* nor to *data* (is_label && !elf_sec__filter(&shdr,
>> secstrs) is true).
>>
>> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>> Cc: Jiri Olsa <jolsa@redhat.com>
>> Cc: Namhyung Kim <namhyung@kernel.org>
>> ---
>>   tools/perf/util/symbol-elf.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
>> index f3577f7d72fe..a31b716fa61c 100644
>> --- a/tools/perf/util/symbol-elf.c
>> +++ b/tools/perf/util/symbol-elf.c
>> @@ -1226,12 +1226,20 @@ int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
>>   		if (sym.st_shndx == SHN_ABS)
>>   			continue;
>>   
>> -		sec = elf_getscn(runtime_ss->elf, sym.st_shndx);
>> +		sec = elf_getscn(syms_ss->elf, sym.st_shndx);
>>   		if (!sec)
>>   			goto out_elf_end;
> 
> we iterate symbols from syms_ss, so the fix seems to be correct
> to call elf_getscn on syms_ss, not on runtime_ss as we do now
> 
> I'd think this worked only when runtime_ss == syms_ss
> 
>>   
>>   		gelf_getshdr(sec, &shdr);
>>   
>> +		if (shdr.sh_type == SHT_NOBITS) {
>> +			sec = elf_getscn(runtime_ss->elf, sym.st_shndx);
>> +			if (!sec)
>> +				goto out_elf_end;
>> +
>> +			gelf_getshdr(sec, &shdr);
>> +		}
> 
> is that fallback necessary? the symbol is from syms_ss

To resume this and answer:

Yes, the fallback is necessary.

It's because syms_ss section header has NOBITS set for the sections, so 
file offset is not incremented. So shdr.sh_offset (the file offset) used 
further in dso__load_sym has different values for syms and runtime. The 
syms_ss (the NOBITS) one is invalid as it has 0x1000 here. The runtime 
one contains good values (like 000509d0 here):

.text         00082560  00000000000509d0  00000000000509d0  [-00001000-] 
  {+000509d0+}  2**4

That is, without the fallback, the computed symbol address is wrong.

thanks,
-- 
js
suse labs
