Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEFC32BF07
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 00:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1577204AbhCCRs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 12:48:29 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44372 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235930AbhCCOwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 09:52:40 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614783092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MtjHPmVHU8CBoanOm4MUbnVxPMgkXOhZVLNvYOhYD1U=;
        b=VBcI/SLxHW3/rrl47ew/1JWyoY45xuax+kmD5RjquJHm7U9Sn1D8oE4b7QLSCU3oMgFmGh
        z3le/JXubQcuGhD5P3QWRtC8u/GL9PIodvdGQSoxHEssTHnraDZQkOoUjqQ2K7krAgt1jV
        ZUSi+q6JLCC5m/r1WEBmAYhSQoYlMxzIRGuhQ0HGzQ6Wa6kkp5PoMzFJOPHwlYqLtGhcar
        eSOdZQ+cWJWboZrGQD2evWdypLgPG3WAV5WgUCcWUWpU2wFOuJRZBQOUVbGGM3V/3h8axz
        4Cwd8tNoFr72IIN8/9Z9LaLpsmbNT5yKJkGbGkxToJQFZ6yK8RXjrkOnz7JTBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614783092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MtjHPmVHU8CBoanOm4MUbnVxPMgkXOhZVLNvYOhYD1U=;
        b=0rxHR11jus9SH3qP3+ZjgR0JVpoOyD9lIqBDYOp0NgjPsCQJHXgsc5gmmi5XyuQUGsMeSN
        J5ZbhmVR+ubbOYDQ==
To:     Feng Tang <feng.tang@intel.com>, Ingo Molnar <mingo@redhat.com>,
        H Peter Anvin <hpa@zytor.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rui.zhang@intel.com, dave.hansen@intel.com, andi.kleen@intel.com,
        len.brown@intel.com, Feng Tang <feng.tang@intel.com>
Subject: Re: [PATCH] x86/tsc: mark tsc reliable for qualified platforms
In-Reply-To: <1614653572-19941-1-git-send-email-feng.tang@intel.com>
References: <1614653572-19941-1-git-send-email-feng.tang@intel.com>
Date:   Wed, 03 Mar 2021 15:51:31 +0100
Message-ID: <878s7470jw.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02 2021 at 10:52, Feng Tang wrote:
> There are cases that tsc clocksource are wrongly judged as unstable by
> clocksource watchdogs like hpet, acpi_pm or 'refined-jiffies'. While
> there is hardly a general reliable way to check the validity of a
> watchdog, and to protect the innocent tsc, Thomas Gleixner proposed [1]:
>
> "I'm inclined to lift that requirement when the CPU has:
>
>     1) X86_FEATURE_CONSTANT_TSC
>     2) X86_FEATURE_NONSTOP_TSC
>     3) X86_FEATURE_NONSTOP_TSC_S3
>     4) X86_FEATURE_TSC_ADJUST
>     5) At max. 4 sockets
>
>  After two decades of horrors we're finally at a point where TSC seems
>  to be halfway reliable and less abused by BIOS tinkerers. TSC_ADJUST
>  was really key as we can now detect even small modifications reliably
>  and the important point is that we can cure them as well (not pretty
>  but better than all other options)."
>
> So implement it with slight change as discussed in the thread, and be
> more defensive to use maxim of 2 sockets.

Can you please explain the slight change in the changelog?

Thanks,

        tglx
