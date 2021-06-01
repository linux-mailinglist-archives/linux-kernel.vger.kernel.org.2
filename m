Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD1C39742F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 15:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233964AbhFANbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 09:31:13 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2932 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233768AbhFANbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 09:31:09 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FvXxK1bj2z68fC;
        Tue,  1 Jun 2021 21:26:29 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 21:29:26 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 21:29:25 +0800
Subject: Re: [PATCH 0/2] ARM: fix PXN process with LPAE feature
To:     Russell King <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jungseung Lee <js07.lee@gmail.com>
References: <20210529034138.83384-1-wangkefeng.wang@huawei.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <09d3b1ac-01ab-ba8b-014a-8db8c58bfc45@huawei.com>
Date:   Tue, 1 Jun 2021 21:29:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210529034138.83384-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/5/29 11:41, Kefeng Wang wrote:
> refactor and cleanup [__do|do]_page_fault, then fix the pxn process
> when lpae feature enabled.

Additional information:

when user code execution with privilege mode, it will lead infinite loop

in the page fault handler if ARM_LPAE enabled,  the issue could be

reproduced with  "echo EXEC_USERSPACE > 
/sys/kernel/debug/provoke-crash/DIRECT"

also I could add a die_kernel_fault() (like arm64 does) to report different

message in different scenes.

Any comments, thanks.


>
> Kefeng Wang (2):
>    ARM: mm: Refactor __do_page_fault()
>    ARM: mm: Fix PXN process when ARM_LPAE enabled
>
>   arch/arm/mm/fault.c | 78 +++++++++++++++++----------------------------
>   1 file changed, 30 insertions(+), 48 deletions(-)
>
