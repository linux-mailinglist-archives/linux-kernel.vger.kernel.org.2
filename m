Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1192A3122C2
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 09:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbhBGIdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 03:33:17 -0500
Received: from marcansoft.com ([212.63.210.85]:48078 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230274AbhBGI3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 03:29:33 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 370D242856;
        Sun,  7 Feb 2021 08:28:36 +0000 (UTC)
To:     Marc Zyngier <maz@kernel.org>
Cc:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, Arnd Bergmann <arnd@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Olof Johansson <olof@lixom.net>
References: <20210204203951.52105-1-marcan@marcan.st>
 <20210204203951.52105-9-marcan@marcan.st> <87im75l2lp.wl-maz@kernel.org>
From:   Hector Martin 'marcan' <marcan@marcan.st>
Subject: Re: [PATCH 08/18] arm64: cpufeature: Add a feature for FIQ support
Message-ID: <d110504f-2461-8b41-72cc-72681d775a97@marcan.st>
Date:   Sun, 7 Feb 2021 17:28:35 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <87im75l2lp.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02/2021 22.58, Marc Zyngier wrote:
> Hector Martin <marcan@marcan.st> wrote:
>> +static void cpu_sync_irq_to_fiq(struct arm64_cpu_capabilities const *cap)
>> +{
>> +	u64 daif = read_sysreg(daif);
>> +
>> +	/*
>> +	 * By this point in the boot process IRQs are likely masked and FIOs
>> +	 * aren't, so we need to sync things to avoid spurious early FIQs.
>> +	 */
>> +
>> +	if (daif & PSR_I_BIT)
>> +		daif |= PSR_F_BIT;
>> +	else
>> +		daif &= ~PSR_F_BIT;
>> +
>> +	write_sysreg(daif, daif);
> 
> Could this happen too late? If, as explained above, we can get a FIQ
> until we mask it here, what prevents something (a timer?) from kicking
> and creating havoc just before the sync?

Nothing, other than timers not being enabled this early (hopefully the 
bootloader doesn't leave a rogue timer running for us...)

> If the answer is "nothing", then it probably means that the default
> behaviour should be to treat PSTATE.I and PSTATE.F as containing the
> same value at all times, and not just as an afterthought when we
> detect that we're on a CPU type or another.

I thought of this too. Originally I thought PSTATE.F was always set on 
other systems, and thus unmasking FIQs could cause problems if there is 
a pending rogue FIQ for some reason. However, while writing this patch I 
realized that as part of normal process state changes we already unmask 
FIQs anyway (see DAIF_PROCCTX).

Thus, in fact, this patch actually changes things (when the cpufeature 
is set) to mask FIQs in some cases where they currently aren't, and 
conversely to unmask them in some cases where they currently are. But 
the fact that FIQ masking is somewhat inconsistent to begin with 
suggests that we should be able to mess with it without causing breakage 
for other systems.

So I guess in this case it would be legitimate to just make I==F on 
every system, and if something breaks it should be fixed by making 
whatever is causing a rogue FIQ not do that, right?

That would leave the vector switcheroo as the only thing the cpufeature 
does, which would certainly simplify a lot of the patch.

> This could expand into enabling Group-0 interrupts with GICv3 on
> systems that have a single security state (such as virtual machines),
> though I don't really see a good use case for it.

I could see having a separate vector path opening up the door for 
performance hacks for very specific use cases that want really low 
latency for *one* thing (e.g. the mess the Raspberry Pi folks do to work 
around that braindead USB controller's performance issues), though I 
imagine there would have to be very compelling reasons to develop a 
framework to do this sanely upstream.

Incidentally, I have a personal interest in real-time performance 
(especially audio); once the dust settles and we have a workable kernel 
for normal use I do hope to spend some time taking a deep dive into 
latencies and finding RT-unfriendly code, but that's pretty far off 
right now. Maybe PREEMPT_RT will even be merged by then :-) (I hope that 
without SMM to screw things up on these machines they might make very 
nice RT-capable boxes...)

-- 
Hector Martin "marcan" (marcan@marcan.st)
Public Key: https://mrcn.st/pub
