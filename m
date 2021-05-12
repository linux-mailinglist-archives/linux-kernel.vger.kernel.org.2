Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92DC637B886
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 10:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbhELIvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 04:51:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:34700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230037AbhELIvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 04:51:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 924C9613EE;
        Wed, 12 May 2021 08:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620809393;
        bh=sgr4pNVw9LZJjQw+GkyhASsiZHhfZWrLikxWIMHCsn4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZOW50uQs1gRUsEJun6YIPTU8TIOp6yLAW0uYrfmgcM3mToFw0h9o5cJ11HhF4Bbbc
         S1BzZCT69mLeYapKbC/kYIlNiGR+C2HWiq5CUMc4xpcCz+xAkk47MqNfmo5opApv4Z
         Xfn8Yqi52DKB++75+74vfJ/1stVIjDBTbjJcONLLMW8zRQtuFNjSohVkM98MuAo3XX
         lEer2ClcqD1kYgn2++x4XQw1Vz+w4zMPYewBi7C3uYC8GRu6/kjNA8Y3hoXNrgY4eN
         /TBJK6Ya19+L9k7Ludpl8ARfk9/KwUqirU1KqYNgFqGAKUogRM1DUhKLkKLumvpNH7
         Obe1zDcCCuexw==
Date:   Wed, 12 May 2021 10:49:46 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Ertman <david.m.ertman@intel.com>,
        Drew Fustini <drew@beagleboard.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Michael Walle <michael@walle.cc>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 12/53] docs: driver-api: avoid using UTF-8 chars
Message-ID: <20210512104946.2fb26eeb@coco.lan>
In-Reply-To: <CAHp75Vegsb-+fVppv3C7Jp0a=mEGAh2pchX=Cr5ZvOMFt+G73Q@mail.gmail.com>
References: <cover.1620641727.git.mchehab+huawei@kernel.org>
        <77e554fee3df340349bc80e7adb8deb255df235f.1620641727.git.mchehab+huawei@kernel.org>
        <CAHp75Vegsb-+fVppv3C7Jp0a=mEGAh2pchX=Cr5ZvOMFt+G73Q@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 10 May 2021 14:05:12 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> escreveu:

> On Monday, May 10, 2021, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> wrote:
>=20
> > While UTF-8 characters can be used at the Linux documentation,
> > the best is to use them only when ASCII doesn't offer a good replacemen=
t.
> > So, replace the occurences of the following UTF-8 characters:
> >
> >         - U+00a0 (' '): NO-BREAK SPACE
> >         - U+2014 ('=E2=80=94'): EM DASH =20
>=20
>=20
> Strictly speaking the EM Dash equivalent is =E2=80=98--=E2=80=98.

Yes, EM DASH is equivalent to multiple '-'.

Sphinx (and other similar tools) use those rules:

	-- is equivalent to EN DASH;
	--- is equivalent to EM DASH

Anyway, I'll change this on a next spin.

>=20
>=20
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  Documentation/driver-api/index.rst | 2 +-
> >  Documentation/driver-api/ioctl.rst | 8 ++++----
> >  2 files changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/driver-api/index.rst
> > b/Documentation/driver-api/index.rst
> > index f5a3207aa7fa..29eb9230b7a9 100644
> > --- a/Documentation/driver-api/index.rst
> > +++ b/Documentation/driver-api/index.rst
> > @@ -4,7 +4,7 @@ The Linux driver implementer's API guide
> >
> >  The kernel offers a wide variety of interfaces to support the developm=
ent
> >  of device drivers.  This document is an only somewhat organized collec=
tion
> > -of some of those interfaces =E2=80=94 it will hopefully get better ove=
r time!  The
> > +of some of those interfaces - it will hopefully get better over time! =
 The
> >  available subsections can be seen below.
> >
> >  .. class:: toc-title
> > diff --git a/Documentation/driver-api/ioctl.rst
> > b/Documentation/driver-api/ioctl.rst
> > index c455db0e1627..5b76e765827d 100644
> > --- a/Documentation/driver-api/ioctl.rst
> > +++ b/Documentation/driver-api/ioctl.rst
> > @@ -25,9 +25,9 @@ ioctl commands that follow modern conventions: ``_IO`=
`,
> > ``_IOR``,
> >  with the correct parameters:
> >
> >  _IO/_IOR/_IOW/_IOWR
> > -   The macro name specifies how the argument will be used.  It may be a
> > +   The macro name specifies how the argument will be used.  It may be a
> >     pointer to data to be passed into the kernel (_IOW), out of the ker=
nel
> > -   (_IOR), or both (_IOWR).  _IO can indicate either commands with no
> > +   (_IOR), or both (_IOWR).  _IO can indicate either commands with no
> >     argument or those passing an integer value instead of a pointer.
> >     It is recommended to only use _IO for commands without arguments,
> >     and use pointers for passing data.
> > @@ -200,10 +200,10 @@ cause an information leak, which can be used to
> > defeat kernel address
> >  space layout randomization (KASLR), helping in an attack.
> >
> >  For this reason (and for compat support) it is best to avoid any
> > -implicit padding in data structures.  Where there is implicit padding
> > +implicit padding in data structures.  Where there is implicit padding
> >  in an existing structure, kernel drivers must be careful to fully
> >  initialize an instance of the structure before copying it to user
> > -space.  This is usually done by calling memset() before assigning to
> > +space.  This is usually done by calling memset() before assigning to
> >  individual members.
> >
> >  Subsystem abstractions
> > --
> > 2.30.2
> >
> > =20
>=20



Thanks,
Mauro
