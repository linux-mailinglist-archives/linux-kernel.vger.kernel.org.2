Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12D2230AD97
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 18:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbhBARSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 12:18:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbhBARRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 12:17:55 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A4AC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 09:17:09 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id s61so14326459ybi.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 09:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1qkxIjHyZ+mZgHgLlc7E3w26cTfMFkJdXD5l+CQq2Vs=;
        b=bjR18GHDHdIGJaZQoNodXMX+SfcsUDq4U0WVFDyxu75y4NuZh7CAv8Vj1mbadkC2lV
         heOQiNNJyB13Bc4oFpGAKtQEwDn7QJvQ6SmRVTTZuRLiuVjFDILaCl9YN9bxi3v2vjNK
         vGIyuyz2wYkrAuI4/nhEB4pH4w9mEB7WgY9g9n80k9xGBKx70vg3rYoRpmGjijWBNEz2
         jyv4lTO1QUsH1r+ZppGs+s0M2UJdrkFLfSVeoGacCjRgCcpgmyFrFRAL5XKMBZ4f6cMD
         p/cnKVySXA9+2wcyA7MfXGhbGC4DTpKAYjM2TcPxiidktCveAoNle26PXweBLhDXmF1y
         cF4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1qkxIjHyZ+mZgHgLlc7E3w26cTfMFkJdXD5l+CQq2Vs=;
        b=qap818njJ/Pdjs27FMIBiuutQDNucYyERMcMcxKZBaHaboFgkr8xM1cf+GFEhfB4t2
         sHr9Z2nEwzgHADY3Wh5m4cxMxV9xKwKjsBrlLdnJBUzD1XPVFwWnI7+NB9KZe3bUU77r
         cFN1+T2abnkpEozYukRpJJDANwqodrbejZ/R6GaoXtt1WF3swk0aZ96iivkb2cubmASj
         BgqjZy3hTLbmp6DkRphQZ4RwkKVR6ct9zlzngOYa0xQFOETcH+r2q5nP3OyKo6Iz5IRH
         cOsMn+IqeZUYxFNO3h8Fv/M2WkMqmRF8oqatfTTZygaZo3pBnS5iX4KBV5TRgMaKwxmb
         0tLw==
X-Gm-Message-State: AOAM532ZpXgjekLAhknCUrgkJ0yv9/FxriREVCC4o89JTIg+cUyNM6zA
        bUdk9fNQP9YhiQgoJNngcJcrOEU4Nb1zdZiU4E3Ukw==
X-Google-Smtp-Source: ABdhPJwHbBdpEpbJml1HqFqx+V4fHSyTjy1ZBh3LG1HD9Y734KThlFsCP+fJMfL/iymJ0fjp3/jt283CL6rD9p4CT7E=
X-Received: by 2002:a25:cc89:: with SMTP id l131mr24523969ybf.346.1612199828847;
 Mon, 01 Feb 2021 09:17:08 -0800 (PST)
MIME-Version: 1.0
References: <20210128104446.164269-1-tudor.ambarus@microchip.com>
 <CAGETcx9CodHDeqSYM1zQXRi-p_rFUJQgwMtnuWeKvCt_B3dCOw@mail.gmail.com> <CAMuHMdXqQL3PQvgC-zACkMyF8S3kg9-RPxvJMK8WXqu45EhwEg@mail.gmail.com>
In-Reply-To: <CAMuHMdXqQL3PQvgC-zACkMyF8S3kg9-RPxvJMK8WXqu45EhwEg@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 1 Feb 2021 09:16:32 -0800
Message-ID: <CAGETcx-aK53QCKu1h-jXxZN85bH-2uQo1MGFXGgpiLJyTfFG8Q@mail.gmail.com>
Subject: Re: [PATCH] clk: at91: sama5d2: Mark device OF_POPULATED after setup
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>, mirq-linux@rere.qmqm.pl,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 1, 2021 at 2:54 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Saravana,
>
> On Thu, Jan 28, 2021 at 6:08 PM Saravana Kannan <saravanak@google.com> wrote:
> > I already accounted for early clocks like this when I designed
> > fw_devlink. Each driver shouldn't need to set OF_POPULATED.
> > drivers/clk/clk.c already does this for you.
> >
> > I think the problem is that your driver is using
> > CLK_OF_DECLARE_DRIVER() instead of CLK_OF_DECLARE(). The comments for
> > CLK_OF_DECLARE_DRIVER() says:
> > /*
> >  * Use this macro when you have a driver that requires two initialization
> >  * routines, one at of_clk_init(), and one at platform device probe
> >  */
> >
> > In your case, you are explicitly NOT having a driver bind to this
> > clock later. So you shouldn't be using CLK_OF_DECLARE() instead.
>

Typo. I meant to say this driver SHOULD be using CLK_OF_DECLARE()
instead. I wonder if this is what caused you to send the email --
because we are saying the same thing.

> Unless I'm missing something, name##_of_clk_init_driver() clearing
> OF_POPULATED again causes consumer driver probing to be postponed by
> fw_devlink until the second initialization phase of the provider has been
> completed?

Right, if they use CLK_OF_DECLARE_DRIVER() what you said above will
happen and that's the issue they are trying to fix.

> This is wrong if the consumer only needs a clock instantiated during the
> first phase, and may cause issues if the consumer is a critical device.
> E.g. a timer, on ARM SoCs lacking an architecture timer (pre-Cortex
> A7/A15) or global timer (pre-Cortex A9, or single-core Cortex A9).
> Probably there are more examples.

So, needing devices like IRQ, timer and clocks early is fine.
fw_devlink can handle that correctly if the proper macros are used
(since most frameworks set the OF_POPULATED flag for these devices).

-Saravana
