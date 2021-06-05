Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2F1F39C824
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 14:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhFEMa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 08:30:59 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:53923 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229902AbhFEMa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 08:30:58 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 3E26D5804A2;
        Sat,  5 Jun 2021 08:29:10 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute3.internal (MEProxy); Sat, 05 Jun 2021 08:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type:content-transfer-encoding; s=fm1; bh=1R
        bQgq677nj7G3MUumWQjelLqbrdkBM2pt/CFGcdDww=; b=IWPbj+jS3yyI1hVyW5
        5sN1YgyHOAAM6fqrk2zzGemytyt9Y3iPjsLueBl2TBunTetDC5YbPeGP9y681UJZ
        0k39tUpGZjoiwtDxSXs3VNq+qyspKPfIwoVGz8Sy/zVqp+elJ8Q7TpWLcagAfzTG
        Fl2uhYittvM3zHEWKL6nrG+tY+pyy/9t6iNUwpaPkiYMHZN0LrN9YR8MxzTBo9ks
        kh9JYRUCbjEUPOv9tcBfmvICu690LGywZIq8K0jM+D91SCSt1EYv65huFmOYg+30
        cFj11jFs5i3ieoJWrjeSERdBJ1s88ukANXH/1BYjic7uA3b/KO6/JbhtI+hgbNgw
        Y5ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=1RbQgq677nj7G3MUumWQjelLqbrdkBM2pt/CFGcdD
        ww=; b=ADM+zxMegh80UeqCKmGjOf/Ocfu3mACp0SHiArW5qzrB2UqrIe+7He8GL
        CMuL7ZIHXeyUjBISAuo3oZ6RxK/k4QIzexC9QyF0ty+ERyD0lAFZKeTvZYCIHHut
        zHY0MMM5x6LtZoUHPVCBHZxljMhWK3s1TgZt6aXDewrd7w24MwAWntciDl92O3Bf
        ctxryzULFb8rbi3zEoklA2O0VbBHGPip7rnooYhB1EktosG+U+aaKI5mNa5GWErV
        VWKKPulJc8i/JLr0cUe+wnIk/NOsjDPOS2B/G8mMRyonIf9itbQouiIfZWaRwLfD
        5I4G0bX8ilWu4IbaMmcFgfyMJFTWw==
X-ME-Sender: <xms:E267YA39LqHB289QpI4QO7j05cWK08AKUAPP9lSSZ2r2zb0duLytwA>
    <xme:E267YLGITa5dwhee8kYQuI9Q8vvLb4wg9SvS9Vl214JzjnRJp03Wpf1N2fo6W0_8N
    V5iAI5hm74zrKT9QGo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfedtfedgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgfgsehtqhertderreejnecuhfhrohhmpedfufhv
    vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
    grthhtvghrnhepteeuudelteefueelvdelheehieevvdfhkeehjeejudfhieelffffudfh
    keeileegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:E267YI6RXlh8AhpHUhLk-4BU1A25EogzJYRqZLkSE_vJCYyZ1_XRbA>
    <xmx:E267YJ351C6D4mO9SnISqYVNpzlJnt3GUyvSeDcm0rWSM6PyuY-4Xg>
    <xmx:E267YDEa8cc8BCZT5XSe1GJzDdSgVWHzQ_brkAp-bV_bXf7cd2hB8w>
    <xmx:Fm67YDGLMS-_IYXnr35e9TtPqCVqR9RrTjXnmM3GYqXGSP7El6S0EA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E519451C0060; Sat,  5 Jun 2021 08:29:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-519-g27a961944e-fm-20210531.001-g27a96194
Mime-Version: 1.0
Message-Id: <89b391d1-c076-491a-97c0-d08593c006e7@www.fastmail.com>
In-Reply-To: <d50ad9392f7719c01f752e73a00d4dc83b1a5c5c.camel@pengutronix.de>
References: <20210603085003.50465-1-sven@svenpeter.dev>
 <20210603085003.50465-4-sven@svenpeter.dev>
 <d50ad9392f7719c01f752e73a00d4dc83b1a5c5c.camel@pengutronix.de>
Date:   Sat, 05 Jun 2021 14:28:27 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Rouven Czerwinski" <r.czerwinski@pengutronix.de>,
        "Will Deacon" <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        "Rob Herring" <robh+dt@kernel.org>
Cc:     "Arnd Bergmann" <arnd@kernel.org>, devicetree@vger.kernel.org,
        "Hector Martin" <marcan@marcan.st>, linux-kernel@vger.kernel.org,
        "Marc Zyngier" <maz@kernel.org>,
        "Mohamed Mediouni" <mohamed.mediouni@caramail.com>,
        "Stan Skowronek" <stan@corellium.com>,
        linux-arm-kernel@lists.infradead.org,
        "Mark Kettenis" <mark.kettenis@xs4all.nl>,
        "Petr Mladek via iommu" <iommu@lists.linux-foundation.org>,
        "Alexander Graf" <graf@amazon.com>
Subject: Re: [PATCH v3 3/3] iommu: dart: Add DART iommu driver
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rouven,

On Sat, Jun 5, 2021, at 13:50, Rouven Czerwinski wrote:
> Hi Sven,
>=20
> just a small comment, see inline.
>=20
> On Thu, 2021-06-03 at 10:50 +0200, Sven Peter wrote:
> > +
> > +/* must be called with held dart_domain->lock */
>=20
> You can remove this comment, include lockdep.h and=E2=80=A6
>=20
> > +static int apple_dart_finalize_domain(struct iommu_domain *domain)
> > +{
> > +	struct apple_dart_domain *dart_domain =3D to_dart_domain(domain);
> > +	struct apple_dart *dart =3D dart_domain->dart;
> > +	struct io_pgtable_cfg pgtbl_cfg;
> > +
>=20
> 	lockdep_assert_held(&dart_domain->lock);
>=20
> A lockdep enabled kernel will warn if this function is called without
> the lock held, otherwise this gets optimized out. Same for the similar=

> comments below.
>=20

That looks very useful, thanks! Will use it for v4.

I only found assert_spin_locked originally but didn't want to have that
performance overhead for code that (I hope :-)) correctly uses these fun=
ctions
with a held lock right now.


Thanks,


Sven

