Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3BEC3ADBFE
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 00:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhFSWcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 18:32:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36216 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbhFSWcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 18:32:45 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624141832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JCZqjT7BQkj4I3lqgj9b8LxZTn5XV5cNEOqOujIa9pk=;
        b=Ogb+aW8iwz1bY+ijdG27mXqDeCAkPw4BQKtq+VTwbHeBHZDOpGHwGtoyeO7Q/4/glc/iRk
        ivmaZ+/gE3tPQsifYo43bopsLe6hr9dKApsWGJsCjUaiacc1o4WF+/QwelspxzcbLzHceM
        ZbrGI1xGz82e/tBTq9BW7t4ZPqXJ/674AQFe1QP7ct7vpsDc5EvluBrQU1zpitmRblpW5d
        icoCHBIqkFDpdP/rypOX8G6lI6VykGGUjfRn2Dd9fikXaxfqwmhlpIfFI3urEU776w+xnq
        k1usMIRED2k20MrUpF4g/cn//xT1oqwDgVkvk3nNHp5QfqsWSq11jBv+3GtScg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624141832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JCZqjT7BQkj4I3lqgj9b8LxZTn5XV5cNEOqOujIa9pk=;
        b=/4PBb/SbidnUVdO7kcz49efhFZl4GYo6Eldmy5YZuJFo5c/bU7UAe5HCB2D4ETAONy1A3/
        kkRl1wGJ/wVoEiAg==
To:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org
Cc:     benh@kernel.crashing.org, boqun.feng@gmail.com, bp@alien8.de,
        catalin.marinas@arm.com, dvyukov@google.com, elver@google.com,
        ink@jurassic.park.msu.ru, jonas@southpole.se,
        juri.lelli@redhat.com, linux@armlinux.org.uk, luto@kernel.org,
        mark.rutland@arm.com, mattst88@gmail.com, mingo@redhat.com,
        monstr@monstr.eu, mpe@ellerman.id.au, paulmck@kernel.org,
        paulus@samba.org, peterz@infradead.org, rth@twiddle.net,
        shorne@gmail.com, stefan.kristiansson@saunalahti.fi,
        vincent.guittot@linaro.org, will@kernel.org
Subject: Re: [RFC PATCH 10/10] x86: snapshot thread flags
In-Reply-To: <20210609122001.18277-11-mark.rutland@arm.com>
References: <20210609122001.18277-1-mark.rutland@arm.com> <20210609122001.18277-11-mark.rutland@arm.com>
Date:   Sun, 20 Jun 2021 00:30:32 +0200
Message-ID: <87eecxh4hj.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09 2021 at 13:20, Mark Rutland wrote:
> Some thread flags can be set remotely, and so even when IRQs are
> disabled, the flags can change under our feet. Generally this is
> unlikely to cause a problem in practice, but it is somewhat unsound, and
> KCSAN will legitimately warn that there is a data race.
>
> To avoid such issues, we should snapshot the flags prior to using them.
> Let's use the new helpers to do so on x86.

 To avoid such issues, a snapshot of the flags has to be taken prior to
 using them. Some places already use READ_ONCE() for that, others do
 not.

 Convert them all to the new flag accessor helpers.

Other than that.

 Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
