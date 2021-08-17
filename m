Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE0B03EE87D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 10:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239646AbhHQI0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 04:26:01 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:14267 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239329AbhHQIZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 04:25:19 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GpkbT5FY4z876x;
        Tue, 17 Aug 2021 16:24:37 +0800 (CST)
Received: from [10.174.179.72] (10.174.179.72) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 17 Aug 2021 16:24:43 +0800
Subject: Re: [PATCH 2/4] mm/hwpoison: fix potential pte_unmap_unlock pte error
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20210814105131.48814-1-linmiaohe@huawei.com>
 <20210814105131.48814-3-linmiaohe@huawei.com>
 <20210817072900.GA452155@hori.linux.bs1.fc.nec.co.jp>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <4b0a5fcd-0b1b-6198-b6a7-d9cab5b9fae2@huawei.com>
Date:   Tue, 17 Aug 2021 16:24:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210817072900.GA452155@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.72]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/17 15:29, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Sat, Aug 14, 2021 at 06:51:29PM +0800, Miaohe Lin wrote:
>> If the first pte is equal to poisoned_pfn, i.e. check_hwpoisoned_entry()
>> return 1, the wrong ptep - 1 would be passed to pte_unmap_unlock().
>>
>> Fixes: ad9c59c24095 ("mm,hwpoison: send SIGBUS with error virutal address")
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> 
> I agree with the change itself, so
> 
> Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 

Many thanks for your review and Acked-by tag!

> One question is that according to "grep -r pte_unmap_unlock ." command over
> whole kernel source code, pte_unmap_unlock() is called with "ptep - 1" in some places.
> I think that none of them seems to have "break in for loop" in locked period,
> so the same problem does not occur there.  But I'm still not sure why some place
> call with "ptep - 1" and the others call with pte returned by pte_offset_map_lock().

IMO pte_unmap_unlock() works as long as the passed in pte belongs to the same page returned
from pte_offset_map_lock(). I have fixed some similar place where pte_unmap_unlock() is called
with wrong "ptep - 1" when I was learning the related mm code.

>
