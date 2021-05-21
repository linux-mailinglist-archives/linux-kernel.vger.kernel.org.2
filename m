Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9580738C507
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 12:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbhEUKgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 06:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbhEUKgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 06:36:04 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77604C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 03:34:41 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id m11so28991945lfg.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 03:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kK6AgO7HXHFP2fUm42xaKIkwVFtfr7s4UEqCfpCwl+E=;
        b=KLXsG/m7VYE4A5kFfihQ0nvrjjtWr64VfJ9MIsUDEDaoUyzf2ksfVsY/hmHWk438jS
         gLj5ArZ5pG1grRrw5FkQnoUQqQE+U7K5HcAHszoNLaxEkUxhOrVwF4qrvota1Kw2P2fe
         pWOQPAwZuwM86fZcM9Qamfdw6W8EZbZhEVbaHAxlS4c92PbRxLfLOk7VUZXk7wezpPQD
         Jvbi6GwEMC7NQBO8wtaqJIXJ/xzYIVlWYtwWcXOwtsrIdV0U6Ggiug4zcNbKq6f6svKx
         fRTRkXhcnT6KVbQFcDaqdUxDGlslzVyddWeW13BVjEfs5MEZsJKGOJhaXYTHvvNv+Wpr
         BuXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kK6AgO7HXHFP2fUm42xaKIkwVFtfr7s4UEqCfpCwl+E=;
        b=drln/ynK7P8w4MPSO2zUNBzXqIfT2F3ZSVgucLtWn4UCRbVz+Ud1Kor23EfT0OrCVu
         fKAKS4vJbgyPubIMJE/DfgqfMEnmnSI6h/iMaDYd6dg5gvRldwNF1yqBTJ64uMCFk0r4
         OFk8Yw2yt4clQWe67fjeoPUv9rQyNtsVTOF9WAAoGVb/7fU/vodKNwByZ2QWNAFBKee8
         qsW6V82vRccGGR7Kpluro+cuXjn1DN/SYBBT4bBxjl5QtBFU452KjmeMcCFd/r72+uL0
         d7R/9QsgZsQY1Qj/vfQgpzkdYeeJPb7ErGDOKGZXiUZdyM6DpJKzvP//wRYj7Ig4hmsJ
         2o1A==
X-Gm-Message-State: AOAM533/co/tn4SvKRMxv+9IIQDc92nj0OtUG5x5cMSaQ8oG6DkdAGHP
        iyMJxpFhKdutMsLOcEd9jUtXg8hN6He4S9uvSBaJZw==
X-Google-Smtp-Source: ABdhPJxr8ksjnYYXAwQIU7SpRtn3uwwJcFL9tmSo9bdWPAP79uBcFzKF+7mYOD4NtS1AzPmeD2LebBnkFx9Z60j91qk=
X-Received: by 2002:a05:6512:471:: with SMTP id x17mr1771096lfd.553.1621593279771;
 Fri, 21 May 2021 03:34:39 -0700 (PDT)
MIME-Version: 1.0
References: <20201209094916.17383-1-zong.li@sifive.com> <87v99qyjaz.fsf@igel.home>
 <CANXhq0oLxFK1431WmTj5HRO5k_omYkQZCBTG+HORTk9=W_XyNg@mail.gmail.com>
 <CANXhq0p90Cgha_zLzxamK9mxmVPn3effh_cZq_CTLrcAkKZg2Q@mail.gmail.com>
 <87lfaj7cki.fsf@igel.home> <871rc4on36.fsf@igel.home> <CANXhq0pDge0BPgAjoLrX7Y2qtofb3dhV1_CPHBaCg0o4cEMrbQ@mail.gmail.com>
 <87a6qrk2pw.fsf@igel.home> <CANXhq0rOeAWnRYHAYKJfDeY4kYz6+5mU_dJSqU67+2p9u0STHQ@mail.gmail.com>
 <874kgyfetu.fsf@igel.home> <CANXhq0rE-ZcPBp02Pvozpk_s-j6NhxHUmso75uz6ji9bejO8gA@mail.gmail.com>
 <87h7kukzy4.fsf@igel.home> <CANXhq0r5_xhFu3W9mUFkp_7BYUVBzvHZE1A6jpBDcL_KwTc1cA@mail.gmail.com>
 <87tuob7n8g.fsf@igel.home> <CANXhq0rTC8grpRe_Q0vG6_52b-41OuN4vHum8RvouMbE6xiXpQ@mail.gmail.com>
 <CALecT5jQ7_-d7j+MXrG++Bnr_wYmbWgCK20Ju5Pgjbu9xmwQBA@mail.gmail.com>
 <CANXhq0q-ou6h_Qxjtq52RQ_V2ERu8JLNa7Vq77Rpv_+SFX4LNA@mail.gmail.com> <CAMuHMdWGakAT1LKg_sje=ZYTbLX1_BjjOsqOYP9KrzhMmMi6Ag@mail.gmail.com>
