Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C321037A2C0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 10:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbhEKI6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 04:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbhEKI6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 04:58:43 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE996C061574;
        Tue, 11 May 2021 01:57:36 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id w22so4518433oiw.9;
        Tue, 11 May 2021 01:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2GM5UN9N24TQvJTRoFkZQ64/JJ8nZjyWhhkhtInsOWQ=;
        b=phW4jI5FWU5J/1V4aHBF/X5nVB8sHBgZgsExEgakm52L4Lx/1PZhKqOMItQKwLhEXz
         olyE1J3ovC/tCl4FjkFsH/J0IJ47FBTp1UISEHGW4jrOEfLqGjFeqwYhao2nF5xnQ5Q9
         FDjQIdUnEo/0oCxR5Jilb+lZJvVE3cO22LbvWE2kynxNQhbsLbqFWksnvw0eHCHlhzQU
         e5qGA60wKUTJPs5aLYdmgKeBFaNs8GxnyHJ6bmUW6whJQy8/YEZyInubYE8ak1frkX3Q
         3htpy1+uK/2QwCMmhc2YTl1/XWL2ZtHIXyYESQ02AF2uyHIYahtHV1xfNLF/7w2Q5V0Z
         J/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2GM5UN9N24TQvJTRoFkZQ64/JJ8nZjyWhhkhtInsOWQ=;
        b=Gd7pryfBZSjSnw1t1cYojEP8yDiFlu4DLgVC0upm1BzD1MBJEpJof3F8zHMLGS6LiR
         MheJBgAK8XY4QmXaAvOr31Lx4i9T9dzTE7m7VXpNF71h2IlVlzrqSxBY0ssq4rz+SxCJ
         kISEkxg9cdgKTh/Vv0z0PTRsnQeYWGqZk8U2BSEuqne+FTqMb4aah4KhvSuAqyq/RRL5
         mkRfFpf4wEvE9gvd/CwreDFfqQ27AocazLTEu0XuRK7KEQM/HWpbR+wLCDTqouUWr0sq
         uxlPfBJmXQNBPCyfpzqpaqojSl3/XtllWEkxnLE4HmDQsg7QEdM8SyXM1OOO7j+SVIT7
         Zh5w==
X-Gm-Message-State: AOAM531DJOpBmn35yHAJFxX3y4u46uPzaUS6YuQAuRWQklLo5+Qg49u5
        9iHgxBTXOL8uZDYSUYqRzbI5MsvXRDg/m/Cnr3A=
X-Google-Smtp-Source: ABdhPJx/vyly/xsGQfudk5VwYktpK3p0PqF9PqTV+9LnINR2W7IrCsW//tJAUqYRTaZs0E6G3NwJIrtoJkRS1IdAsk0=
X-Received: by 2002:aca:c30f:: with SMTP id t15mr21358226oif.145.1620723456379;
 Tue, 11 May 2021 01:57:36 -0700 (PDT)
MIME-Version: 1.0
References: <20201209094916.17383-1-zong.li@sifive.com> <87v99qyjaz.fsf@igel.home>
 <CANXhq0oLxFK1431WmTj5HRO5k_omYkQZCBTG+HORTk9=W_XyNg@mail.gmail.com>
 <CANXhq0p90Cgha_zLzxamK9mxmVPn3effh_cZq_CTLrcAkKZg2Q@mail.gmail.com>
 <87lfaj7cki.fsf@igel.home> <871rc4on36.fsf@igel.home> <CANXhq0pDge0BPgAjoLrX7Y2qtofb3dhV1_CPHBaCg0o4cEMrbQ@mail.gmail.com>
 <87a6qrk2pw.fsf@igel.home> <CANXhq0rOeAWnRYHAYKJfDeY4kYz6+5mU_dJSqU67+2p9u0STHQ@mail.gmail.com>
 <874kgyfetu.fsf@igel.home> <CANXhq0rE-ZcPBp02Pvozpk_s-j6NhxHUmso75uz6ji9bejO8gA@mail.gmail.com>
 <87h7kukzy4.fsf@igel.home> <CANXhq0r5_xhFu3W9mUFkp_7BYUVBzvHZE1A6jpBDcL_KwTc1cA@mail.gmail.com>
 <87tuob7n8g.fsf@igel.home> <CANXhq0rTC8grpRe_Q0vG6_52b-41OuN4vHum8RvouMbE6xiXpQ@mail.gmail.com>
In-Reply-To: <CANXhq0rTC8grpRe_Q0vG6_52b-41OuN4vHum8RvouMbE6xiXpQ@mail.gmail.com>
From:   Yixun Lan <yixun.lan@gmail.com>
Date:   Tue, 11 May 2021 08:53:58 +0000
Message-ID: <CALecT5jQ7_-d7j+MXrG++Bnr_wYmbWgCK20Ju5Pgjbu9xmwQBA@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] clk: add driver for the SiFive FU740
To:     Zong Li <zong.li@sifive.com>
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

On Wed, Apr 14, 2021 at 2:25 PM Zong Li <zong.li@sifive.com> wrote:
>
> On Mon, Apr 12, 2021 at 7:31 PM Andreas Schwab <schwab@linux-m68k.org> wr=
ote:
> >
> > On M=C3=A4r 31 2021, Zong Li wrote:
> >
> > > I found that the gemgxlpll was disabled immediately by power
> > > management after macb driver install. The mainline's defconfig doesn'=
t
> > > enable CONFIG_PM, so the network is fine on it. The opensuse defconfi=
g
> > > enables CONFIG_PM, and the patch
> > > 732374a0b440d9a79c8412f318a25cd37ba6f4e2 added the enable/disable
> > > callback functions, so the gemgxlpll PLL, I have no idea why power
> > > management disable it, I would keep trace it.
> >
> > Does that mean that CONFIG_PM also affects the FU740?
> >
>
> Yes, we got the same problem on the FU740. We are checking the issue.
>
Just a mild ping, any progress regarding this issue?

Yxun
