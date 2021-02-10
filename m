Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 352CD31679E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 14:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbhBJNNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 08:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbhBJNNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 08:13:02 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E2CC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 05:12:21 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612962740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EOR6Op00R5qPfGO4dFo1mxtV8aaQR7ma4WLvzuHdwYY=;
        b=PVN1/hJqAQAagRCj8KCbuCNRzH09lF5iYH2faPP0lujj/m17AFB+r7bzCZimfg8eBWMoMX
        IAkc2i8orsnPgkBrkfpiqMgbvaJzTBElejC2LczANMqJye0+1qPM8Hmc264WsdBn2bmw2w
        vdJ/oXpIacCNY1zb8vv/mF3q18GgZT3HaFNBH5vt87kKLKsjUCMtwQa7VITfeaF4dkQYXh
        g1el8M1JgiTOBI8lklqACBfqkg8WdWKaPnCdKvygVLtnosWIOfVs9qms7Y+8tUjinwTuWo
        c838Op5YBJMuDWpwDsezc638Iy62TuSu8VCisl9KEMH0MXSbi/bOKZsvIDPEXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612962740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EOR6Op00R5qPfGO4dFo1mxtV8aaQR7ma4WLvzuHdwYY=;
        b=o2GaZ+xxj4fRzFNQgWyGKAJKMXaU/xrEEu0+kIp/dA9N4iCkdOG3dNWRZ8mxUXQNFwQ7U5
        /Al1xtNr43xwC4Dg==
To:     Hikaru Nishida <hikalium@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     suleiman@google.com, Hikaru Nishida <hikalium@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ingo Molnar <mingo@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [RFC PATCH 1/2] timekeeping: Add timekeeping_adjust_boottime
In-Reply-To: <20210210193728.RFC.1.I123660cac7339e5b982ade27775a48b8ebbd9435@changeid>
References: <20210210103908.1720658-1-hikalium@google.com> <20210210193728.RFC.1.I123660cac7339e5b982ade27775a48b8ebbd9435@changeid>
Date:   Wed, 10 Feb 2021 14:12:20 +0100
Message-ID: <87blcsawy3.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10 2021 at 19:39, Hikaru Nishida wrote:
> From: Hikaru Nishida <hikalium@chromium.org>
>
> This introduces timekeeping_adjust_boottime() to give an interface to
> modules that enables to advance CLOCK_BOOTTIME from userspace for
> virtualized environments. Later patch introduces a sysfs interface
> which calls this function.

Not going to happen. That's just wrong in several ways.

The underlying problem of virt and timekeeping needs to be fixed not
hacked around it.

Thanks,

        tglx


