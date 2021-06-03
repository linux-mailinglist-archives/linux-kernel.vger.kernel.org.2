Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E448B399A84
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 08:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbhFCGTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 02:19:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:40602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229635AbhFCGTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 02:19:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1CC8D6100A;
        Thu,  3 Jun 2021 06:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622701050;
        bh=xK8KIXeSPe3ZkUF3XrMLWkT+jJlhFOriOArWK3qvMSU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=HfP+8MnI7YT9oEMqSaNPF2qV83BA2v2bZZFiI79z2cBUZd/Iwo8WPfefIAgSLYZXR
         xeSeZ5FkZVMB62JZwfMRuYT0wgPPtt5GWfl6oNM4tvDTRKf3bDrIjLtr0YmU9nhchT
         nH31D48xp64DM4xAtSy/f/I2eRwPHnmGhZLURQpqJRDKIlPRbbnelPNhSKx0trc6z3
         mzvKJmEIK2qgM4l3qTfyS7XN9SKavIpeu5eSxJbpiZus1Rhp1yH0rhpvvz9YWXlxNa
         U6U+ea24FbMK3CqP/Zjr3rm+o5O8FixYMKAJuj+y/VODff1z0Pvc5sg24WzqCsnF79
         MaK1gZtaSwESw==
From:   Felipe Balbi <balbi@kernel.org>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>
Subject: Re: [PATCH 1/3] USB: cdnsp: drop irq-flags initialisations
In-Reply-To: <20210519093303.10789-2-johan@kernel.org>
References: <20210519093303.10789-1-johan@kernel.org>
 <20210519093303.10789-2-johan@kernel.org>
Date:   Thu, 03 Jun 2021 09:17:22 +0300
Message-ID: <875yyveakt.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Johan Hovold <johan@kernel.org> writes:
> There's no need to initialise irq-flags variables before saving the
> interrupt state.
>
> Cc: Pawel Laszczak <pawell@cadence.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

Acked-by: Felipe Balbi <balbi@kernel.org>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFFBAEBCAAvFiEE9DumQ60WEZ09LIErzlfNM9wDzUgFAmC4c/IRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzlfNM9wDzUh/5QgAkY5VXMv3R+KJFE2ItxlwZWwtmx1k0TR0
4lguaDPp/Xcg5WK5ugVUl0zvJckcSBCivts8Y68Lxncp2oILEIkTxIoa0r8jn8eL
o0c4nQIXPtYyOkea7rc95TCsZ/H50OYdTZbp5lyCHpVqjuFu/aPbf8bXi2jTxIh9
9eAkq4bu8xDfl/5VjXxhbuhL3Ao/Hh6TJlRv1vUL7JkTkWN/3HMHcJqeTJP+mjNU
qo60qdqj5hpmA60OmjNqV5OmzpvftxvfDpkvS4gZGtL9KQpZzrQS5x6wUXmu9LYu
3xa6Z/t0oUPKESEl+wTuqzsH2BKMfqCyxQIHdSgadcceIkukfeoGww==
=o1oS
-----END PGP SIGNATURE-----
--=-=-=--
