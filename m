Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8E63F2A41
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 12:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238356AbhHTKoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 06:44:18 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:54714 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbhHTKoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 06:44:13 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 577191C0B80; Fri, 20 Aug 2021 12:43:34 +0200 (CEST)
Date:   Fri, 20 Aug 2021 12:43:28 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>
Subject: Re: [ANNOUNCE] 4.4.277-rt224
Message-ID: <20210820104328.GA30359@amd>
References: <162762714720.5121.4789079771844033633@beryllium.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <162762714720.5121.4789079771844033633@beryllium.lan>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I'm pleased to announce the 4.4.277-rt224 stable release.
>=20
> This is just an update to the latest stable release. No RT specific
> changes.
>=20
> Sorry for the long delay. I was refactoring and improving my test
> setup which took a bit longer than I expected. I switched from a
> Debian based rootfs to an Tumbleweed based one, for obvious
> reasons. Anyway, this should not matter at all.

A bit late thanks for the release, BTW. We are maintaining -cip-rt
based kernels, and were getting worried :-).

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmEfh1AACgkQMOfwapXb+vKuRwCgupWDZwOxxiIzICzz85B/9zRL
XE8AoIqtjRr71fTGD4RO1/8uFiUSPSSg
=znr5
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
