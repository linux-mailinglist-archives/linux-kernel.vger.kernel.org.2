Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89223F541A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 02:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233496AbhHXAhH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 23 Aug 2021 20:37:07 -0400
Received: from mga09.intel.com ([134.134.136.24]:19211 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233260AbhHXAhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 20:37:06 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10085"; a="217207984"
X-IronPort-AV: E=Sophos;i="5.84,346,1620716400"; 
   d="scan'208";a="217207984"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 17:36:23 -0700
X-IronPort-AV: E=Sophos;i="5.84,346,1620716400"; 
   d="scan'208";a="493206675"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.159.119])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 17:36:20 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [RFC 20/20] mm/rmap: avoid potential races
References: <20210131001132.3368247-1-namit@vmware.com>
        <20210131001132.3368247-21-namit@vmware.com>
        <87zgt8y4aj.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <3F1EF02A-6FD4-42BE-BD07-1C5AC97A515B@vmware.com>
Date:   Tue, 24 Aug 2021 08:36:18 +0800
In-Reply-To: <3F1EF02A-6FD4-42BE-BD07-1C5AC97A515B@vmware.com> (Nadav Amit's
        message of "Mon, 23 Aug 2021 15:50:22 +0000")
Message-ID: <87v93vy8zh.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nadav Amit <namit@vmware.com> writes:

>> On Aug 23, 2021, at 1:05 AM, Huang, Ying <ying.huang@intel.com> wrote:
>> 
>> Hi, Nadav,
>> 
>> Nadav Amit <nadav.amit@gmail.com> writes:
>> 
>>> From: Nadav Amit <namit@vmware.com>
>>> 
>>> flush_tlb_batched_pending() appears to have a theoretical race:
>>> tlb_flush_batched is being cleared after the TLB flush, and if in
>>> between another core calls set_tlb_ubc_flush_pending() and sets the
>>> pending TLB flush indication, this indication might be lost. Holding the
>>> page-table lock when SPLIT_LOCK is set cannot eliminate this race.
>> 
>> Recently, when I read the corresponding code, I find the exact same race
>> too.  Do you still think the race is possible at least in theory?  If
>> so, why hasn't your fix been merged?
>
> I think the race is possible. It didn’t get merged, IIRC, due to some
> addressable criticism and lack of enthusiasm from other people, and
> my laziness/busy-ness.

Got it!  Thanks your information!

>>> The current batched TLB invalidation scheme therefore does not seem
>>> viable or easily repairable.
>> 
>> I have some idea to fix this without too much code.  If necessary, I
>> will send it out.
>
> Arguably, it would be preferable to have a small back-portable fix for
> this issue specifically. Just try to ensure that you do not introduce
> performance overheads. Any solution should be clear about its impact
> on additional TLB flushes on the worst-case scenario and the number
> of additional atomic operations that would be required.

Sure.  Will do that.

Best Regards,
Huang, Ying
