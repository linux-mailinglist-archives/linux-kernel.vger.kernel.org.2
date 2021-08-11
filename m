Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A433E91C6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhHKMox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhHKMow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:44:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6801C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 05:44:27 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628685866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0CbAMqQCWiLWsnnOg23BGyvXm0vqekQj3qxYNb5O8TY=;
        b=TNz5X6ea1EQ4h4TjKiuLmBMtvODtyyOmU/kqMymIOje+oSD8GBdpH026nXuXfhT8DbQOnz
        1O9XmpFV34lmbcRwGfuxqegTKHHLFR08ZMGQmoxxNlZjG2MY2G2Yz55x/Zgg2mDHN/fgLC
        6cEoz1hfqN7MDZHiJqrG+p9p+UOwiuYkumBTayJh3FwavRBjFVFtu9YNjz2z7cmHW0nGlA
        CXuLbx0IDl3SP+y46ipEtSU9o9VZTaatNcuBsjLH/qs22upQNIPtAb7SWNCImex1B+fdEZ
        LeIBhsDwfO/7s7yeKVWuqnHNSBZmFbTrT+SdZyeAHlgA5/N00CwBL7IkZJl87g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628685866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0CbAMqQCWiLWsnnOg23BGyvXm0vqekQj3qxYNb5O8TY=;
        b=CZNb1dCDjjXRaDqzGskVESskJe27nlaliJw6nuaXTWrRPY/hipv3Eb3eAzKd73fkG+oUqD
        KbXSBHGuLfdFphDg==
To:     brookxu <brookxu.cn@gmail.com>, john.stultz@linaro.org,
        sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] clocksource: skip check while watchdog hung up or
 unstable
In-Reply-To: <63064a758eb087febce3eff5b2c736a5449b3dd2.1628675461.git.brookxu@tencent.com>
References: <63064a758eb087febce3eff5b2c736a5449b3dd2.1628675461.git.brookxu@tencent.com>
Date:   Wed, 11 Aug 2021 14:44:26 +0200
Message-ID: <877dgsp2vp.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11 2021 at 17:55, brookxu wrote:
> From: Chunguang Xu <brookxu@tencent.com>
>
> After patch 1f45f1f3 (clocksource: Make clocksource validation work
> for all clocksources), md_nsec may be 0 in some scenarios, such as
> the watchdog is delayed for a long time or the watchdog has a
> time-warp.

Maybe 0? There is exactly one single possibility for it to be zero:

  cs->wd_last == wdnow, i.e. delta = 0 -> wd_nsec = 0

So how does that condition solve any long delay or wrap around of the
watchdog? It's more than unlikely to hit exactly this case where the
readout is identical to the previous readout unless the watchdog stopped
counting.

> We found a problem when testing nvme disks with fio, when multiple
> queue interrupts of a disk were mapped to a single CPU. IO interrupt
> processing will cause the watchdog to be delayed for a long time
> (155 seconds), the system reports TSC unstable and switches the clock

If you hold off the softirq from running for 155 seconds then the TSC
watchdog is the least of your problems.

Thanks,

        tglx