In-Reply-To: <CAMuHMdWGakAT1LKg_sje=ZYTbLX1_BjjOsqOYP9KrzhMmMi6Ag@mail.gmail.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Fri, 21 May 2021 18:34:28 +0800
Message-ID: <CANXhq0oa+Sbk0jgXAkOYfutGqx+W+ToD5LuTLSkNCRFOm_=WYQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] clk: add driver for the SiFive FU740
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2021 at 2:17 AM Geert Uytterhoeven <geert@linux-m68k.org> w=
rote:
>
> Hi Zong,
>
> On Wed, May 19, 2021 at 5:55 PM Zong Li <zong.li@sifive.com> wrote:
> > On Tue, May 11, 2021 at 4:57 PM Yixun Lan <yixun.lan@gmail.com> wrote:
> > > On Wed, Apr 14, 2021 at 2:25 PM Zong Li <zong.li@sifive.com> wrote:
> > > > On Mon, Apr 12, 2021 at 7:31 PM Andreas Schwab <schwab@linux-m68k.o=
rg> wrote:
> > > > > On M=C3=A4r 31 2021, Zong Li wrote:
> > > > > > I found that the gemgxlpll was disabled immediately by power
> > > > > > management after macb driver install. The mainline's defconfig =
doesn't
> > > > > > enable CONFIG_PM, so the network is fine on it. The opensuse de=
fconfig
> > > > > > enables CONFIG_PM, and the patch
> > > > > > 732374a0b440d9a79c8412f318a25cd37ba6f4e2 added the enable/disab=
le
> > > > > > callback functions, so the gemgxlpll PLL, I have no idea why po=
wer
> > > > > > management disable it, I would keep trace it.
> > > > >
> > > > > Does that mean that CONFIG_PM also affects the FU740?
> > > >
> > > > Yes, we got the same problem on the FU740. We are checking the issu=
e.
> > > >
> > > Just a mild ping, any progress regarding this issue?
> >
> > Currently, if runtime power management is enabled, macb driver would
> > go to sleep at the end of macb_probe, then the gigabit ethernet PLL
> > would be disabled.  During this period of time, the system would hang
> > up if we try to access GEMGXL control registers, it means that we
> > can't access GEMGXL control registers before the gigabit ethernet PLL
> > is resumed again. There are some cases, for example, if we execute the
>
> Sounds familiar.
>
> > 'ifconfig' command, it would eventually go to the macb_get_status to
>
> Do you mean mac_get_stats()? macb_get_status() does not exist.

Sorry for the typo, it should be macb_get_stats.

>
> > access GEMGXL control registers and cause the system to hang up. Give
> > more example here, if we execute 'ip link set lo up & ip addr add
> > 127.0.0.1/8 dev lo', it would cause the system to hang up, because
> > these commands would try to query the interfaces and eventually go to
> > macb_get_status as well. However, if we can resume the gigabit
> > ethernet PLL first, such as 'ip link set eth0 up' or 'udhcpc', then
> > everything goes well. I'm trying to figure out if there are some hooks
> > that we can check the PLL status in the macb driver before it actually
> > touches the control registers. If anyone has an idea about that,
> > please feel free to point it out to me, thanks.
>
> And you cannot call pm_runtime_get_sync(), as this is called from
> atomic contect. Other drivers avoid accessing the registers while
> the device is not up, cfr. e.g. commit 7fa2955ff70ce453 ("sh_eth:
> Fix sleeping function called from invalid context").
>

Thanks for your help. I have done the similar modification by
following the patch you provided. I also verified the bug that we use
pm_runtime_get_sync there. I'm going to post the fix patch by adding
the is_opened flag.

Thanks again.

> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
