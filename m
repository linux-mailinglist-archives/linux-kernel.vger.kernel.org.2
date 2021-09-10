Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B03D406844
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 10:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbhIJIVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 04:21:48 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55932 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbhIJIVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 04:21:44 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 29ECA1FE4F;
        Fri, 10 Sep 2021 08:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631262032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PCgoRtxzRnF5bEJGYpSj0uCPTAjsJVEopC7CNDwuFzg=;
        b=KnynwVh/0g7vmefyAevVI0TF4SGClQqLZxh2Tt5/o6kS8JEyNjSqdQMW1lRQkmiD4EkOaE
        NOz2rjuisn2BilcPaKv5pMjFNO9P2WUbJGJvBWY2riLabWVRdAwgaUPvwoG5yCUMUAwu1D
        2JwHxMBODtR6CxWjaU+s6kv42V4yr7E=
Received: from suse.cz (tiehlicka.dhcp.prg.suse.com [10.156.228.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DEE06A3B99;
        Fri, 10 Sep 2021 08:20:31 +0000 (UTC)
Date:   Fri, 10 Sep 2021 10:20:31 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Hillf Danton <hdanton@sina.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 0/8] hugetlb: add demote/split page functionality
Message-ID: <YTsVT74kAgpAD17s@dhcp22.suse.cz>
References: <20210816184611.07b97f4c26b83090f5d48fab@linux-foundation.org>
 <10d86c18-f0cf-395f-4209-17ac71b9fc03@oracle.com>
 <efcf6049-6110-d516-b21f-41bb8775f042@suse.cz>
 <2d826470-d345-0196-1359-b79ed08dfc66@oracle.com>
 <b3b334ea-0e6f-ced9-e444-df4ec49455a0@suse.cz>
 <02a1a50f-4e7c-4eb7-519c-35b26ec2c6af@oracle.com>
 <20210907085001.3773-1-hdanton@sina.com>
 <6c42bed7-d4dd-e5eb-5a74-24cf64bf52d3@oracle.com>
 <YTn196em42sDsXs+@dhcp22.suse.cz>
 <71f855ac-ff61-1eed-454f-909c0e4210b2@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71f855ac-ff61-1eed-454f-909c0e4210b2@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 09-09-21 15:45:45, Vlastimil Babka wrote:
> On 9/9/21 13:54, Michal Hocko wrote:
> > On Wed 08-09-21 14:00:19, Mike Kravetz wrote:
> >> On 9/7/21 1:50 AM, Hillf Danton wrote:
> >> > On Mon, 6 Sep 2021 16:40:28 +0200 Vlastimil Babka wrote:
> >> > 
> >> > And/or clamp reclaim retries for costly orders
> >> > 
> >> > 	reclaim retries = MAX_RECLAIM_RETRIES - order;
> >> > 
> >> > to pull down the chance for stall as low as possible.
> >> 
> >> Thanks, and sorry for not replying quickly.  I only get back to this as
> >> time allows.
> >> 
> >> We could clamp the number of compaction and reclaim retries in
> >> __alloc_pages_slowpath as suggested.  However, I noticed that a single
> >> reclaim call could take a bunch of time.  As a result, I instrumented
> >> shrink_node to see what might be happening.  Here is some information
> >> from a long stall.  Note that I only dump stats when jiffies > 100000.
> >> 
> >> [ 8136.874706] shrink_node: 507654 total jiffies,  3557110 tries
> >> [ 8136.881130]              130596341 reclaimed, 32 nr_to_reclaim
> >> [ 8136.887643]              compaction_suitable results:
> >> [ 8136.893276]     idx COMPACT_SKIPPED, 3557109
> > 
> > Can you get a more detailed break down of where the time is spent. Also
> > How come the number of reclaimed pages is so excessive comparing to the
> > reclaim target? There is something fishy going on here.
> 
> I would say it's simply should_continue_reclaim() behaving similarly to
> should_compact_retry(). We'll get compaction_suitable() returning
> COMPACT_SKIPPED because the reclaimed pages have been immediately stolen,
> and compaction indicates there's not enough base pages to begin with to form
> a high-order pages. Since the stolen pages will appear on inactive lru, it
> seems to be worth continuing reclaim to make enough free base pages for
> compaction to no longer be skipped, because "inactive_lru_pages >
> pages_for_compaction" is true.
> 
> So, both should_continue_reclaim() and should_compact_retry() are unable to
> recognize that reclaimed pages are being stolen and limit the retries in
> that case. The scenario seems to be uncommon, otherwise we'd be getting more
> reports of that.

Thanks this sounds like a viable explanation. For some reason I have
thought that a single reclaim round can take that much time but reading
again it seems like a cumulative thing.

I do agree that we should consider the above scenario when bailing out.
It is simply unreasonable to reclaim so much memory without any forward
progress.

A more robust way to address this problem (which is not really new)
would be to privatize reclaimed pages in the direct reclaim context and
reuse them in the compaction so that it doesn't have to just
pro-actively reclaim to keep watermarks good enough. A normal low order
requests would benefit from that as well because the reclaim couldn't be
stolen from them as well.

Another approach would be to detect the situation and treat reclaim
success which immediatelly leads to compaction deferral due to
watermarks as a failure.

-- 
Michal Hocko
SUSE Labs
