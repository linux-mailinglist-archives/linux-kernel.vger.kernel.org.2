Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AACB33A3C62
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 08:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhFKG5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 02:57:47 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:34258 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhFKG5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 02:57:45 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2E1631FD3F;
        Fri, 11 Jun 2021 06:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623394547; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N2XJlMbDzn+ePfxRClY3gO0FkSnDmd58pgVQ6MHl3tc=;
        b=PCAPx+BwqsoG/XE8TBDIzCqULGdJAN2G7SFwSw8L9QIyY4yJlSK+MQ7MjNVvOm3X5Fisy8
        GEPQ6bBMT1RAY99VdFqGe5HvS2k9xcZ+5UzLuAspyJ9l6JTntkWJaoDcdCoLpugh4qQ5qk
        mw6LSSH4Htk4HULGkTvBSvGIg8yj6hw=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4953AA3B87;
        Fri, 11 Jun 2021 06:55:46 +0000 (UTC)
Date:   Fri, 11 Jun 2021 08:55:45 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Aaron Tomlin <atomlin@redhat.com>, Waiman Long <llong@redhat.com>,
        Shakeel Butt <shakeelb@google.com>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] mm/oom_kill: allow oom kill allocating task for
 non-global case
Message-ID: <YMMI8R3rlH0Foyq3@dhcp22.suse.cz>
References: <YL51Tp/3jVHUrpuj@dhcp22.suse.cz>
 <YL57rLFwAo7EpYeH@dhcp22.suse.cz>
 <353d012f-e8d4-c54c-b33e-54737e1a0115@redhat.com>
 <YL8MjSteKeO7w0il@dhcp22.suse.cz>
 <20210609143534.v65qknfihqimiivd@ava.usersys.com>
 <YMHivM+0DRYXzAD0@dhcp22.suse.cz>
 <20210610122323.6geriip66jjmdstj@ava.usersys.com>
 <YMII3OMPoZPuCe0r@dhcp22.suse.cz>
 <20210610133644.zpoqfvlchaey24za@ava.usersys.com>
 <c205367d-f47e-61f3-3aed-fd8142a0010f@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c205367d-f47e-61f3-3aed-fd8142a0010f@i-love.sakura.ne.jp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 10-06-21 23:06:47, Tetsuo Handa wrote:
> On 2021/06/10 22:36, Aaron Tomlin wrote:
> > On Thu 2021-06-10 14:43 +0200, Michal Hocko wrote:
> >> Well, I am not sure this is a good thing in general. We do not want to
> >> hide tasks. We already do display oom_score_adj_min even though they are
> >> not eligible and that can serve a good purpose from my experience. It
> >> gives us some picture at least. Maybe a flag to mark all uneligible
> >> tasks would be something useful but I wouldn't drop them from the list.
> > 
> > Fair enough.
> 
> Yes, marking ineligible (i.e. oom_badness() returning LONG_MIN) tasks would be useful.
> 
> By the way, was the task namely "node" (i.e. PID 1703345) multithreaded program?
> Your kernel might want commit 7775face207922ea ("memcg: killed threads should not invoke memcg OOM killer").

Yes, this would help for multithreaded race situation indeed. Thanks!

-- 
Michal Hocko
SUSE Labs
