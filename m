Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFD0731FC48
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 16:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhBSPnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 10:43:02 -0500
Received: from marcansoft.com ([212.63.210.85]:44616 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229720AbhBSPlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 10:41:49 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 80DC5419B4;
        Fri, 19 Feb 2021 15:41:03 +0000 (UTC)
To:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, james.morse@arm.com, maz@kernel.org,
        tglx@linutronix.de, will@kernel.org,
        Arnd Bergmann <arnd@kernel.org>
References: <20210219113904.41736-1-mark.rutland@arm.com>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH 0/8] arm64: Support FIQ controller registration
Message-ID: <d714eee3-2746-d607-622c-184eadb480a1@marcan.st>
Date:   Sat, 20 Feb 2021 00:41:01 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210219113904.41736-1-mark.rutland@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Thanks for tackling this side of the problem!

On 19/02/2021 20.38, Mark Rutland wrote:
> The only functional difference here is that if an IRQ
> is somehow taken prior to set_handle_irq() the default handler will directly
> panic() rather than the vector branching to NULL.

That sounds like the right thing to do, certainly.

> The penultimate patch is cherry-picked from the v2 M1 series, and as per
> discussion there [3] will need a few additional fixups. I've included it for
> now as the DAIF.IF alignment is necessary for the FIQ exception handling added
> in the final patch.

> The final patch adds the low-level FIQ exception handling and registration
> mechanism atop the prior rework.
> 
> I'm hoping that we can somehow queue the first 6 patches of this series as a
> base for the M1 support. With that we can either cherry-pick a later version of
> the DAIF.IF patch here, or the M1 support series can take the FIQ handling
> patch. I've pushed the series out to my arm64/fiq branch [4] on kernel.org,
> atop v5.11.

Looks good! I cherry picked my updated version of the DAIF.IF patch into 
your series at [1] (3322522d), and then rebased the M1 series on top of 
it (with the change to use set_handle_fiq(), minus all the other 
obsoleted FIQ stuff) at [2]. It all boots and works as expected.

I think it makes sense for you to take the DAIF.IF patch, as it goes 
along with this series. Then we can base the M1 series off of it. If you 
think that works, I can send it off as a one-off reply to the version in 
this series and we can review it here if you want, or otherwise feel 
free to cherry-pick it into a v2 (CC as appropriate).

If this all makes sense, the v3 of the M1 series will then be based off 
of this patchset as in [2], and I'll link to your tree in the cover 
letter so others know where to apply it. Arnd (CCed) is going to be 
merging that one via the SoC tree, so as long as we coordinate a stable 
base once everything is reviewed and ready to merge, I believe it should 
all work out fine on the way up.

Just for completeness, the current DAIF.IF patch in the context of the 
original series is at [3] (4dd6330f), in case that's useful to someone 
for some reason (since there were conflicts due to the refactoring 
happening before it, it changed a bit).

[1] https://github.com/AsahiLinux/linux/tree/fiq
[2] https://github.com/AsahiLinux/linux/tree/upstream-bringup-v3
[3] https://github.com/AsahiLinux/linux/tree/upstream-bringup-v2.5

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
