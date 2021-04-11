Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6F435B2CF
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 11:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235311AbhDKJlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 05:41:00 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34830 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235267AbhDKJk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 05:40:59 -0400
Received: from zn.tnic (p200300ec2f23de002e7d52dd33d8f804.dip0.t-ipconnect.de [IPv6:2003:ec:2f23:de00:2e7d:52dd:33d8:f804])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7824F1EC0350;
        Sun, 11 Apr 2021 11:40:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1618134042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=CHl4jeX0ttoaB+n97ZavUjRTE8LvpyYYuduWXYDQ4GM=;
        b=NoLiA/3SBAtfgzkSEvdCHVtIX0PJgTFA33YRXJQ7Wj1FOQ+m+xu48EykaOTQCE1Mz5kWc+
        7i5lHIkfCXJsfEcKDAd8hb33UZvki71r0eZiGorWtRuRhQsmDHpaHZaumogouB6FPfkjAZ
        6dR7aVLMe8FYea/ToJsPYeTy7D/almo=
Date:   Sun, 11 Apr 2021 11:40:40 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Feng Tang <feng.tang@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        andi.kleen@intel.com, dave.hansen@intel.com, len.brown@intel.com
Subject: Re: [PATCH] x86/msr: Block writes to certain MSRs unconditionally
Message-ID: <20210411094040.GC14022@zn.tnic>
References: <1617092747-15769-1-git-send-email-feng.tang@intel.com>
 <87y2dq32xc.ffs@nanos.tec.linutronix.de>
 <20210410094752.GB21691@zn.tnic>
 <20210410121144.GC21691@zn.tnic>
 <87r1jiug4e.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87r1jiug4e.fsf@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2021 at 11:52:17AM -0700, Andi Kleen wrote:
> Have you ever seen any user programs actually write those MSRs?
> I don't see why they ever would, it's not that they have any motivation
> to do it (unlike SMM), and I don't know of any examples.

You'd be surprised how much motivation people have to poke at random
MSRs. Just browse some of those tools on github which think poking at
MSRs is ok.

> The whole MSR blocking seems more like a tilting at windmills
> type effort.

Nope, this is trying to salvage the current situation of people thinking
it is a good idea to poke at random MSRs and develop all kinds of tools
around it and then run those tools ontop of a kernel which pokes at
those same MSRs.

It is not really hard to realize that touching resources in an
unsynchronized way is a disaster waiting to happen. No matter how useful
and how wonderful those tools are.

> But on a non locked down system fully accessible MSRs are really
> useful for all kind of debugging and tuning, and anything that
> prevents that is bad.

If you wanna do that, you can just as well patch your kernel.

We're currently tainting the kernel on MSR writes and perhaps that's
good enough for now but if some tool starts doing dumb crap and pokes at
MSRs it should not be poking at and users start complaining because of
it, I'm committing that.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
