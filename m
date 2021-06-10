Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9592B3A28E2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 12:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbhFJKC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 06:02:27 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:34558 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbhFJKC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 06:02:26 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9D32821977;
        Thu, 10 Jun 2021 10:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623319229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gBT9cBgbszfObFIQ+8NIrK4HBkhGamQu4yAv7aPuVzY=;
        b=Gx6x0mZzJsfX3FYBsXYisQfsQH0SIYsRFnudqF7jRkxpigDpihwrMraMM5uqYsGomnF8w7
        y7zCxya3ICuueI/V/J7bm0sMoq/QP6MBMwS/TNrAvjU6ixlKBw9Q6zsDyRCISPcxjmvFsd
        zfH4ZpG1KwdzjD00KAMDLii9ogCrQ5o=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 56CD5A3B84;
        Thu, 10 Jun 2021 10:00:29 +0000 (UTC)
Date:   Thu, 10 Jun 2021 12:00:28 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     Waiman Long <llong@redhat.com>, Shakeel Butt <shakeelb@google.com>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] mm/oom_kill: allow oom kill allocating task for
 non-global case
Message-ID: <YMHivM+0DRYXzAD0@dhcp22.suse.cz>
References: <c16893a9-35e2-7625-d7f3-83488f874040@redhat.com>
 <CALvZod4eUoquGTQ5AsWgbWTQyqtCNNwb-9+fRw_ZPavH-r9dbA@mail.gmail.com>
 <dc7f54eb-933e-5bbb-7959-815dfbfcc836@redhat.com>
 <YL5tqdw+iWLLavxV@dhcp22.suse.cz>
 <6d23ce58-4c4b-116a-6d74-c2cf4947492b@redhat.com>
 <YL51Tp/3jVHUrpuj@dhcp22.suse.cz>
 <YL57rLFwAo7EpYeH@dhcp22.suse.cz>
 <353d012f-e8d4-c54c-b33e-54737e1a0115@redhat.com>
 <YL8MjSteKeO7w0il@dhcp22.suse.cz>
 <20210609143534.v65qknfihqimiivd@ava.usersys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609143534.v65qknfihqimiivd@ava.usersys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 09-06-21 15:35:34, Aaron Tomlin wrote:
> On Tue 2021-06-08 08:22 +0200, Michal Hocko wrote:
> > Is it possible the only eligible task has been killed and oom reaped
> > already?
> 
> Yes, I suspect so; and I had a look at the vmcore, the task in the OOM
> report is no longer present. Therefore, I suspect the task namely "node"
> (i.e. PID 1703345) was OOM killed i.e. a SIGKILL was sent and was granted
> access to memory reserves and selected/or choosen by the OOM reaper for
> termination; the victim then raised a page fault that triggered yet
> another "charge" in the memcg that exceeded the memory limit set on the
> container;

If that was the case then the allocating (charging) task would not hit
the oom path at all
stable/linux-4.18.y:mm/memcontrol.c
try_charge()
        /*
         * Unlike in global OOM situations, memcg is not in a physical
         * memory shortage.  Allow dying and OOM-killed tasks to
         * bypass the last charges so that they can exit quickly and
         * free their memory.
         */
        if (unlikely(tsk_is_oom_victim(current) ||
                     fatal_signal_pending(current) ||
                     current->flags & PF_EXITING))
                goto force;

If you have a crash dump available then you can check the memcg
associate with the allocating task and check whether it is really marked
as OOM victim.

> and since no other task in the memcg had a suitable OOM score
> and the allocating task/or victim was "unkillable" i.e. already selected
> for termination by the OOM reaper, we got the message: "Out of memory and
> no killable processes...".

What do you mean by allocating task being unkillable?

-- 
Michal Hocko
SUSE Labs
