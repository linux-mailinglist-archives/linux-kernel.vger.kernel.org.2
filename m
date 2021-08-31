Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011893FCE43
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 22:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240870AbhHaUS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 16:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240997AbhHaUSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 16:18:54 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B936C061764
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 13:17:59 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id x2-20020a1c7c02000000b002e6f1f69a1eso3099107wmc.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 13:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eTA4MTa9fR7VQl13W35WSPsOZXqyOOwDKcbbECJxILw=;
        b=G3z6lMvK9dc+oIbe10pHol1ME0wuCgBBEhuDUYy4KRHTHkIP+f2/0op8WYYdbodZGl
         5Ey8pzsGLFOvKwE9uZjxa+/CtjRoiRSNMGf7/kpWAI/dboyehMeOmQRdLLfRnWdhJkF2
         eRS566MiVYLuEnJ+gYRM72BJ3B1A1qIp2VPxi4yuYI2EP6Hs5uksIRThWp3R8M0a4yuY
         BGBIpUEtaqHyn/5oMWnysrc6DuqtDySLFLr5jpt40W+uAZQ0D9LbPvw7Jr9sx1bw8rYw
         nySCH+kIPMmzNUxYxW4Tm6ofO1GxQ8rKd2OiTombEmBKbBmOjGBV6n36vm69+tHrzZLD
         OBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eTA4MTa9fR7VQl13W35WSPsOZXqyOOwDKcbbECJxILw=;
        b=BDzK+Ip5J4roTPZceMhIibZdh1L4Df3LZ0XwJY4Y+s0lC3cMiYcph4Fm5oYl+47yzo
         g6g3G6IxmSP7oqnyGMHD0r0aZhuKN0L8HgbDiax2i9pB4GGA4/5J6iNBlaZeWLvdUNLp
         bXzjpk19WWJun4P1y6snQVjhWx6HGzADVzxYheVmalGQTw8r4Wmcv7pSn/TSNSTQO9cq
         uGxUnqwVCy1RYwHCbVOcn401/3D65sxtZKLJ/Fhc04na+teAdg2F6u7Gl0Oxg3dlZCOS
         ashRR/hEonckf+V9muDG96a7kNn1r2NegT4q/bor01+Qrx2pywAQhPShp2wO9cL/Oz1o
         c0vQ==
X-Gm-Message-State: AOAM532Jl1i+FU+aAniYbsppa6NoRgIo9Yb8RVVPtgWyNFwo6Sjl5CyI
        DuaUexhdARKGuldOpYbA2Tw=
X-Google-Smtp-Source: ABdhPJwDme9//+ocNFePWdkzBV2WpSwAReezNa5CDT36Ft0F9wihyqeujVjDZqvfUmnPB7f6zyG9UQ==
X-Received: by 2002:a1c:4cd:: with SMTP id 196mr6146070wme.10.1630441077752;
        Tue, 31 Aug 2021 13:17:57 -0700 (PDT)
Received: from kista.localnet (cpe-86-58-29-253.static.triera.net. [86.58.29.253])
        by smtp.gmail.com with ESMTPSA id q11sm3508781wmc.41.2021.08.31.13.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 13:17:57 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     =?utf-8?B?Q2zDqW1lbnQgQsWTc2No?= <u@pkh.me>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Willy Liu <willy.liu@realtek.com>,
        Rob Herring <robh+dt@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] arm64: dts: sun50i: h5: NanoPI Neo 2: phy-mode rgmii-id
Date:   Tue, 31 Aug 2021 22:17:56 +0200
Message-ID: <4192454.QcIURlJl1r@kista>
In-Reply-To: <YS1Mwz+fT9P2qskW@ssq0.pkh.me>
References: <20210830151645.18018-1-u@pkh.me> <116454729.UZi3dMzWh7@jernej-laptop> <YS1Mwz+fT9P2qskW@ssq0.pkh.me>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Dne ponedeljek, 30. avgust 2021 ob 23:25:23 CEST je Cl=C3=A9ment B=C5=93sch=
 napisal(a):
