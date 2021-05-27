Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D45A3923D0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 02:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbhE0Ae0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 20:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbhE0AeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 20:34:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF55C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 17:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rGnGbvjwxo5pZ/xivVTzhZZksaRg9qYZ3497Lsqz1j0=; b=qik79SlIXNJdlHZ3tdNFMlPZjf
        /GX4ppKG7Htrhi1w9MFCnu4/yRx7GW14Jb4z7fpCUJNBOmFcwtW7WEbEcmDBjvWQdrckWQNd8dM2J
        qFo5EJ8Jug9DpqktI1WAWyoStvwxmufiur4YOKzQWm1lQbSZjq8CZJWXz+UFgk3MsqYjJU8fxXAHx
        q0W/bBR9AIxQjUBq3AAogSyYWw22TMr/Pqnv9+SpYRzt4C+FVpF2D7e0aVLcpctgx9s4qX0R/9eNl
        LoRg0MNdURKh6yG+Te38Vwl69F5DKcSAR7ZfbY1d6SxY/ov1XIm5KazcLF8qYNk9tVyWf+Tb0NSUK
        Iyrl+Y0w==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lm3wB-0051pP-Bz; Thu, 27 May 2021 00:31:54 +0000
Date:   Thu, 27 May 2021 01:31:47 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc:     linux-mm@kvack.org, Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] hugetlb: pass head page to remove_hugetlb_page()
Message-ID: <YK7oc0/y9UHWFfYt@casper.infradead.org>
References: <20210526235257.2769473-1-nao.horiguchi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526235257.2769473-1-nao.horiguchi@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 08:52:57AM +0900, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> When memory_failure() or soft_offline_page() is called on a tail page of
> some hugetlb page, "BUG: unable to handle page fault" error can be
> triggered.
> 
> remove_hugetlb_page() dereferences page->lru, so it's assumed that the
> page points to a head page, but one of the caller,
> dissolve_free_huge_page(), provides remove_hugetlb_page() with 'page'
> which could be a tail page.  So pass 'head' to it, instead.

I'd like to point out that with folios, this is a compile-time error,
not a run-time error.
