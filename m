Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5123C3A4BB6
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 02:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbhFLA0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 20:26:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43522 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbhFLA0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 20:26:18 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623457458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2pwQHFpcDVYfToqL9TN0yJPou8wPXsU8chr64rdvCog=;
        b=iIGLohCiA/yQrNlWhJ7T7qAW/1fRIikNY0scD5UURPe7vdPP2i+p45p6wV2KyheaNLl8yU
        6/kewkEGydehtzAmPrgqG2k7Mj1A6r/mK4Yhg6ocICEd6BDc19G/IeMNUF4XThKz/yY/yT
        dnOJvy1g9/XF56uEVsqTwe7ZbUvWbC0OoXpHmvV66MEfo/IoVw6oKSsU6WMkE/joe2N097
        cwPbcRmsTJB0pAM+ZQMxd0EQ3OHpcaCMWOIhOtcco6jJF8mZgSIzHDK7Cm6WfKaUP6x7Hn
        QgrIbSZhQWfYLtwqvljcuyom/RTKUhvfiwyirfFBpjZqxDZJbC30OVKxumn84Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623457458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2pwQHFpcDVYfToqL9TN0yJPou8wPXsU8chr64rdvCog=;
        b=FIevHXPdHr7Z2A1zczjdxKJ9yBiKRcDsGy4eQXO+TFpHMY5eZTwjlnvFf5jHKwuUx/gU2M
        zA1xERLfolhguvDQ==
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>
Subject: Re: [patch 00/41] x86/fpu: Spring cleaning and PKRU sanitizing
In-Reply-To: <20210611161523.508908024@linutronix.de>
References: <20210611161523.508908024@linutronix.de>
Date:   Sat, 12 Jun 2021 02:24:17 +0200
Message-ID: <871r98vsjy.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11 2021 at 18:15, Thomas Gleixner wrote:
>   - Removal of PKRU from being XSTATE managed in the kernel because PKRU
>     has to be eagerly restored on context switch and keeping it in sync
>     in the xstate buffer is just pointless overhead and fragile.

Just before anyone comes up with any complaints about the resulting
inconsistency vs. xgetbv(1) in the case that the PKRU value is 0.

That inconsistency is simply a INTEL only hardware bug and there is no
way to get this consistent ever no matter what kind of mechanism the
kernel uses. This inconsistency can be demonstrated in user space w/o
any kernel interaction.

The Intel SDM states in volume 1, chapter 13.6

 PROCESSOR TRACKING OF XSAVE-MANAGED STATE

  * PKRU state. PKRU state is in its initial configuration if the value
    of the PKRU is 0.

But that's just not true.

        wrpkru(0)
        assert(!(xgetbv(1) & XFEATURE_PKRU);

fails on Intel but not on AMD AFAIK. xgetbv(1) returns the 'INUSE'
bitmap of xstate managed features.

But the Intel SDM is blury about this:

  XINUSE denotes the state-component bitmap corresponding to the init
  optimization. If XINUSE[i] = 0, state component i is known to be in
  its initial configuration; otherwise XINUSE[i] = 1. It is possible for
  XINUSE[i] to be 1 even when state component i is in its initial
  configuration. On a processor that does not support the init
  optimization, XINUSE[i] is always 1 for every value of i.

IOW there is no consistency vs. XINUSE and initial state guaranteed at
all. So why should the kernel worry about this?

We just use the most optimized way to deal with this and that's what
this patch series is doing by removing PKRU from xstate management in
the kernel.

If anyone cares about consistency of XINUSE vs. the actual component
state then please redirect the complaints to INTEL.

Either the hardware folks get their act together or software which
relies on consistency (cough, cough) like rr has to cope with it.

Making the kernel to pretend that all of this is consistent under all
circumstances is a futile attempt to ignore reality.

This inconsistency can only be fixed in hardware/ucode. End of story.

Thanks,

        tglx
