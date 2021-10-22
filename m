Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5A174377D2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 15:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbhJVNT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 09:19:58 -0400
Received: from outbound-smtp29.blacknight.com ([81.17.249.32]:47418 "EHLO
        outbound-smtp29.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230342AbhJVNTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 09:19:52 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp29.blacknight.com (Postfix) with ESMTPS id 456C018E11B
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 14:17:34 +0100 (IST)
Received: (qmail 6329 invoked from network); 22 Oct 2021 13:17:34 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 22 Oct 2021 13:17:34 -0000
Date:   Fri, 22 Oct 2021 14:17:32 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     NeilBrown <neilb@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux-MM <linux-mm@kvack.org>,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/8] Remove dependency on congestion_wait in mm/
Message-ID: <20211022131732.GK3959@techsingularity.net>
References: <20211019090108.25501-1-mgorman@techsingularity.net>
 <163486531001.17149.13533181049212473096@noble.neil.brown.name>
 <20211022083927.GI3959@techsingularity.net>
 <163490199006.17149.17259708448207042563@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <163490199006.17149.17259708448207042563@noble.neil.brown.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 10:26:30PM +1100, NeilBrown wrote:
> On Fri, 22 Oct 2021, Mel Gorman wrote:
> > On Fri, Oct 22, 2021 at 12:15:10PM +1100, NeilBrown wrote:
> > 
> > > In general, I still don't like the use of wake_up_all(), though it won't
> > > cause incorrect behaviour.
> > > 
> > 
> > Removing wake_up_all would be tricky.
> 
> I think there is a misunderstanding.  Removing wake_up_all() is as
> simple as
>    s/wake_up_all/wake_up/
> 
> If you used prepare_to_wait_exclusive(), then wake_up() would only wake
> one waiter, while wake_up_all() would wake all of them.
> As you use prepare_to_wait(), wake_up() will wake all waiters - as will
> wake_up_all(). 
> 

Ok, yes, there was a misunderstanding. I thought you were suggesting a
move to exclusive wakeups. I felt that the wake_up_all was explicit in
terms of intent and that I really meant for all tasks to wake instead of
one at a time.

-- 
Mel Gorman
SUSE Labs
