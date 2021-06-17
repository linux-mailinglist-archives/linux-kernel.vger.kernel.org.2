Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEB63AAFE9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 11:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbhFQJko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 05:40:44 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:7465 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbhFQJkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 05:40:43 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G5H3S3CQ5zZhbh;
        Thu, 17 Jun 2021 17:35:32 +0800 (CST)
Received: from dggpemm000001.china.huawei.com (7.185.36.245) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 17:38:28 +0800
Received: from [10.174.177.125] (10.174.177.125) by
 dggpemm000001.china.huawei.com (7.185.36.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 17:38:28 +0800
Subject: Re: [PATCH -next] riscv: mm: remove redundant trampoline PGD for
 64bit
To:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <anup.patel@wdc.com>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <palmerdabbelt@google.com>, <atish.patra@wdc.com>,
        <wangkefeng.wang@huawei.com>
References: <20210527144819.12101-1-sunnanyong@huawei.com>
From:   "Sunnanyong (Nanyong Sun, Intelligent Computing Solution Development
        Dep)" <sunnanyong@huawei.com>
Message-ID: <a58c4cde-6212-29f3-080a-f4e50221db21@huawei.com>
Date:   Thu, 17 Jun 2021 17:38:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210527144819.12101-1-sunnanyong@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.125]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm000001.china.huawei.com (7.185.36.245)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/5/27 22:48, Nanyong Sun wrote:

> Remove redundant trampoline PGD for 64bit and add more comment
> for why 32bit systems need trampoline PGD.
>
> There was a patch and discussion similar to this,refer to
> the link [1][2].
>
> The trampoline PGD is redundant for 64bit systems because:
> 1. The early PGD covers the entire kernel mapping. Directly
> loading early PGD can achieve the result in boot stage.
> A more trampoline PGD makes code hard to understand.
> 2. Directly loading early PGD is safe in 64bit systems since
> the kernel virtual address starts as 0xFFFFxxxxxxxxxxxx,
> which has a very big gap with RAM address.It won't fall into
> the corner case that 32bit system worrys.
> 3. Remove redundant trampoline PGD can benefit to code maintaince,
> because 64bit systems have more page table levels.For example:
> If we want to support SV48 which has 4 page table levels, we have
> to add a trampoline_pud and insert it before trampoline_pmd.
>
> Reference link:
> [1]https://lore.kernel.org/linux-riscv/20190325092234.5451-4-anup.patel@wdc.com/
> [2]https://lkml.org/lkml/2019/3/28/147

Long time no response.

Hi anup,

     do you agree this?

