Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9068B42D77E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 12:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhJNKzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 06:55:43 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:54548 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbhJNKzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 06:55:40 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 90A861C0B79; Thu, 14 Oct 2021 12:53:34 +0200 (CEST)
Date:   Thu, 14 Oct 2021 12:53:34 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>,
        vitaly.lubart@intel.com, tomas.winkler@intel.com,
        daniele.ceraolospurio@intel.com, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        intel-gfx@lists.freedesktop.org
Subject: intel_mei_pxp: needs better help text
Message-ID: <20211014105334.GA19786@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


CONFIG_INTEL_MEI_PXP:

MEI Support for PXP Services on Intel platforms.

Enables the ME FW services required for PXP support through
I915 display driver of Intel.


That's ... very useless help text. According to
https://www.phoronix.com/scan.php?page=3Dnews_item&px=3DIntel-PXP-Protected=
-Xe-Path
this is some kind of DRM. Help text should probably say it has to do
with i915 video, and explain the acronyms, and probably its usecases.



--=20
http://www.livejournal.com/~pavelmachek

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYWgMLgAKCRAw5/Bqldv6
8vXQAKCaZIbr9BzntFKSnAJ7J3QFZsMjMwCfXZUJ0s9UEqQacjevS3ERxAo+/e0=
=Otrh
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
