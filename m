Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7BFC4043B1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 04:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236171AbhIICmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 22:42:40 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:15309 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbhIICmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 22:42:39 -0400
Received: from dggeml765-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4H4jtM0bMQz8syC;
        Thu,  9 Sep 2021 10:40:59 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggeml765-chm.china.huawei.com
 (10.1.199.175) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Thu, 9 Sep
 2021 10:41:28 +0800
From:   Liu Yuntao <liuyuntao10@huawei.com>
To:     <kirill@shutemov.name>
CC:     <akpm@linux-foundation.org>, <hughd@google.com>,
        <kirill.shutemov@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <liusirui@huawei.com>,
        <liuyuntao10@huawei.com>, <windspectator@gmail.com>,
        <wuxu.wu@huawei.com>
Subject: Re: [PATCH] fix judgment error in shmem_is_huge()
Date:   Thu, 9 Sep 2021 10:39:19 +0800
Message-ID: <20210909023919.2520886-1-liuyuntao10@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210908145844.wqkyfuizqaj5mmrj@box>
References: <20210908145844.wqkyfuizqaj5mmrj@box>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeml765-chm.china.huawei.com (10.1.199.175)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Sep 2021 17:58:44 +0300, Kirill A. Shutemov wrote:
> On Wed, Sep 08, 2021 at 06:26:48PM +0800, Liu Yuntao wrote:
> > In the case of SHMEM_HUGE_WITHIN_SIZE, the page index is not rounded
> > up correctly. When the page index points to the first page in a huge
> > page, round_up() cannot bring it to the end of the huge page, but
> > to the end of the previous one.
> > 
> > an example:
> > HPAGE_PMD_NR on my machine is 512(2 MB huge page size).
> > After allcoating a 3000 KB buffer, I access it at location 2050 KB.
> > In shmem_is_huge(), the corresponding index happens to be 512.
> > After rounded up by HPAGE_PMD_NR, it will still be 512 which is
> > smaller than i_size, and shmem_is_huge() will return true.
> > As a result, my buffer takes an additional huge page, and that
> > shouldn't happen when shmem_enabled is set to within_size.
> > 
> > Fixes: f3f0e1d2150b2b ("khugepaged: add support of collapse for tmpfs/shmem pages")
> > Signed-off-by: Liu Yuntao <liuyuntao10@huawei.com>
> > ---
> >  mm/shmem.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index 88742953532c..5747572859d1 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -490,7 +490,7 @@ bool shmem_is_huge(struct vm_area_struct *vma,
> >  	case SHMEM_HUGE_ALWAYS:
> >  		return true;
> >  	case SHMEM_HUGE_WITHIN_SIZE:
> > -		index = round_up(index, HPAGE_PMD_NR);
> > +		index = round_up(index + 1, HPAGE_PMD_NR);
> >  		i_size = round_up(i_size_read(inode), PAGE_SIZE);
> >  		if (i_size >= HPAGE_PMD_SIZE && (i_size >> PAGE_SHIFT) >= index)
> 
> With the change, the condition can be simplified to
> 
> 		if (i_size >> PAGE_SHIFT >= index)
> 
> right?

Yes, will add it.

> 
> >  			return true;
> > -- 
> > 2.23.0
> > 
> 
> -- 
>  Kirill A. Shutemov

