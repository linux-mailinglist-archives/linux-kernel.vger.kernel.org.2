Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25E9438C72F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 14:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbhEUMzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 08:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235745AbhEUMyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 08:54:41 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FC5C061355
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 05:52:47 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id c10so8519487lfm.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 05:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LBz0N/H2AYuYTe99L8IN2L1BlOwoBdUWjJLDEKhnr/c=;
        b=T69z0LmTzeJXqaXwhcq8MJjVHKJXg9U71fbL/y7Ge+6wDLZz1pVZIXbwHFa6W1Efhb
         pXq5DGM4oK9ZwQpLcgd5ruvaTx4X9xrzjlWK7urFF+j1pjVHhXctaxXaoRyMEWGFq0wO
         eoNhHljM27F8zq6cXzucBN0qYlBKNa80Vxl0M0EtllYx/6PXZ2yufMu63S3xwB/MEFyJ
         +TmEnHfIz4DoOsm7R6qyL1EclVXT/VlQUWp5KadgT7sLGv7UNRBqSEBVXeJWy3ow2LrW
         iVWDRTIUWF8Kx0mM0ZZjNCDYMt/uiz7puubquehd6sfCdjrst/HOILtXG9yY42WHICDh
         /2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LBz0N/H2AYuYTe99L8IN2L1BlOwoBdUWjJLDEKhnr/c=;
        b=cvnSUhB+RgAfZZrlcrz1vW+o8II/979FtDCsB2HC9CxrL8kh06gbzGJAGdpMMnsCzj
         E6Okxkim733lEaYX850aURhtFXvsa1ZZ7//2XnEqvqulK3taH5mF5gZI6wyZ5cY5rKD1
         Vh0ti/79/584sicYVrNucNXk8IhRn3UtHIHPCItoY910giIlPxJtgjJUFiHstrQ+L3Lg
         +xkja10+9gAh6YtSSwl8edKoLvbBW8UUPNTQ2KzokgMlLjKQI9s0jvHpgRzllmMDUOjz
         EpgHCqEE+WCZeR8xWc6VR3VIfZBh3eY1bQeBiW7VBfS0Vj7X6j8eI5sB5i5YnaH69zHM
         vNCg==
X-Gm-Message-State: AOAM530WKQbkyvBMtGtHZiwdU6l+YFBmidx/s4MAREL//KRq+XtXuIMd
        4ped1WtyZMb/AF+Fq/L/T/1+wWWTyV8K8vU7Ppf8agfLVRUIQg==
X-Google-Smtp-Source: ABdhPJxJCEu3ybVS+4YwTXi9Tv690RJ4IER7AHDybYUJS0fNdZNOP5aGEAudYSxXd7RnRNi7iCN5Dn8fXIIQnydPELI=
X-Received: by 2002:ac2:53b2:: with SMTP id j18mr2135683lfh.127.1621601565829;
 Fri, 21 May 2021 05:52:45 -0700 (PDT)
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
 <CANXhq0q-ou6h_Qxjtq52RQ_V2ERu8JLNa7Vq77Rpv_+SFX4LNA@mail.gmail.com>
 <CAMuHMdWGakAT1LKg_sje=ZYTbLX1_BjjOsqOYP9KrzhMmMi6Ag@mail.gmail.com> <CANXhq0oa+Sbk0jgXAkOYfutGqx+W+ToD5LuTLSkNCRFOm_=WYQ@mail.gmail.com>
In-Reply-To: <CANXhq0oa+Sbk0jgXAkOYfutGqx+W+ToD5LuTLSkNCRFOm_=WYQ@mail.gmail.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Fri, 21 May 2021 20:52:35 +0800
Message-ID: <CANXhq0pvR3pNaHPYJxy6zs03Sgd-viwUPidKjPz5792tAYoj-A@mail.gmail.com>
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

