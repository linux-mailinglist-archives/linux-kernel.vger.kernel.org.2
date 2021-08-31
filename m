Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5D13FCE12
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 22:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241005AbhHaTyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 15:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238633AbhHaTyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 15:54:49 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E3EC061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 12:53:53 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id u15so219194wmj.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 12:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qQ7pRpfj3Zvhm7mtC8636KmrgJunLoZPtX0Bf0A/Whw=;
        b=kuDYr9xO5OpyFL0y8r/WxNtqmTwOYUJc9AMOyYOtaHl2NUbh7topJfQoiJpt4s0l+6
         ADFBe9aovwAjs4wNe2EA4+I4pHO+fftDvDG/ReRFk+7PTuPJEA04l61TiGN/J2Gc3YY/
         2SoDwkHetZPQ7KdIWx577FLJEVDvqZqLjwXgGSo5VWfraljZ/Gmg3dLbC4w/4w1s1EPN
         xiBEN7xNAfNETBBy6+tbxE1e24WyG2SapbkCsfyHovrdmpWVCmwsPgAg9uckdAw0KWnM
         P9xP77tQ3UO4sanXYfUEUy0Olysk1hMKn5vGGLCvtb9HttGgcIZp954U8gFOsAGImbFl
         wl9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qQ7pRpfj3Zvhm7mtC8636KmrgJunLoZPtX0Bf0A/Whw=;
        b=lHG8qRjvGbj+/zxbSQ71yDBS2fOa6Om/yHf8/67BKAw9SsPMMnMOX1Ovkfh3CKa92v
         r3p6T7AhCHW+nVg0Ed6N9eFQBwpm9ycLjXhNB1mGec4csuY+xpskXMdnn35XEm3JDXTx
         XAnvsvFGRSame+b1jtJZP0h+B7VI7nmvDcizrAzfcUrG1Om0VJmanzLslGJ9jzzHrrkr
         XsOGYWxj3aNORvGm7vFEFfdDQKRAGxwM5z3eG7PWAm9Zc/92MQA8K5yCXwrdGYAaso0l
         QzHkfkIwg2B59JJeICNvxAQzJMyCTr9NihjEh8KQbOAmdSDdkd2w/Nb8H55gIZQR13Hz
         nROg==
X-Gm-Message-State: AOAM531ovLqe6YgTL1WG/D5+gj8gH8PnwLX5vhmhTBx2vNIgSptxZGz/
        er2It2wpdlVe8SFC9RatHjc=
X-Google-Smtp-Source: ABdhPJxGWxr4kDCDpQ6LMo42hH4LRXFBwPKhVoasjCcPzF94SSAdxocVyGF3wev5aGuu+rtKUuESqA==
X-Received: by 2002:a1c:f712:: with SMTP id v18mr5904179wmh.25.1630439632249;
        Tue, 31 Aug 2021 12:53:52 -0700 (PDT)
Received: from kista.localnet (cpe-86-58-29-253.static.triera.net. [86.58.29.253])
        by smtp.gmail.com with ESMTPSA id k25sm20318237wrd.42.2021.08.31.12.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 12:53:51 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        =?utf-8?B?Q2zDqW1lbnQgQsWTc2No?= <u@pkh.me>,
        Willy Liu <willy.liu@realtek.com>,
        Rob Herring <robh+dt@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] arm64: dts: sun50i: h5: NanoPI Neo 2: phy-mode rgmii-id
Date:   Tue, 31 Aug 2021 21:53:50 +0200
Message-ID: <1746741.3t3T1tWQfl@kista>
In-Reply-To: <YS1SsqDgGFOvyIT0@lunn.ch>
References: <20210830151645.18018-1-u@pkh.me> <116454729.UZi3dMzWh7@jernej-laptop> <YS1SsqDgGFOvyIT0@lunn.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew!

Dne ponedeljek, 30. avgust 2021 ob 23:50:42 CEST je Andrew Lunn napisal(a):
> On Mon, Aug 30, 2021 at 10:49:37PM +0200, Jernej =C5=A0krabec wrote:
> > Hi!
> >=20
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
> Hi Jernej
>=20
> I would say, it is debatable. The board broke when the driver started
> acting on the value, which is commit bbc4d71d6354. It could be argued
> it was always technically broken, since it has the wrong value, but
> practically, it was not broken. One of the rules for stable is:
>=20
>  - It must fix a real bug that bothers people (not a, "This could be a
>    problem..." type thing).
>=20
> So i would argue, anything before bbc4d71d6354 does not fulfil stable
> requirements, since it does not bother anybody.

True, but then again, DT is a bit special, since it's not used only by Linu=
x.=20
It's shared at least with BSDs and U-Boot, which most likely have independe=
nt=20
driver implementation. That's why it's good to have DT fixes referencing DT=
=20
related commits. As you said, DT described HW wrong.

Looking at past Allwinner related DT commits regarding this issue, we were =
not=20
totally consistent. Most of them reference commit where emac node was=20
introduced in DT. But I also found a couple of commits which indeed have fi=
xes=20
tag for bbc4d71d6354.

Best regards,
Jernej

>=20
>       Andrew
>=20


