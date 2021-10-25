Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C22A438CC0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 02:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbhJYAP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 20:15:27 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:41561 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229814AbhJYAP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 20:15:26 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UtUYDQq_1635120782;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0UtUYDQq_1635120782)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 25 Oct 2021 08:13:03 +0800
Date:   Mon, 25 Oct 2021 08:12:55 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] erofs: get rid of ->lru usage
Message-ID: <YXX2h26Fm/hztdaZ@B-P7TQMD6M-0146.local>
References: <20211022090120.14675-1-hsiangkao@linux.alibaba.com>
 <YXWQ6p4Hlx6tGpPN@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YXWQ6p4Hlx6tGpPN@moria.home.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 24, 2021 at 12:59:22PM -0400, Kent Overstreet wrote:
> On Fri, Oct 22, 2021 at 05:01:20PM +0800, Gao Xiang wrote:
> > Currently, ->lru is a way to arrange non-LRU pages and has some
> > in-kernel users. In order to minimize noticable issues of page
> > reclaim and cache thrashing under high memory presure, limited
> > temporary pages were all chained with ->lru and can be reused
> > during the request. However, it seems that ->lru could be removed
> > when folio is landing.
> > 
> > Let's use page->private to chain temporary pages for now instead
> > and transform EROFS formally after the topic of the folio / file
> > page design is finalized.
> > 
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: Kent Overstreet <kent.overstreet@gmail.com>
> > Cc: Chao Yu <chao@kernel.org>
> > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> 
> Would it not be an option to use an array of pointers to pages, instead of a
> linked list? Arrays are faster than lists, and page->private is another thing we
> prefer not to use if we don't have to.

Our requirement is to maintain variable-sized temporary pages, that
may be short or maybe long during decompression process (according to
different algorithms and whether it's inplace I/O or not) rather than
before I/O submission:

 For LZ4, that maybe 16 pages for lz4 sliding window and other
temporary pages;
 For LZMA, since it has a internal dictionary (sliding window) so we
don't have to allocate any temporary pages for cached decompression
(outplace I/O), but we still need allocating temporary pages to
handle overlapped decompression due to inplace I/O (think about it,
if each compressed pcluster is 4pages -- 16KiB, we have to allocate
for example another 128KiB compressed pages due to read request for
outplace I/O, but instead 0 pages for inplace I/O during I/O process,
and only 4 pages for decompression process. It saves much memory in
the low memory scenarios by using inplace I/O and important to the
performance).

Currently we only add some page to the head or pick some page from
head, so a singly-linked list is also fine to us for now.

> 
> That said - this is definitely preferable to using page->lru - thank you.
> 
> Reviewed-by: Kent Overstreet <kent.overstreet@gmail.com>

Thank you!

Thanks,
Gao Xiang

