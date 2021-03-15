Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF3F33C4F1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 18:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbhCOR42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 13:56:28 -0400
Received: from mout.gmx.net ([212.227.17.22]:60269 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233932AbhCORsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 13:48:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1615830427;
        bh=Wu1d93KCJ6IyQLhxRr2vqIOFNnbH/Vo0DvKz84ETRYE=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=HgHBw/Fdkel0vjiVaxiIX7XF90iQnfZCEbaTk0uim5g5mMlYq6pkgGXLHj6M8FImA
         lwqSUIfcAySCPCg4YLYNgs6y5EecWHD6u8aA4u0KDpmEoP1e322Ib7nBs3iJBleNvV
         bPA3Mh/93bKeoGEF2wGllYLfP0l41kJtvhSlmiA4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.134]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MkHQX-1m1Gfi0fKj-00khDv; Mon, 15
 Mar 2021 18:47:07 +0100
Date:   Mon, 15 Mar 2021 18:47:05 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Rob Herring <robh@kernel.org>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: arm: Convert nuvoton,npcm750 binding to
 YAML
Message-ID: <YE+dmdBBk0BZ7BIO@latitude>
References: <20210313175321.2515675-1-j.neuschaefer@gmx.net>
 <20210315162338.GA973222@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wJW7zCh7EAM97BVR"
Content-Disposition: inline
In-Reply-To: <20210315162338.GA973222@robh.at.kernel.org>
X-Provags-ID: V03:K1:EFciw7A0hfwSHV60faKpptLnztVaI7IRnOFK+4pxzVJbcNXE3n0
 gB3RYi3rWS0wabiuGgQn5DeljqgEA69dpTkJ/GY3pPsTWEyq6TFF5JgSckSr/7/tODcJbxe
 b4mv5MUTbyEty1Zm0d+ggOGnABleyMGiZKjbLXGrWM3asaTpK2e7wqjsLDgEHMR/EFCZaqj
 GKJAv7X8tGsEWjIRfYbpw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:AWMPOS+4Jfo=:vlwg8muDZXG2b7zp3jZ+8P
 KUaSRCLzlislNDNsfCZFqElPlQe+TzbTedPDWWhRHvk9yUF4KahqHhNiCZZfcFEea96t8Tacm
 8KSsSR/yuLNElifRqihCslGy4984Je4cgnpW8h34/sIWujwkTRJ6fCJppbz1kqhU5iR4aTpnq
 UfudejGoy4Yh9tN9sLJTg6BGCpePiUU7/0+bsrcjnTTyPyJv4Zsbnf5IFxfCQsQ26xDbSKiaM
 ZGQUiIEIsibGzSML9RLxgTguWmA/wQnFHnxxNF1vzKHTwnfd4i2KDZOynork6i63od17mdVb7
 9xpWzZYWYlLLYWCMOXU2vVk9eCKy2hM6QptE4vNkj0K97ixPBwZQ7yw6Zn7FDQcElHQNpUTX6
 Hx3w8O9JSubTaXJk4OmVhy4i/HEkrt5t7ByL5Dac1lVAH6I1hScuTrZltUaO2Ar/QCGwBK2RD
 MSgZvv8YKVURWqdDAbmHLVAJyq1+YmyPSV4jVWgTuNvADUE5IZXavsxsHUlErdEeQptTQGynw
 Vpvh26TzX4SEfeaHsnAjDM82j10W+75NztTUVSfaNUbqmpJsUnpCg/IEJSSt3fV+7fqdNFLQT
 h4o4rmqEJm6jKg8oFNwXnH2ogGID289rmr01jWF6J8y3BSLg0tZT08nxUNcLXkGLbYlns9jSB
 Qtc3J/05PaG2QYSPcrRdOdFC5n294wrwCDQ1eiEEy915zP/TvRlC2joiMt0EskhZ2jXwoVTRM
 LSam75Q6TnlQoY8U0d2qOBzH6Tkl6pXKcPmcl0vU4+zzg/jOx/WGL2BboOWZQ0UyPXmFcrUEE
 TqX9jnDQM2JLrLxR9e8FI4y8B3bHkKkCwUh/I+s8sUq983IWZxMEeazRFvWabCC72DkqFNUxN
 GOfEpZLoiN4OZwRhN28w==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wJW7zCh7EAM97BVR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 15, 2021 at 10:23:38AM -0600, Rob Herring wrote:
> On Sat, Mar 13, 2021 at 06:53:20PM +0100, Jonathan Neusch=C3=A4fer wrote:
> > The general trend is to have devicetree bindings in YAML format, to
> > allow automatic validation of bindings and devicetrees.
> >=20
> > Convert the NPCM SoC family's binding to YAML before it accumulates more
> > entries.
> >=20
> > Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> > ---
> >=20
> > If someone else wants to be listed as the maintainer, please let me
> > know.
> >=20
> >=20
> > v3:
> > - In this version, I removed the nuvoton,npcm750-evb compatible string
> >   again. I had previously introduced it to simplify the binding a little
> >   bit, but Tomer Maimon suggested to keep /compatible of
> >   nuvoton-npcm750-evb.dts as-is (i.e. only use "nuvoton,npcm750", no
> >   board-specific string).
> >   Because of this change, I am not including Rob Herring's R-b tag.
>=20
> I think you should add nuvoton,npcm750-evb. Not so much for that board,=
=20
> but to ensure any additional boards get a board specific compatible.

I'm inclined to agree and go back to v2, but I'd like to hear Tomer
Maimon's opinion first.

> > v2:
> > - https://lore.kernel.org/lkml/20210116010907.3475405-1-j.neuschaefer@g=
mx.net/
> >   https://lore.kernel.org/lkml/20210303154622.3018839-1-j.neuschaefer@g=
mx.net/
> > - Fix indentation to satisfy yamllint
> > - Fix $schema line


Thanks,
Jonathan Neusch=C3=A4fer

--wJW7zCh7EAM97BVR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmBPnZEACgkQCDBEmo7z
X9vAsA/8DydIOX3092DeZLSRBhpBXobXkng94K3NOlk7BOv5bSQH/PQfBGfwrkqo
bDhN8p6nFJoSf3jkD3zEhhnq0A4clDq33f7CEMhU+H8jb1fLCRM+HaMthSJ5BtbW
gxO9fZZ0Sk+PO1bRCdWRF7hWY2C1SPQh9eWZPiNRDr+qSu+Y/ofM5gEMN/ftsSSD
p1gfhsFHbTrwapkZigDHuiDxEsKpflus2GX6H+e4nE3S2J9DQJqlG0e4c0pV/1SY
I07cfIpqNCqO9uEePGKFyfBjYHOjHIhiKDHf9NVgJc1eCH4zoSWnEjJe8xq4Sk9G
4rb37xQrKvrqtwUeKhxnKlWLj2DVjixO0RvKH/NPad/L1YBz9P0vbPeUtMG9XjfH
iRnphcVkpivnlmDD3TN5xjjYwjXDLOf2nKHAjs5+cNhmJzooS9vB4zb9LnGTolXk
DTII7K3O9yU1raGXU7dnXENB54FQRFo4NB4Z5U9lRuTy1CQSmSyC6uE6RELJKPpJ
RDTFoHz3Lh2kmnO9Ayu/jD4vcrc6d4HKMhxJwO+J2Ka3ADWByNH+1VAUC74AoGqy
+borMy7d+zPbtYZhBHXIPSnFdPGpPk5fzdsQoWeeh8H7vdri0HFu3bnKBctJ3g65
9I0PBhN45wKEVYXoD0rla09TGgRHVROtFIE+LjVHv+R6mEmegKM=
=bzH7
-----END PGP SIGNATURE-----

--wJW7zCh7EAM97BVR--