> On Mon, Aug 30, 2021 at 10:49:37PM +0200, Jernej =C5=A0krabec wrote:
> > Hi!
> >=20
>=20
> Hi,
>=20
> > Dne ponedeljek, 30. avgust 2021 ob 17:16:45 CEST je Cl=C3=A9ment B=C5=
=93sch=20
napisal(a):
> > > Since commit bbc4d71d6354 ("net: phy: realtek: fix rtl8211e rx/tx del=
ay
> > > config") network is broken on the NanoPi Neo 2.
> > >=20
> > > This patch changes the phy-mode to use internal delays both for RX and
> > > TX as has been done for other boards affected by the same commit.
> > >=20
> > > Fixes: bbc4d71d6354 ("net: phy: realtek: fix rtl8211e rx/tx delay con=
fig")
> >=20
> > This commit fixes DT issue, so "fixes" tag should be:
> > Fixes: 44a94c7ef989 ("arm64: dts: allwinner: H5: Restore EMAC changes")
> >=20
> > Here, a node with wrong phy-mode property was added to NanoPi Neo 2 boa=
rd=20
DT. =20
>=20
> Shouldn't I add it instead of replacing? I followed what I observed in
> `git log --grep bbc4d71d63` where all the commits pretty much follow this
> pattern: that commit is the one causing the actual observed regression,
> while 44a94c7ef989 is much older, and while it's wrong, it wasn't causing
> an issue in practice.
>=20
> Or did I misunderstand something?

With that grep command you limited yourself only to those commits which=20
reference this particular commit. There are others, which also change "rgmi=
i"=20
to "rgmii-id" and reference other commits, like:
544cc3f8573b ("arm64: dts: allwinner: h6: orangepi-one-plus: Fix ethernet")
97a38c1c213b ("arm64: dts: allwinner: beelink-gs1: Enable both RGMII RX/TX=
=20
delay")
(there are more).

Anyway, let's continue this discussion in Andrew's thread.

>=20
> > Other than that, this patch is fine and once fixes tag is fixed, you ca=
n add:
> > Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> >=20
> > For next version, you should:
> > - change fixed tag
> > - add my review-by tag right above your signed-off-by tag
> > - mark patch as v2 (add "-v2" parameter to git format-patch)
> > - describe change right under "---" line
> >=20
>=20
> Will do.

Please wait until discussion reaches a conclusion.

>=20
> > Note, if you borked something when sending, you should mark patch or pa=
tch=20
> > series as "RESEND", so recipients don't look for changes in two subsequ=
ent=20
e-
> > mails (--subject-prefix=3D"RESEND PATCH").
>=20
> Not sure I follow you so before I disturb everyone with more noise I'd
> just like to confirm: you mean a git send-email in-reply-to=3D[broken pat=
ch
> attempt] (the one where I borked the --cc), right? But with what patch?
> I'm a bit confused here.

That's just for the future reference. No need to do anything now for this=20
patch. If you bork any send attempt in the future, recreate same patch(es)=
=20
with this additional tag ("RESEND") and send them again.

>=20
> > Thanks for the fix!
>=20
> No problem; I really think a scan of all the other boards would be
> meaningful though, it looks like a lot of them got fixed but there are
> many other candidates and the issue feels pretty critical to me
> (regression, and no network at all).

I guess you speak for all boards, not just those with Allwinner SoC? I fixe=
d as=20
many boards as I have - testing is very desired. On some boards rgmii was=20
changed to rgmii-txid, so it's not as straightforward as search and replace=
=2E=20
It could be also deducted from schematics, but at least one Allwinner board=
=20
has this configured in HW wrong (SW fix was needed for that board) and othe=
r=20
boards might not have schematics publicy available.

In short, I wouldn't start mass generating patches for this.

Best regards,
Jernej

>=20
> --=20
> Cl=C3=A9ment B.
>=20


