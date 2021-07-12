Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1B2D3C40C8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 03:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhGLBIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 21:08:43 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:10350 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbhGLBIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 21:08:42 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GNQSl6vt7z78MB;
        Mon, 12 Jul 2021 09:01:27 +0800 (CST)
Received: from dggpeml500016.china.huawei.com (7.185.36.70) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 12 Jul 2021 09:05:47 +0800
Received: from [10.174.148.223] (10.174.148.223) by
 dggpeml500016.china.huawei.com (7.185.36.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 12 Jul 2021 09:05:46 +0800
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
To:     Steven Sistare <steven.sistare@oracle.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     "Gonglei (Arei)" <arei.gonglei@huawei.com>, <willy@infradead.org>
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
 <cc714571-4461-c9e0-7b24-e213664caa54@huawei.com>
 <43471cbb-67c6-f189-ef12-0f8302e81b06@oracle.com>
From:   "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>
Message-ID: <a1dbf12e-9949-109e-122c-ba7ba609801b@huawei.com>
Date:   Mon, 12 Jul 2021 09:05:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <43471cbb-67c6-f189-ef12-0f8302e81b06@oracle.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.148.223]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500016.china.huawei.com (7.185.36.70)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

在 2021/7/8 20:48, Steven Sistare 写道:
> On 7/8/2021 5:52 AM, Longpeng (Mike, Cloud Infrastructure Service Product Dept.) wrote:
>> Hi Anthony and Steven,
>>
>> 在 2020/7/28 1:11, Anthony Yznaga 写道:
>>> This patchset adds support for preserving an anonymous memory range across
>>> exec(3) using a new madvise MADV_DOEXEC argument.  The primary benefit for
>>> sharing memory in this manner, as opposed to re-attaching to a named shared
>>> memory segment, is to ensure it is mapped at the same virtual address in
>>> the new process as it was in the old one.  An intended use for this is to
>>> preserve guest memory for guests using vfio while qemu exec's an updated
>>> version of itself.  By ensuring the memory is preserved at a fixed address,
>>> vfio mappings and their associated kernel data structures can remain valid.
>>> In addition, for the qemu use case, qemu instances that back guest RAM with
>>> anonymous memory can be updated.
>>
>> We have a requirement like yours, but ours seems more complex. We want to
>> isolate some memory regions from the VM's memory space and the start a child
>> process who will using these memory regions.
>>
>> I've wrote a draft to support this feature, but I just find that my draft is
>> pretty like yours.
>>
>> It seems that you've already abandoned this patchset, why ?
> 
> Hi Longpeng,
>   The reviewers did not like the proposal for several reasons, but the showstopper
> was that they did not want to add complexity to the exec path in the kernel.  You
> can read the email archive for details.
> 
I've read the archive and did some study these days, maybe this soluation is
more sutiable for my use case.

Let me describe my use case more clearly (just ignore if you're not interested
in it):

1. Prog A mmap() 4GB memory (anon or file-mapping), suppose the allocated VA
range is [0x40000000,0x140000000)

2. Prog A specifies [0x48000000,0x50000000) and [0x80000000,0x100000000) will be
shared by its child.

3. Prog A fork() Prog B and then Prog B exec() a new ELF binary.

4. Prog B notice the shared ranges (e.g. by input parameters or ...) and remap
them to a continuous VA range.

Do you have any suggestions ?

> We solved part of our problem by adding new vfio interfaces: VFIO_DMA_UNMAP_FLAG_VADDR
> and VFIO_DMA_MAP_FLAG_VADDR.  That solves the vfio problem for shared memory, but not
> for mmap MAP_ANON memory.
> 
> - Steve
> 
>>> Patches 1 and 2 ensure that loading of ELF load segments does not silently
>>> clobber existing VMAS, and remove assumptions that the stack is the only
>>> VMA in the mm when the stack is set up.  Patch 1 re-introduces the use of
>>> MAP_FIXED_NOREPLACE to load ELF binaries that addresses the previous issues
>>> and could be considered on its own.
>>>
>>> Patches 3, 4, and 5 introduce the feature and an opt-in method for its use
>>> using an ELF note.
>>>
>>> Anthony Yznaga (5):
>>>   elf: reintroduce using MAP_FIXED_NOREPLACE for elf executable mappings
>>>   mm: do not assume only the stack vma exists in setup_arg_pages()
>>>   mm: introduce VM_EXEC_KEEP
>>>   exec, elf: require opt-in for accepting preserved mem
>>>   mm: introduce MADV_DOEXEC
>>>
>>>  arch/x86/Kconfig                       |   1 +
>>>  fs/binfmt_elf.c                        | 196 +++++++++++++++++++++++++--------
>>>  fs/exec.c                              |  33 +++++-
>>>  include/linux/binfmts.h                |   7 +-
>>>  include/linux/mm.h                     |   5 +
>>>  include/uapi/asm-generic/mman-common.h |   3 +
>>>  kernel/fork.c                          |   2 +-
>>>  mm/madvise.c                           |  25 +++++
>>>  mm/mmap.c                              |  47 ++++++++
>>>  9 files changed, 266 insertions(+), 53 deletions(-)
>>>
>>
> .
> 
