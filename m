Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7FEA406AEE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 13:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbhIJLpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 07:45:12 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:36828 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbhIJLpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 07:45:11 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8A1A92005C;
        Fri, 10 Sep 2021 11:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631274239; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w86BLDTkoihpTkMV+bmcVu+5NgKjI1pW8yCMRIcNiRk=;
        b=aEmdav0TlL1DhoCmFgKBUDEb9LdZuGAI7g1zjKNtqSQ2Dhefhfx68Ix3YOXahsgN8qiAYj
        05XfYluXf3avyedy+S9Yw8KKgj+x5AffZ6aNc7w1EKMR2kRfxVcrmIJ0vxXWozNBx24//m
        A3s5B9RwfBY0x3U76Iyr7zMkHrtAPZg=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E2A8FA3BAB;
        Fri, 10 Sep 2021 11:43:58 +0000 (UTC)
Date:   Fri, 10 Sep 2021 13:43:55 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: detect allocation forbidden by cpuset and
 bail out early
Message-ID: <YTtE+/w1I/6uj70f@dhcp22.suse.cz>
References: <1631003150-96935-1-git-send-email-feng.tang@intel.com>
 <YTcmcEUmtO++WeBk@dhcp22.suse.cz>
 <20210908015014.GA28091@shbuild999.sh.intel.com>
 <YThg8Mp42b194k0/@dhcp22.suse.cz>
 <20210910074400.GA18707@shbuild999.sh.intel.com>
 <YTsYxbMhGIunUPZr@dhcp22.suse.cz>
 <20210910092132.GA54659@shbuild999.sh.intel.com>
 <YTs01sPa5MojLGqO@dhcp22.suse.cz>
 <20210910112953.GB54659@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910112953.GB54659@shbuild999.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 10-09-21 19:29:53, Feng Tang wrote:
[...]
> > Sorry I didn't really get to read this previously. The implementation
> > works but I find it harder to read than really necessary. Why don't you
> > use first_zones_zonelist here as well?
> 
> The concern I had was which zonelist to use, local node or the first node
> of nodemask's node_zonelists[ZONELIST_FALLBACK],

I am not sure I see your concern. Either of the two should work just
fine because all nodes should be reachable from the zonelist. But why
don't you simply do the same kind of check as in the page allocator?
-- 
Michal Hocko
SUSE Labs
