Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6364B35AFB9
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 20:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234977AbhDJSwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 14:52:37 -0400
Received: from mga12.intel.com ([192.55.52.136]:19672 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234963AbhDJSwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 14:52:35 -0400
IronPort-SDR: RU7dfQnp8STDsV4X5346Ycjw5fldQd90UzMZOfxVpoqbE81QsXDfmVriC2l4Xx0V2VIPzcnpIu
 Q5iFbGWraddA==
X-IronPort-AV: E=McAfee;i="6000,8403,9950"; a="173438721"
X-IronPort-AV: E=Sophos;i="5.82,212,1613462400"; 
   d="scan'208";a="173438721"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2021 11:52:17 -0700
IronPort-SDR: d8s7bbDC9S9TN3ZsVR0wIC+HNuw9iLcTjKvqCUkHYQRATS2Y48nlWsWdS8SQHFSF6QB5p/VHGQ
 Q2U9mez6y9/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,212,1613462400"; 
   d="scan'208";a="531372794"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.54.74.11])
  by orsmga004.jf.intel.com with ESMTP; 10 Apr 2021 11:52:17 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 0E43A301B81; Sat, 10 Apr 2021 11:52:17 -0700 (PDT)
From:   Andi Kleen <ak@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Feng Tang <feng.tang@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        andi.kleen@intel.com, dave.hansen@intel.com, len.brown@intel.com
Subject: Re: [PATCH] x86/msr: Block writes to certain MSRs unconditionally
References: <1617092747-15769-1-git-send-email-feng.tang@intel.com>
        <87y2dq32xc.ffs@nanos.tec.linutronix.de>
        <20210410094752.GB21691@zn.tnic> <20210410121144.GC21691@zn.tnic>
Date:   Sat, 10 Apr 2021 11:52:17 -0700
In-Reply-To: <20210410121144.GC21691@zn.tnic> (Borislav Petkov's message of
        "Sat, 10 Apr 2021 14:11:44 +0200")
Message-ID: <87r1jiug4e.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Borislav Petkov <bp@alien8.de> writes:

> From: Borislav Petkov <bp@suse.de>
> Date: Sat, 10 Apr 2021 14:08:13 +0200
>
> There are a bunch of MSRs which luserspace has no business poking at,
> whatsoever. Add a ban list and put the TSC-related MSRs in there. Issue
> a big juicy splat to catch offenders.

Have you ever seen any user programs actually write those MSRs?
I don't see why they ever would, it's not that they have any motivation
to do it (unlike SMM), and I don't know of any examples.

The whole MSR blocking seems more like a tilting at windmills
type effort. Root kits typically write from the kernel anyways. And the
only results we have so far is various legitimate debug
and benchmark utilities running much slower due to them flooding the
kernel log with warnings.

I can see that there are security reasons to lock down MSRs, but that is
already handled fine with existing sandbox and lockdown mechanisms. But
on a non locked down system fully accessible MSRs are really useful for
all kind of debugging and tuning, and anything that prevents that
is bad.

-Andi
