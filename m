Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2489C39FC37
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 18:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbhFHQT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 12:19:26 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:46354 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbhFHQTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 12:19:21 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3EFFF1FD33;
        Tue,  8 Jun 2021 16:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623169047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gi8XCTYoavMm87bNCuOv2uvqUg6h/75nK0TzemGzaj8=;
        b=e8p9f0vstQUoeVxfIg4N5nt8NmysE+kFUj4CTZtHPu5RKJDqWxzzwtwxa3LlSVjbf86Vp0
        gPMv0eAkmM4/HqdfUHsZLtqM+DKYI534IubzVOzQNcH8mPDMZ5DXPBd0lzHXAoneO5TSIz
        Ac2gekzihAmN6m4TRxXc/yqJiJbt+OU=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A37EBA3B85;
        Tue,  8 Jun 2021 16:17:26 +0000 (UTC)
Date:   Tue, 8 Jun 2021 18:17:25 +0200
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
Message-ID: <YL+YFbiAsj77iqhq@dhcp22.suse.cz>
References: <dc7f54eb-933e-5bbb-7959-815dfbfcc836@redhat.com>
 <YL5tqdw+iWLLavxV@dhcp22.suse.cz>
 <6d23ce58-4c4b-116a-6d74-c2cf4947492b@redhat.com>
 <YL51Tp/3jVHUrpuj@dhcp22.suse.cz>
 <YL57rLFwAo7EpYeH@dhcp22.suse.cz>
 <353d012f-e8d4-c54c-b33e-54737e1a0115@redhat.com>
 <YL8MjSteKeO7w0il@dhcp22.suse.cz>
 <20210608100022.pzuwa6aiiffnoikx@ava.usersys.com>
 <YL93eXFZodiCM509@dhcp22.suse.cz>
 <931bbf2e-19e3-c598-c244-ae5e7d00dfb0@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <931bbf2e-19e3-c598-c244-ae5e7d00dfb0@i-love.sakura.ne.jp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 09-06-21 00:22:13, Tetsuo Handa wrote:
> On 2021/06/08 22:58, Michal Hocko wrote:
> > I do not see this message to be ever printed on 4.18 for memcg oom:
> >         /* Found nothing?!?! Either we hang forever, or we panic. */
> >         if (!oc->chosen && !is_sysrq_oom(oc) && !is_memcg_oom(oc)) {
> >                 dump_header(oc, NULL);
> >                 panic("Out of memory and no killable processes...\n");
> >         }
> > 
> > So how come it got triggered here? Is it possible that there is a global
> > oom killer somehow going on along with the memcg OOM? Because the below
> > stack clearly points to a memcg OOM and a new one AFAICS.
> 
> 4.18 does print this message, and panic() will be called if global OOM
> killer invocation were in progress. 
> 
> 4.18.0-193.51.1.el8.x86_64 is doing
> 
> ----------
>         select_bad_process(oc);
>         /* Found nothing?!?! */
>         if (!oc->chosen) {
>                 dump_header(oc, NULL);
>                 pr_warn("Out of memory and no killable processes...\n");
>                 /*
>                  * If we got here due to an actual allocation at the
>                  * system level, we cannot survive this and will enter
>                  * an endless loop in the allocator. Bail out now.
>                  */
>                 if (!is_sysrq_oom(oc) && !is_memcg_oom(oc))
>                         panic("System is deadlocked on memory\n");
>         }
> ----------

Ahh, OK. That would explain that. I have looked at 4.18 Vanilla kernel.
I do not have RHEL sources handy and neither checked the 4.18 stable
tree. Thanks for the clarification!
 
[...]
> Since dump_tasks() from dump_header(oc, NULL) does not exclude tasks
> which already has MMF_OOM_SKIP set, it is possible that the last OOM
> killable victim was already OOM killed but the OOM reaper failed to reclaim
> memory and set MMF_OOM_SKIP. (Well, maybe we want to exclude (or annotate)
> MMF_OOM_SKIP tasks when showing OOM victim candidates...)

Well, the allocating task was clearly alive and whether it has been
reaped or not is not all that important as it should force the charge as
an oom victim. This is actually the most puzzling part. Because the
allocating task either is not a preexisting OOM victim and therefore
could become one or it has been and should have skipped the memcg killer
altogether. But I fail to see how it could be missed completely while
looking for a victim.
-- 
Michal Hocko
SUSE Labs
