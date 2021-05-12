Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 842CD37B467
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 05:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhELDOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 23:14:40 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:2449 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhELDOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 23:14:38 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Fg0D93P73zCrTC;
        Wed, 12 May 2021 11:10:49 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Wed, 12 May 2021 11:13:29 +0800
Subject: Re: [PATCH v4 0/4] arm64: drop pfn_valid_within() and simplify
 pfn_valid()
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David Hildenbrand" <david@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>, <kvmarm@lists.cs.columbia.edu>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20210511100550.28178-1-rppt@kernel.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
Message-ID: <b4b384c1-0d45-bb7f-3bd4-56cdb15ff2f8@huawei.com>
Date:   Wed, 12 May 2021 11:13:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210511100550.28178-1-rppt@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/5/11 18:05, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Hi,
> 
> These patches aim to remove CONFIG_HOLES_IN_ZONE and essentially hardwire
> pfn_valid_within() to 1.
> 
> The idea is to mark NOMAP pages as reserved in the memory map and restore
> the intended semantics of pfn_valid() to designate availability of struct
> page for a pfn.
> 
> With this the core mm will be able to cope with the fact that it cannot use
> NOMAP pages and the holes created by NOMAP ranges within MAX_ORDER blocks
> will be treated correctly even without the need for pfn_valid_within.
> 
> The patches are boot tested on qemu-system-aarch64.
> 
> I beleive it would be best to route these via mmotm tree.

Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
