Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC225388C64
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 13:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346123AbhESLL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 07:11:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:44166 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240482AbhESLLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 07:11:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621422634; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XdXzje8WfXzeezrDAcUDXmoA/xW1OT3HQqZBYc3f9WU=;
        b=lC/LFpTqj9VIQrfUtkdAO0ZEmb4dFq9CWroO3B4O2ug6IrgqNFAJB9YUsiJpj9sDT0ukXR
        FX5u9y8cspaQWrtu+3Rii1yUNPLwL/SosRhLFX+ROjlZcRoYDw4hPcJcEgQ/uITuV7Ln12
        /p5xZx8KNEsqf5Wp3wSirx8nUPb5WpU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 48404AEC6;
        Wed, 19 May 2021 11:10:34 +0000 (UTC)
Date:   Wed, 19 May 2021 13:10:33 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm/page_alloc: try oom if reclaim is unable to make
 forward progress
Message-ID: <YKTyKSDrFZjCS6Wu@dhcp22.suse.cz>
References: <20210315165837.789593-1-atomlin@redhat.com>
 <YFN8wXwJA59w9twA@dhcp22.suse.cz>
 <20210319172901.cror2u53b7caws3a@ava.usersys.com>
 <YFh10eSTKY5lbE9u@dhcp22.suse.cz>
 <20210325210159.r565fvfitoqeuykp@ava.usersys.com>
 <YF2YTNnyzWNHfrEg@dhcp22.suse.cz>
 <20210326112254.jy5jkiwtgj3pqkt2@ava.usersys.com>
 <YF3/YZPd+iz/xGu6@dhcp22.suse.cz>
 <20210518140554.dwan66i4ttmzw4hj@ava.usersys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210518140554.dwan66i4ttmzw4hj@ava.usersys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 18-05-21 15:05:54, Aaron Tomlin wrote:
> Michal,
> 
> On Fri 2021-03-26 16:36 +0100, Michal Hocko wrote:
> > OK, I kinda expected this would be not easily reproducible.
> 
> Unfortunately, I'm still waiting for feedback on this.
> 
> > We should be focusing on the compaction retry logic and see whether we
> > can have some "run away" scenarios there. Seeing so many retries without
> > compaction bailing out sounds like a bug in that retry logic.
> 
> I suspect so.
> 
> This is indeed a case of excessive reclaim/compaction retries (i.e. the
> last known value stored in the no_progress_loops variable was 31,611,688).
> 
> What might be particularly unique about this situation is that a fatal
> signal was found pending. In this context, if I understand correctly, it
> does not make sense to retry compaction when the last known compact result
> was skipped and a fatal signal is pending.

OK, this might be an interesting lead.

> Looking at try_to_compact_pages(), indeed COMPACT_SKIPPED can be returned;
> albeit, not every zone, on the zone list, would be considered in the case
> a fatal signal is found to be pending. Yet, in should_compact_retry(),
> given the last known compaction result, each zone, on the zone list, can be
> considered/or checked (see compaction_zonelist_suitable()). If a zone e.g.
> was found to succeed then reclaim/compaction would be tried again
> (notwithstanding the above).

I believe Vlastimil would be much better fit into looking into those
details but it smells like pending fatal signals can lead to a unbound
retry indeed.

Thanks!

-- 
Michal Hocko
SUSE Labs
