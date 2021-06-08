Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF3C139F83D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 15:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbhFHOAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 10:00:12 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57406 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232797AbhFHOAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 10:00:12 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5A90D1FD2A;
        Tue,  8 Jun 2021 13:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623160698; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3eQcJU82pP5ycYh4pXk4zYpBiluail9LWdG6tOqrsbk=;
        b=tkeLvhYC+AR5T7NP+R3G7NGdVmV695Y/tz2aFQgfuvTobXvsZIDOHAne0RtdOMWe3XDeqR
        jjesP2KTgQlzCdbfBuTCbIkqjquSc4mA+JLFhbfqSHTIinZVF4ogSCzTb9LfNixikDBPkr
        2tpSs/hP4r0RUTqhd0+RNAa6T95YF+I=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 27495A3B83;
        Tue,  8 Jun 2021 13:58:18 +0000 (UTC)
Date:   Tue, 8 Jun 2021 15:58:17 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     Waiman Long <llong@redhat.com>, Shakeel Butt <shakeelb@google.com>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] mm/oom_kill: allow oom kill allocating task for
 non-global case
Message-ID: <YL93eXFZodiCM509@dhcp22.suse.cz>
References: <c16893a9-35e2-7625-d7f3-83488f874040@redhat.com>
 <CALvZod4eUoquGTQ5AsWgbWTQyqtCNNwb-9+fRw_ZPavH-r9dbA@mail.gmail.com>
 <dc7f54eb-933e-5bbb-7959-815dfbfcc836@redhat.com>
 <YL5tqdw+iWLLavxV@dhcp22.suse.cz>
 <6d23ce58-4c4b-116a-6d74-c2cf4947492b@redhat.com>
 <YL51Tp/3jVHUrpuj@dhcp22.suse.cz>
 <YL57rLFwAo7EpYeH@dhcp22.suse.cz>
 <353d012f-e8d4-c54c-b33e-54737e1a0115@redhat.com>
 <YL8MjSteKeO7w0il@dhcp22.suse.cz>
 <20210608100022.pzuwa6aiiffnoikx@ava.usersys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210608100022.pzuwa6aiiffnoikx@ava.usersys.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 08-06-21 11:00:22, Aaron Tomlin wrote:
> On Tue 2021-06-08 08:22 +0200, Michal Hocko wrote:
> > OK. A full report (including the backtrace) would tell us more what is
> > the source of the charge. I thought that most #PF charging paths use the
> > same gfp mask as the allocation (which would include other flags on top
> > of GFP_KERNEL) but it seems we just use GFP_KERNEL at many places.
> 
> The following is what I can provide for now:
> 
Let me add what we have from previous email

> [ 8221.433608] memory: usage 21280kB, limit 204800kB, failcnt 49116
>   :
> [ 8227.239769] [ pid ]   uid  tgid total_vm      rss pgtables_bytes swapents  oom_score_adj name
> [ 8227.242495] [1611298]     0 1611298    35869      635 167936        0         -1000 conmon
> [ 8227.242518] [1702509]     0 1702509    35869      701 176128        0         -1000 conmon
> [ 8227.242522] [1703345] 1001050000 1703294   183440        0 2125824        0           999 node
> [ 8227.242706] Out of memory and no killable processes...

I do not see this message to be ever printed on 4.18 for memcg oom:
        /* Found nothing?!?! Either we hang forever, or we panic. */
        if (!oc->chosen && !is_sysrq_oom(oc) && !is_memcg_oom(oc)) {
                dump_header(oc, NULL);
                panic("Out of memory and no killable processes...\n");
        }

So how come it got triggered here? Is it possible that there is a global
oom killer somehow going on along with the memcg OOM? Because the below
stack clearly points to a memcg OOM and a new one AFAICS.

That being said, a full chain of oom events would be definitely useful
to get a better idea.

> [ 8227.242731] node invoked oom-killer: gfp_mask=0x6000c0(GFP_KERNEL), nodemask=(null), order=0, oom_score_adj=999
> [ 8227.242732] node cpuset=XXXX mems_allowed=0-1
> [ 8227.242736] CPU: 12 PID: 1703347 Comm: node Kdump: loaded Not tainted 4.18.0-193.51.1.el8_2.x86_64 #1
> [ 8227.242737] Hardware name: XXXX
> [ 8227.242738] Call Trace:
> [ 8227.242746]  dump_stack+0x5c/0x80
> [ 8227.242751]  dump_header+0x6e/0x27a
> [ 8227.242753]  out_of_memory.cold.31+0x39/0x8d
> [ 8227.242756]  mem_cgroup_out_of_memory+0x49/0x80
> [ 8227.242758]  try_charge+0x58c/0x780
> [ 8227.242761]  ? __alloc_pages_nodemask+0xef/0x280
> [ 8227.242763]  mem_cgroup_try_charge+0x8b/0x1a0
> [ 8227.242764]  mem_cgroup_try_charge_delay+0x1c/0x40
> [ 8227.242767]  do_anonymous_page+0xb5/0x360
> [ 8227.242770]  ? __switch_to_asm+0x35/0x70
> [ 8227.242772]  __handle_mm_fault+0x662/0x6a0
> [ 8227.242774]  handle_mm_fault+0xda/0x200
> [ 8227.242778]  __do_page_fault+0x22d/0x4e0
> [ 8227.242780]  do_page_fault+0x32/0x110
> [ 8227.242782]  ? page_fault+0x8/0x30
> [ 8227.242783]  page_fault+0x1e/0x30
> 
> -- 
> Aaron Tomlin

-- 
Michal Hocko
SUSE Labs
