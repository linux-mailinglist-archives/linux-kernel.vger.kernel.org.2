Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 155333DD513
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 14:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbhHBMDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 08:03:01 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:7916 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbhHBMDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 08:03:00 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Gdc3l1xHgz82dV;
        Mon,  2 Aug 2021 19:58:59 +0800 (CST)
Received: from dggema757-chm.china.huawei.com (10.1.198.199) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 2 Aug 2021 20:02:48 +0800
Received: from [127.0.0.1] (10.69.38.203) by dggema757-chm.china.huawei.com
 (10.1.198.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 2 Aug
 2021 20:02:48 +0800
Subject: Re: [PATCH] arm64: kprobe: Enable OPTPROBE for arm64
To:     Linuxarm <linuxarm@huawei.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "naveen.n.rao@linux.ibm.com" <naveen.n.rao@linux.ibm.com>,
        "anil.s.keshavamurthy@intel.com" <anil.s.keshavamurthy@intel.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210719122417.10355-1-liuqi115@huawei.com>
 <20210721174153.34c1898dc9eea135eb0b8be8@kernel.org>
 <332df5b7d7bb4bd096b6521ffefaabe6@hisilicon.com>
 <20210723000318.5594c86e7c454aed82d9465d@kernel.org>
 <e63531dc8b7040219761e72fb9b1e74a@hisilicon.com>
 <20210731101537.a64063d84e86d7910bd58a96@kernel.org>
 <6a97dff6c33c4b84887223de2502bd3d@hisilicon.com>
 <2f32fff3-6b58-583f-8e85-06ec1553d3f4@huawei.com>
From:   "liuqi (BA)" <liuqi115@huawei.com>
Message-ID: <ddb44b9b-cc18-8f49-e82c-b1ae00546962@huawei.com>
Date:   Mon, 2 Aug 2021 20:02:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <2f32fff3-6b58-583f-8e85-06ec1553d3f4@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.38.203]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggema757-chm.china.huawei.com (10.1.198.199)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/8/2 11:52, liuqi (BA) wrote:
[...]

>> This might be the direction to go later. Anyway, "Rome wasn't built
>> in a day", for this stage, we might focus on optprobe for the case
>> of non-randomized module region :-).
>>
>> BTW, @liuqi, if users set "nokaslr" in bootargs, will your optprobe
>> always work and not fall back to normal kprobe even we remove the
>> dependency on RANDOMIZED_MODULE_REGION_FULL?
>>
> Hi Barry,
> 
> I do some tests on Hip08 platform, using nokaslr in booting cmdline and 
> remove dependency on RANDOMIZED_MODULE_REGION_FULL, optprobe seems work.
> Here is the log:
> 
> estuary:/$ uname -a
> Linux (none) 5.13.0-rc4+ #37 SMP PREEMPT Mon Aug 2 08:13:37 CST 2021 
> aarch64 GNU/Linux
> estuary:/$ zcat /proc/config.gz | grep RANDOMIZE_MODULE_REGION
> CONFIG_RANDOMIZE_MODULE_REGION_FULL=y
> estuary:/$ zcat /proc/config.gz | grep OPTPROBE
> CONFIG_OPTPROBES=y
> CONFIG_HAVE_OPTPROBES=y
> estuary:/$ cat /proc/cmdline
> console=ttyAMA0,115200 earlycon=pl011,0x9000000 kpti=off nokaslr
> estuary:/$ cat /sys/bus/platform/devices/hello_driver/kprobe_test
> [   61.304143] do_empty returned 0 and took 200 ns to execute
> [   61.304662] do_empty returned 0 and took 110 ns to execute
> [   61.305196] do_empty returned 0 and took 100 ns to execute
> [   61.305745] do_empty returned 0 and took 90 ns to execute
> [   61.306262] do_empty returned 0 and took 90 ns to execute
> [   61.306781] do_empty returned 0 and took 90 ns to execute
> [   61.307286] do_empty returned 0 and took 90 ns to execute
> [   61.307798] do_empty returned 0 and took 90 ns to execute
> [   61.308314] do_empty returned 0 and took 90 ns to execute
> [   61.308828] do_empty returned 0 and took 90 ns to execute
> [   61.309323] do_empty returned 0 and took 80 ns to execute
> [   61.309832] do_empty returned 0 and took 80 ns to execute
> [   61.310357] do_empty returned 0 and took 80 ns to execute
> [   61.310871] do_empty returned 0 and took 80 ns to execute
> [   61.311361] do_empty returned 0 and took 80 ns to execute
> [   61.311851] do_empty returned 0 and took 90 ns to execute
> [   61.312358] do_empty returned 0 and took 90 ns to execute
> [   61.312879] do_empty returned 0 and took 80 ns to execute
> 
> Thanks,
> Qi
> 
Hi Barry,


I've done test on Hip08 platform using nokaslr in booting cmdline and 
remove dependency on RANDOMIZED_MODULE_REGION_FULL, on following 4 cases:
1. probed code in module, pre_handler in kernel.
2. probed code in kernel, pre_handler in kernel.
3. probed code in module, pre_handler in module.
4. probed code in kernel, pre_handler in module.

and optprobe works in these 4 cases.

Thanks,
Qi
>>>
>>> Thank you,
>>>
>>> -- 
>>> Masami Hiramatsu <mhiramat@kernel.org>
>>
>> Thanks
>> Barry
>> .
>>
> 
> .

