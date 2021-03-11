Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85A37336CAC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 08:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbhCKHDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 02:03:01 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:13520 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbhCKHC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 02:02:56 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Dx0Ft0VvSzMkhG;
        Thu, 11 Mar 2021 15:00:34 +0800 (CST)
Received: from [127.0.0.1] (10.69.38.203) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.498.0; Thu, 11 Mar 2021
 15:02:46 +0800
Subject: Re: [PATCH v4 4/5] perf stat: Enable iostat mode for x86 platforms
To:     Alexander Antonov <alexander.antonov@linux.intel.com>
CC:     <acme@kernel.org>, <linux-kernel@vger.kernel.org>,
        <jolsa@redhat.com>, <ak@linux.intel.com>,
        <alexander.shishkin@linux.intel.com>, <mark.rutland@arm.com>,
        <namhyung@kernel.org>, <irogers@google.com>, <mingo@redhat.com>,
        <peterz@infradead.org>
References: <20210203135830.38568-1-alexander.antonov@linux.intel.com>
 <20210203135830.38568-5-alexander.antonov@linux.intel.com>
 <d2f23f76-3557-f6f1-dd0b-2491bb734b00@huawei.com>
 <65bccfcb-2e43-714f-f586-09aa5015c4fa@linux.intel.com>
From:   "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <9fc839cc-6c5d-1e3b-5d21-716a0a77df18@huawei.com>
Date:   Thu, 11 Mar 2021 15:02:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <65bccfcb-2e43-714f-f586-09aa5015c4fa@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.38.203]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/3/11 0:19, Alexander Antonov wrote:
> 
> On 3/9/2021 10:51 AM, liuqi (BA) wrote:
>> Hi Alexander,
>>
>> On 2021/2/3 21:58, Alexander Antonov wrote:
>>> This functionality is based on recently introduced sysfs attributes
>>> for Intel® Xeon® Scalable processor family (code name Skylake-SP):
>>> Commit bb42b3d39781 ("perf/x86/intel/uncore: Expose an Uncore unit to
>>> IIO PMON mapping")
>>>
>>> Mode is intended to provide four I/O performance metrics in MB per each
>>> PCIe root port:
>>>   - Inbound Read: I/O devices below root port read from the host memory
>>>   - Inbound Write: I/O devices below root port write to the host memory
>>>   - Outbound Read: CPU reads from I/O devices below root port
>>>   - Outbound Write: CPU writes to I/O devices below root port
>>>
>>> Each metric requiries only one uncore event which increments at every 4B
>>> transfer in corresponding direction. The formulas to compute metrics
>>> are generic:
>>>      #EventCount * 4B / (1024 * 1024)
>>>
>>> Signed-off-by: Alexander Antonov<alexander.antonov@linux.intel.com>
>>> ---
>>>   tools/perf/Documentation/perf-iostat.txt |  88 ++++++
>>>   tools/perf/Makefile.perf                 |   5 +-
>>>   tools/perf/arch/x86/util/Build           |   1 +
>>>   tools/perf/arch/x86/util/iostat.c        | 345 +++++++++++++++++++++++
>>>   tools/perf/command-list.txt              |   1 +
>>>   tools/perf/perf-iostat.sh                |  12 +
>>>   6 files changed, 451 insertions(+), 1 deletion(-)
>>>   create mode 100644 tools/perf/Documentation/perf-iostat.txt
>>>   create mode 100644 tools/perf/perf-iostat.sh
>>>
>>> diff --git a/tools/perf/Documentation/perf-iostat.txt 
>>> b/tools/perf/Documentation/perf-iostat.txt
>>> new file mode 100644
>>> index 000000000000..165176944031
>>> --- /dev/null
>>> +++ b/tools/perf/Documentation/perf-iostat.txt
>>> @@ -0,0 +1,88 @@
>>> +perf-iostat(1)
>>> +===============
>>> +
>>> +NAME
>>> +----
>>> +perf-iostat - Show I/O performance metrics
>>> +
>>> +SYNOPSIS
>>> +--------
>>> +[verse]
>>> +'perf iostat' list
>>> +'perf iostat' <ports> -- <command> [<options>]
>>> +
>>> +DESCRIPTION
>>> +-----------
>>> +Mode is intended to provide four I/O performance metrics per each 
>>> PCIe root port:
>>> +
>>> +- Inbound Read   - I/O devices below root port read from the host 
>>> memory, in MB
>>> +
>>> +- Inbound Write  - I/O devices below root port write to the host 
>>> memory, in MB
>>> +
>>> +- Outbound Read  - CPU reads from I/O devices below root port, in MB
>>> +
>>> +- Outbound Write - CPU writes to I/O devices below root port, in MB
>>> +
>>> +OPTIONS
>>> +-------
>>> +<command>...::
>>> +    Any command you can specify in a shell.
>>> +
>>> +list::
>>> +    List all PCIe root ports.
>>
>> I noticed that "iostat" commond and cmd_iostat() callback function is 
>> not registered in cmd_struct in perf.c. So I think "perf iostat list" 
>> perhaps can not work properly.
>>
>> I also test this patchset on x86 platform, and here is the log:
>>
>> root@ubuntu:/home/lq# ./perf iostat list
>> perf: 'iostat' is not a perf-command. See 'perf --help'.
>> root@ubuntu:/home/lq# ./perf stat --iostat
>> ^C
>>  Performance counter stats for 'system wide':
>>
>>    port             Inbound Read(MB)    Inbound Write(MB) Outbound 
>> Read(MB)   Outbound Write(MB)
>> 0000:00                    0 0                    0                  0
>> 0000:80                    0 0                    0                  0
>> 0000:17                    0 0                    0                  0
>> 0000:85                    0 0                    0                  0
>> 0000:3a                    0 0                    0                  0
>> 0000:ae                    0 0                    0                  0
>> 0000:5d                    0 0                    0                  0
>> 0000:d7                    0 0                    0                  0
>>
>>        0.611303832 seconds time elapsed
>>
>>
>> root@ubuntu:/home/lq# ./perf stat --iostat=0000:17
>> ^C
>>  Performance counter stats for 'system wide':
>>
>>    port             Inbound Read(MB)    Inbound Write(MB) Outbound 
>> Read(MB)   Outbound Write(MB)
>> 0000:17                    0 0                    0                  0
>>
>>        0.521317572 seconds time elapsed
>>
>> So how does following perf iostat list work, did I miss something?
>>
>> Thanks,
>> Qi
>>
> Hello,
> 
> The 'iostat' mode uses aliases mechanism in perf same as 'perf archive' and
> in this case you don't need to add function callback into cmd_struct.
> For example, the command 'perf iostat list' will be converted to
> 'perf stat --iostat=list'.
> 
> After building the perf tool you should have two shell scripts in 
> tools/perf
> directory and one of them is executable, for example:
> # make -C tools/perf
> # ls -l tools/perf/perf-iostat*
> -rwxr-xr-x 1 root root 290 Mar 10 18:17 perf-iostat
> -rw-r--r-- 1 root root 290 Feb  3 15:14 perf-iostat.sh
> 
> It should be possible to run 'perf iostat' from build directory:
> # cd tools/perf
> # ./perf iostat list
> S0-uncore_iio_0<0000:00>
> S1-uncore_iio_0<0000:80>
> S0-uncore_iio_1<0000:17>
> S1-uncore_iio_1<0000:85>
> S0-uncore_iio_2<0000:3a>
> S1-uncore_iio_2<0000:ae>
> S0-uncore_iio_3<0000:5d>
> S1-uncore_iio_3<0000:d7>
> 
> Also you can copy 'perf-iostat' to ~/libexec/perf-core/ or just run 
> 'make install'
> 
> # make install
> # cp perf /usr/bin/
> # ls -lh ~/libexec/perf-core/
> total 24K
> -rwxr-xr-x 1 root root 1.4K Mar 10 18:17 perf-archive
> -rwxr-xr-x 1 root root  290 Mar 10 18:17 perf-iostat
> -rwxr-xr-x 1 root root 6.3K Mar 10 18:17 perf-with-kcore
> drwxr-xr-x 4 root root 4.0K Nov  5  2019 scripts
> drwxr-xr-x 4 root root 4.0K Mar 10 18:17 tests
> # perf iostat 0000:17 -I 1000 --interval-count 2
> #           time    port             Inbound Read(MB)    Inbound 
> Write(MB)    Outbound Read(MB)   Outbound Write(MB)
>       1.000220341 0000:17                    0 0 0                    0
>       2.000569569 0000:17                    0 0 0                    0
> 
> Actually, Arnaldo has explained before how does aliases mechanism work.
> 
> I hope it will solve your issue. Otherwise, please email.
> 
> Thank you,
> Alexander

Hi Alexander,

I try it again on x86 platform and it works, thanks a lot:)

Thanks,
Qi
>>> +
>>> +<ports>::
>>> +    Select the root ports for monitoring. Comma-separated list is 
>>> supported.
>>> +
>>> +EXAMPLES
>>> +--------
>>> +
>>> +1. List all PCIe root ports (example for 2-S platform):
>>> +
>>> +   $ perf iostat list
>>> +   S0-uncore_iio_0<0000:00>
>>> +   S1-uncore_iio_0<0000:80>
>>> +   S0-uncore_iio_1<0000:17>
>>> +   S1-uncore_iio_1<0000:85>
>>> +   S0-uncore_iio_2<0000:3a>
>>> +   S1-uncore_iio_2<0000:ae>
>>> +   S0-uncore_iio_3<0000:5d>
>>> +   S1-uncore_iio_3<0000:d7>
>>
> 
> .

