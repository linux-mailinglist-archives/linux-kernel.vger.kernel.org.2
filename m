Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F4B407650
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 13:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235741AbhIKLuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 07:50:23 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:34469 "EHLO
        einhorn-mail-out.in-berlin.de" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230249AbhIKLuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 07:50:20 -0400
X-Greylist: delayed 352 seconds by postgrey-1.27 at vger.kernel.org; Sat, 11 Sep 2021 07:50:19 EDT
X-Envelope-From: stefanr@s5r6.in-berlin.de
Received: from authenticated.user (localhost [127.0.0.1]) by einhorn.in-berlin.de  with ESMTPSA id 18BBge3X031428
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 11 Sep 2021 13:43:00 +0200
Date:   Sat, 11 Sep 2021 13:42:36 +0200
From:   Stefan Richter <stefanr@s5r6.in-berlin.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: [git pull] FireWire (IEEE 1394) update post v5.14
Message-ID: <20210911134236.58da0be9@kant>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/qIXG0B.=9T1GyME9K.JO/Ba";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qIXG0B.=9T1GyME9K.JO/Ba
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Linus,

please pull from the tag "firewire-update" at

    git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git
    firewire-update

to receive the following FireWire (IEEE 1394) subsystem updates:

  - Migrate the bus snooper driver 'nosy' from PCI to DMA API.

  - Small janitorial cleanup in the IPv4/v6-over-1394 driver.

Christophe JAILLET (1):
      firewire: nosy: switch from 'pci_' to 'dma_' API

Pu Lehui (1):
      firewire: net: remove unused variable 'guid'

 drivers/firewire/net.c  |  4 ----
 drivers/firewire/nosy.c | 43 ++++++++++++++++++++++++-------------------
 2 files changed, 24 insertions(+), 23 deletions(-)

Thank you,
--=20
Stefan Richter
-=3D=3D=3D=3D=3D=3D--=3D-=3D =3D--=3D -=3D-=3D=3D
http://arcgraph.de/sr/

--Sig_/qIXG0B.=9T1GyME9K.JO/Ba
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElVwAmOXEbvmhUkgUefNvslRdedAFAmE8li0ACgkQefNvslRd
edBfqxAAgOhfHtfVPC44m/8hZHUqVeRNCwdFmsDd3teqbunXsrD3lagSgzLhysZD
b/KciVbe8vRDreNxtH3KaGTWOhMeGL7BcrKJhQPlizwW3NrQketEzkh6OXLfJmQw
bwT/+fPUFNrXEWKN0iPLEDwkN15JbRX1oQqsA/OK+gOToASNznjEG6cyUwZjz5Yo
n9QBa4pCtZd9WPzklvbYRbYHlhDxoaqyGVVu+2bVqfhtSCmhfHHweuAN+O4zXgMm
mgkdEACXhZITTPd/KTyOP53OyR6N+uugTAgdIDcorKET8oqOcjbP4WnqiVpgTwxj
2PSzqYsIisuYWEqQkWWvSE+V8YIGqkvuDbXJ7DP8GQnOnZMUXAdE6nDKArL51/BD
eer7uHF88kk7H66rkejrg0Q0oJS2F6ZsUjfxF4YdorILQ1+0HOJW0chfg0ZvvsNu
OakWaVfohqkICoLrbWBBZlUQDYg7iU6UqrZ1IAtZxb0Y7olN4VpCNRZZZ+5rHDMR
hwqjNf5wZHjl8L6N3fMFsopVETx62jRwV53Td4bS+RcincH/CDZM67Wf1Cx50NTA
+I7kouSI7nrEbIuFcbmVVxX2zx3YMvB9YVgdlJ30kBzf64ExuqIWo34jvizDx+y3
YeiTULOvTXRi0nFSTqzcubMn27pyB80YJctpROtFmNFXtzNCkTY=
=Ak0q
-----END PGP SIGNATURE-----

--Sig_/qIXG0B.=9T1GyME9K.JO/Ba--
