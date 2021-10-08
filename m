Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5DAA4261A6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 03:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbhJHBY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 21:24:56 -0400
Received: from mga11.intel.com ([192.55.52.93]:62053 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229524AbhJHBYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 21:24:54 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="223818969"
X-IronPort-AV: E=Sophos;i="5.85,356,1624345200"; 
   d="scan'208";a="223818969"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 18:22:58 -0700
X-IronPort-AV: E=Sophos;i="5.85,356,1624345200"; 
   d="scan'208";a="489253856"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.159.119])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 18:22:56 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>, Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH v2] mm/mempolicy: do not allow illegal
 MPOL_F_NUMA_BALANCING | MPOL_LOCAL in mbind()
References: <20211001215630.810592-1-eric.dumazet@gmail.com>
Date:   Fri, 08 Oct 2021 09:22:54 +0800
In-Reply-To: <20211001215630.810592-1-eric.dumazet@gmail.com> (Eric Dumazet's
        message of "Fri, 1 Oct 2021 14:56:30 -0700")
Message-ID: <87pmsgqpht.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Eric,

Eric Dumazet <eric.dumazet@gmail.com> writes:

> From: Eric Dumazet <edumazet@google.com>
>
> syzbot reported access to unitialized memory in mbind() [1]
>
> Issue came with commit bda420b98505 ("numa balancing: migrate on
> fault among multiple bound nodes")
>
> This commit added a new bit in MPOL_MODE_FLAGS, but only checked
> valid combination (MPOL_F_NUMA_BALANCING can only be used with MPOL_BIND)
> in do_set_mempolicy()
>
> This patch moves the check in sanitize_mpol_flags() so that it
> is also used by mbind()

Good catch!  Thanks!  When MPOL_F_NUMA_BALANCING is introduced, it is
intended to be used with set_memopolicy() syscall only, it is not
allowed to be used with mbind() syscall at least for now.  But I
misunderstood the original code apparently.

So I think it may be better to return EINVAL for mbind() +
MPOL_F_NUMA_BALANCING?

Best Regards,
Huang, Ying
