Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0353B5874
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 06:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbhF1ErY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 00:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbhF1ErX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 00:47:23 -0400
X-Greylist: delayed 1012 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 27 Jun 2021 21:44:58 PDT
Received: from scorn.kernelslacker.org (scorn.kernelslacker.org [IPv6:2600:3c03:e000:2fb::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D9AC061574
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 21:44:58 -0700 (PDT)
Received: from [2601:196:4600:6634:ae9e:17ff:feb7:72ca] (helo=wopr.kernelslacker.org)
        by scorn.kernelslacker.org with esmtp (Exim 4.92)
        (envelope-from <davej@codemonkey.org.uk>)
        id 1lxisJ-0003gK-S0; Mon, 28 Jun 2021 00:27:59 -0400
Received: by wopr.kernelslacker.org (Postfix, from userid 1026)
        id 72A26560148; Mon, 28 Jun 2021 00:27:59 -0400 (EDT)
Date:   Mon, 28 Jun 2021 00:27:59 -0400
From:   Dave Jones <davej@codemonkey.org.uk>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] mm/page_alloc: do bulk array bounds check after checking
 populated elements
Message-ID: <20210628042759.GA19686@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20210618125102.GU30378@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210618125102.GU30378@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Note: SpamAssassin invocation failed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 01:51:02PM +0100, Mel Gorman wrote:
 > Dan Carpenter reported the following
 > 
 >   The patch 0f87d9d30f21: "mm/page_alloc: add an array-based interface
 >   to the bulk page allocator" from Apr 29, 2021, leads to the following
 >   static checker warning:
 > 
 >         mm/page_alloc.c:5338 __alloc_pages_bulk()
 >         warn: potentially one past the end of array 'page_array[nr_populated]'
 > 
 > The problem can occur if an array is passed in that is fully populated. That
 > potentially ends up allocating a single page and storing it past the end of
 > the array. This patch returns 0 if the array is fully populated.
 > 
 > Fixes: 0f87d9d30f21 ("mm/page_alloc: add an array-based interface to the bulk page allocator")
 > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
 > Signed-off-by: Mel Gorman <mgorman@techsinguliarity.net>
 > ---
 >  mm/page_alloc.c | 4 ++++
 >  1 file changed, 4 insertions(+)
 > 
 > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
 > index 7124bb00219d..ef2265f86b91 100644
 > --- a/mm/page_alloc.c
 > +++ b/mm/page_alloc.c
 > @@ -5056,6 +5056,10 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 >  	while (page_array && nr_populated < nr_pages && page_array[nr_populated])
 >  		nr_populated++;
 >  
 > +	/* Already populated array? */
 > +	if (unlikely(page_array && nr_pages - nr_populated == 0))
 > +		return 0;
 > +
 >  	/* Use the single page allocator for one page. */
 >  	if (nr_pages - nr_populated == 1)
 >  		goto failed;


This made it into 5.13 final, and completely breaks NFSD for me (Serving tcp v3 mounts).
Existing mounts on clients hang, as do new mounts from new clients.
Rebooting the server back to rc7 everything recovers.  Bisect lands on
this commit.

$ git bisect start
# good: [13311e74253fe64329390df80bed3f07314ddd61] Linux 5.13-rc7
git bisect good 13311e74253fe64329390df80bed3f07314ddd61
# bad: [b665c68f11192e7b31e9b793f31c78d80558da07] restart watchdog if oopsing
git bisect bad b665c68f11192e7b31e9b793f31c78d80558da07
# good: [b960e0147451915b5d4cd208b7abd3b07ceaf1a2] Merge tag 'for-linus-5.13b-rc8-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip
git bisect good b960e0147451915b5d4cd208b7abd3b07ceaf1a2
# bad: [7ce32ac6fb2fc73584b567c73ae0c47528954ec6] Merge branch 'akpm' (patches from Andrew)
git bisect bad 7ce32ac6fb2fc73584b567c73ae0c47528954ec6
# good: [5fa54346caf67b4b1b10b1f390316ae466da4d53] kthread: prevent deadlock when kthread_mod_delayed_work() races with kthread_cancel_delayed_work_sync()
git bisect good 5fa54346caf67b4b1b10b1f390316ae466da4d53
# bad: [72a461adbe88acf6a8cc5dba7720cf94d7056154] mailmap: add Marek's other e-mail address and identity without diacritics
git bisect bad 72a461adbe88acf6a8cc5dba7720cf94d7056154
# good: [ea6d0630100b285f059d0a8d8e86f38a46407536] mm/hwpoison: do not lock page again when me_huge_page() successfully recovers
git bisect good ea6d0630100b285f059d0a8d8e86f38a46407536
# bad: [b3b64ebd38225d8032b5db42938d969b602040c2] mm/page_alloc: do bulk array bounds check after checking populated elements
git bisect bad b3b64ebd38225d8032b5db42938d969b602040c2
# good: [b08e50dd64489e3997029d204f761cb57a3762d2] mm/page_alloc: __alloc_pages_bulk(): do bounds check before accessing array
git bisect good b08e50dd64489e3997029d204f761cb57a3762d2


	Dave

