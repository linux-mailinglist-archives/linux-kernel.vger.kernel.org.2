Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 599ED368BBE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 05:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240341AbhDWDyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 23:54:24 -0400
Received: from mailgate.ics.forth.gr ([139.91.1.2]:25220 "EHLO
        mailgate.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbhDWDyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 23:54:23 -0400
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
        by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 13N3rkPW043861
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 06:53:46 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
        q=dns/txt; i=@ics.forth.gr; t=1619150021; x=1621742021;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6JC6V3yB3c17P/ozmgZ9a/Qnmb/kmR5GANxG8psx14o=;
        b=VSTJkNpQANQuiJxvooVcX6x/cLTK+ymcbf49Lii8BdzNNn5oJaqhlt7CyKIBmAZn
        83PjQD8yGw9tQJRhrJnMuoQyC6rvq0xTl3x36NELQwhm7HWbR7Vy/K1TN5iNtKf6
        8OhG5W6leEGVJnlxPtJ7BL62NyQd+GmtosFAJsYeBA09UfIXKm4E4IIXkxXxVxQW
        sJAhrMYthh2NghVWApDQe6flM3YLCnM60+4PsgHBGSn744qe85ZE4ACV05ud5fns
        kCM1ZmriUmYLYg9W/sPmYESJMg9QdxzrIa7Igbdins3IvJFFonLbFeOQwaClAQc1
        SPDF1NToX8UNuCf7TAKDIg==;
X-AuditID: 8b5b014d-a70347000000209f-f6-608244c4ff26
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id F1.9A.08351.4C442806; Fri, 23 Apr 2021 06:53:41 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 23 Apr 2021 06:53:40 +0300
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     mick@ics.forth.gr, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] RISC-V: Add kexec/kdump support
Organization: FORTH
In-Reply-To: <mhng-c073ca02-d152-4ef5-86c5-4bcf58154afc@palmerdabbelt-glaptop>
References: <mhng-c073ca02-d152-4ef5-86c5-4bcf58154afc@palmerdabbelt-glaptop>
Message-ID: <d3e45b902a28ec95c25cfa1f34d07d0d@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.3.16
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsXSHT1dWfeoS1OCwaljTBaXd81hs9j2uYXN
        ovndOXaLl5d7mC3aZvE7sHq8efmSxePhpktMHpuX1Htcar7O7vF5k1wAaxSXTUpqTmZZapG+
        XQJXxsHmiewFPyUqts5rZmpgfCvcxcjJISFgIrHt6X7WLkYuDiGBo4wS77u3M0IkTCVm7+0E
        s3kFBCVOznzCAmIzC1hITL2ynxHClpdo3jqbGcRmEVCVmL/rNFgNm4CmxPxLB8FsEQF1iQOv
        7zCDLGAWmMQo0XLoJVhCWMBa4uPaQ2A2v4CwxKe7F1lBbE4BP4lr3TPAbCEBX4mFH5+zQBzh
        ItHyeA8LxHEqEh9+P2DvYuTgEAWyN89VmsAoOAvJqbOQnDoLyakLGJlXMQoklhnrZSYX66Xl
        F5Vk6KUXbWIEhzaj7w7G25vf6h1iZOJgPMQowcGsJMLrdbQxQYg3JbGyKrUoP76oNCe1+BCj
        NAeLkjgvr96EeCGB9MSS1OzU1ILUIpgsEwenVANT6+7tE44d3faM55mRsKXksYzE5x9D9c0E
        rpl2/1rzU+k348ZX2UejGf7Vfudq/vhHPOtSdE3NqZkF9x8K715vz5KUetKqd29bnp5itNXK
        z4vljfxsY3s2n9ANylvvvJLBbp+3C2eDhVz12rdXNf4cs9CbVfTF9ehFiYYj3Vkb9ssx9reE
        Km66Prm/teYDb9P3OFXHyfmTLHZ+zT7uwPxt9bS7B8yP9BsyRSx//z7O/0LfpcDjIg1bZ55g
        j9rcI374dNMc6ccq7P8nvrnw3mzfKwXdC77iJSEi0gnuX2+rCiz9xHA8ssuAU3Ld7sTa1t8z
        9iqdKIwL49hw89Gs/IJF2VHJMxNuGnYrnVm4O7BQiaU4I9FQi7moOBEAGqNUStwCAAA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Στις 2021-04-23 06:48, Palmer Dabbelt έγραψε:
