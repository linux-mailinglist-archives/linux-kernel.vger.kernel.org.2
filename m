Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79747368BA8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 05:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237143AbhDWDhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 23:37:41 -0400
Received: from mailgate.ics.forth.gr ([139.91.1.2]:60833 "EHLO
        mailgate.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbhDWDhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 23:37:40 -0400
Received: from av3.ics.forth.gr (av3in.ics.forth.gr [139.91.1.77])
        by mailgate.ics.forth.gr (8.15.2/ICS-FORTH/V10-1.8-GATE) with ESMTP id 13N3b2fG043700
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 06:37:02 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; d=ics.forth.gr; s=av; c=relaxed/simple;
        q=dns/txt; i=@ics.forth.gr; t=1619149017; x=1621741017;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZbUCIK+vNMXLT6bt5IcYDuPKpMJvQ+n7NbeVwMpT5/0=;
        b=FVpPsRSuS/RsEqijSUV8uTTjOLRi503VnPxsanGaP3fHa3d6xVrnBIGtypFoLBEG
        Loln0W7HGDMFvF3XRc9NWA7h/xVH4aPVwl/rmvBiJWuxGQW2Mm9XD6FQ0jG96E8r
        R4v18WILQ/+xA7POlk79HkmgNr3T874pnH8fTX/hnYFwpFQzwWohfCUNLxJAw8mu
        FulijclffSO5lhweAsb4jIAI5vjL4kM1jO8lppJeFfNd9reUs8o04lFLepFVy0u8
        VyH/fRUCK9YkFsin65HChB0AoynmIlZKTsFq9pVEg4DkaPEMRiL7OcqjYWsxek9l
        wjTgkE/jQVIaTTxUw4M6jA==;
X-AuditID: 8b5b014d-a4c337000000209f-81-608240d9df52
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id 1B.8A.08351.9D042806; Fri, 23 Apr 2021 06:36:57 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 23 Apr 2021 06:36:56 +0300
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     mick@ics.forth.gr, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] RISC-V: Add kexec/kdump support
Organization: FORTH
In-Reply-To: <mhng-4f2d27cc-6dc2-4d3d-ae61-5681b15372b7@palmerdabbelt-glaptop>
References: <mhng-4f2d27cc-6dc2-4d3d-ae61-5681b15372b7@palmerdabbelt-glaptop>
Message-ID: <0ce30336b7dfaaf14a20e72e990d70f5@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.3.16
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsXSHT1dWfemQ1OCwYHz/BaXd81hs9j2uYXN
        ovndOXaLl5d7mC3aZvE7sHq8efmSxePhpktMHpuX1Htcar7O7vF5k1wAaxSXTUpqTmZZapG+
        XQJXxr85/1gL9gpV/G2fw97AuIevi5GTQ0LARKJ16kzWLkYuDiGBo4wS29ceY4VImErM3tvJ
        CGLzCghKnJz5hAXEZhawkJh6ZT8jhC0v0bx1NjOIzSKgKvH22RqwXjYBTYn5lw6C1YsIqEsc
        eH2HGWQBs8AkRomWQy/BEsIC1hIf1x4Cs/kFhCU+3b0I1swp4Cdxamc/O4gtJOAr8efSDyaI
        I1wk2k91s0EcpyLx4fcDoBoODlEge/NcpQmMgrOQnDoLyamzkJy6gJF5FaNAYpmxXmZysV5a
        flFJhl560SZGcGgz+u5gvL35rd4hRiYOxkOMEhzMSiK8XkcbE4R4UxIrq1KL8uOLSnNSiw8x
        SnOwKInz8upNiBcSSE8sSc1OTS1ILYLJMnFwSjUwNUVuPHPp9Z6EdgnpHsGESxMY7Z4t/Tll
        8i+tonC/rRfavvbPfxtsYxPH/HTLwxlhErclJk584L9u0xaHF87Wrt+v9F86+Xmh0I2Px9Yn
        yYhsmHnRJ7x9am/x/sNZ/6ZlzcidFP9xfYAK/7aoJZctzojPnvI7Z8Ft3SdHFgu9OZfUdbM8
        QaP98SrOBFvuVUus3ZcxFR9rmSfms63t8cxCh8l3/M4L7Tac86E9oro6rfQts8/GOYqBfdZX
        Kp+umHN29kW2Bw9NFyr17y81yOsWX5h3bcKRZ0zBbKKpLNqHmardXnGlfL89rcza0/bR7sr5
        k59+XbyyOrzvINO9rviTicGeU/LF7j5TZFu5M2e16gclluKMREMt5qLiRADFU4G93AIAAA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Στις 2021-04-23 06:30, Palmer Dabbelt έγραψε:
> On Mon, 05 Apr 2021 01:57:07 PDT (-0700), mick@ics.forth.gr wrote:
>> This patch series adds kexec/kdump and crash kernel
>> support on RISC-V. For testing the patches a patched
>> version of kexec-tools is needed (still a work in
>> progress) which can be found at:
>> 
>> https://riscv.ics.forth.gr/kexec-tools-patched.tar.xz
>> 
>> v3:
>>  * Rebase on newer kernel tree
>>  * Minor cleanups
>>  * Split UAPI changes to a separate patch
>>  * Improve / cleanup init_resources
>>  * Resolve Palmer's comments
>> 
>> v2:
>>  * Rebase on newer kernel tree
>>  * Minor cleanups
>>  * Properly populate the ioresources tre, so that it
>>    can be used later on for implementing strict /dev/mem
>>  * Use linux,usable-memory on /memory instead of a new binding
>>  * USe a reserved-memory node for ELF core header
>> 
>> Nick Kossifidis (5):
>>   RISC-V: Add EM_RISCV to kexec UAPI header
>>   RISC-V: Add kexec support
>>   RISC-V: Improve init_resources
>>   RISC-V: Add kdump support
>>   RISC-V: Add crash kernel support
>> 
>>  arch/riscv/Kconfig                  |  25 ++++
>>  arch/riscv/include/asm/elf.h        |   6 +
>>  arch/riscv/include/asm/kexec.h      |  54 +++++++
>>  arch/riscv/kernel/Makefile          |   6 +
>>  arch/riscv/kernel/crash_dump.c      |  46 ++++++
>>  arch/riscv/kernel/crash_save_regs.S |  56 +++++++
>>  arch/riscv/kernel/kexec_relocate.S  | 222 
>> ++++++++++++++++++++++++++++
>>  arch/riscv/kernel/machine_kexec.c   | 193 ++++++++++++++++++++++++
>>  arch/riscv/kernel/setup.c           | 113 ++++++++------
>>  arch/riscv/mm/init.c                | 110 ++++++++++++++
>>  include/uapi/linux/kexec.h          |   1 +
>>  11 files changed, 787 insertions(+), 45 deletions(-)
>>  create mode 100644 arch/riscv/include/asm/kexec.h
>>  create mode 100644 arch/riscv/kernel/crash_dump.c
>>  create mode 100644 arch/riscv/kernel/crash_save_regs.S
>>  create mode 100644 arch/riscv/kernel/kexec_relocate.S
>>  create mode 100644 arch/riscv/kernel/machine_kexec.c
> 
> Thanks.  There were some minor issues and some merge conflicts, I put
> this on for-next with some fixups.

I've sent a v4 that shouldn't have merge conflicts, addressing some 
comments from Alex as well, could you use that instead or is it too late 
?
