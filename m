Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8F1A3B64C6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 17:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238001AbhF1PPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 11:15:10 -0400
Received: from outbound-smtp44.blacknight.com ([46.22.136.52]:38945 "EHLO
        outbound-smtp44.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234595AbhF1Oxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 10:53:48 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp44.blacknight.com (Postfix) with ESMTPS id 68512F8016
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 15:51:18 +0100 (IST)
Received: (qmail 15563 invoked from network); 28 Jun 2021 14:51:18 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.255])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 28 Jun 2021 14:51:18 -0000
Date:   Mon, 28 Jun 2021 15:51:16 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Mike Galbraith <efault@gmx.de>
Cc:     lkml <linux-kernel@vger.kernel.org>
Subject: Re: v5.13 regression - suspend went belly up
Message-ID: <20210628145116.GB3840@techsingularity.net>
References: <760cf981588a31b9a51fa1f6d485d5dbdc61400a.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <760cf981588a31b9a51fa1f6d485d5dbdc61400a.camel@gmx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2021 at 03:33:42PM +0200, Mike Galbraith wrote:
> Greetings,
> 
> A regression popping up post rc7 is a bit unusual, but hohum, I suppose
> they can bite whenever they damn well feel like it.  This one was
> bisected rc7..release, the (surprising to me) result then confirmed in
> four disgruntled local trees.
> 

Hi Mike, this may be NFS-related fallout given that it appears in the
stack. Can you try this please?

--8<---
mm/page_alloc: Correct return value of populated elements if bulk array is populated

Dave Jones reported the following

	This made it into 5.13 final, and completely breaks NFSD for me
	(Serving tcp v3 mounts).  Existing mounts on clients hang, as do
	new mounts from new clients.  Rebooting the server back to rc7
	everything recovers.

The commit b3b64ebd3822 ("mm/page_alloc: do bulk array bounds check after
checking populated elements") returns the wrong value if the array is
already populated which is interpreted as an allocation failure.

Fixes: b3b64ebd3822 ("mm/page_alloc: do bulk array bounds check after checking populated elements")
Reported-by: Dave Jones <davej@codemonkey.org.uk>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Cc: <stable@vger.kernel.org> [5.13+]
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ef2265f86b91..04220581579c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5058,7 +5058,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 
 	/* Already populated array? */
 	if (unlikely(page_array && nr_pages - nr_populated == 0))
-		return 0;
+		return nr_populated;
 
 	/* Use the single page allocator for one page. */
 	if (nr_pages - nr_populated == 1)