> On Thu, 22 Apr 2021 20:36:56 PDT (-0700), mick@ics.forth.gr wrote:
>> Στις 2021-04-23 06:30, Palmer Dabbelt έγραψε:
>>> On Mon, 05 Apr 2021 01:57:07 PDT (-0700), mick@ics.forth.gr wrote:
>>>> This patch series adds kexec/kdump and crash kernel
>>>> support on RISC-V. For testing the patches a patched
>>>> version of kexec-tools is needed (still a work in
>>>> progress) which can be found at:
>>>> 
>>>> https://riscv.ics.forth.gr/kexec-tools-patched.tar.xz
>>>> 
>>>> v3:
>>>>  * Rebase on newer kernel tree
>>>>  * Minor cleanups
>>>>  * Split UAPI changes to a separate patch
>>>>  * Improve / cleanup init_resources
>>>>  * Resolve Palmer's comments
>>>> 
>>>> v2:
>>>>  * Rebase on newer kernel tree
>>>>  * Minor cleanups
>>>>  * Properly populate the ioresources tre, so that it
>>>>    can be used later on for implementing strict /dev/mem
>>>>  * Use linux,usable-memory on /memory instead of a new binding
>>>>  * USe a reserved-memory node for ELF core header
>>>> 
>>>> Nick Kossifidis (5):
>>>>   RISC-V: Add EM_RISCV to kexec UAPI header
>>>>   RISC-V: Add kexec support
>>>>   RISC-V: Improve init_resources
>>>>   RISC-V: Add kdump support
>>>>   RISC-V: Add crash kernel support
>>>> 
>>>>  arch/riscv/Kconfig                  |  25 ++++
>>>>  arch/riscv/include/asm/elf.h        |   6 +
>>>>  arch/riscv/include/asm/kexec.h      |  54 +++++++
>>>>  arch/riscv/kernel/Makefile          |   6 +
>>>>  arch/riscv/kernel/crash_dump.c      |  46 ++++++
>>>>  arch/riscv/kernel/crash_save_regs.S |  56 +++++++
>>>>  arch/riscv/kernel/kexec_relocate.S  | 222
>>>> ++++++++++++++++++++++++++++
>>>>  arch/riscv/kernel/machine_kexec.c   | 193 ++++++++++++++++++++++++
>>>>  arch/riscv/kernel/setup.c           | 113 ++++++++------
>>>>  arch/riscv/mm/init.c                | 110 ++++++++++++++
>>>>  include/uapi/linux/kexec.h          |   1 +
>>>>  11 files changed, 787 insertions(+), 45 deletions(-)
>>>>  create mode 100644 arch/riscv/include/asm/kexec.h
>>>>  create mode 100644 arch/riscv/kernel/crash_dump.c
>>>>  create mode 100644 arch/riscv/kernel/crash_save_regs.S
>>>>  create mode 100644 arch/riscv/kernel/kexec_relocate.S
>>>>  create mode 100644 arch/riscv/kernel/machine_kexec.c
>>> 
>>> Thanks.  There were some minor issues and some merge conflicts, I put
>>> this on for-next with some fixups.
>> 
>> I've sent a v4 that shouldn't have merge conflicts, addressing some
>> comments from Alex as well, could you use that instead or is it too 
>> late
>> ?
> 
> Thanks, for some reason I didn't see it when poking around.  There was
> still that one init_resources() merge conflict and I fixed up some of
> the commit texts, it's now on for-next as
> 
> b94394119804 (HEAD -> for-next, riscv/for-next) RISC-V: Add crash 
> kernel support
> 6e8451782c90 RISC-V: Add kdump support
> 0a0652429bdb RISC-V: Improve init_resources()
> d9a8897d6b5d RISC-V: Add kexec support
> f59938095b94 RISC-V: Add EM_RISCV to kexec UAPI header

Thanks a lot ! I'll keep on working on the user-space part and submit it 
on kexec-tools later on.
