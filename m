Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4BF5388999
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 10:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343508AbhESInO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 04:43:14 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3024 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245683AbhESInH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 04:43:07 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FlR8m48phzQpWf;
        Wed, 19 May 2021 16:38:16 +0800 (CST)
Received: from dggeme703-chm.china.huawei.com (10.1.199.99) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 19 May 2021 16:41:46 +0800
Received: from [10.174.176.110] (10.174.176.110) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 19 May 2021 16:41:45 +0800
Subject: Re: [Question] Is there a race window between __anon_vma_prepare()
 with page_lock_anon_vma_read() ?
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>
References: <726b53ca-f8a5-c8cb-d704-bcd656afa68e@huawei.com>
Message-ID: <6da23315-a00e-4b30-68f4-828b2f66dd47@huawei.com>
Date:   Wed, 19 May 2021 16:41:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <726b53ca-f8a5-c8cb-d704-bcd656afa68e@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.110]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/5/14 17:16, Miaohe Lin wrote:
> Hi all,
> I am investigating the rmap code, and I found the below possible race window:
> 
> CPU 1								CPU 2
> -----								-----
> page_lock_anon_vma_read
>   rcu_read_lock
>   /* We assume anon_vam == root_anon_vma in this case. */
>   root_anon_vma = READ_ONCE(anon_vma->root);
>   root_anon_vma is *released* somewhere unfortunately.
>   down_read_trylock(&root_anon_vma->rwsem)
> 								__anon_vma_prepare
> 								  anon_vma_alloc
> 								    root_anon_vma is *allocated* here.
> 								    init_rwsem(&anon_vma->rwsem);
>   !page_mapped(page)
>     up_read(&root_anon_vma->rwsem); -- *Oops!*
> 
> root_anon_vma->rwsem is reinitialized after locked. And reinitialized anon_vma->rwsem will be
> unlocked without lock first.
> 
> I think this could happen due to the subtle SLAB_TYPESAFE_BY_RCU. But only can occur when anon_vma
> is root anon_vma or they won't operate on the same rwsem.
> Is this will really happen or Am I miss something ? Any reply would be very grateful.
> Many Thanks! :)

Any reply would be very grateful.
Many thanks!

> 

