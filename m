Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4B213FA03B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 22:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbhH0UAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 16:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbhH0UAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 16:00:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5526DC0613D9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 13:00:00 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630094397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cuyJ1n7mYRIj0b5rsSRH9b404T7DIM3i9sVBEK1dcis=;
        b=bcElS44fhP7ldO1xyRVqF9iFaCnidIhMJRiK8Zs44+o/OGmdNr4aRyK7M8X7kQNm7lsOIG
        9XiLw4nYspxLqPPuYkmd+Q96djxh2zWBqsqyH+a5wYh/1vGxAMk9hYvgiJwfVGiGqnYEzE
        a0C38yoieeEHyRYRhikjuapVvEHiDDYST5zv8CbNCwmM3+XUNQHysGFQ1VumuDtXZNUSoe
        zH9QBk1VrS8ZMwBkf3dOakBzEwX88ctN+sv5oeZFGhHM3RXrALjqC5EQeWuWI3JKrNzdGl
        zdWIS26aUsc7PTt/qMAsKjakGPAmGXThu2HQp6NOzPxpfSxhUj+hNY8jZ+fPOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630094397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cuyJ1n7mYRIj0b5rsSRH9b404T7DIM3i9sVBEK1dcis=;
        b=msCyxaniaaZ4lR0mwgSMPTwNQfjJjBdccGLlJTAVPStOF1aI68UnVbEWh9BnS5CgD48xie
        SJvNzHeJEeZN4RAQ==
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        "Z.Q. Hou" <zhiqiang.hou@nxp.com>, Biwen Li <biwen.li@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] regmap: teach regmap to use raw spinlocks if
 requested in the config
In-Reply-To: <20210827161227.4pnaglgctikobpf6@skbuf>
References: <20210825205041.927788-1-vladimir.oltean@nxp.com>
 <20210825205041.927788-2-vladimir.oltean@nxp.com> <875yvr3j5c.ffs@tglx>
 <20210827161227.4pnaglgctikobpf6@skbuf>
Date:   Fri, 27 Aug 2021 21:59:56 +0200
Message-ID: <87pmty1ww3.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27 2021 at 16:12, Vladimir Oltean wrote:
> On Fri, Aug 27, 2021 at 01:01:35AM +0200, Thomas Gleixner wrote:
>> Even for the case where the regmap is not dealing with irq chips it does
>> not make any sense to protect low level operations on shared register
>> with a regular spinlock. I might be missing something though...
>
> Mark, any comments?
>
> Generally it is said that misusing raw spinlocks has detrimential
> performance upon the real-time aspects of the system, and I don't really
> have a good feeling for what constitutes misuse vs what is truly justified
> (in fact I did start the thread with "apologies for my novice level of
> understanding").
>
> On the other hand, while it does seem a bit too much overhead for
> sequences of MMIO reads/writes to be able to be preempted, it doesn't
> sound like it would break something either, so...

The question is how long those sequences are.

If it's just a pair or so then the raw spinlock protection has
definitely a smaller worst case than the sleeping spinlock in the
contended case.

OTOH, if regmap operations consist of several dozens of MMIO accesses,
then the preempt disabled region might be quite long.

I'm not familiar enough with regmaps to make a judgement here.

Thanks,

        tglx
