Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49C364034BE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 09:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240357AbhIHHHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 03:07:55 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:60494 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344672AbhIHHHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 03:07:33 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 884162224B;
        Wed,  8 Sep 2021 07:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631084785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mw56HzEmlO2HCwIOHnTkhLtTlF65Hy4hZno8P/WeBwI=;
        b=mbI22tYI0wGZWVloc0Kx0Bxw+mkkGgFP4qO+bZO7FM3fbYSk+CO3JtOE2EFDI8He4kYR7C
        YJRds1fTOa2lxvXKMuKSfd8a15/FtxstdXCVM31RYKt/JF39Z0rqXTEcTJpB33THUpr+CA
        fzFolNXMadGyFINPdju+s41YjRVewXQ=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 50883A3B96;
        Wed,  8 Sep 2021 07:06:25 +0000 (UTC)
Date:   Wed, 8 Sep 2021 09:06:24 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: detect allocation forbidden by cpuset and
 bail out early
Message-ID: <YThg8Mp42b194k0/@dhcp22.suse.cz>
References: <1631003150-96935-1-git-send-email-feng.tang@intel.com>
 <YTcmcEUmtO++WeBk@dhcp22.suse.cz>
 <20210908015014.GA28091@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210908015014.GA28091@shbuild999.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 08-09-21 09:50:14, Feng Tang wrote:
> On Tue, Sep 07, 2021 at 10:44:32AM +0200, Michal Hocko wrote:
[...]
> > While this is a good fix from the functionality POV I believe you can go
> > a step further. Please add a detection to the cpuset code and complain
> > to the kernel log if somebody tries to configure movable only cpuset.
> > Once you have that in place you can easily create a static branch for
> > cpuset_insane_setup() and have zero overhead for all reasonable
> > configuration. There shouldn't be any reason to pay a single cpu cycle
> > to check for something that almost nobody does.
> > 
> > What do you think?
> 
> I thought about the implementation, IIUC, the static_branch_enable() is
> easy, it could be done when cpuset.mems is set with movable only nodes,
> but disable() is much complexer,

Do we care about disable at all? The point is to not have 99,999999%
users pay overhead of the check which is irrelevant to them. Once
somebody wants to use this "creative" setup then paying an extra check
sounds perfectly sensible to me. If somebody cares enough then the
disable logic could be implemented. But for now I believe we should be
OK with only enable case.

> as we may need a global reference
> counter to track the set/unset, and the unset could be the time when
> freeing the cpuset data structure, also one cpuset.mems could be changed
> runtime, and system could have multiple cpuset dirs (user space usage
> could be creative or crazy :)).
> 
> While checking cpuset code, I thought more about configuring cpuset with
> movable only nodes, that we may still have normal usage: mallocing a big
> trunk of memory and do some scientific calculation, or AI training. It
> works with current code.

It might work but it would be inherently subtle because a single
non-movable allocation will throw the whole thing off the cliff.
I do not think we want to even pretend we support such a setup.
-- 
Michal Hocko
SUSE Labs
