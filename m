Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 511A638847E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 03:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbhESBlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 21:41:15 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:2975 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbhESBlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 21:41:14 -0400
Received: from dggems702-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FlFpq3PQ0zBvSp;
        Wed, 19 May 2021 09:37:07 +0800 (CST)
Received: from dggeme703-chm.china.huawei.com (10.1.199.99) by
 dggems702-chm.china.huawei.com (10.3.19.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 19 May 2021 09:39:53 +0800
Received: from [10.174.176.110] (10.174.176.110) by
 dggeme703-chm.china.huawei.com (10.1.199.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 19 May 2021 09:39:53 +0800
Subject: Re: [PATCH 5/5] mm/swap: simplify the code of find_get_incore_page()
To:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20210518135352.3705306-1-linmiaohe@huawei.com>
 <20210518135352.3705306-6-linmiaohe@huawei.com>
 <YKPQUjjdC3mP5f/P@casper.infradead.org>
 <20210518141304.c09cd8762e3f3d16a722444c@linux-foundation.org>
 <YKQy+fMIxQVTSjaW@casper.infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <b74ae719-41a4-80d2-95ae-ce0122d21338@huawei.com>
Date:   Wed, 19 May 2021 09:39:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YKQy+fMIxQVTSjaW@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.110]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/5/19 5:34, Matthew Wilcox wrote:
> On Tue, May 18, 2021 at 02:13:04PM -0700, Andrew Morton wrote:
>> On Tue, 18 May 2021 15:33:54 +0100 Matthew Wilcox <willy@infradead.org> wrote:
>>
>>> On Tue, May 18, 2021 at 09:53:52PM +0800, Miaohe Lin wrote:
>>>> pagecache_get_page() can do find_subpage() for us if we do not specify
>>>> FGP_HEAD. No functional change intended.
>>>
>>> Please, no.  This interferes with the folio work.
>>
>> In what way?  Can't the folio patches simply revert this or suitably
>> alter it?
> 
> Of course, it's just software.  Anything can just be modified.  I don't
> see the point of putting in a cleanup patch that creates a conflict with
> important work.

I could hold this patch out until folio work is done if you ask for it.
Thanks.

> .
> 

