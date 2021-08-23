Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3865B3F4346
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 04:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234767AbhHWCDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 22:03:50 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:14408 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234740AbhHWCDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 22:03:49 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GtFm45q3KzbdNk;
        Mon, 23 Aug 2021 09:59:16 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 23 Aug 2021 10:02:41 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 23 Aug 2021 10:02:40 +0800
Subject: Re: [PATCH -next v2 0/3] riscv: Fix two vdso issue
To:     Tong Tiangen <tongtiangen@huawei.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Palmer Dabbelt" <palmerdabbelt@google.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20210820125042.1844629-1-tongtiangen@huawei.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <0fa49162-18c2-0643-7495-86f2c891a285@huawei.com>
Date:   Mon, 23 Aug 2021 10:02:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210820125042.1844629-1-tongtiangen@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/8/20 20:50, Tong Tiangen wrote:
> v2->v1:
>   Add patch "Refactor asm/vdso.h" to avoid vdso.lds syntax error if
>   CONFIG_GENERIC_TIME_VSYSCALL=n.

This is better than v1.

>
> 1) Refactor the asm/vdso.h to avoid vdso.lds syntax error.
>
> 2) Move vdso data page up front
Move  vdso data page before code page could save the problem which the 
.text

section could be bigger than PAGE_SIZE.

> and introduce enum vvar_pages, To pave the
> way for the subsequent support of TIME_NS, the support of TIME_NS will be
> issued in the later patch.
This makes it easier to introduce new features TIME_NS.

>
> 3) In arch_setup_additional_pages(), make Wait for the lock in the
> killable mode and return with EINTR if the task got killed while waiting.
For series,

Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Tong Tiangen (3):
>    riscv/vdso: Refactor asm/vdso.h
>    riscv/vdso: Move vdso data page up front
>    riscv/vdso: make arch_setup_additional_pages wait for mmap_sem for
>      write killable
>
>   arch/riscv/include/asm/syscall.h  |  1 +
>   arch/riscv/include/asm/vdso.h     | 10 ++----
>   arch/riscv/kernel/syscall_table.c |  1 -
>   arch/riscv/kernel/vdso.c          | 53 +++++++++++++++++++------------
>   arch/riscv/kernel/vdso/vdso.lds.S |  3 +-
>   5 files changed, 39 insertions(+), 29 deletions(-)
>
