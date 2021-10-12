Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8B3942A4CE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 14:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236454AbhJLMrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 08:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbhJLMrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 08:47:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D540DC061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 05:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fs/MX5SszswqpeGNl8Ck0CoDmx06jLPiMI+4u0nlpGU=; b=Kf3LiAw9fYZHdjY8uctjTofZTW
        8A3czTTk1/bsdxmCYqI81LKa4b3Vwu1kW0Az++7nfhB3D/kcIfzv/5s9/8U4Sb07CnF/JfRSSL69J
        7pAhpEEzbI/IdX2lNLaVlXgcwUDKII8rfbiPHlP8sdenBZtwXutt+7Lrm29KtH9ndEBrWLfXjat5P
        AsYD4wwQPQ8pvXQY39dzYpxvobqE7WRf4m/O6oSdeN6PDM1wN4I++FRwdmfJE6lzhiQ5KNw8wcNJU
        szKyHsUO8CoZkhoPkzSWcaH5TUhpo085OsJq4zzbB0CUQc2CBzFopmloDqOccacwFfZapy+GwJwle
        gu6adehQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maH83-006VWb-27; Tue, 12 Oct 2021 12:43:53 +0000
Date:   Tue, 12 Oct 2021 13:43:35 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?6rmA7ISx7ZuI?= <sfoon.kim@samsung.com>,
        Song Liu <songliubraving@fb.com>,
        Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hillf Danton <hdanton@sina.com>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Yang Shi <yang.shi@linux.alibaba.com>
Subject: Re: [PATCH] mm/thp: decrease nr_thps in file's mapping on THP split
Message-ID: <YWWC9+93pHQ77Ir3@casper.infradead.org>
References: <CGME20211012120247eucas1p1f66926c6fc334216cdbdd39285601aa8@eucas1p1.samsung.com>
 <20211012120237.2600-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012120237.2600-1-m.szyprowski@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 02:02:37PM +0200, Marek Szyprowski wrote:
> Decrease nr_thps counter in file's mapping to ensure that the page cache
> won't be dropped excessively on file write access if page has been
> already splitted.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Fixes: 09d91cda0e82 ("mm,thp: avoid writes to file with THP in pagecache")
> Fixes: 06d3eff62d9d ("mm/thp: fix node page state in split_huge_page_to_list()")
> ---
> I've analyzed the code a few times but either I missed something or the
> nr_thps counter is not decremented during the THP split on non-shmem file
> pages.

This looks OK to me, but have you tested it?  If so, what workload did
you use?  The way you wrote this changelog makes it sound like you only
read the code and there have been rather too many bugs introduced recently
that way :-(
