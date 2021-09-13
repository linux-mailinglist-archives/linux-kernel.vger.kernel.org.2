Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6B0408897
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 11:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238688AbhIMJ4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 05:56:46 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:59484 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238444AbhIMJ4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 05:56:42 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 7D3BA1C0BA6; Mon, 13 Sep 2021 11:55:25 +0200 (CEST)
Date:   Mon, 13 Sep 2021 11:55:24 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Joseph Hwang <josephsih@chromium.org>
Cc:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org, josephsih@google.com,
        chromeos-bluetooth-upstreaming@chromium.org,
        kernel test robot <lkp@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] Bluetooth: btandroid: Support Android Bluetooth
 Quality Report
Message-ID: <20210913095524.GD12225@amd>
References: <20210913152801.v3.1.I17f57656757b83a1c0fb4b78525d8aca581725db@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="eheScQNz3K90DVRs"
Content-Disposition: inline
In-Reply-To: <20210913152801.v3.1.I17f57656757b83a1c0fb4b78525d8aca581725db@changeid>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eheScQNz3K90DVRs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> +config BT_HCIBTANDROID
> +	tristate

Calling it btquality (or something) would be better.

> index 000000000000..fffacc8d67cc
> --- /dev/null
> +++ b/drivers/bluetooth/btandroid.c

Same here.
								Pavel
							=09
--=20
http://www.livejournal.com/~pavelmachek

--eheScQNz3K90DVRs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmE/IAwACgkQMOfwapXb+vJ7kACfbhiTe/JytoG9II5Zf9wEAd5t
a1IAnAqEJ75IBBJHGR63YAcM+ZqecJb/
=soHg
-----END PGP SIGNATURE-----

--eheScQNz3K90DVRs--
