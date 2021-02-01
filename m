Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1FD530A80B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 13:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbhBAMxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 07:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhBAMxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 07:53:13 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7252C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 04:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gdml/OWE1lilIJqyqR60caVTMgJclWBs681D5GJ1NKI=; b=r8HfU73Mu0WvtDuVMhnZb/+Dc/
        Ybz2yXO0iwBDpRwQ9BBJSxu2Vdw7+EULsa868TA5Y0fjkVl+BeykikhyPB4ze9hb8wouD0rYeJZOt
        OWmkcimRNVuBprOBILwwfrZzq9DVh3OGDT5OZmhVYEynQOGOw6zeLaxVNnC0YILcjOKaQLaun/SJy
        3BLP3/HtUOaI1A9YKqgWGuM36AAaAzqpNFAfTfcyywr47NqOXBQskIIxO19NGheeGOoo/jtFcutYD
        6XMYC67U6kEqAc+MYlOfqHs/od7ayIPM0PDgfDZtOqTRyy22vicu/huoyZD1BKoJa5L0aeKXZokSp
        DymVwYlQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l6Ygv-00DmZA-Kv; Mon, 01 Feb 2021 12:52:29 +0000
Date:   Mon, 1 Feb 2021 12:52:29 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     syzbot <syzbot+97ef6376738cb5104a71@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        kent.overstreet@gmail.com, hch@lst.de
Subject: Re: BUG: Bad page state (8)
Message-ID: <20210201125229.GO308988@casper.infradead.org>
References: <00000000000019201505ba43855e@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000019201505ba43855e@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 02:07:22AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:

Thank you, syzbot.  This is legit.  But annoying.

> BUG: Bad page state in process syz-executor.4  pfn:369c1
> page:0000000025f15602 refcount:0 mapcount:0 mapping:0000000000000000 index:0x3d pfn:0x369c1
> flags: 0xfff00000020005(locked|uptodate|mappedtodisk)
> raw: 00fff00000020005 dead000000000100 dead000000000122 0000000000000000
> raw: 000000000000003d 0000000000000000 00000000ffffffff 0000000000000000
> page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set

Having the uptodate and mappedtodisk flags set is fine.  It's the 'locked'
flag which is triggering the bug.  Here's the code in question:

truncated:
        error = AOP_TRUNCATED_PAGE;
        put_page(page);
unlock:
        unlock_page(page);

So we're going to unlock the page!  But we actually have to unlock it first,
before the refcount goes to zero.  Does anyone see a better way than this?

(Andrew, this is a fix to "mm/filemap: add filemap_range_uptodate")

diff --git a/mm/filemap.c b/mm/filemap.c
index bc4c9ac0ef4a..a945102b55c2 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2322,8 +2322,9 @@ static int filemap_update_page(struct kiocb *iocb,
 		put_page(page);
 	return error;
 truncated:
-	error = AOP_TRUNCATED_PAGE;
+	unlock_page(page);
 	put_page(page);
+	return AOP_TRUNCATED_PAGE;
 unlock:
 	unlock_page(page);
 	return error;
