Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F414442633
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 04:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhKBDyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 23:54:55 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:26145 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbhKBDyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 23:54:54 -0400
Received: from dggeme706-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HjwsD3t9Hz1DJ4d;
        Tue,  2 Nov 2021 11:50:08 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 dggeme706-chm.china.huawei.com (10.1.199.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.15; Tue, 2 Nov 2021 11:52:11 +0800
Subject: Re: [PATCH 2/3] RISC-V: use memcpy for kexec_file mode
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nick Kossifidis <mick@ics.forth.gr>, <jszhang@kernel.org>,
        <guoren@linux.alibaba.com>, Pekka Enberg <penberg@kernel.org>,
        <sunnanyong@huawei.com>, <wangkefeng.wang@huawei.com>,
        <changbin.du@intel.com>, Alex Ghiti <alex@ghiti.fr>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>
References: <20211030031832.165457-1-liaochang1@huawei.com>
 <20211030031832.165457-3-liaochang1@huawei.com> <87ee83goju.fsf@disp2133>
 <CAJ+HfNjaBQrBtOuMvTccbb2K-Ua=T1eZk0+70hp0_aOAc83A-Q@mail.gmail.com>
 <87a6inbmrl.fsf@disp2133>
From:   "liaochang (A)" <liaochang1@huawei.com>
Message-ID: <fb0d251a-8c94-0710-757a-7cd9bbdb008c@huawei.com>
Date:   Tue, 2 Nov 2021 11:52:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <87a6inbmrl.fsf@disp2133>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.108]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme706-chm.china.huawei.com (10.1.199.102)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2021/11/2 5:15, Eric W. Biederman 写道:
> Björn Töpel <bjorn.topel@gmail.com> writes:
> 
>> On Sat, 30 Oct 2021 at 05:51, Eric W. Biederman <ebiederm@xmission.com> wrote:
>>>
>>> Liao Chang <liaochang1@huawei.com> writes:
>>>
>>>> The pointer to buffer loading kernel binaries is in kernel space for
>>>> kexec_fil mode, When copy_from_user copies data from pointer to a block
>>>> of memory, it checkes that the pointer is in the user space range, on
>>>> RISCV-V that is:
>>>>
>>>> static inline bool __access_ok(unsigned long addr, unsigned long size)
>>>> {
>>>>       return size <= TASK_SIZE && addr <= TASK_SIZE - size;
>>>> }
>>>>
>>>> and TASK_SIZE is 0x4000000000 for 64-bits, which now causes
>>>> copy_from_user to reject the access of the field 'buf' of struct
>>>> kexec_segment that is in range [CONFIG_PAGE_OFFSET - VMALLOC_SIZE,
>>>> CONFIG_PAGE_OFFSET), is invalid user space pointer.
>>>>
>>>> This patch fixes this issue by skipping access_ok(), use mempcy() instead.
>>>
>>> I am a bit confused.
>>>
>>> Why is machine_kexec ever calling copy_from_user?  That seems wrong in
>>> all cases.
>>>
>>
>> It's not machine_kexec -- it's machine_kexec_prepare, which pulls out
>> the FDT from the image. It looks like MIPS does it similarly.
>>
>> (Caveat: I might be confused as well! ;-))
> 
> True it is machine_kexec_prepare.  But still.  copy_from_user does not
> belong in there.  It is not passed a userspace pointer.
> 
> This looks more like a case for kmap to read a table from the firmware.

Thanks for all your comments.

As I know, these buffer pointed by kexec_segment object here are allocated in
userspace and passed into kernel via sys_kexec_load syscall, that is why it
uses copy_from_user to read data from these memory, perhaps Nick Kossifids
could explain it further.

Do you mean it makes sense to remap the pointer to kernel space using API like
virt_to_page and kamp,then read data via memcpy, so that no matter which address
space the original pointer belongs to,the abstraction will smell better.

> 
> Even if it someone made sense it definitely does not make sense to
> make it a conditional copy_from_user.  That way lies madness.
> 
> The entire change is a smell that there is some abstraction that is
> going wrong, and that abstraction needs to get fixed.
> 
> Eric
> 
> .
> 

-- 
BR,
Liao, Chang
