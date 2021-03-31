Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE8534FB46
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 10:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234303AbhCaILj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 04:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234316AbhCaILc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 04:11:32 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E0CC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 01:11:31 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id w31-20020a9d36220000b02901f2cbfc9743so18153910otb.7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 01:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dB0gWAEfZHKWfkYzrwK4EeStUrUWxM9Hj/xXv+mALOI=;
        b=NfAdeXgL3iBuXyT9lp5nzsqiQkroT5annb1uZOmXLpNXmjk+hpy6F0F+FRveH5r1/1
         XUzWiLPwYLgMQpX7ndNKM/1Qb31qLumbWtNZQusMYrgg8eMH1glsHsq/VJKJN5v2OYR8
         qlBQFWstfKVN2XnQPUDzNgkhphm66qbGOBTBFija6FUExwqS3l/h9zS9h/dnZ35ZwNPY
         xKL9YsEOPaF9+P7hWg1B/adoSFuYlqcuzoKUqDELe9HIeVvQKUk279LunGX4e4WH6Z0g
         6bohdzIgiulsiOxgbI7yia63Elb8jGWDWKhOgYMlcQwDermLHfQijNchYgbhutEiOEjD
         /VVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dB0gWAEfZHKWfkYzrwK4EeStUrUWxM9Hj/xXv+mALOI=;
        b=NaUhzH1Ykw3Ac4epf4uaXyzQfKOyozgAE3IcWUdubuccACiA0Py+aLsifd/1a9AaZV
         +8qTCEOyLJBRkyhd3ENvFoEdysB9Nltmo70ooH8L+eAKco8T5GLyGR/inWrfaA6OlA7U
         4Bqyjhb2aFLBLv5PZDcqs5v4+dvlDPRYN5vzA2ayOzKm0el5g+8cMeUC7MclfpBRY+QN
         3L3ZMJz226UK3iF5cnZlwht8IIWBuA5bnHw/+wsn1JnjOXGoHmnRbuAqTik5v/MnxQJX
         8U7/Ka+pYX72BFTj5TllizIXlGmnOpVC3vTuZLT7vuu1gwGsU8imvGfPAtzC+pGZekPd
         u1xQ==
X-Gm-Message-State: AOAM530K3FStLuqz/JZrLj71HEdZzD0NdWmHOOzCGF9hyOzAKvRLr7ip
        iKgVif1E/rbKeCk03n3CFLM4aWLfwX0XT8aBzIZ/9Q==
X-Google-Smtp-Source: ABdhPJwncnEGkqPa53glb2cwgGqHNjR8JoKY4ey9u94NBOGSLTlyqhNGXBFQt2Q3v3VffMEnW3Ti9RMoqF56AIEeisY=
X-Received: by 2002:a9d:6249:: with SMTP id i9mr1781965otk.166.1617178290874;
 Wed, 31 Mar 2021 01:11:30 -0700 (PDT)
MIME-Version: 1.0
References: <20201209094916.17383-1-zong.li@sifive.com> <87v99qyjaz.fsf@igel.home>
 <CANXhq0oLxFK1431WmTj5HRO5k_omYkQZCBTG+HORTk9=W_XyNg@mail.gmail.com>
 <CANXhq0p90Cgha_zLzxamK9mxmVPn3effh_cZq_CTLrcAkKZg2Q@mail.gmail.com>
 <87lfaj7cki.fsf@igel.home> <871rc4on36.fsf@igel.home> <CANXhq0pDge0BPgAjoLrX7Y2qtofb3dhV1_CPHBaCg0o4cEMrbQ@mail.gmail.com>
 <87a6qrk2pw.fsf@igel.home> <CANXhq0rOeAWnRYHAYKJfDeY4kYz6+5mU_dJSqU67+2p9u0STHQ@mail.gmail.com>
 <874kgyfetu.fsf@igel.home> <CANXhq0rE-ZcPBp02Pvozpk_s-j6NhxHUmso75uz6ji9bejO8gA@mail.gmail.com>
 <87h7kukzy4.fsf@igel.home>
In-Reply-To: <87h7kukzy4.fsf@igel.home>
From:   Zong Li <zong.li@sifive.com>
Date:   Wed, 31 Mar 2021 16:11:20 +0800
Message-ID: <CANXhq0r5_xhFu3W9mUFkp_7BYUVBzvHZE1A6jpBDcL_KwTc1cA@mail.gmail.com>
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

On Mon, Mar 29, 2021 at 6:37 PM Andreas Schwab <schwab@linux-m68k.org> wrot=
e:
>
> On M=C3=A4r 29 2021, Zong Li wrote:
>
> > Yes, I could get the network problem by using the defconfig you
> > provided, the system hung up when executing 'ifconfig' immediately
> > after installing macb driver module, the network can work by only
> > reverting the commit 732374a0b440d9a79c8412f318a25cd37ba6f4e2. But the
> > network is fine by using the mainline's defconfig, this is a little
> > bit weird, I will check that and try to find the difference.
>
> My guess would be that it is an init dependency problem between the phy
> driver and the clock driver, which causes the clock to be enabled too
> late.
>

I found that the gemgxlpll was disabled immediately by power
management after macb driver install. The mainline's defconfig doesn't
enable CONFIG_PM, so the network is fine on it. The opensuse defconfig
enables CONFIG_PM, and the patch
732374a0b440d9a79c8412f318a25cd37ba6f4e2 added the enable/disable
callback functions, so the gemgxlpll PLL, I have no idea why power
management disable it, I would keep trace it.

By the way, I tried to disable CONFIG_PM on oenpsuse defconfig, the
system didn't hang anymore, on the contrary, I enable CONFIG_PM on
mainline's defconfig, I expect that the system would hang up as well,
unfortunately, I cannot boot successfully by just enabling CONFIG_PM
easily.


> Andreas.
>
> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint =3D 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC=
1
> "And now for something completely different."
