Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D57B5389309
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 17:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354327AbhESPzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 11:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346825AbhESPzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 11:55:08 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA5BC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 08:53:48 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 131so16229412ljj.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 08:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+h7qBn31/XdOKJhJupPMTX05eKZyP5qewLWYYYVaOa4=;
        b=gKAxLopmId1irlMMaOBYM3XHjyy4rHKldUhIsjxpaOh9yF9PBe6/8DOnOcJXOhSxtL
         PRmQH/6/tIZrJJS3wFonduNEGuEv9Ii602QKjuPmttmSXX5fDNq9ra4edMdO5My3eJSw
         JD1SwaSsm+0yuudPCgmJRpSORU8xHb0guqz0Dh5HjW4D8axJBJYR+O5siDmC8qR3n/vG
         dyC0ksMpziDxYgH2Hc1z6f/xmCKdEbGCW0K6EryBUD5+oQ9ZVG8CNFF5MGLzQXIkuuni
         1xKxAFQPNxtkYAvbkMLcV9DtXl2z4wGunp+DxMHQQO7rc0OVmymqJhzuy27+e+A1jzwz
         2Itg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+h7qBn31/XdOKJhJupPMTX05eKZyP5qewLWYYYVaOa4=;
        b=rgSu7Kv5tjY7TDD7Kn0CzdicfOsrEJHpbIU+g/RRxg1dUkMuzRXHXvDjU2HHu/D3R1
         OSyZonkHpyHyMpsVk51y8LL7LIUlnyXpOUVAPL5gcKEobec3Vt89Mftm5qEe1ppq4sSB
         U7cdv+dKwmWQHgkyuiEuioU0JzWtVczc5j67PiE2UtnbrlD29Q6ctbEK3GQbgTBWPjAp
         qEvlBIkDiiLSIpIEwwdg/1GkovB2gxnLzOxbQA+qVLplGh1kJ3ElCyPUcecFEQlkYFs4
         Z+aMHtUSmb4Hdgbsx/8QM2vJJikRZZaYVSypCctugqKOIw4Cuw8GeEyeBSbTaB1bKzx3
         iMDQ==
X-Gm-Message-State: AOAM530igqhQp80GGx9txeyB2X3Nk2+yuwyGFwAMVrSNXRgBOQsdOGzz
        XT/l8kM1jnI0WyQD9UUXeapL6oiNylACQIpIFjeBxA==
X-Google-Smtp-Source: ABdhPJzstoito5f6ig1I5Nm25wwkcDeVPsvWfkNlrovbdfFlE/8m1RtVJDkkMeKMpjcycWYhfwUlgpNCBUxdQbnJWaE=
X-Received: by 2002:a2e:82c5:: with SMTP id n5mr9289881ljh.191.1621439626369;
 Wed, 19 May 2021 08:53:46 -0700 (PDT)
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
In-Reply-To: <CALecT5jQ7_-d7j+MXrG++Bnr_wYmbWgCK20Ju5Pgjbu9xmwQBA@mail.gmail.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Wed, 19 May 2021 23:53:33 +0800
Message-ID: <CANXhq0q-ou6h_Qxjtq52RQ_V2ERu8JLNa7Vq77Rpv_+SFX4LNA@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] clk: add driver for the SiFive FU740
To:     Yixun Lan <yixun.lan@gmail.com>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Pragnesh Patel <pragnesh.patel@openfive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Michael Turquette <mturquette@baylibre.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 4:57 PM Yixun Lan <yixun.lan@gmail.com> wrote:
>
> On Wed, Apr 14, 2021 at 2:25 PM Zong Li <zong.li@sifive.com> wrote:
> >
> > On Mon, Apr 12, 2021 at 7:31 PM Andreas Schwab <schwab@linux-m68k.org> =
wrote:
> > >
> > > On M=C3=A4r 31 2021, Zong Li wrote:
> > >
> > > > I found that the gemgxlpll was disabled immediately by power
> > > > management after macb driver install. The mainline's defconfig does=
n't
> > > > enable CONFIG_PM, so the network is fine on it. The opensuse defcon=
fig
> > > > enables CONFIG_PM, and the patch
> > > > 732374a0b440d9a79c8412f318a25cd37ba6f4e2 added the enable/disable
> > > > callback functions, so the gemgxlpll PLL, I have no idea why power
> > > > management disable it, I would keep trace it.
> > >
> > > Does that mean that CONFIG_PM also affects the FU740?
> > >
> >
> > Yes, we got the same problem on the FU740. We are checking the issue.
> >
> Just a mild ping, any progress regarding this issue?

Currently, if runtime power management is enabled, macb driver would
go to sleep at the end of macb_probe, then the gigabit ethernet PLL
would be disabled.  During this period of time, the system would hang
up if we try to access GEMGXL control registers, it means that we
can't access GEMGXL control registers before the gigabit ethernet PLL
is resumed again. There are some cases, for example, if we execute the
'ifconfig' command, it would eventually go to the macb_get_status to
access GEMGXL control registers and cause the system to hang up. Give
more example here, if we execute 'ip link set lo up & ip addr add
127.0.0.1/8 dev lo', it would cause the system to hang up, because
these commands would try to query the interfaces and eventually go to
macb_get_status as well. However, if we can resume the gigabit
ethernet PLL first, such as 'ip link set eth0 up' or 'udhcpc', then
everything goes well. I'm trying to figure out if there are some hooks
that we can check the PLL status in the macb driver before it actually
touches the control registers. If anyone has an idea about that,
please feel free to point it out to me, thanks.


>
> Yxun
