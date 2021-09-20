Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0DC0411770
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 16:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240742AbhITOtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 10:49:07 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:42857 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231720AbhITOtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 10:49:05 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 2FE4C5C00AF;
        Mon, 20 Sep 2021 10:47:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 20 Sep 2021 10:47:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=Se9ZjgXoFb23WRqzS6LZo2VfyPN
        N9yAxCDLzhKQA1gY=; b=iM4RlWpFL5SdZDhQBNhCdNoP3SqJVTY0wgjvABwo+Cl
        fNJTf2TyVcgFVo2yeb4s8h/5LbbZo+tY2XDSj0AIr8w/K2R9fDWc5Y0rUGjMcyKs
        kHspZhxSohw+W/b96/fyvvkBody+qK+7c92Revp9KiJ0B9Mzc0FlYgQ5FK/fgOz+
        wn52qIzLvjkurL72DEV+6SA12IabTXXpsC4OKE5uuCtlpXBIA5Ez0dxQahUqaxuG
        zQbonm3dW7c3bd6Zub/PmI173HPqfgRNijKNta11MUlniyHSgIJyeu8xQqaePRka
        UlJtZq5La4GFyrxj9EehInTuRERh8qCvXFvvlwhKUpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Se9Zjg
        XoFb23WRqzS6LZo2VfyPNN9yAxCDLzhKQA1gY=; b=IVLRBsPpjSa3AxAqnI8tfM
        uFmA6CC2pMWOmGnSJ9U4Jc3a/KPHzGD86OZq4nMc0pOHhvMIr9cQkk44ZRrKtxUb
        u1Uw2NzGhzFFjuba4iVRRB/ELHstREPVNfIsdRDL5CB+yv17sfYWekNXaybBGgLa
        8a4PMcZC8WWL79YJmJmhlrmyomU7B+OL7U2nbX5Wjg3I4gIR47RjHslNCAZnBS9g
        mj1ugNtNfpN5lAAXM7VzaTrnCRre4YrTF2Y0xX+aMBPsD1dQbxiHRFqfUtvGa6Yk
        dnNsb9Hfub5BE328AJ7+Yx4gjXQpCc4cnzyOukWgeYsoZGWeiqUxlgAdXEqek+ww
        ==
X-ME-Sender: <xms:BZ9IYZfxJwUkTR0dwJBrqgdk92W4xZEiEIfn_flTdiJbUIWdvonYiQ>
    <xme:BZ9IYXOjOQaY7iznb1-3WFEs3_jMv7BIM0y1S5LfNQfz9r86odK4bRHkBVwHqf3mi
    MriPBIPJrMh6U10IS0>
X-ME-Received: <xmr:BZ9IYShCyM6gKk5ezT37vx0HhVGQouHD5eXl6SLI20iQQ12laESCCTaAaD2_Q3BrE_ZLvcLeJZuDuYoIgfJtyuH64LB8wX3kbXFj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudeivddgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepgfetffffhfejhfevieekkedvkeetheevkeevueffieegvddtgfdttdfhheei
    feefnecuffhomhgrihhnpegtohguvghthhhinhhkrdgtohdruhhknecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhho
    rdhtvggthh
X-ME-Proxy: <xmx:BZ9IYS-Hd-jkDmv_dPUj9Pui8cbkKLiYdUUpsVvFURpUrxEXy-xHvw>
    <xmx:BZ9IYVuN8PuGj1TufxWkAL31ts3gVd00ynmDIy3Alg0qq2wUoxovaw>
    <xmx:BZ9IYRGONh_oIBfPvvtDWFqxeELSnBarLPUwuY1BCuNjtIYkAKlHnw>
    <xmx:Bp9IYZjq4GJG05aIKX4Fnn7vpn26IsOVQfwAUtUYs3nsHNgKuWOuQA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Sep 2021 10:47:32 -0400 (EDT)
Date:   Mon, 20 Sep 2021 16:47:30 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Emma Anholt <emma@anholt.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Regression with mainline kernel on rpi4
Message-ID: <20210920144730.d7oabqfbx7pmyyfb@gilmour>
References: <CADVatmPB9-oKd=ypvj25UYysVo6EZhQ6bCM7EvztQBMyiZfAyw@mail.gmail.com>
 <20210903160302.yh42vpkuob45dbpb@gilmour>
 <CADVatmMqT1yq3YHBzt4-VsL8uVHUULmy2gpaH27rAqimao2i_A@mail.gmail.com>
 <20210904091050.g5axxctgelciihjn@gilmour>
 <CADVatmN+9euG5Fegor1+kaSPewbW8vRwBgnxmr5SsK3mOE6FEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zauteup23pojfqra"
Content-Disposition: inline
In-Reply-To: <CADVatmN+9euG5Fegor1+kaSPewbW8vRwBgnxmr5SsK3mOE6FEg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zauteup23pojfqra
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 04, 2021 at 10:40:29AM +0100, Sudip Mukherjee wrote:
> Hi Maxime,
>=20
> On Sat, Sep 4, 2021 at 10:10 AM Maxime Ripard <maxime@cerno.tech> wrote:
> >
> > On Fri, Sep 03, 2021 at 09:09:50PM +0100, Sudip Mukherjee wrote:
> > > Hi Maxime,
> > >
> > > On Fri, Sep 3, 2021 at 5:03 PM Maxime Ripard <maxime@cerno.tech> wrot=
e:
> > > >
> > > > Hi Sudip,
> > > >
> > > > On Thu, Sep 02, 2021 at 10:08:19AM +0100, Sudip Mukherjee wrote:
> > > > > Hi All,
> > > > >
> > > >
> > >
> > > <snip>
> > >
> > > >
> > > > >
> > > > > You can see the complete dmesg at
> > > > > https://openqa.qa.codethink.co.uk/tests/76#step/dmesg/8
> > > >
> > > > What test were you running?
> > >
> > > Nothing particular, its just a boot test that we do every night after
> > > pulling from torvalds/linux.git
> >
> > What are you booting to then?
>=20
> I am not sure I understood the question.
> Its an Ubuntu image. The desktop environment is gnome. And as
> mentioned earlier, we use the HEAD of linus tree every night to boot
> the rpi4 and test that we can login via desktop environment and that
> there is no regression in dmesg.

Looking at the CI, this isn't from a RPi but from qemu?

What defconfig are you using? How did you generate the Ubuntu image?
Through debootstrap? Any additional package?

Maxime

--zauteup23pojfqra
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYUifAgAKCRDj7w1vZxhR
xd3oAP4/bAIXXAxoA2sjlOzDAwGmXhGImmbdpnJ9gZCKVsBRSwEApUbVhBbD0zxp
JnQ7qpCMqRhJzIWuAix+4x4V77d/3Qo=
=v/vC
-----END PGP SIGNATURE-----

--zauteup23pojfqra--
