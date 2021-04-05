Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2925D35411B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 12:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237892AbhDEKLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 06:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbhDEKLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 06:11:41 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2304C061756
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 03:11:35 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 9E19E1F44D7D
Received: by earth.universe (Postfix, from userid 1000)
        id 32ACE3C0C96; Mon,  5 Apr 2021 12:11:32 +0200 (CEST)
Date:   Mon, 5 Apr 2021 12:11:32 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Roman Kiryanov <rkir@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Lingfeng Yang <lfy@google.com>
Subject: Re: [PATCH] Remove the GOLDFISH dependency from BATTERY_GOLDFISH
Message-ID: <20210405101132.f5q6e25dgf25dby6@earth.universe>
References: <20210206023118.1521194-1-rkir@google.com>
 <CAOGAQep2y2SM3quAcXSghBM3MHak4wtPGzWpZoYcza1ckosX5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dr22f5pdmtssv6i4"
Content-Disposition: inline
In-Reply-To: <CAOGAQep2y2SM3quAcXSghBM3MHak4wtPGzWpZoYcza1ckosX5Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dr22f5pdmtssv6i4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 09, 2021 at 11:22:26AM -0800, Roman Kiryanov wrote:
> On Fri, Feb 5, 2021 at 6:31 PM <rkir@google.com> wrote:
> >
> > From: Roman Kiryanov <rkir@google.com>
> >
> > This will allow to use the BATTERY_GOLDFISH driver
> > without enabling GOLDFISH.
>=20
> Hi Sebastian, could you please take a look at my patch?
>=20
> Thank you.

Thanks, queued.

-- Sebastian

--dr22f5pdmtssv6i4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmBq4lMACgkQ2O7X88g7
+prF9w/8CbiNIXCkDz47dhdULTR+XWypMrJWcnjA3vbVDv5lAcjwr9gnhahBnBMf
XR43TMLCg6ZxsLOOtuCbw/SqK+nnV6Vnc2/zeNHeKohdVHFNOvh3/EMVkxN6cZHf
5y1YzWXgXqJooia/RjSJPVtvdJ5AGEio7Zq+a0kNXcTpj1mEEIN8Shm9d5faRHVV
TzV9X9Hkwasw74Uzr9/5c5XgqXw73IzWU1EvLGknAolDZibgTDnBIQ2wOm7BIsVx
DE0z/8WyUXpXnsvp1v18JOqe1mGSF6Vq5sY6yI0m+hdH13EkHfAt6F2k0bJ1aSIK
oMpoJKiSwVTGobbanNymoKfajhdjrutediYd7D05dweavQNgyCIQHCYTUIXf5d67
W+IagjA2p+2VQ1a5kndJtjOzaDIVJaBo2bcC/ACl//GhngiAGRCk32RZljeq18fa
9k+Myn9KFxuWiNp9IvAdz+SPcO7NOFm3r3gBdfMRXXc96SYzMDLBE8Pe0z4TOjMH
sGgbBqTWQDtXCJ5v04FTVJ6i61FgbWPLJpyYqlm+9/oINC3HYRgkcy2edfzdYSem
MEEjFzFb44TIUrTQZlA9CgEuglNQRNAZ7WHZeM0DJXJzXGVs4heTOhKJ3tAxS+kl
Y+iRoVqTfD+nEmJF1Hf7/ySZcUff3j7S9BuZVB+kbX4Y0NAeHgg=
=20ms
-----END PGP SIGNATURE-----

--dr22f5pdmtssv6i4--
