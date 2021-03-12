Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B40ED3395DE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 19:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232529AbhCLSJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 13:09:15 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:50708 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbhCLSIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 13:08:46 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id B00C81C0B7C; Fri, 12 Mar 2021 19:08:42 +0100 (CET)
Date:   Fri, 12 Mar 2021 19:08:42 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Peiyong Lin <lpy@google.com>
Cc:     Brian Starkey <brian.starkey@arm.com>, alexdeucher@gmail.com,
        android-kernel@google.com, dri-devel@lists.freedesktop.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        nd@arm.com, Paul Walmsley <paul.walmsley@sifive.com>,
        Prahlad Kilambi <prahladk@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sidath Senanayake <sidaths@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        zzyiwei@android.com
Subject: Re: [PATCH v5] Add power/gpu_frequency tracepoint.
Message-ID: <20210312180841.GA29093@amd>
References: <20201202123420.g3ivr5le4imcrdsa@DESKTOP-E1NTVVP.localdomain>
 <20201221201019.2897731-1-lpy@google.com>
 <CA+0soAnXOknfWBbuHiq4VG8byoQ89u8NdYBtq-n-JMURPUOhUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
In-Reply-To: <CA+0soAnXOknfWBbuHiq4VG8byoQ89u8NdYBtq-n-JMURPUOhUw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2021-03-10 13:56:29, Peiyong Lin wrote:
> On Mon, Dec 21, 2020 at 12:10 PM Peiyong Lin <lpy@google.com> wrote:
> >
> > Historically there is no common trace event for GPU frequency, in
> > downstream Android each different hardware vendor implements their own
> > way to expose GPU frequency, for example as a debugfs node.  This patch
> > standardize it as a common trace event in upstream linux kernel to help
> > the ecosystem have a common implementation across hardware vendors.
> > Toolings in the Linux ecosystem will benefit from this especially in the
> > downstream Android, where this information is critical to graphics
> > developers.
=2E..
> >  /* This part must be outside protection */
> > --
> > 2.29.2.684.gfbc64c5ab5-goog
> >
>=20
> Hi there,
>=20
> Could you please take a look at this patch?

Please trim email quotes when replying.

Also, you might want to state _name_ of person who should apply this,
so there's no ambiguity. You cc-ed many people...
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmBLrikACgkQMOfwapXb+vKmUgCfYJkfoLcgo9O2CieH/qJZ1Y6i
CuEAnRsSitZAj6RBtdRepNCJESxo1r2p
=l4Xr
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
