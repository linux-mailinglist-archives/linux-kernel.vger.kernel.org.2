Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2668C35B623
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 18:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236467AbhDKQoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 12:44:01 -0400
Received: from mga14.intel.com ([192.55.52.115]:26541 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235855AbhDKQoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 12:44:00 -0400
IronPort-SDR: GQZBYxe8kw4jab8Wa0kZWqtE35KauO5urs8siariG0/I68VhQcu2NKplrf/bqOHmbDI/dylCyT
 cDbxPVk+gwHg==
X-IronPort-AV: E=McAfee;i="6000,8403,9951"; a="193610106"
X-IronPort-AV: E=Sophos;i="5.82,214,1613462400"; 
   d="scan'208";a="193610106"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2021 09:43:43 -0700
IronPort-SDR: AGMDNKepf+6A8aWmg8Ikwx/5s9oC0SNzqjbvgKhJ46oqblcjLGpu5Kt1XO0BgDVssdHFAL3a6P
 tng+GVzZsoCQ==
X-IronPort-AV: E=Sophos;i="5.82,214,1613462400"; 
   d="scan'208";a="417042057"
Received: from tassilo.jf.intel.com ([10.54.74.11])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2021 09:43:43 -0700
Date:   Sun, 11 Apr 2021 09:43:42 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Feng Tang <feng.tang@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Len Brown <len.brown@intel.com>
Subject: Re: [PATCH] x86/msr: Block writes to certain MSRs unconditionally
Message-ID: <20210411164342.GL3762101@tassilo.jf.intel.com>
References: <1617092747-15769-1-git-send-email-feng.tang@intel.com>
 <87y2dq32xc.ffs@nanos.tec.linutronix.de>
 <20210410094752.GB21691@zn.tnic>
 <20210410121144.GC21691@zn.tnic>
 <87r1jiug4e.fsf@linux.intel.com>
 <CALCETrXD6aKet8gpQUmcH0Z2AtHoGY-7MDK8WmCtH3_K=EYjtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXD6aKet8gpQUmcH0Z2AtHoGY-7MDK8WmCtH3_K=EYjtg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I have actually seen real user programs poke MSR_SYSCALL_MASK.

Hmm, what was the use case?

-Andi
