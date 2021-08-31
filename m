Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA9B53FCBBD
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 18:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234473AbhHaQqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 12:46:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59834 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbhHaQqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 12:46:44 -0400
Date:   Tue, 31 Aug 2021 18:45:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630428347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sX7Zw+ZUCacC/y/LNFBhiLk3ZXMEzCI8sqh1jqKDVxc=;
        b=CjL0Asvk0JJ10+dZ2Lbf3cxLSgj1WWTDwNQzZL6fh/gPOsdLV/q53bU8vJi2Amj50gyg9d
        1Zy0Uz9bp9gcYTpS2JAlZwTi3How00cYBojJXPr0bWaU0ZyCHM60ugIg0W3B7ya3zeie08
        iVk838f6pEyGq3tHkdRe3RBPkDNgLc+r0OXqny2NaQjEd6JbwTU2XgIF8K+gaN0jP+ODkk
        jUH3h+XEn4/vLqblmfomUdIoz7h2ob8N93SYl4OBg7es4KVtNZI+xfQBo1Zk548+BbyqTx
        Mv+olOW3RJHShaFjS3WGdlO+cJY0fgWFkmOScDrZU9uwZVyd/8SLis3r0sdPhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630428347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sX7Zw+ZUCacC/y/LNFBhiLk3ZXMEzCI8sqh1jqKDVxc=;
        b=2Dgqcz+bbby1U2tMfHdsffVIXE3Fey09padEoE/gmBz8jVY7XPjIzFZxDfYhdM0rqWgymD
        +zb6bPe4BZXUONAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>, Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] mm/vmstat: Protect per cpu variables with preempt
 disable on RT
Message-ID: <20210831164546.t7b6ksblzhsmm6jr@linutronix.de>
References: <20210805160019.1137-1-mgorman@techsingularity.net>
 <20210805160019.1137-2-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210805160019.1137-2-mgorman@techsingularity.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-05 17:00:19 [+0100], Mel Gorman wrote:
>  mm/vmstat.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)

The version in RT also covered the functions
  __count_vm_event()
  __count_vm_events()

in include/linux/vmstat.h. Were they dropped by mistake or on purpose? 

Sebastian
