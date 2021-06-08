Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A050239EB90
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 03:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbhFHBly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 21:41:54 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3460 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbhFHBlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 21:41:53 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FzXsP2Fgkz6wv9;
        Tue,  8 Jun 2021 09:36:57 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 09:39:55 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 09:39:54 +0800
Subject: Re: [PATCH v2 15/15] x86: convert to setup_initial_init_mm()
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, <x86@kernel.org>
References: <20210604070633.32363-1-wangkefeng.wang@huawei.com>
 <20210604070633.32363-16-wangkefeng.wang@huawei.com>
 <20210607172608.fda6ee76f9b195428ddb1d0d@linux-foundation.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <6dca29c0-bcb0-9af3-4d49-68b2b1c924e5@huawei.com>
Date:   Tue, 8 Jun 2021 09:39:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210607172608.fda6ee76f9b195428ddb1d0d@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/6/8 8:26, Andrew Morton wrote:
> On Fri, 4 Jun 2021 15:06:33 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
>> Use setup_initial_init_mm() helper to simplify code.
>>
>> ...
>>
>> --- a/arch/x86/kernel/setup.c
>> +++ b/arch/x86/kernel/setup.c
>> @@ -868,10 +868,7 @@ void __init setup_arch(char **cmdline_p)
>>   
>>   	if (!boot_params.hdr.root_flags)
>>   		root_mountflags &= ~MS_RDONLY;
>> -	init_mm.start_code = (unsigned long) _text;
>> -	init_mm.end_code = (unsigned long) _etext;
>> -	init_mm.end_data = (unsigned long) _edata;
>> -	init_mm.brk = _brk_end;
>> +	setup_initial_init_mm(_text, _etext, _edata, _brk_end);
>>   
>>   	code_resource.start = __pa_symbol(_text);
>>   	code_resource.end = __pa_symbol(_etext)-1;
> arch/x86/kernel/setup.c:873:47: warning: passing argument 4 of 'setup_initial_init_mm' makes pointer from integer without a cast [-Wint-conversion]
>    873 |  setup_initial_init_mm(_text, _etext, _edata, _brk_end);
>        |                                               ^~~~~~~~
>        |                                               |
>        |                                               long unsigned int
> In file included from ./include/linux/pid_namespace.h:7,
>                   from ./include/linux/ptrace.h:10,
>                   from ./include/linux/elfcore.h:11,
>                   from ./include/linux/crash_core.h:6,
>                   from ./include/linux/kexec.h:18,
>                   from ./include/linux/crash_dump.h:5,
>                   from arch/x86/kernel/setup.c:9:
> ./include/linux/mm.h:248:29: note: expected 'void *' but argument is of type 'long unsigned int'
>    248 |       void *end_data, void *brk);
>        |                       ~~~~~~^~~
>
>
> afaict the other architectures will warn this way, not sure.

I check all archs again, the x86/m68k/powerpc/h8300 has use some value 
which is not pointer ,

other are changed, but forget this one.  I do compile, but I don't know 
why I missed it, sorry about

this.


>
> Please check all that, refresh ,retest and resend?
> .
>
