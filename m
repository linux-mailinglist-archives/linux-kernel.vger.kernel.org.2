Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D62694145A1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 11:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234610AbhIVJ7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 05:59:03 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:42465 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234616AbhIVJ7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 05:59:00 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 718795C0116;
        Wed, 22 Sep 2021 05:57:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 22 Sep 2021 05:57:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=0gHCLIfziyik9l923GZQIjA3Xvw
        LK+R5zbKScTsFOv4=; b=0VgVC+s6XK/N9fQsWmVwvAYRtGii6KYW4ExFzNGFcGZ
        4TdAoHkrhwzAJQsZru1hofnP0rft3z7+hiaUeiiUvUNAuqkUEr/X1dutH/bbVmsW
        TLzr9I18ygS43uALFOG0+ertOT4+hMTVMVUu86Qzw+0LPseyjDGbR4LHQovuIzbz
        mODRFy4blI/kV5JtQ3JQlrnmbbKagt900mgXhBPZH8s7TK+nmKVKqAggmg6Dfdlg
        ejR9ghI1WJgiBDsKTIdqePIUG1WSVPWtTo190y01WORheeRx/uRXRaQzXrTsVPgm
        r24noFWdYhE87lXzAY9NtIk+FS9Y89UzWuf9N7X+8dA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=0gHCLI
        fziyik9l923GZQIjA3XvwLK+R5zbKScTsFOv4=; b=hAelqmxVlJZ2SvDlYpfPEX
        InsQI+6OmGwjj8MzhkSqbrBtSpfqLAPbjEQHtV7Nf1smceuUwWa9YvXKRfm/tHH2
        wXBDdDxTgfridbai5vt7Hw9glCc52CtjafWp9I/GWrEiYKr9xilvBavMqgi2C5kP
        WRUXAlbzZkXG9tHtcbzY0EMuTrdYY4t1E1RwqIokwu1XMAakjJ+AiOKukXgWmEfY
        ldRPJkEGHE8utEgYJP4yb3jzkorff5otZE+jS77vO1FZ2sFbSYMg0V6QDO2HGzJY
        FqJt7Ej+F8RJthJKT4VmoTb5Jojq1aNAcYufV3LFVT9yfYEaQbjDwc3R8qrfl2qg
        ==
X-ME-Sender: <xms:B_5KYQUIcfbmZEfBwzKl_QMcDRP26Uc8CGBgqR9Pj9M2Or2MtCxWJQ>
    <xme:B_5KYUkE5314UGUZZtiVkSbrl-SVeektVNyYagD04W8ZlJ5kWY_PIFc3AnL2mxsz0
    0ibhEzxS5rDpzFkvvE>
X-ME-Received: <xmr:B_5KYUbB4mE4DablulYDX221dCScIGsIaeZ62coz6cI7wEUbHCJT_UvgAag-fRqmfbGjGsXrTBaSC8uZ_0KBG9MHia6fSiKT_GH->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudeijedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepgfetffffhfejhfevieekkedvkeetheevkeevueffieegvddtgfdttdfhheei
    feefnecuffhomhgrihhnpegtohguvghthhhinhhkrdgtohdruhhknecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhho
    rdhtvggthh
X-ME-Proxy: <xmx:B_5KYfWanIz3LMhYIvfEOurS6CzRIB5kdZaIRxzhe1Ed-qKZ4Pgebw>
    <xmx:B_5KYancBR455uE2FKOGcj-MhKiU2sQ6dCIfj0c4xJpsqHIxJkT2TA>
    <xmx:B_5KYUdmcYeAzAmafPTvlg1TjtGmJe3S30-IDZ9nBnE863dCdeXf9w>
    <xmx:CP5KYYZ4dKKia38g15XC_99XD-lWmxTV8kLvWo2JVNUI2TpPvwtBgg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Sep 2021 05:57:27 -0400 (EDT)
Date:   Wed, 22 Sep 2021 11:57:25 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Emma Anholt <emma@anholt.net>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Regression with mainline kernel on rpi4
Message-ID: <20210922095725.dk4vk42zb3kh7y6s@gilmour>
References: <20210903160302.yh42vpkuob45dbpb@gilmour>
 <CADVatmMqT1yq3YHBzt4-VsL8uVHUULmy2gpaH27rAqimao2i_A@mail.gmail.com>
 <20210904091050.g5axxctgelciihjn@gilmour>
 <CADVatmN+9euG5Fegor1+kaSPewbW8vRwBgnxmr5SsK3mOE6FEg@mail.gmail.com>
 <20210920144730.d7oabqfbx7pmyyfb@gilmour>
 <20210920154333.vunyxeshdb7jt5ka@gilmour>
 <20210920155350.h6624mt65vwg72p2@gilmour>
 <CADVatmNi+jN+EwiWuoDoocZFyErDVNt1ND0BxtjuKiV63aNuJg@mail.gmail.com>
 <20210920171042.oq3ndp3ox4xv5odh@gilmour>
 <CADVatmOs7Cc1EdCZXMyXcWM-3-J4bU_3zF1thkOohVUL-G6ZrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qcwikbeg7e3hiubv"
