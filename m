Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9F3E3EF05E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 18:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbhHQQsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 12:48:14 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:40572 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbhHQQsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 12:48:13 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2715021FD2;
        Tue, 17 Aug 2021 16:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629218859; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XjbM6q0B49u7CEY1Vk/k4nOtwMrfJRYnAZ4Evl+0w4I=;
        b=Yp4LKhWSOBGgiytwqqrr02EmmQ0NQGSjgC7tFFYlnB2phnoyS29L8k5l1L06lOf+fEMsKr
        keWNoNMH3IDUx3xAp/bL4PdDcfiBvFVMlfSdYcmtKQdcGdwjFuSsXy6WMxCk83y5veG7AY
        NaCj+B9S1jRZpeHQxfjFocxdb8dgSgw=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id E796412FF9;
        Tue, 17 Aug 2021 16:47:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id EpvdNyroG2E0bgAAGKfGzw
        (envelope-from <mkoutny@suse.com>); Tue, 17 Aug 2021 16:47:38 +0000
Date:   Tue, 17 Aug 2021 18:47:37 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <oliver.sang@intel.com>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        andi.kleen@intel.com
Subject: Re: [mm] 2d146aa3aa: vm-scalability.throughput -36.4% regression
Message-ID: <20210817164737.GA23342@blackbody.suse.cz>
References: <20210811031734.GA5193@xsang-OptiPlex-9020>
 <CAHk-=wiSHHSuSQsCCLOxQA+cbcvjmEeMsTCMWPT1sFVngd9-ig@mail.gmail.com>
 <20210812031910.GA63920@shbuild999.sh.intel.com>
 <20210816032855.GB72770@shbuild999.sh.intel.com>
 <YRrbpRsvdDoom9iG@cmpxchg.org>
 <20210817024500.GC72770@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210817024500.GC72770@shbuild999.sh.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 10:45:00AM +0800, Feng Tang <feng.tang@intel.com> wrote:
> Initially from the perf-c2c data, the in-cacheline hotspots are only
> 0x0, and 0x10, and if we extends to 2 cachelines, there is one more
> offset 0x54 (css.flags), but still I can't figure out which member
> inside the 128 bytes range is written frequenty.

Is it certain that perf-c2c reported offsets are the cacheline of the
first bytes of struct cgroup_subsys_state? (Yeah, it looks to me so,
given what code accesses those and your padding fixing it. I'm just
raising it in case there was anything non-obvious.)

> 
> /* pah info for cgroup_subsys_state */
> struct cgroup_subsys_state {
> 	struct cgroup *            cgroup;               /*     0     8 */
> 	struct cgroup_subsys *     ss;                   /*     8     8 */
> 	struct percpu_ref          refcnt;               /*    16    16 */
> 	struct list_head           sibling;              /*    32    16 */
> 	struct list_head           children;             /*    48    16 */
> 	/* --- cacheline 1 boundary (64 bytes) --- */
> 	struct list_head           rstat_css_node;       /*    64    16 */
> 	int                        id;                   /*    80     4 */
> 	unsigned int               flags;                /*    84     4 */
> 	u64                        serial_nr;            /*    88     8 */
> 	atomic_t                   online_cnt;           /*    96     4 */
> 
> 	/* XXX 4 bytes hole, try to pack */
> 
> 	struct work_struct         destroy_work;         /*   104    32 */
> 	/* --- cacheline 2 boundary (128 bytes) was 8 bytes ago --- */
> 
> Since the test run implies this is cacheline related, and I'm not very
> familiar with the mem_cgroup code, the original perf-c2c log is attached
> which may give more hints.

As noted by Johannes, even in atomic mode, the refcnt would have the
atomic part elsewhere. The other members shouldn't be written frequently
unless there are some intense modifications of the cgroup tree in
parallel.
Does the benchmark create lots of memory cgroups in such a fashion?

Regards,
Michal
