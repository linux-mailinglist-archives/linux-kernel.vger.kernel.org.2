Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E833F12BF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 07:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbhHSFZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 01:25:05 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:17044 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbhHSFZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 01:25:04 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GqtQJ23H0zbfHJ;
        Thu, 19 Aug 2021 13:20:40 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 19 Aug 2021 13:24:25 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 19 Aug 2021 13:24:24 +0800
Subject: Re: [PATCH -next 0/2] riscv: Fix two vdso issue
To:     Tong Tiangen <tongtiangen@huawei.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Palmer Dabbelt" <palmerdabbelt@google.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20210819030650.716478-1-tongtiangen@huawei.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <7b9520dd-1c61-4a5f-7239-b42f5f37cb54@huawei.com>
Date:   Thu, 19 Aug 2021 13:24:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210819030650.716478-1-tongtiangen@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/19 11:06, Tong Tiangen wrote:
> 1) Move vdso data page up front and introduce enum vvar_pages, To pave the way
> for the subsequent support of TIME_NS, the support of TIME_NS will be issued
> in the later patch.
>
> 2) In arch_setup_additional_pages(), make Wait for the lock in the killable mode
> and return with EINTR if the task got killed while waiting.

For series,

Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>

>
> Tong Tiangen (2):
>    riscv/vdso: Move vdso data page up front
>    riscv/vdso: make arch_setup_additional_pages wait for mmap_sem for
>      write killable
>
>   arch/riscv/include/asm/syscall.h  |  2 ++
>   arch/riscv/include/asm/vdso.h     |  4 +--
>   arch/riscv/kernel/vdso.c          | 51 ++++++++++++++++++-------------
>   arch/riscv/kernel/vdso/vdso.lds.S |  3 +-
>   4 files changed, 36 insertions(+), 24 deletions(-)
>
