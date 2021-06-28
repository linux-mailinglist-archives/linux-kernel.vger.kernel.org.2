Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4163B587D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 06:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbhF1FCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 01:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhF1FCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 01:02:06 -0400
Received: from scorn.kernelslacker.org (scorn.kernelslacker.org [IPv6:2600:3c03:e000:2fb::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD9FC061574
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jun 2021 21:59:41 -0700 (PDT)
Received: from [2601:196:4600:6634:ae9e:17ff:feb7:72ca] (helo=wopr.kernelslacker.org)
        by scorn.kernelslacker.org with esmtp (Exim 4.92)
        (envelope-from <davej@codemonkey.org.uk>)
        id 1lxjMu-00043N-Kh; Mon, 28 Jun 2021 00:59:36 -0400
Received: by wopr.kernelslacker.org (Postfix, from userid 1026)
        id 58200560148; Mon, 28 Jun 2021 00:59:36 -0400 (EDT)
Date:   Mon, 28 Jun 2021 00:59:36 -0400
From:   Dave Jones <davej@codemonkey.org.uk>
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] mm/page_alloc: do bulk array bounds check after checking
 populated elements
Message-ID: <20210628045936.GA1669@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20210618125102.GU30378@techsingularity.net>
 <20210628042759.GA19686@codemonkey.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628042759.GA19686@codemonkey.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Note: SpamAssassin invocation failed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2021 at 12:27:59AM -0400, Dave Jones wrote:
 > On Fri, Jun 18, 2021 at 01:51:02PM +0100, Mel Gorman wrote:
 >  > Dan Carpenter reported the following
 >  > 
 >  >   The patch 0f87d9d30f21: "mm/page_alloc: add an array-based interface
 >  >   to the bulk page allocator" from Apr 29, 2021, leads to the following
 >  >   static checker warning:
 >  > 
 >  >         mm/page_alloc.c:5338 __alloc_pages_bulk()
 >  >         warn: potentially one past the end of array 'page_array[nr_populated]'
 >  > 
 >  > The problem can occur if an array is passed in that is fully populated. That
 >  > potentially ends up allocating a single page and storing it past the end of
 >  > the array. This patch returns 0 if the array is fully populated.
 >  > 
 >  > Fixes: 0f87d9d30f21 ("mm/page_alloc: add an array-based interface to the bulk page allocator")
 >  > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
 >  > Signed-off-by: Mel Gorman <mgorman@techsinguliarity.net>
 >  > ---
 >  >  mm/page_alloc.c | 4 ++++
 >  >  1 file changed, 4 insertions(+)
 >  > 
 >  > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
 >  > index 7124bb00219d..ef2265f86b91 100644
 >  > --- a/mm/page_alloc.c
 >  > +++ b/mm/page_alloc.c
 >  > @@ -5056,6 +5056,10 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 >  >  	while (page_array && nr_populated < nr_pages && page_array[nr_populated])
 >  >  		nr_populated++;
 >  >  
 >  > +	/* Already populated array? */
 >  > +	if (unlikely(page_array && nr_pages - nr_populated == 0))
 >  > +		return 0;
 >  > +
 >  >  	/* Use the single page allocator for one page. */
 >  >  	if (nr_pages - nr_populated == 1)
 >  >  		goto failed;
 > 
 > 
 > This made it into 5.13 final, and completely breaks NFSD for me (Serving tcp v3 mounts).
 > Existing mounts on clients hang, as do new mounts from new clients.
 > Rebooting the server back to rc7 everything recovers.  Bisect lands on
 > this commit.

replacing the return 0 with a warn gets me this:

[   15.127686] WARNING: CPU: 1 PID: 1673 at mm/page_alloc.c:5060 __alloc_pages_bulk+0x6a/0x560
[   15.129286] CPU: 1 PID: 1673 Comm: lockd Not tainted 5.13.0-firewall+ #15
[   15.129290] Hardware name: To be filled by O.E.M. To be filled by O.E.M./Q3XXG4-P, BIOS 5.6.5 06/30/2018
[   15.129292] RIP: 0010:__alloc_pages_bulk+0x6a/0x560
[   15.129301] Code: 00 48 83 38 00 0f 84 69 04 00 00 48 83 c0 08 31 db eb 0f 48 83 c0 08 48 83 78 f8 00 0f 84 72 03 00 00 83 c3 01 41 39 df 75 e9 <0f> 0b 8b 05 0e 71 32 01 8b 6c 24 14 23 2d 10 71 32 01 85 c0 0f 85
[   15.129303] RSP: 0018:ffffb920031e7e10 EFLAGS: 00010246
[   15.129306] RAX: ffff9fff4ef502f0 RBX: 0000000000000004 RCX: 0000000000000004
[   15.129308] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000cc0
[   15.129309] RBP: 0000000000000004 R08: 0000000000000000 R09: ffff9fff4ef502d0
[   15.129311] R10: 0000000000000000 R11: 0000000000000002 R12: ffff9fff42186240
[   15.129312] R13: 7fffffffffffffff R14: 0000000000000004 R15: 0000000000000004
[   15.129317] FS:  0000000000000000(0000) GS:ffffa00057480000(0000) knlGS:0000000000000000
[   15.129319] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   15.129321] CR2: 00007f0bf731c000 CR3: 000000007840b002 CR4: 00000000001706e0
[   15.129323] Call Trace:
[   15.129327]  svc_recv+0x7a/0x820
[   15.129333]  ? __schedule+0x358/0x700
[   15.129338]  ? nlmsvc_retry_blocked+0x1b/0x280
[   15.156135]  ? grace_ender+0x20/0x20
[   15.157546]  lockd+0x83/0x140
[   15.157564]  kthread+0x116/0x140
[   15.157569]  ? __kthread_create_on_node+0x180/0x180
[   15.157574]  ret_from_fork+0x22/0x30
[   15.157579] ---[ end trace 0854dec2f1b25912 ]---


