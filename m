Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31DC63EADDB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 02:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237008AbhHMAWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 20:22:10 -0400
Received: from mga11.intel.com ([192.55.52.93]:48426 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232410AbhHMAWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 20:22:08 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10074"; a="212362556"
X-IronPort-AV: E=Sophos;i="5.84,317,1620716400"; 
   d="scan'208";a="212362556"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2021 17:21:41 -0700
X-IronPort-AV: E=Sophos;i="5.84,317,1620716400"; 
   d="scan'208";a="517673887"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.159.119])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2021 17:21:40 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Data corruption problem with swapfiles and THP
References: <YRU5NAD+G9DVFYM/@casper.infradead.org>
Date:   Fri, 13 Aug 2021 08:21:38 +0800
In-Reply-To: <YRU5NAD+G9DVFYM/@casper.infradead.org> (Matthew Wilcox's message
        of "Thu, 12 Aug 2021 16:07:32 +0100")
Message-ID: <87a6lm6vot.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@infradead.org> writes:

> There is an assumption in the swap writepage path that a THP is physically
> contiguous on swap:
>
>         bio->bi_iter.bi_sector = swap_page_sector(page);
>         bio->bi_opf = REQ_OP_WRITE | REQ_SWAP | wbc_to_write_flags(wbc);
>         bio->bi_end_io = end_write_func;
>         bio_add_page(bio, page, thp_size(page), 0);
>
> As far as I can tell, this is not necessarily true.  If a file is not
> contiguous, we can have an extent which is 1MB long followed by an extent
> somewhere else on storage that's 1MB long.  When we try to write a 2MB
> page to swap, we overwrite whatever's on the block device after that
> first 1MB extent.
>
> (Came across this by code examination while looking at getting rid of
> the bio path entirely; no attempt has been made to produce this problem;
> something else may prevent it from actually happening)

Yes.  THP needs to be split firstly before swapping out to a swap device
backed by a file.  Please take a look at the get_swap_pages()

		if (size == SWAPFILE_CLUSTER) {
			if (si->flags & SWP_BLKDEV)
				n_ret = swap_alloc_cluster(si, swp_entries);
		} else
			n_ret = scan_swap_map_slots(si, SWAP_HAS_CACHE,
						    n_goal, swp_entries);

If the swap device is backed by a file, si->flags & SWP_BLKDEV == 0,
only normal swap entry (not huge) can be allocated.  This will result
that the THP is split.

Best Regards,
Huang, Ying
