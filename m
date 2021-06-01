Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 853D2397CEF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 01:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235147AbhFAXRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 19:17:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:45116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234766AbhFAXRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 19:17:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B4B9613AD;
        Tue,  1 Jun 2021 23:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1622589341;
        bh=5ip7+F+u4x7Elx8YchgKVpLnPI+LRDsjCnnUKc2BQqg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FzWydQwG6S8CzzC1bkXcHpD4hGUQCnQH2MrFcl0coBGqVaOL8x9O7PLrkeB/QSnoi
         kBVgVfyyvuKD+0BK8jwu6E6R7O7W6tOQyG1bvBIMEsi+lGwsdStc2wUFFq0VTzQE2a
         Ug3QRtr3kf/RIh3kWVJjSUC34WAkHBSrpiB5v1so=
Date:   Tue, 1 Jun 2021 16:15:40 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Chris Goldsworthy <cgoldswo@codeaurora.org>,
        Laura Abbott <labbott@kernel.org>,
        Oliver Sang <oliver.sang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        John Dias <joaodias@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@intel.com, linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH v2] mm: fs: invalidate bh_lrus for only cold path
Message-Id: <20210601161540.9f449314965bd94c84725481@linux-foundation.org>
In-Reply-To: <20210601145425.1396981-1-minchan@kernel.org>
References: <20210601145425.1396981-1-minchan@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  1 Jun 2021 07:54:25 -0700 Minchan Kim <minchan@kernel.org> wrote:

> kernel test robot reported the regression of fio.write_iops[1]
> with [2].
> 
> Since lru_add_drain is called frequently, invalidate bh_lrus
> there could increase bh_lrus cache miss ratio, which needs
> more IO in the end.
> 
> This patch moves the bh_lrus invalidation from the hot path(
> e.g., zap_page_range, pagevec_release) to cold path(i.e.,
> lru_add_drain_all, lru_cache_disable).

This code is starting to hurt my brain.

What are the locking/context rules for invalidate_bh_lrus_cpu()? 
AFAICT it offers no protection against two CPUs concurrently running
__invalidate_bh_lrus() against the same bh_lru.

So when CONFIG_SMP=y, invalidate_bh_lrus_cpu() must always and only be
run on the cpu which owns the bh_lru.  In which case why does it have
the `cpu' arg?

Your new lru_add_and_bh_lrus_drain() follows these rules by calling
invalidate_bh_lrus_cpu() from a per-cpu worker or when CONFIG_SMP=n.

I think.  It's all as clear as mud and undocumented.  Could you please
take a look at this?  Comment the locking/context rules thoroughly and
check that they are being followed?  Not forgetting cpu hotplug...  See if
there's a way of simplifying/clarifying the code?

The fact that swap.c has those #ifdef CONFIG_SMPs in there is a hint
that we're doing something wrong (or poorly) in there.  Perhaps that's
unavoidable because of all the fancy footwork in __lru_add_drain_all().

