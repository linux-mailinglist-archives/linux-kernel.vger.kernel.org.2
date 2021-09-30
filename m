Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16ACF41DFAF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 19:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344620AbhI3RDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 13:03:25 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36360 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344570AbhI3RDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 13:03:24 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 5D09E1F41FBB
Received: by earth.universe (Postfix, from userid 1000)
        id 4AE8F3C0CA8; Thu, 30 Sep 2021 19:01:38 +0200 (CEST)
Date:   Thu, 30 Sep 2021 19:01:38 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Aditya Srivastava <yashsri421@gmail.com>
Subject: Re: [PATCH v2] HSI: cmt_speech: unmark comments as kernel-doc
Message-ID: <20210930170138.xlspkxshgr4od7t6@earth.universe>
References: <20210928183536.30645-1-rdunlap@infradead.org>
 <20210928185727.GA10433@duo.ucw.cz>
 <85f5c28b-3b70-8e31-47a0-7317ebdc216f@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ibc5qbkizjxc7fkx"
Content-Disposition: inline
In-Reply-To: <85f5c28b-3b70-8e31-47a0-7317ebdc216f@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ibc5qbkizjxc7fkx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 28, 2021 at 12:52:03PM -0700, Randy Dunlap wrote:
> On 9/28/21 11:57 AM, Pavel Machek wrote:
> > Hi!
> >=20
> > > Fix build warnings from the kernel test robot:
> > >=20
> > > drivers/hsi/clients/cmt_speech.c:831: warning: This comment starts wi=
th '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/ker=
nel-doc.rst
> > >      * Block until pending data transfers have completed.
> > >=20
> > > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Cc: Sebastian Reichel <sre@kernel.org>
> > > Cc: Aditya Srivastava <yashsri421@gmail.com>
> > > Acked-by: Pavel Machek <pavel@ucw.cz>
> >=20
> > If noone applies it, you may want to send it to akpm, he's  often
> > helpful in pushing similar patches.
>=20
> Yes, good idea. Thanks.

Looks like I missed v1. The patch LGTM and I can apply it to the hsi tree.
If you already sent it to akpm, that's also fine. Not much is happening in
HSI nowadays and it probably will be the only patch for the next cycle.

-- Sebastian

--ibc5qbkizjxc7fkx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmFV7WgACgkQ2O7X88g7
+pr9mw//a0ZniBXQkEsSXiASPfAR3jVx7/88kdgJ46vDJyt/e9pmGnDCLA06UAUX
pkxgNBkaO67IwpazM8M3WtwsWMvlNEv7FT+qd7yQ0QaKXFjaU6FlsmWr1Qbmlqqy
z3KvZCtrEtATQ4VuI+/4kulcrcFttH6DAioWp8tNlTkolq+YJvj6yXRMh2/2V7CE
AjYSU0Dfsbpq+xsCschIE0RUarqhxoPoIaTv2JTg6aT00J1bRS/l+LreA0jHt1O3
xKiaDYuh55rFOiTvw++vmvKwDgKb6B4uCaZrWkUgOj5LHGEy5L756q7tgmj08xaY
as1s7ZWRUe25DOkk1aHekHa6XLL/MrmmIWPItfiqEIjDp9eeueqhygzR3u4BOitE
3ZnzHWyL2puEv9PfPwdnWpeo7BvRTlmLiHUOWZx4WpTmfR7RJlh8vOri4S0yYqni
oYmBHCpxk4qWo+tzRv5rubFmrrMeFh1SMbXsJwZj98yq0S1RdoiwmrmvzmXtVl2P
bt6GanmN61/pm3fPbM1yomPKGjG1bSHenGDo0RWfH5BCjXAPNBOeWVVyA8LvH+b/
Qcc97HDJMQIAld0/9u8aOHIysVwUCAotsfPl2+ipxe2D7nYVsrczO3Y4O8GexYUo
Hee3yKWRo+vLh1QPmlpf6HITllUngiKjV+K2CyqWASGzKmG1wlQ=
=AAxP
-----END PGP SIGNATURE-----

--ibc5qbkizjxc7fkx--
