Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF21377D12
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 09:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbhEJHZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 03:25:40 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2670 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbhEJHZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 03:25:39 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fdstq2Ltbz1BKlc;
        Mon, 10 May 2021 15:21:55 +0800 (CST)
Received: from [10.174.179.24] (10.174.179.24) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Mon, 10 May 2021 15:24:30 +0800
Subject: Re: [PATCH -next v3 1/2] mm/debug_vm_pgtable: Move
 {pmd/pud}_huge_tests out of CONFIG_TRANSPARENT_HUGEPAGE
To:     Andrew Morton <akpm@linux-foundation.org>
References: <20210419071820.750217-1-liushixin2@huawei.com>
 <20210509212654.e215ff71042b62704965ae01@linux-foundation.org>
CC:     Anshuman Khandual <anshuman.khandual@arm.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <64dd2a02-e175-e414-9a1b-1de38fdf9547@huawei.com>
Date:   Mon, 10 May 2021 15:24:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20210509212654.e215ff71042b62704965ae01@linux-foundation.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/5/10 12:26, Andrew Morton wrote:
> On Mon, 19 Apr 2021 15:18:19 +0800 Liu Shixin <liushixin2@huawei.com> wrote:
>
>> The functions {pmd/pud}_set_huge and {pmd/pud}_clear_huge are not dependent
>> on THP. Hence move {pmd/pud}_huge_tests out of CONFIG_TRANSPARENT_HUGEPAGE.
> What is the actual effect of this?  Better test coverage?  Smaller
> kernel?  Larger kernel?
>
> (I'm too lazy to figure this out and it should have been in the
> changelog anyway ;))
> .
>
Better test coverage I think.

And I want to add HUGE_VMAP support for riscv, which doesn't have THP support right now.

