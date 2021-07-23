Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3173D315A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 03:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbhGWA4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 20:56:16 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:15049 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbhGWA4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 20:56:15 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GWBfX0L1GzZqYQ;
        Fri, 23 Jul 2021 09:33:24 +0800 (CST)
Received: from dggpemm000001.china.huawei.com (7.185.36.245) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 23 Jul 2021 09:36:48 +0800
Received: from [10.174.177.250] (10.174.177.250) by
 dggpemm000001.china.huawei.com (7.185.36.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 23 Jul 2021 09:36:47 +0800
Subject: Re: [PATCH -next v2] riscv: add VMAP_STACK overflow detection
To:     Jisheng Zhang <jszhang3@mail.ustc.edu.cn>,
        Andreas Schwab <schwab@linux-m68k.org>
References: <87bl6yrcmd.fsf@igel.home>
 <mhng-e14c3232-cc4d-4146-8c93-c60ec81ed272@palmerdabbelt-glaptop>
 <CAOnJCU+Ss0cO1mqr=GDVnpxV075uR+KipSnr7dN93099dAH+vQ@mail.gmail.com>
 <20210722213724.1f12a0e7@xhacker> <87zguexslf.fsf@igel.home>
 <20210723075432.098634a2@xhacker>
CC:     Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
From:   tongtiangen <tongtiangen@huawei.com>
Message-ID: <52e3626a-2b40-bda6-de0e-68ea12a86dd9@huawei.com>
Date:   Fri, 23 Jul 2021 09:36:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20210723075432.098634a2@xhacker>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.250]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm000001.china.huawei.com (7.185.36.245)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/7/23 7:54, Jisheng Zhang wrote:
> On Thu, 22 Jul 2021 17:42:52 +0200
> Andreas Schwab <schwab@linux-m68k.org> wrote:
>
>> On Jul 22 2021, Jisheng Zhang wrote:
>>
>>> I think we need to pin the stack before calling get_wchan(), could you please
>>> try below patch?
>>
>> Thanks, this fixes the crash for me.
>>
>> Andreas.
>>
>
> Thanks for testing. I will send out formal patch later
>
> Thanks
>
> .
>

Hi all:
I tried to reproduced this crash in openSUSE code repo（ 
https://github.com/opensuse/kernel ）, but not reproduced successfully.

 From the patch of problem repair, the crash is due to task->stack is 
released before calling get_wchan, the task state of maybe TASK_DEAD.

VMAP_STACK is used to detect kernel stack overflow, there is no 
connection between the two, it makes me a little confused.
