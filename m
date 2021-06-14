Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4833A5D37
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 08:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbhFNGqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 02:46:25 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51246 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbhFNGqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 02:46:23 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B79D41FD32;
        Mon, 14 Jun 2021 06:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623653060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D20mXPC8ATcQmpUBigVgqbIFb3BvnjpamFiZvCrYA3k=;
        b=CG4bgaW4zRK3woNe103pLi6m58Ce7imgr8UIhkLOMyzj1PO9btNAiXJ4G61QEs4C58eM84
        iOstlRMkWH0O7XuVJhZ5jqxZfLnhL/SrqKJo0TEU+I5QL8310+ucBAtveVkJ0l1J/tke5u
        ejqVTHln6Q0b1aF3A2r8Rpp+UBfG7Ws=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1CE0BA3B83;
        Mon, 14 Jun 2021 06:44:20 +0000 (UTC)
Date:   Mon, 14 Jun 2021 08:44:19 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, vbabka@suse.cz,
        penguin-kernel@i-love.sakura.ne.jp, llong@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/oom_kill: show oom eligibility when displaying the
 current memory state of all tasks
Message-ID: <YMb6w/bGdhJvOy6j@dhcp22.suse.cz>
References: <20210612204634.1102472-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210612204634.1102472-1-atomlin@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 12-06-21 21:46:34, Aaron Tomlin wrote:
> Changes since v2:
>  - Use single character (e.g. 'R' for MMF_OOM_SKIP) as suggested
>    by Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
>  - Add new header to oom_dump_tasks documentation
> 
> 
> At the present time, when showing potential OOM victims, we do not
> exclude tasks which already have MMF_OOM_SKIP set; it is possible that
> the last OOM killable victim was already OOM killed, yet the OOM
> reaper failed to reclaim memory and set MMF_OOM_SKIP.
> This can be confusing/or perhaps even misleading, to the reader of the
> OOM report. Now, we already unconditionally display a task's
> oom_score_adj_min value that can be set to OOM_SCORE_ADJ_MIN which is
> indicative of an "unkillable" task i.e. is not eligible.

Well, I have to say that I have a bit hard time understand the problem
statement here. First of all you are very likely basing your observation
on an old kernel which is missing a fix which should make the situation
impossible IIRC. You should be focusing on a justification why the new
information is helpful for the current tree.

Historically, all tasks eligible for the oom killing have been
printed. That includes also tasks which are excluded later in the
selection. E.g. OOMS_SCORE_ADJ_MIN which can be tricky indeed. IIRC the
primary reason was to have a sufficient amount of information to
evaluate whether the system is configured properly (e.g.
OOMS_SCORE_ADJ_MIN is not used too extensively). More excluded
criterion have been added due to implementation details
(e.g.MMF_OOM_SKIP or mm shared with otherwise ineligible task.

You are correctly pointing out that those internal states are not
exposed but you should focus on explanation why that gap really stands
in the way for the current upstream. Who is going to consume that
information and for what purpose?

> This patch provides a clear indication with regard to the OOM
> eligibility of each displayed task.

This should provide an example of the output with a clarification of the
meaning.

[...]
-- 
Michal Hocko
SUSE Labs
