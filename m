Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3376D38952B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 20:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbhESSS4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 19 May 2021 14:18:56 -0400
Received: from mail-ua1-f51.google.com ([209.85.222.51]:42959 "EHLO
        mail-ua1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbhESSSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 14:18:52 -0400
Received: by mail-ua1-f51.google.com with SMTP id 14so4731898uac.9;
        Wed, 19 May 2021 11:17:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2rY1yW/YsvOZYFTiuIc2+ehXyRnGQoCM7oBhn+XshDI=;
        b=fk6eP+41rU/FeynydG46bB4kpyT7GEIseuXdHSTqtvJd6z7CX1p/kkanj3Krv5Nk0H
         OGlZDIPGlKBs4xPoFFAxcW/KP6DD4PTUOyQ5SLAEeGtcItjKnFWuAVV93WI0yy2mf8g7
         uQW9t2wVKKYPKutb74kN3OFbKDq16ySgqo9OXOHqT+t0fZ56rJVX43W9do7lL7dZMWSn
         UcmpgIVGOUE1tr8yRsyxuB4j6f7NOl8wzqj/8czdSdHfq/puyZbDxyujoh0AHw/roGzT
         evlAmz1BqXaN5/Qen1GZLLDt0p67MiIiG7gRqYCMBcP8Jj1G41mxWQCElzDb5p7N4Msp
         x72A==
X-Gm-Message-State: AOAM531CQXTOB5UVUst849HhJX47jwwXU7/pDQU62jkxJwSpL2xVmSfi
        lkx09clmJWQ0CszimT0GiU5dZbvGnQ8PZIGkVvo=
X-Google-Smtp-Source: ABdhPJwW7PwgWmazkSCrWv4XAkCvSaYsIKLalnqHAOYA26PIBau9vsCcc8rqJcC2rad2wL1KTwP6PI8LTRXqT3PWq4A=
X-Received: by 2002:ab0:7705:: with SMTP id z5mr1011167uaq.2.1621448248375;
 Wed, 19 May 2021 11:17:28 -0700 (PDT)
MIME-Version: 1.0
References: <20201209094916.17383-1-zong.li@sifive.com> <87v99qyjaz.fsf@igel.home>
 <CANXhq0oLxFK1431WmTj5HRO5k_omYkQZCBTG+HORTk9=W_XyNg@mail.gmail.com>
 <CANXhq0p90Cgha_zLzxamK9mxmVPn3effh_cZq_CTLrcAkKZg2Q@mail.gmail.com>
 <87lfaj7cki.fsf@igel.home> <871rc4on36.fsf@igel.home> <CANXhq0pDge0BPgAjoLrX7Y2qtofb3dhV1_CPHBaCg0o4cEMrbQ@mail.gmail.com>
 <87a6qrk2pw.fsf@igel.home> <CANXhq0rOeAWnRYHAYKJfDeY4kYz6+5mU_dJSqU67+2p9u0STHQ@mail.gmail.com>
 <874kgyfetu.fsf@igel.home> <CANXhq0rE-ZcPBp02Pvozpk_s-j6NhxHUmso75uz6ji9bejO8gA@mail.gmail.com>
 <87h7kukzy4.fsf@igel.home> <CANXhq0r5_xhFu3W9mUFkp_7BYUVBzvHZE1A6jpBDcL_KwTc1cA@mail.gmail.com>
 <87tuob7n8g.fsf@igel.home> <CANXhq0rTC8grpRe_Q0vG6_52b-41OuN4vHum8RvouMbE6xiXpQ@mail.gmail.com>
 <CALecT5jQ7_-d7j+MXrG++Bnr_wYmbWgCK20Ju5Pgjbu9xmwQBA@mail.gmail.com> <CANXhq0q-ou6h_Qxjtq52RQ_V2ERu8JLNa7Vq77Rpv_+SFX4LNA@mail.gmail.com>
In-Reply-To: <CANXhq0q-ou6h_Qxjtq52RQ_V2ERu8JLNa7Vq77Rpv_+SFX4LNA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 19 May 2021 20:17:16 +0200
Message-ID: <CAMuHMdWGakAT1LKg_sje=ZYTbLX1_BjjOsqOYP9KrzhMmMi6Ag@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] clk: add driver for the SiFive FU740
To:     Zong Li <zong.li@sifive.com>
Cc:     Yixun Lan <yixun.lan@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Pragnesh Patel <pragnesh.patel@openfive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Michael Turquette <mturquette@baylibre.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zong,

On Wed, May 19, 2021 at 5:55 PM Zong Li <zong.li@sifive.com> wrote:
> On Tue, May 11, 2021 at 4:57 PM Yixun Lan <yixun.lan@gmail.com> wrote:
> > On Wed, Apr 14, 2021 at 2:25 PM Zong Li <zong.li@sifive.com> wrote:
> > > On Mon, Apr 12, 2021 at 7:31 PM Andreas Schwab <schwab@linux-m68k.org> wrote:
> > > > On Mär 31 2021, Zong Li wrote:
> > > > > I found that the gemgxlpll was disabled immediately by power
> > > > > management after macb driver install. The mainline's defconfig doesn't
> > > > > enable CONFIG_PM, so the network is fine on it. The opensuse defconfig
> > > > > enables CONFIG_PM, and the patch
> > > > > 732374a0b440d9a79c8412f318a25cd37ba6f4e2 added the enable/disable
> > > > > callback functions, so the gemgxlpll PLL, I have no idea why power
> > > > > management disable it, I would keep trace it.
> > > >
> > > > Does that mean that CONFIG_PM also affects the FU740?
> > >
> > > Yes, we got the same problem on the FU740. We are checking the issue.
> > >
> > Just a mild ping, any progress regarding this issue?
>
> Currently, if runtime power management is enabled, macb driver would
> go to sleep at the end of macb_probe, then the gigabit ethernet PLL
> would be disabled.  During this period of time, the system would hang
> up if we try to access GEMGXL control registers, it means that we
> can't access GEMGXL control registers before the gigabit ethernet PLL
> is resumed again. There are some cases, for example, if we execute the

Sounds familiar.

> 'ifconfig' command, it would eventually go to the macb_get_status to

Do you mean mac_get_stats()? macb_get_status() does not exist.

> access GEMGXL control registers and cause the system to hang up. Give
> more example here, if we execute 'ip link set lo up & ip addr add
> 127.0.0.1/8 dev lo', it would cause the system to hang up, because
> these commands would try to query the interfaces and eventually go to
> macb_get_status as well. However, if we can resume the gigabit
> ethernet PLL first, such as 'ip link set eth0 up' or 'udhcpc', then
> everything goes well. I'm trying to figure out if there are some hooks
> that we can check the PLL status in the macb driver before it actually
> touches the control registers. If anyone has an idea about that,
> please feel free to point it out to me, thanks.

And you cannot call pm_runtime_get_sync(), as this is called from
atomic contect. Other drivers avoid accessing the registers while
the device is not up, cfr. e.g. commit 7fa2955ff70ce453 ("sh_eth:
Fix sleeping function called from invalid context").

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
