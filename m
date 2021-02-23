Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C15F3234B3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 01:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbhBXAsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 19:48:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:57598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234679AbhBXAEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 19:04:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 24ED164EBB;
        Tue, 23 Feb 2021 23:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1614124687;
        bh=bZ30MhhE5ZCrYTDGI5TcYFn+yUYa2L1/c+U8urUIaA4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kaapH1nbcdcQTJjVB/1rgD+6QVpXSAmgx1NeeiD1BMDUwFxjTECDcfPkS2nuKqSci
         3iVmmRgvGAhyh4FfSYtP0YpF6Eq/Pe41wmPu02zccRS8joqNtZn5/kWDRXt1u9k2pc
         pju/+VdtnLSWiaetDQHxm/9ySwEzRQCLmsJy3PjQ=
Date:   Tue, 23 Feb 2021 15:58:06 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [RFC] linux-next panic in hugepage_subpool_put_pages()
Message-Id: <20210223155806.8e2284682df5d08ce9b3da68@linux-foundation.org>
In-Reply-To: <3c536d3c-a180-301b-5cb7-c737a178a9d7@oracle.com>
References: <20210223155740.553df3ee@thinkpad>
        <3c536d3c-a180-301b-5cb7-c737a178a9d7@oracle.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Feb 2021 10:06:12 -0800 Mike Kravetz <mike.kravetz@oracle.com> wrote:

> On 2/23/21 6:57 AM, Gerald Schaefer wrote:
> > Hi,
> > 
> > LTP triggered a panic on s390 in hugepage_subpool_put_pages() with
> > linux-next 5.12.0-20210222, see below.
> > 
> > It crashes on the spin_lock(&spool->lock) at the beginning, because the
> > passed-in *spool points to 0000004e00000000, which is not addressable
> > memory. It rather looks like some flags and not a proper address. I suspect
> > some relation to the recent rework in that area, e.g. commit f1280272ae4d
> > ("hugetlb: use page.private for hugetlb specific page flags").
> > 
> > __free_huge_page() calls hugepage_subpool_put_pages() and takes *spool from
> > hugetlb_page_subpool(page), which was changed by that commit to use
> > page[1]->private now.
> > 
> 
> Thanks Gerald,
> 
> Yes, I believe f1280272ae4d is the root cause of this issue.  In that
> commit, the subpool pointer was moved from page->private of the head
> page to page->private of the first subpage.  The page allocator will
> initialize (zero) the private field of the head page, but not that of
> subpages.  So, that bad subpool pointer is likely an old page->private
> value for the page.
> 
> That strange call path from set_max_huge_pages to __free_huge_page is
> actually how the code puts newly allocated pages on it's interfal free
> list.  
> 
> I will do a bit more verification and put together a patch (it should
> be simple).

There's also Michel's documentation request:
https://lkml.kernel.org/r/20210127102645.GH827@dhcp22.suse.cz
