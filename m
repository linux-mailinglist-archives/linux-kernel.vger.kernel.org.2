Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C512B3F465C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 10:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235503AbhHWIGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 04:06:15 -0400
Received: from mga11.intel.com ([192.55.52.93]:2762 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235353AbhHWIGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 04:06:11 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10084"; a="213927037"
X-IronPort-AV: E=Sophos;i="5.84,344,1620716400"; 
   d="scan'208";a="213927037"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 01:05:29 -0700
X-IronPort-AV: E=Sophos;i="5.84,344,1620716400"; 
   d="scan'208";a="535251129"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.159.119])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 01:05:26 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Nadav Amit <namit@vmware.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        x86@kernel.org
Subject: Re: [RFC 20/20] mm/rmap: avoid potential races
References: <20210131001132.3368247-1-namit@vmware.com>
        <20210131001132.3368247-21-namit@vmware.com>
Date:   Mon, 23 Aug 2021 16:05:24 +0800
In-Reply-To: <20210131001132.3368247-21-namit@vmware.com> (Nadav Amit's
        message of "Sat, 30 Jan 2021 16:11:32 -0800")
Message-ID: <87zgt8y4aj.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Nadav,

Nadav Amit <nadav.amit@gmail.com> writes:

> From: Nadav Amit <namit@vmware.com>
>
> flush_tlb_batched_pending() appears to have a theoretical race:
> tlb_flush_batched is being cleared after the TLB flush, and if in
> between another core calls set_tlb_ubc_flush_pending() and sets the
> pending TLB flush indication, this indication might be lost. Holding the
> page-table lock when SPLIT_LOCK is set cannot eliminate this race.

Recently, when I read the corresponding code, I find the exact same race
too.  Do you still think the race is possible at least in theory?  If
so, why hasn't your fix been merged?

> The current batched TLB invalidation scheme therefore does not seem
> viable or easily repairable.

I have some idea to fix this without too much code.  If necessary, I
will send it out.

Best Regards,
Huang, Ying