Content-Disposition: inline
In-Reply-To: <CADVatmOs7Cc1EdCZXMyXcWM-3-J4bU_3zF1thkOohVUL-G6ZrQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qcwikbeg7e3hiubv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 20, 2021 at 06:21:42PM +0100, Sudip Mukherjee wrote:
> On Mon, Sep 20, 2021 at 6:10 PM Maxime Ripard <maxime@cerno.tech> wrote:
> >
> > On Mon, Sep 20, 2021 at 05:35:00PM +0100, Sudip Mukherjee wrote:
> > > On Mon, Sep 20, 2021 at 4:53 PM Maxime Ripard <maxime@cerno.tech> wro=
te:
> > > >
> > > > On Mon, Sep 20, 2021 at 05:43:33PM +0200, Maxime Ripard wrote:
> > > > > On Mon, Sep 20, 2021 at 04:47:31PM +0200, Maxime Ripard wrote:
> > > > > > On Sat, Sep 04, 2021 at 10:40:29AM +0100, Sudip Mukherjee wrote:
> > > > > > > Hi Maxime,
> > > > > > >
> > > > > > > On Sat, Sep 4, 2021 at 10:10 AM Maxime Ripard <maxime@cerno.t=
ech> wrote:
> > > > > > > >
> > > > > > > > On Fri, Sep 03, 2021 at 09:09:50PM +0100, Sudip Mukherjee w=
rote:
> > > > > > > > > Hi Maxime,
> > > > > > > > >
> > > > > > > > > On Fri, Sep 3, 2021 at 5:03 PM Maxime Ripard <maxime@cern=
o.tech> wrote:
> > > > > > > > > >
> > > > > > > > > > Hi Sudip,
> > > > > > > > > >
> > > > > > > > > > On Thu, Sep 02, 2021 at 10:08:19AM +0100, Sudip Mukherj=
ee wrote:
> > > > > > > > > > > Hi All,
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > <snip>
> > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > You can see the complete dmesg at
> > > > > > > > > > > https://openqa.qa.codethink.co.uk/tests/76#step/dmesg=
/8
> > > > > > > > > >
> > > > > > > > > > What test were you running?
> > > > > > > > >
> > > > > > > > > Nothing particular, its just a boot test that we do every=
 night after
> > > > > > > > > pulling from torvalds/linux.git
> > > > > > > >
> > > > > > > > What are you booting to then?
> > > > > > >
> > > > > > > I am not sure I understood the question.
> > > > > > > Its an Ubuntu image. The desktop environment is gnome. And as
> > > > > > > mentioned earlier, we use the HEAD of linus tree every night =
to boot
> > > > > > > the rpi4 and test that we can login via desktop environment a=
nd that
> > > > > > > there is no regression in dmesg.
> > > > > >
> > > > > > Looking at the CI, this isn't from a RPi but from qemu?
> > >
> > > No, this is from rpi4 board (4GB), not qemu. The CI is a little
> > > complicated here, lava boots the board with the new kernel and will
> > > then trigger the openQA job. openQA will then connect to the board
> > > using vnc to test the desktop. This is the last link that I sent to
> > > Linus when he asked for it.
> > > https://lava.qa.codethink.co.uk/scheduler/job/164#L1356
> > >
> > > And this is the lava job for today -
> > > https://lava.qa.codethink.co.uk/scheduler/job/173
> >
> > Is it connected to a monitor then?
>=20
> Missed replying to this one earlier. I have a hdmi lilliput monitor
> connected to it.
>=20
> >
> > > > > >
> > > > > > What defconfig are you using? How did you generate the Ubuntu i=
mage?
> > > > > > Through debootstrap? Any additional package?
> > >
> > > Its the default ubuntu config. I can send you the config if you want.
> >
> > Yes, please.
>=20
> Attached.
> My build script will copy this config as .config,  do olddefconfig
> and then build.

I still can't reproduce it.

What other customisations did you do to that image? It looks like
there's some customs scripts in there (test-mainline.sh), what are they
doing?

Maxime

--qcwikbeg7e3hiubv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYUr+BQAKCRDj7w1vZxhR
xZL/AQDYrZoeJHMtSBLubJT3mm+veFFWWt6FP04HxytouZjuGwEA7uDlCviRWNMh
ED2s4reMOXpsiZNqH0V107ZXuVJSLwU=
=K3wd
-----END PGP SIGNATURE-----

--qcwikbeg7e3hiubv--
