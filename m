Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38CFA429B1A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 03:41:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbhJLBnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 21:43:40 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:14330 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhJLBni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 21:43:38 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HSyv35HmPz907V;
        Tue, 12 Oct 2021 09:36:47 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 12 Oct 2021 09:41:24 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Tue, 12 Oct 2021 09:41:23 +0800
Message-ID: <22320379-1905-d678-bfd7-2e5e118fa578@huawei.com>
Date:   Tue, 12 Oct 2021 09:41:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH v3 0/6] ARM: mm: cleanup page fault and fix pxn process
 issue
Content-Language: en-US
To:     Russell King <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jungseung Lee <js07.lee@gmail.com>,
        Will Deacon <will@kernel.org>
References: <20210610123556.171328-1-wangkefeng.wang@huawei.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20210610123556.171328-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggeme707-chm.china.huawei.com (10.1.199.103) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/6/10 20:35, Kefeng Wang wrote:
> The patchset cleanup ARM page fault handle to improve readability,
> fix the page table entries printing and fix infinite loop in the
> page fault handler when user code execution with privilege mode if
> ARM_LPAE enabled.

Hi Russell, I send the v3(most patches were reviewed by you in v2[1]) to
ARM patch system due to no more comments, and this patchset is suspended
too long without any changes, looking forward to your reply and hope it
could be merged, many thanks.

[1] 
https://lore.kernel.org/linux-arm-kernel/20210602070246.83990-1-wangkefeng.wang@huawei.com/
