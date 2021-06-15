Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8FAC3A7E59
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 14:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhFOMow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 08:44:52 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45472 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbhFOMov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 08:44:51 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id AF15E2196D;
        Tue, 15 Jun 2021 12:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623760966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kELEEW1qxH+m+4Qkk9qF9CMOJ122ywI9/XKYVjKrTEg=;
        b=c3wl8qqyIzbHlNZr5z7xQeShk/RlgWnN3E49KpRGUYDTYDerKY3Vm4d4cu/tQcKyC1WslA
        cLIV5xfr7MrBDKGm0/Ga2nJ0S52p/Z80i3LMBiTy0V7rY9gmP6uuvBS5BshqFdm36CFsyr
        iRC2H7OK+z7hNExX0czxrgMpVnTYMcg=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 340E8A3B89;
        Tue, 15 Jun 2021 12:42:46 +0000 (UTC)
Date:   Tue, 15 Jun 2021 14:42:35 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, vbabka@suse.cz,
        penguin-kernel@i-love.sakura.ne.jp, llong@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/oom_kill: show oom eligibility when displaying the
 current memory state of all tasks
Message-ID: <YMigO5N55QhnrB87@dhcp22.suse.cz>
References: <20210612204634.1102472-1-atomlin@redhat.com>
 <YMb6w/bGdhJvOy6j@dhcp22.suse.cz>
 <20210615115147.gp3w5bcjoaarvyse@ava.usersys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210615115147.gp3w5bcjoaarvyse@ava.usersys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 15-06-21 12:51:47, Aaron Tomlin wrote:
> On Mon 2021-06-14 08:44 +0200, Michal Hocko wrote:
> > Well, I have to say that I have a bit hard time understand the problem
> > statement here. First of all you are very likely basing your observation
> > on an old kernel which is missing a fix which should make the situation
> > impossible IIRC. You should be focusing on a justification why the new
> > information is helpful for the current tree.
> 
> Michal,
> 
> Not exactly.
> 
> See oom_reap_task(). Let's assume an OOM event occurred within the context
> of a memcg and 'memory.oom.group' was not set. If I understand correctly,
> once all attempts to OOM reap the specified task were "unsuccessful" then
> MMF_OOM_SKIP is applied; and, the assumption is it will be terminated
> shorty due to the pending fatal signal (see __oom_kill_process()) i.e. a
> SIGKILL is sent to the "victim" before the OOM reaper is notified. Now
> assuming the above task did not exited yet, another task, in the same
> memcg, could also trigger an OOM event.  Therefore, when showing potential
> OOM victims the task above with MMF_OOM_SKIP set, will indeed be displayed.
> 
> I understanding the point on OOM_SCORE_ADJ_MIN. This can be easily
> identified and is clear to the viewer. However, the same cannot be stated
> for MMF_OOM_SKIP.

This is all true but it is not really clear why that is really a
problem. Kernel log already contains information about reaped processes
as they are reported to the log. I fully acknowledge that this is rather
spartan but on the other hand from years of experience reading oom
reports I have to say the dump_tasks is the least interesting part of
the report (while being the most verbose one).

All that being said, I am not really opposing extending the information
although I am a bit worried about leaking too much internal state to the
log. What I am asking for here is a justification why this addition is a
general improvement and how it helps uderstanding oom reports further.
So please focus on that part.
-- 
Michal Hocko
SUSE Labs
