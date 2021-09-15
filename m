Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C14AF40BFB0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 08:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbhIOGjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 02:39:09 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:9045 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhIOGjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 02:39:08 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H8Vqd6yC4zW2TD;
        Wed, 15 Sep 2021 14:36:45 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Wed, 15 Sep 2021 14:37:46 +0800
Subject: Re: [PATCH v3] mm/page_isolation: guard against possible putback
 unisolated page
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <david@redhat.com>, <jhubbard@nvidia.com>, <vbabka@suse.cz>,
        <iamjoonsoo.kim@lge.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20210914114508.23725-1-linmiaohe@huawei.com>
 <20210914190951.2e44de6a55a0c7004d5381b3@linux-foundation.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <9c22734e-0549-f9a1-36a0-1311a54e7d06@huawei.com>
Date:   Wed, 15 Sep 2021 14:37:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210914190951.2e44de6a55a0c7004d5381b3@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/9/15 10:09, Andrew Morton wrote:
> On Tue, 14 Sep 2021 19:45:08 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
>> Isolating a free page in an isolated pageblock is expected to always work
>> as watermarks don't apply here. But if __isolate_free_page() failed, due
>> to condition changes, the page will be left on the free list. And the page
>> will be put back to free list again via __putback_isolated_page(). This may
>> trigger VM_BUG_ON_PAGE() on page->flags checking in __free_one_page() if
>> PageReported is set. Or we will corrupt the free list because list_add()
>> will be called for pages already on another list. Add a VM_WARN_ON() to
>> complain about this change.
> 
> Are you able to identify a Fixes: here?
> 

Sure, this should be "Fixes: 3c605096d315 ("mm/page_alloc: restrict max order of merging on isolated pageblock")."

> Is a cc:stable justified?

I'm afraid not. As David pointed out,
""

In unset_migratetype_isolate() we check that is_migrate_isolate_page(page) holds, otherwise we return.

We call __isolate_free_page() only for such pages.

__isolate_free_page() won't perform watermark checks on is_migrate_isolate().

Consequently, __isolate_free_page() should never fail when called from unset_migratetype_isolate()


""

In a nutshell, __isolate_free_page can not fail here. So it is harmless now and doesn't worth cc:stable.

Please see https://www.spinics.net/lists/linux-mm/msg269434.html for detail.

Many thanks.

> .
> 
