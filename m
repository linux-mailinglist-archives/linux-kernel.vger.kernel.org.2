Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B466D359447
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 07:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbhDIFFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 01:05:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:50228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231495AbhDIFFG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 01:05:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B70CC610A2;
        Fri,  9 Apr 2021 05:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1617944693;
        bh=7SOpsa0o4t1jaPRNexNfeE1nLPrakeTw29gTONj7AJ0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FJ5fT3Q56hZnzLI8EgfR7InX0tVvMv4PMvTINhEZUDMfJQ+vqk4HTOZpqZ8xx2BDK
         XsrgJDSQU/GpmstHL8p59p2Sf3PvhFAEufhRDWilOUOAYGYPhKFcuGnRvngb7Gm/eH
         daUpKXDNjp+J79zfk2ZSBolDgIhCy3tBRYlvPI04=
Date:   Thu, 8 Apr 2021 22:04:53 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        <n-horiguchi@ah.jp.nec.com>, <hillf.zj@alibaba-inc.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH 4/4] mm/hugeltb: handle the error case in
 hugetlb_fix_reserve_counts()
Message-Id: <20210408220453.f95942bf20baadd8dbbc1488@linux-foundation.org>
In-Reply-To: <fe37dcbd-5604-8b43-c184-b7d991b16de8@huawei.com>
References: <20210402093249.25137-1-linmiaohe@huawei.com>
        <20210402093249.25137-5-linmiaohe@huawei.com>
        <a61335c2-c6ab-6169-012c-5b5d2d9499da@oracle.com>
        <fe37dcbd-5604-8b43-c184-b7d991b16de8@huawei.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Apr 2021 11:17:49 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> On 2021/4/9 7:25, Mike Kravetz wrote:
> > On 4/2/21 2:32 AM, Miaohe Lin wrote:
> >> A rare out of memory error would prevent removal of the reserve map region
> >> for a page. hugetlb_fix_reserve_counts() handles this rare case to avoid
> >> dangling with incorrect counts. Unfortunately, hugepage_subpool_get_pages
> >> and hugetlb_acct_memory could possibly fail too. We should correctly handle
> >> these cases.
> > 
> > Yes, this is a potential issue.
> > 
> > The 'good news' is that hugetlb_fix_reserve_counts() is unlikely to ever
> > be called.  To do so would imply we could not allocate a region entry
> > which is only 6 words in size.  We also keep a 'cache' of entries so we
> > may not even need to allocate.
> > 
> > But, as mentioned it is a potential issue.
> 
> Yes, a potential *theoretical* issue.
> 
> > 
> >> Fixes: b5cec28d36f5 ("hugetlbfs: truncate_hugepages() takes a range of pages")
> > 
> > This is likely going to make this get picked by by stable releases.
> > That is unfortunate as mentioned above this is mostly theoretical.
> > 
> 
> I will drop this. This does not worth backport.
> 

-stable have been asked not to backport MM patches unless MM patches
include "cc:stable".  ie, no making our backporting decisions for us,
please.

