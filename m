Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE3C73F3CCC
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 01:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbhHUXyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 19:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhHUXyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 19:54:05 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CEEC061575
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 16:53:25 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Gsb1F315Vz9sW5;
        Sun, 22 Aug 2021 09:53:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1629590002;
        bh=Onr5AVHEjS7M8Si0SK8p4+KxnU55CdgeVthymwBaJDw=;
        h=From:To:Cc:Subject:Date:From;
        b=nu0XqUSSYyTuXZDETTjfzNFz+D7FURiP19Gmfd13EsjceY2owDp7IH+JUisr1qNqn
         hQyHf469VuduqJ3WByutUUDFiVvfhkKntgFLqd996g4+ZEbvVWaUEhBwNl54/lvgDw
         2RX45lcEY4nTb0tsvEOl3q1XvJi6P9tIKStlsQofSqxCWn8AqCm/SDTTjboWJYpYfk
         TqC5DQqWPjJosmzZ0bqb6+5jWW4nJoBkykLQK6tVT3TJLdGgETSw6CxzKze12q98nO
         kRnpvjVfV57C6061XtSjC/MHdvdFNRz53FBymGyo/k/ft4tPpFktKGAJMM3XW+xuno
         DqgGHz/d1rgfw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, nathan@kernel.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.14-6 tag
Date:   Sun, 22 Aug 2021 09:53:18 +1000
Message-ID: <87mtpacq35.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull some more powerpc fixes for 5.14:

The following changes since commit cbc06f051c524dcfe52ef0d1f30647828e226d30:

  powerpc/xive: Do not skip CPU-less nodes when creating the IPIs (2021-08-=
12 22:31:41 +1000)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/po=
werpc-5.14-6

for you to fetch changes up to 9f7853d7609d59172eecfc5e7ccf503bc1b690bd:

  powerpc/mm: Fix set_memory_*() against concurrent accesses (2021-08-19 09=
:41:54 +1000)

- ------------------------------------------------------------------
powerpc fixes for 5.14 #6

 - Fix random crashes on some 32-bit CPUs by adding isync() after locking/u=
nlocking KUEP
 - Fix intermittent crashes when loading modules with strict module RWX
 - Fix a section mismatch introduce by a previous fix.

Thanks to: Christophe Leroy, Fabiano Rosas, Laurent Vivier, Murilo Opsfelde=
r Ara=C3=BAjo,
Nathan Chancellor, Stan Johnson.

- ------------------------------------------------------------------
Christophe Leroy (1):
      powerpc/32s: Fix random crashes by adding isync() after locking/unloc=
king KUEP

Michael Ellerman (1):
      powerpc/mm: Fix set_memory_*() against concurrent accesses

Nathan Chancellor (1):
      powerpc/xive: Do not mark xive_request_ipi() as __init


 arch/powerpc/include/asm/book3s/32/kup.h | 20 +++++++++++++++++
 arch/powerpc/mm/pageattr.c               | 23 +++++++++-----------
 arch/powerpc/sysdev/xive/common.c        |  2 +-
 3 files changed, 31 insertions(+), 14 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmEhkccACgkQUevqPMjh
pYC9Lg/+IUShkBlGUMxvOiz81E/PllRoYsj7ljHyzACZ1ofwa2u2ffSX06E8Ymqh
GDtzSx13q6i9zInxZ4Fg8Ml7wh1oWxRu/wDOSoOS+Td2JtjhJxB0YKOxnpdr2FaS
7wMQpQOZVQfbskr8RouuU0mvUYhrdkxQJT8Q9E5xOUl8jTuzmYsctdr5JHzUVWHF
FrOrKDVs7thwwUlZ5vA9woCUC4CxktqR5WX89KJLd8zuwuH2nNVVq7fLVm2jC7vU
VVww1XydwSPD77r8CCqd599Sx/yGF38xKPwJ9eVqQktceQnSCI32xSfhSTz/HfMm
CVMTkfbqP1Mwo0dGWnZXfJICB9pUlOImT5+dwBFGzOnEent13ZJGcVivKZj8KhHu
wT6AOSpMpS7+I3VfPwgv97YZT9Obea4Ntap1hBKCxgPg7Szb3MRvdpR+Rw77DaYW
YAJL3gugzhWtL4xZ6gkYWlya9boS1cuOa7tVHncrouQ1XYT0ac49BwTnA85x/orV
rlgaNg4SETnqhXWYhQOW+3K1iltgWnYHiD777y+m1jupFZv87t9F/2mjgqj/MqIV
YIrpXfY0XLu092958taOvcjYhjjFjIuQVaXHhSLhTH3s8A6zcbULwqJCqjNPvSOx
b7+ad8XFLLFjNqcF6MDcp63WK5zUf21ev0iNRfkXoMaat3cnn/8=3D
=3DQn2l
-----END PGP SIGNATURE-----
