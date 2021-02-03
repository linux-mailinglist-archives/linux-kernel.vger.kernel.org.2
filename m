Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5508C30E337
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 20:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbhBCTZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 14:25:52 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:56938 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbhBCTZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 14:25:52 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 5205F1C0BB5; Wed,  3 Feb 2021 20:24:54 +0100 (CET)
Date:   Wed, 3 Feb 2021 20:24:53 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     bobwxc <bobwxc@email.cn>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: syzbot reporting less duplicates
Message-ID: <20210203192453.GA21047@amd>
References: <CACT4Y+YytChe9Tv5etacBL4snEDu+A2fNzF4zKiKtfmH0C0roQ@mail.gmail.com>
 <20210203160543.GA19512@duo.ucw.cz>
 <20210203172834.GA3943@mipc>
 <CACT4Y+bkQOAwAwEnRoZVwKM2sDpHW3bzeWdga4MhxhERvZKT+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <CACT4Y+bkQOAwAwEnRoZVwKM2sDpHW3bzeWdga4MhxhERvZKT+Q@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!
On Wed 2021-02-03 19:22:34, Dmitry Vyukov wrote:
> On Wed, Feb 3, 2021 at 6:39 PM bobwxc <bobwxc@email.cn> wrote:
> >
> > On Wed, Feb 03, 2021 at 05:05:43PM +0100, Pavel Machek wrote:
> > > On Mon 2021-02-01 11:52:12, Dmitry Vyukov wrote:
> > > Could we please get common prefix (like syzbot: KASAN:....) so that
> > > the bulk of emails is easier to remove?
> > There are several bots testing on the kernel, maybe we should give a pr=
efix
> > format for all bot.
> > Also we can use mail-address to fliter email, but it's still a little
> > inconvenient.
>=20
> Hi Pavel, bobwxc,
>=20
> Yes, I was wondering if syzbot in From/To/CC can be used for
> filtering? I assume email clients that can filter based on subject can
> also filter based on From/To/CC.
> Does anybody filter syzbot emails? Maybe you can share what works
> best?

=46rom does not really work. So... syzbot reports for subsystems I don't
maintain are uninteresting, and so is the resulting discussion.

While filtering on "From:" is easy for initial report, it does not
make it easy to remove follow up discussion.n=20

> I am not sure a common prefix for all bots is useful because it
> supports only all or nothing. There are also some bots that
> maintainers use now that seem to be fundamental to the process, if one
> is ignoring them, then they are effectively ignoring what the
> maintainer is saying.

I'm pretty sure common prefix for all bots is useful.

Best regards,
							Pavel
--=20
http://www.livejournal.com/~pavelmachek

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEUEARECAAYFAmAa+IUACgkQMOfwapXb+vL1RgCeM3M9+J+1KshFJ1LPPaYY6vVI
09sAl1FMuAxut7CxzzP2GUVj0/fSJXE=
=9Goe
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