On Fri, May 21, 2021 at 6:34 PM Zong Li <zong.li@sifive.com> wrote:
>
> On Thu, May 20, 2021 at 2:17 AM Geert Uytterhoeven <geert@linux-m68k.org>=
 wrote:
> >
> > Hi Zong,
> >
> > On Wed, May 19, 2021 at 5:55 PM Zong Li <zong.li@sifive.com> wrote:
> > > On Tue, May 11, 2021 at 4:57 PM Yixun Lan <yixun.lan@gmail.com> wrote=
:
> > > > On Wed, Apr 14, 2021 at 2:25 PM Zong Li <zong.li@sifive.com> wrote:
> > > > > On Mon, Apr 12, 2021 at 7:31 PM Andreas Schwab <schwab@linux-m68k=
.org> wrote:
> > > > > > On M=C3=A4r 31 2021, Zong Li wrote:
> > > > > > > I found that the gemgxlpll was disabled immediately by power
> > > > > > > management after macb driver install. The mainline's defconfi=
g doesn't
> > > > > > > enable CONFIG_PM, so the network is fine on it. The opensuse =
defconfig
> > > > > > > enables CONFIG_PM, and the patch
> > > > > > > 732374a0b440d9a79c8412f318a25cd37ba6f4e2 added the enable/dis=
able
> > > > > > > callback functions, so the gemgxlpll PLL, I have no idea why =
power
> > > > > > > management disable it, I would keep trace it.
> > > > > >
> > > > > > Does that mean that CONFIG_PM also affects the FU740?
> > > > >
> > > > > Yes, we got the same problem on the FU740. We are checking the is=
sue.
> > > > >
> > > > Just a mild ping, any progress regarding this issue?
> > >
> > > Currently, if runtime power management is enabled, macb driver would
> > > go to sleep at the end of macb_probe, then the gigabit ethernet PLL
> > > would be disabled.  During this period of time, the system would hang
> > > up if we try to access GEMGXL control registers, it means that we
> > > can't access GEMGXL control registers before the gigabit ethernet PLL
> > > is resumed again. There are some cases, for example, if we execute th=
e
> >
> > Sounds familiar.
> >
> > > 'ifconfig' command, it would eventually go to the macb_get_status to
> >
> > Do you mean mac_get_stats()? macb_get_status() does not exist.
>
> Sorry for the typo, it should be macb_get_stats.
>
> >
> > > access GEMGXL control registers and cause the system to hang up. Give
> > > more example here, if we execute 'ip link set lo up & ip addr add
> > > 127.0.0.1/8 dev lo', it would cause the system to hang up, because
> > > these commands would try to query the interfaces and eventually go to
> > > macb_get_status as well. However, if we can resume the gigabit
> > > ethernet PLL first, such as 'ip link set eth0 up' or 'udhcpc', then
> > > everything goes well. I'm trying to figure out if there are some hook=
s
> > > that we can check the PLL status in the macb driver before it actuall=
y
> > > touches the control registers. If anyone has an idea about that,
> > > please feel free to point it out to me, thanks.
> >
> > And you cannot call pm_runtime_get_sync(), as this is called from
> > atomic contect. Other drivers avoid accessing the registers while
> > the device is not up, cfr. e.g. commit 7fa2955ff70ce453 ("sh_eth:
> > Fix sleeping function called from invalid context").
> >
>
> Thanks for your help. I have done the similar modification by
> following the patch you provided. I also verified the bug that we use
> pm_runtime_get_sync there. I'm going to post the fix patch by adding
> the is_opened flag.
>
> Thanks again.

I have posted a patch to fix this problem. Many thanks to all in this threa=
d.

https://lore.kernel.org/netdev/20210521124859.101012-1-zong.li@sifive.com/T=
/#u

>
> > Gr{oetje,eeting}s,
> >
> >                         Geert
> >
> > --
> > Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org
> >
> > In personal conversations with technical people, I call myself a hacker=
. But
> > when I'm talking to journalists I just say "programmer" or something li=
ke that.
> >                                 -- Linus Torvalds
