Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEE813EC22C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 13:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238040AbhHNLBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 07:01:16 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:14204 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbhHNLBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 07:01:13 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GmyBd0k2sz1CThs;
        Sat, 14 Aug 2021 19:00:25 +0800 (CST)
Received: from [10.174.179.25] (10.174.179.25) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Sat, 14 Aug 2021 19:00:43 +0800
Subject: Re: [PATCH 0/4] Cleanups and fixup for memcontrol
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
CC:     <sfr@canb.auug.org.au>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20210814105131.48814-1-linmiaohe@huawei.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <f620476a-d833-b22f-aa85-ee52b2d2dde6@huawei.com>
Date:   Sat, 14 Aug 2021 19:00:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210814105131.48814-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.25]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/8/14 18:51, Miaohe Lin wrote:
> Hi all,
> This series contains cleanups to remove unneeded variable, fix some
> obsolete comments and so on. Also we fix potential pte_unmap_unlock
> on wrong pte. More details can be found in the respective changelogs.
> Thanks!
> 
> Miaohe Lin (4):
>   mm/hwpoison: remove unneeded variable unmap_success
>   mm/hwpoison: fix potential pte_unmap_unlock pte error
>   mm/hwpoison: change argument struct page **hpagep to *hpage
>   mm/hwpoison: fix some obsolete comments
> 
>  mm/memory-failure.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
> 

My bad! The title should be "[PATCH 0/4] Cleanups and fixup for hwpoison". Sorry for inconvenience!
