Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6D654186C2
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 08:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbhIZGpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 02:45:50 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:19361 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhIZGpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 02:45:49 -0400
Received: from dggeml765-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HHGND5MX3zQk7q;
        Sun, 26 Sep 2021 14:39:56 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggeml765-chm.china.huawei.com
 (10.1.199.175) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Sun, 26
 Sep 2021 14:44:10 +0800
From:   liuyuntao <liuyuntao10@huawei.com>
To:     <hughd@google.com>
CC:     <akpm@linux-foundation.org>, <kirill.shutemov@linux.intel.com>,
        <kirill@shutemov.name>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <liusirui@huawei.com>,
        <liuyuntao10@huawei.com>, <windspectator@gmail.com>,
        <wuxu.wu@huawei.com>
Subject: Re: [PATCH v2] fix judgment error in shmem_is_huge()
Date:   Sun, 26 Sep 2021 14:42:01 +0800
Message-ID: <20210926064201.3416154-1-liuyuntao10@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <614538e2-16bb-2657-f374-64195c5c7c2@google.com>
References: <614538e2-16bb-2657-f374-64195c5c7c2@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeml765-chm.china.huawei.com (10.1.199.175)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Sep 2021, Hugh Dickins wrote:
> On Fri, 24 Sep 2021, Hugh Dickins wrote:
> > On Thu, 9 Sep 2021, Liu Yuntao wrote:
> > 
> > > In the case of SHMEM_HUGE_WITHIN_SIZE, the page index is not rounded
> > > up correctly. When the page index points to the first page in a huge
> > > page, round_up() cannot bring it to the end of the huge page, but
> > > to the end of the previous one.
> > > 
> > > an example:
> > > HPAGE_PMD_NR on my machine is 512(2 MB huge page size).
> > > After allcoating a 3000 KB buffer, I access it at location 2050 KB.
> > 
> > Your example is certainly helpful, but weird!  It's not impossible,
> > but wouldn't it be easier to understand if you said "2048 KB" there?

I wanted to emphasize that access to any bit in the first page will
trigger this problem, so I didn't use "2048 KB".

> > 
> > > In shmem_is_huge(), the corresponding index happens to be 512.
> > > After rounded up by HPAGE_PMD_NR, it will still be 512 which is
> > > smaller than i_size, and shmem_is_huge() will return true.
> > > As a result, my buffer takes an additional huge page, and that
> > > shouldn't happen when shmem_enabled is set to within_size.
> > 
> > A colleague very recently opened my eyes to within_size on shmem_enabled:
> > I've always been dubious of both, but they can work quite well together.
> > 
> > > 
> > > Fixes: f3f0e1d2150b2b ("khugepaged: add support of collapse for tmpfs/shmem pages")
> > > Signed-off-by: Liu Yuntao <liuyuntao10@huawei.com>
> > 
> > Thanks, with a nice simplification from Kirill.
> > 
> > Acked-by: Hugh Dickins <hughd@google.com>
> 
> Andrew has just sent this on to Linus - thanks - and that's fine:
> no need to get in the way of that.
> 
> But since replying, I have remembered more history, and there is
> something that we need to be aware of.
> 
> Whereas to you this is a straightforward off-by-one (or off-by-page)
> fix, it also results in a significant change in behaviour - I'd say
> usually for the better, but some might be surprised.  This patch has
> Kirill's Ack and my Ack, and I hope and believe that we can get away
> with the change in behaviour: but let's be aware of it.
> 
> The change that concerns me is when, for example, copying a large
> file into a huge=within_size tmpfs (or more generally, just writing
> to the file by appending at EOF in the usual way).
> 
> With the old WITHIN_SIZE code, the first 2MB was allocated in small
> pages, then subsequent 2MB extents were allocated with huge pages;
> including the final extent, even if it only needed a single byte.
> 
> I always thought that was very clunky behaviour, the small pages
> coming at the wrong end of the file; and that's why I was dubious
> about it as a sensible filesystem mount option.  But I was under
> the impression that it was the intended behaviour.
> 
> With your new WITHIN_SIZE code, all those appending allocations
> are outside i_size, and the whole file is allocated in small pages.
> (Then maybe later on khugepaged can assemble huge pages for it.)
> 
> Your patch makes within_size more sensible than it was for pre-sized
> files (and I think it's fair to say that the majority of files in
> shmem's internal mount, subject to thp/shmem_enabled, are likely to
> be fixed-size files); and better-defined than it used to be on
> growing files, but they won't get the huge pages they used to.

Although my patch changes shmem's behaviour, it makes shmem consistent
with the documentation. I think with the new code, it will be easier
for our users to understand.

> 
> Hugh
