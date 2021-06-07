Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60F9739E7B9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 21:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhFGTtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 15:49:13 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51612 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbhFGTtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 15:49:11 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3F5C4219BF;
        Mon,  7 Jun 2021 19:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623095239; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TOi1KB6lja6UnRpVQU3eb/l3MsV0mm06Av/9CJInWhg=;
        b=C08xuK/sEVIO8LHSIswJfmSbcS1WZIAMfmXpqBDcdBran4ge0viWHfL5V1uyd0cIrySnq1
        Yckx2wMALbD8ik54qxJ/P8mZNEqw15I4e7FRN03PEG03RLC6ILqk761L/juXisuG84yHNl
        w/IfcoJ5kagufdP4l3tZ5f2F2lE2oyc=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EFA5AA3BD2;
        Mon,  7 Jun 2021 19:47:18 +0000 (UTC)
Date:   Mon, 7 Jun 2021 21:47:17 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Waiman Long <llong@redhat.com>
Cc:     Aaron Tomlin <atomlin@redhat.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, vbabka@suse.cz,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm/oom_kill: allow oom kill allocating task for
 non-global case
Message-ID: <YL53xd0wYBlECPvt@dhcp22.suse.cz>
References: <20210607163103.632681-1-atomlin@redhat.com>
 <YL5tBQ3utMzUkHF3@dhcp22.suse.cz>
 <8a6b57d1-b8dd-bf67-92c8-0421623f54ea@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a6b57d1-b8dd-bf67-92c8-0421623f54ea@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 07-06-21 15:26:00, Waiman Long wrote:
> On 6/7/21 3:01 PM, Michal Hocko wrote:
> > On Mon 07-06-21 17:31:03, Aaron Tomlin wrote:
> > > At the present time, in the context of memcg OOM, even when
> > > sysctl_oom_kill_allocating_task is enabled/or set, the "allocating"
> > > task cannot be selected, as a target for the OOM killer.
> > > 
> > > This patch removes the restriction entirely.
> > This is a global oom policy not a memcg specific one so a historical
> > behavior would change. So I do not think we can change that. The policy
> > can be implemented on the memcg level but this would require a much more
> > detailed explanation of the usecase and the semantic (e.g. wrt.
> > hierarchical behavior etc).
> 
> Maybe we can extend the meaning of oom_kill_allocating_task such that memcg
> OOM killing of allocating task is only enabled when bit 1 is set. So if an
> existing application just set oom_kill_allocating_task to 1, it will not be
> impacted.

panic_on_oom is already allowing to implement originally global policy
to memcg. So if anything this policy should follow the same interface
but still I think what you are seeing is either a bug or something else
(e.g. the task being migrated while the oom is ongoing) and this should
be properly investigated and explained. We cannot simply paper it over
by telling people to use oom_kill_allocating_task to work it around.

If there is a real usecase for such a policy for memcg oom killing can
be discussed of course.
-- 
Michal Hocko
SUSE Labs
