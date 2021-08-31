Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B67E3FC095
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 03:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239301AbhHaB5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 21:57:01 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:9388 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235217AbhHaB5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 21:57:00 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Gz9Cp0018z8wNC;
        Tue, 31 Aug 2021 09:51:49 +0800 (CST)
Received: from [10.174.178.75] (10.174.178.75) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Tue, 31 Aug 2021 09:56:03 +0800
Subject: Re: [PATCH 6/6] mm/page_alloc.c: avoid allocating highmem pages via
 alloc_pages_exact_nid()
To:     Matthew Wilcox <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <vbabka@suse.cz>,
        <sfr@canb.auug.org.au>, <peterz@infradead.org>,
        <mgorman@techsingularity.net>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20210830141051.64090-1-linmiaohe@huawei.com>
 <20210830141051.64090-7-linmiaohe@huawei.com>
 <YSzqDt/13YbOAyo4@casper.infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <d90329db-b13a-ac28-c381-758f12c679c2@huawei.com>
Date:   Tue, 31 Aug 2021 09:56:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YSzqDt/13YbOAyo4@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.75]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/30 22:24, Matthew Wilcox wrote:
> On Mon, Aug 30, 2021 at 10:10:51PM +0800, Miaohe Lin wrote:
>> Don't use with __GFP_HIGHMEM because page_address() cannot represent
>> highmem pages without kmap(). Newly allocated pages would leak as
>> page_address() will return NULL for highmem pages here. But It works
>> now because the only caller does not specify __GFP_HIGHMEM now.
> 
> This is a misunderstanding of how alloc_pages_exact() /
> alloc_pages_exact_nid() work.  You simply can't call them with
> GFP_HIGHMEM.
> 

Yep, they can't work with GFP_HIGHMEM. So IMO it might be better to
get rid of GFP_HIGHMEM explicitly or add a comment to clarify this
situation to avoid future misbehavior. But this may be a unnecessary
worry... Do you prefer to not change anything here?

Many thanks.

> If you really must change anything here,
> s/__GFP_COMP/(__GFP_COMP|__GFP_HIGHMEM)/g throughout both
> alloc_pages_exact() and alloc_pages_exact_nid().
> .
>
