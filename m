Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4F741A58C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 04:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238702AbhI1Ccb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 22:32:31 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:13342 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238655AbhI1Cca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 22:32:30 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HJNfY4R8jz8ywv;
        Tue, 28 Sep 2021 10:26:13 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 28 Sep 2021 10:30:41 +0800
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 28 Sep 2021 10:30:40 +0800
Subject: Re: [PATCH -next v3 0/3] riscv: Fix two vdso issue
To:     Liu Shixin <liushixin2@huawei.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, <abdulras@google.com>
References: <20210901024621.2528797-1-tongtiangen@huawei.com>
 <935c5e32-8df2-670d-da33-869e6dce4917@huawei.com>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
From:   tongtiangen <tongtiangen@huawei.com>
Message-ID: <380ef41e-bba7-1f7b-5e0c-08690cef13eb@huawei.com>
Date:   Tue, 28 Sep 2021 10:30:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <935c5e32-8df2-670d-da33-869e6dce4917@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.234]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kindly ping.

On 2021/9/28 10:19, Liu Shixin wrote:
> On 2021/9/1 10:46, Tong Tiangen wrote:
>> v3->v2:
>>   Adapt to the latest code.
>>
>> v2->v1:
>>   Add patch "Refactor asm/vdso.h" to avoid vdso.lds syntax error if
>>   CONFIG_GENERIC_TIME_VSYSCALL=n.
>>
>> 1) Move vdso data page up front and introduce enum vvar_pages, This makes it
>> easier to introduce new feature TIME_NS.
>>
>> 2) In arch_setup_additional_pages(), make Wait for the lock in the killable mode
>> and return with EINTR if the task got killed while waiting.
>>
>> Tong Tiangen (3):
>>   riscv/vdso: Refactor asm/vdso.h
>>   riscv/vdso: Move vdso data page up front
>>   riscv/vdso: make arch_setup_additional_pages wait for mmap_sem for
>>     write killable
>>
>>  arch/riscv/include/asm/syscall.h  |  1 +
>>  arch/riscv/include/asm/vdso.h     | 15 ++++-----
>>  arch/riscv/kernel/syscall_table.c |  1 -
>>  arch/riscv/kernel/vdso.c          | 53 +++++++++++++++++++------------
>>  arch/riscv/kernel/vdso/vdso.lds.S |  3 +-
>>  5 files changed, 42 insertions(+), 31 deletions(-)
>>
>
> Test-by: Liu Shixin <liushixin2@huawei.com>
> .
>
