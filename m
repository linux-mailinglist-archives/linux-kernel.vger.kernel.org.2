Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52653B65DA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 17:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235021AbhF1PlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 11:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237174AbhF1PjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 11:39:20 -0400
Received: from scorn.kernelslacker.org (scorn.kernelslacker.org [IPv6:2600:3c03:e000:2fb::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3969FC061D7C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 07:48:13 -0700 (PDT)
Received: from [2601:196:4600:6634:ae9e:17ff:feb7:72ca] (helo=wopr.kernelslacker.org)
        by scorn.kernelslacker.org with esmtp (Exim 4.92)
        (envelope-from <davej@codemonkey.org.uk>)
        id 1lxsYQ-0000KC-9i; Mon, 28 Jun 2021 10:48:06 -0400
Received: by wopr.kernelslacker.org (Postfix, from userid 1026)
        id D320F560148; Mon, 28 Jun 2021 10:48:05 -0400 (EDT)
Date:   Mon, 28 Jun 2021 10:48:05 -0400
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
Message-ID: <20210628144805.GA3687@codemonkey.org.uk>
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
 <20210628115322.GA3840@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628115322.GA3840@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Note: SpamAssassin invocation failed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2021 at 12:53:23PM +0100, Mel Gorman wrote:

 > > This made it into 5.13 final, and completely breaks NFSD for me (Serving tcp v3 mounts).
 > > Existing mounts on clients hang, as do new mounts from new clients.
 > > Rebooting the server back to rc7 everything recovers.  Bisect lands on
 > > this commit.
 > 
 > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
 > index ef2265f86b91..04220581579c 100644
 > --- a/mm/page_alloc.c
 > +++ b/mm/page_alloc.c
 > @@ -5058,7 +5058,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 >  
 >  	/* Already populated array? */
 >  	if (unlikely(page_array && nr_pages - nr_populated == 0))
 > -		return 0;
 > +		return nr_populated;

Yep, this works.

	Dave

