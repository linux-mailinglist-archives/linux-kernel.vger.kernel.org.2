Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27C56387CE3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 17:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350406AbhERPxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 11:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239415AbhERPxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 11:53:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA30C061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 08:51:46 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621353104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZP4mauUIqjhpjmh7Cbw+l4ZUA13KW/6IoUasso1gQhs=;
        b=y9uhJjBT3MMRfH/xnVkul+nG2CSZ7LoD/hbs6FMku7rQ/qfMXFlXnPG2genAY9RuqYCHF/
        lLGq9wU1oO3m2nktBiBrT1BIp/8Z7/WLVtPfyVESVBqJd77x23+aU7aZGlMNHLYYbm0+W8
        C2qRXeYAbk/OkZO/30Ae9iKO7NL4Mu9tlzoX7yvDrlMNXQItMwwPvdIcDWYQu/dASVe6kd
        dDubRPB4cDj+N4q/MAlK9D23bAWro7LmErahCLSSKolX/j2XRnOYIr+pDPWUu3JxH6/XVN
        3XJZW//O5S6gR8bHzJ4mKi5PJ/PcKySSzyXPm0wvX6xrYz+2DfFNzcNVwcgGzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621353104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZP4mauUIqjhpjmh7Cbw+l4ZUA13KW/6IoUasso1gQhs=;
        b=9uDvu9GWbCkNCuBvw6FfCEHRXOCYPOzo0UIte7yVk8WPUOq4ziSliVkhbFiUFOEgamSp+m
        +7oTP83KrHzpReCQ==
To:     Will Deacon <will@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Nitesh Lal <nilal@redhat.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, Frank Li <Frank.li@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>
Subject: Re: [patch 0/8] genirq, perf: Cleanup the abuse of irq_set_affinity_hint()
In-Reply-To: <20210518104849.GB7770@willie-the-truck>
References: <20210518091725.046774792@linutronix.de> <20210518104849.GB7770@willie-the-truck>
Date:   Tue, 18 May 2021 17:51:44 +0200
Message-ID: <874kf0doq7.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18 2021 at 11:48, Will Deacon wrote:
> On Tue, May 18, 2021 at 11:17:25AM +0200, Thomas Gleixner wrote:
>> The modular PMU drivers use irq_set_affinity_hint() to set the affinity
>> for the PMU interrupts, which relies on the undocumented side effect that
>> this function actually sets the affinity under the hood.
>> 
>> Setting an hint is clearly not a guarantee and for these PMU interrupts an
>> affinity hint, which is supposed to guide userspace for setting affinity,
>> is beyond pointless, because the affinity of these interrupts cannot be
>> modified from user space.
>> 
>> Aside of that the error checks are bogus because the only error which is
>> returned from irq_set_affinity_hint() is when there is no irq descriptor
>> for the interrupt number, but not when the affinity set fails. That's on
>> purpose because the hint can point to an offline CPU.
>> 
>> Sigh, if people would at least talk if something is missing...
>> 
>> Clean up the mess by exposing irq_set_affinity() and converting the drivers
>> over to that.
>
> This all looks good to me, thanks. Given the number of PMU drivers it
> touches, it may well conflict with driver work for 5.14. If you put the
> IRQ core stuff on a stable branch, then I could pull that into the Arm
> perf tree and stick all the driver changes on top. That also means any
> new drivers that come in can use irq_set_affinity() right away.
>
> Does that work for you?

Sure. I'll send you a tag to pull ...

Thanks,

        tglx
