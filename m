Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10D3D35F5F7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 16:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233823AbhDNONf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 10:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbhDNONd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 10:13:33 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8253C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 07:13:12 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 125-20020a4a1a830000b02901b6a144a417so4627284oof.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 07:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sb+yeDNpNA+Bz8H8xtWBwZnjUmpmY3Grk6ocFL4I/TQ=;
        b=HVfk+QtkxRTNz90nOoRDFi1g41C5yA5NI/ndLkdC2nUXutLyI0cslXbLRurCPBCNIp
         6P1nWTfHukY5aUH9ge6nL0/7tuPhJiOVRjTGSjn01VihAi5+D9DqH0yVSNTAZzge9FH0
         eClYBXJwNw+fiSRccdpqbtOX1sih8b1fMI5CB2q6pQKwN24LAPV9nVRBsOQ4R+UlJrvp
         ZS66rwnXzQ1n/r0TGT0Ltnclq3Z2dhqbmDZENQxVBOvkM/ci8U2MrwgiW7KW/QCTkwWr
         7MXKkeQIgRWHYn7Q7jju7/9tGgU2tl3UfYj02SBFrgOe/h1hZohzbpzID2cSeV14xDom
         LtYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sb+yeDNpNA+Bz8H8xtWBwZnjUmpmY3Grk6ocFL4I/TQ=;
        b=hGCtbJc3K3ZhHM/NzSXowHfO2cXupxVzGCJYV42+W+lekvfEhJlc+VjDMs+ylvuWoH
         yP7CkL3DPncqtCa1naZg7sZSaOFvlw0MQ3YBYCo6gc+SNe8lDIYTRAHaOfRJv88fOFfo
         06asxlNlYHDhy9OFTk1JHNiKQULcaNznHOe+KS0+y6+u0gPehyFPyzIuQp4KlAlnXtOM
         0fzIPtai5NjCZDapWeXca9OovhiXC9v0/2svYVV+ebJZx/KRvAguZPGg54IcR4Ux+OnW
         Zz9f9MazxIS5jb2T7ybJN+9+0zIXJdm4nKJuq3rEET5/Wv9+wCD+ssOkzIdUGKDbhk/w
         +q+g==
X-Gm-Message-State: AOAM531sa0qjNI4nofx5hmlu2jeCDrgkI5IEyLx/SpKgpM/CYVVE8QJD
        rAcUYRqDs2pqaIN1RqinTqGN2+aCy2SfOUU0ULtlHA==
X-Google-Smtp-Source: ABdhPJzVqDgUTs0CSOHiGCtXMVUP29nRAd/nar8/zWXZGwSyMpmH6yKoTRiRNGStUZoW4T97KmUZzdsisS7I7MQE5SE=
X-Received: by 2002:a4a:925a:: with SMTP id g26mr18617165ooh.29.1618409592066;
 Wed, 14 Apr 2021 07:13:12 -0700 (PDT)
MIME-Version: 1.0
References: <20201209094916.17383-1-zong.li@sifive.com> <87v99qyjaz.fsf@igel.home>
 <CANXhq0oLxFK1431WmTj5HRO5k_omYkQZCBTG+HORTk9=W_XyNg@mail.gmail.com>
 <CANXhq0p90Cgha_zLzxamK9mxmVPn3effh_cZq_CTLrcAkKZg2Q@mail.gmail.com>
 <87lfaj7cki.fsf@igel.home> <871rc4on36.fsf@igel.home> <CANXhq0pDge0BPgAjoLrX7Y2qtofb3dhV1_CPHBaCg0o4cEMrbQ@mail.gmail.com>
 <87a6qrk2pw.fsf@igel.home> <CANXhq0rOeAWnRYHAYKJfDeY4kYz6+5mU_dJSqU67+2p9u0STHQ@mail.gmail.com>
 <874kgyfetu.fsf@igel.home> <CANXhq0rE-ZcPBp02Pvozpk_s-j6NhxHUmso75uz6ji9bejO8gA@mail.gmail.com>
 <87h7kukzy4.fsf@igel.home> <CANXhq0r5_xhFu3W9mUFkp_7BYUVBzvHZE1A6jpBDcL_KwTc1cA@mail.gmail.com>
 <87tuob7n8g.fsf@igel.home>
In-Reply-To: <87tuob7n8g.fsf@igel.home>
From:   Zong Li <zong.li@sifive.com>
Date:   Wed, 14 Apr 2021 22:13:00 +0800
Message-ID: <CANXhq0rTC8grpRe_Q0vG6_52b-41OuN4vHum8RvouMbE6xiXpQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] clk: add driver for the SiFive FU740
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
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

On Mon, Apr 12, 2021 at 7:31 PM Andreas Schwab <schwab@linux-m68k.org> wrot=
e:
>
> On M=C3=A4r 31 2021, Zong Li wrote:
>
> > I found that the gemgxlpll was disabled immediately by power
> > management after macb driver install. The mainline's defconfig doesn't
> > enable CONFIG_PM, so the network is fine on it. The opensuse defconfig
> > enables CONFIG_PM, and the patch
> > 732374a0b440d9a79c8412f318a25cd37ba6f4e2 added the enable/disable
> > callback functions, so the gemgxlpll PLL, I have no idea why power
> > management disable it, I would keep trace it.
>
> Does that mean that CONFIG_PM also affects the FU740?
>

Yes, we got the same problem on the FU740. We are checking the issue.

> Andreas.
>
> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint =3D 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC=
1
> "And now for something completely different."
