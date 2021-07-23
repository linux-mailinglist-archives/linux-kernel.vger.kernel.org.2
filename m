Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 288FA3D3990
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 13:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbhGWKxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 06:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234218AbhGWKw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 06:52:58 -0400
Received: from gpm.stappers.nl (gpm.stappers.nl [IPv6:2001:981:6c6a:1::49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 040CBC061575;
        Fri, 23 Jul 2021 04:33:31 -0700 (PDT)
Received: by gpm.stappers.nl (Postfix, from userid 1000)
        id E62AB3041A7; Fri, 23 Jul 2021 13:33:27 +0200 (CEST)
Date:   Fri, 23 Jul 2021 13:33:27 +0200
From:   Geert Stappers <stappers@stappers.nl>
To:     Matthew Wilcox <willy@infradead.org>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/17] Rust support, GPIO driver
Message-ID: <20210723113327.cnw4wdjqdeg6o6x4@gpm.stappers.nl>
References: <20210704202756.29107-1-ojeda@kernel.org>
 <YOVNJuA0ojmeLvKa@infradead.org>
 <CANiq72mKPFtB4CtHcc94a_y1V4bEOXXN2CwttQFvyzwXJv62kw@mail.gmail.com>
 <YOWjLmg/Z7kr2+tx@kroah.com>
 <YOW1Nj8+a2Yth2++@google.com>
 <YOXB7FRqldZik2Xn@kroah.com>
 <BFD5298D-00CD-4FEF-AE77-61E69AF78604@kloenk.dev>
 <YOZNuEtNbsLxRM0R@casper.infradead.org>
 <YPn3fgDX8uNkF8Vp@google.com>
 <YPoYxiq63QcfUXg+@casper.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="67mj6aqryecr4rvw"
Content-Disposition: inline
In-Reply-To: <YPoYxiq63QcfUXg+@casper.infradead.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--67mj6aqryecr4rvw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 23, 2021 at 02:17:58AM +0100, Matthew Wilcox wrote:
> On Thu, Jul 22, 2021 at 11:55:58PM +0100, Wedson Almeida Filho wrote:
> > Hey Matthew,
> >=20
> > On Thu, Jul 08, 2021 at 01:58:32AM +0100, Matthew Wilcox wrote:
> > > Why are you so resistant to writing a real driver that deals with act=
ual
> > > hardware? =20
> >=20
> > I don't think it was so much resistance but rather a prioritisation thi=
ng. Have
> > you by any chance seen the gpio driver I posted a couple of days ago?
>=20
> I haven't seen it, no ...

Most likely it is https://lwn.net/Articles/863459/

=20

=20
Groeten
Geert Stappers
--=20
Silence is hard to parse

--67mj6aqryecr4rvw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEin8gjG2ecykWV0FNITXRI9jBm+wFAmD6qQAACgkQITXRI9jB
m+zOyw//R/ups+zRvGYwR/AI5OtWjOFKYdDUACDl9PGEMYn4IK8VJ72hfrVV03cA
irukF91cUBa7sB/vaa9gpnD9cWapPCIcwgOT7cIWGPgyi06JpIDOB1StTGzlvZJV
kjojc/qazR/V5uhe987qhXrc0N5mOkhvCuIwVYTZR0H2VSgfhhO5qKLhadzcKGij
EaEooeI0uM4TbKAxrS9OJKI1PwHPg5Ww0lZPeUgU6OLgzyLscAxwWL9XtRHOTcQ0
1/rZR+DWm4RvjweGitNy8pfQLEOjnjb6Y7U9u9FteeikfQhY4ChBgnAmdinO/wWw
/J1v9Q3ODOHagU2ihgKaoZYo7g2cD/Ks/MN8ooxYSOE7/x3L6IAOdDMkORXN84Mc
/OA4ZIGhy4IdiSzEBnHfyV2ituBBY3SUEm43iDR6ydOtkKXI5DNiEAIcImBYFtrB
LiWi1inyawL1XCp2yYqUvbAWzDEdXpuUKOovNR5vZklQb1jzJcOVo6zm5yPP1x3C
ckXaVqFXbKRR+1F9GklM/d5OA8mvjFY7HccIVcOkPfv0N6Lt+Y1NNu2dNmXHmFlo
6GdCm6mXzRFh61tSkX59OVQRspSAlURhlauiKCO4i2tA5HtcIZ3/KANmuJOArTt6
kAlodz13QWkYeDc1LtJ0i4hL/0hO9lUTbKD/PjAb0PYrT4wK8/s=
=jmor
-----END PGP SIGNATURE-----

--67mj6aqryecr4rvw--
