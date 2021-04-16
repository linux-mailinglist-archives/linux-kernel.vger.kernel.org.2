Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF776362BD7
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 01:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234843AbhDPXQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 19:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhDPXQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 19:16:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95A4C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 16:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=nwUWUH98s+1WN159z74VpGNQ2eihncUQHO8O/S2I9OI=; b=uIlnfxHrnXGnNjvoqqw7j1Unf5
        lQlvtWGC71jnFtTqwAbv4DUBBEju4/d6JdSWLEva7QoWbXXlvGY3IM8T/GhTSNQtXlQtRZ+hdewKk
        xPEVBH90bm2howGqpuQVaHxZMxA9E1kKxuF8UAeH90vevC0H0GLFDw/+is1Yq33mXOqCuqk8Crt/D
        NCi7IVu3c8hQK8OTHf7lhh9Y678s2kEa/01ddY4YFDVupkNaZKv3puQKKQi+oY99LUzdWEoNe8bwc
        nlh7RStmiJHmRITNO7ImPYxxCxdSHVKoDDYmQQ6aVA568lcecTeb9IjHVamnxP2d39srUNNDKZsL1
        NPHJyV4w==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lXXgU-00AZwI-AP; Fri, 16 Apr 2021 23:15:38 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [RESEND][PATCH 0/6] Constify struct page arguments
Date:   Sat, 17 Apr 2021 00:15:25 +0100
Message-Id: <20210416231531.2521383-1-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[I'm told that patches 2-6 did not make it to the list; resending and
cc'ing lkml this time]

While working on various solutions to the 32-bit struct page size
regression, one of the problems I found was the networking stack expects
to be able to pass const struct page pointers around, and the mm doesn't
provide a lot of const-friendly functions to call.  The root tangle of
problems is that a lot of functions call VM_BUG_ON_PAGE(), which calls
dump_page(), which calls a lot of functions which don't take a const
struct page (but could be const).

I have other things I need to work on, but I offer these patches as a few
steps towards being able to make dump_page() take a const page pointer.

Matthew Wilcox (Oracle) (6):
  mm: Make __dump_page static
  mm/debug: Factor PagePoisoned out of __dump_page
  mm/page_owner: Constify dump_page_owner
  mm: Make compound_head const-preserving
  mm: Constify get_pfnblock_flags_mask and get_pfnblock_migratetype
  mm: Constify page_count and page_ref_count

 include/linux/mmdebug.h         |  3 +--
 include/linux/page-flags.h      | 10 +++++-----
 include/linux/page_owner.h      |  6 +++---
 include/linux/page_ref.h        |  4 ++--
 include/linux/pageblock-flags.h |  2 +-
 mm/debug.c                      | 25 +++++++------------------
 mm/page_alloc.c                 | 16 ++++++++--------
 mm/page_owner.c                 |  2 +-
 8 files changed, 28 insertions(+), 40 deletions(-)

-- 
2.30.2

