Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1F336D9B1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 16:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239865AbhD1Oia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 10:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbhD1Oi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 10:38:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411A5C061573
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 07:37:44 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619620662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yhrm1zOqkUS61+Y9hGn2Bze80Gv2AY9rckCTy31Zc88=;
        b=kQ3kjkTk/D3nvQMMtABVVjsGtVeIzF0lwCszgJ8GjKpCgdp1buGNhX3BIbN86/4ETCKvk6
        mvpn3fCLMfWWkvM3EgQk5VFIrz3LoihYoR2MRBOR79mEQGf1rFLbYwQbwzpHpoAfqwFB9c
        hVVPFeg8BHuc0ZNx7tv/yCdc8TbSSsrKoPRXsvi84eYUxnERJA2iMjkl7yZLXe6C+AdLAP
        rvbD5IOHgPgR/wfvI3Ro78ICI3cwLnjH/L7V70P3IsjpoeZGQvjBMXX4XgkoYVpqmv+xj4
        Pixwl0V6GYn6bAl6ATy6PgSR6o7Y9z2CN7NkjRQ2Wz3+rm6fsCuoQo0b9mqayw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619620662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yhrm1zOqkUS61+Y9hGn2Bze80Gv2AY9rckCTy31Zc88=;
        b=hwoZbbC7j6RaJM9uv/hxOBsjaL/9WksOcBGSMWPoaBZmXJit5Hl7rmmFIv2ptW91jqm0bp
        0VG7jZJ4d+Fh7DAA==
To:     Luming Yu <luming.yu@gmail.com>, paulmck@kernel.org
Cc:     Andi Kleen <ak@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        feng.tang@intel.com, zhengjun.xing@intel.com,
        Chris Mason <clm@fb.com>
Subject: Re: [PATCH v10 clocksource 1/7] clocksource: Provide module parameters to inject delays in watchdog
In-Reply-To: <CAJRGBZyFbvpdrbKmV9KrXz7VkMcTMqVp2PAcFRvroZue6b9tag@mail.gmail.com>
References: <20210425224540.GA1312438@paulmck-ThinkPad-P17-Gen-1> <20210425224709.1312655-1-paulmck@kernel.org> <20210426040736.GS1401198@tassilo.jf.intel.com> <20210426152801.GY975577@paulmck-ThinkPad-P17-Gen-1> <20210426160008.GY1401198@tassilo.jf.intel.com> <20210426161425.GC975577@paulmck-ThinkPad-P17-Gen-1> <20210426175627.GZ1401198@tassilo.jf.intel.com> <20210426182433.GD975577@paulmck-ThinkPad-P17-Gen-1> <CAJRGBZxgJuc2OJfvT_k3Xmk_qsxzm=xX5wm4NqeRo7vkTcZk6w@mail.gmail.com> <20210428135725.GN975577@paulmck-ThinkPad-P17-Gen-1> <CAJRGBZyFbvpdrbKmV9KrXz7VkMcTMqVp2PAcFRvroZue6b9tag@mail.gmail.com>
Date:   Wed, 28 Apr 2021 16:37:41 +0200
Message-ID: <877dkmmq4q.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28 2021 at 22:24, Luming Yu wrote:
> On Wed, Apr 28, 2021 at 9:57 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>> Therefore, the code marks the clock unstable if it has four bad reads
>> in a row, as it should.
>
> The hard problem to solve is tsc is still in good shape and it can be verified
> with a quick cross check with other thread/core's tsc counts in the
> injected situation or in real life case
> to prove if it is  truly a tsc problem or reference clock's problem of
> the watchdog.
>
> Ideally, we could factor out hard-to-debug unstable tsc problems from
> clock source watchdog problems
> and get less and less tsc sightings caused by clock source watchdog.

The only way to fix this is at the hardware level. Everything else is
wishful thinking.

Thanks,

        tglx
