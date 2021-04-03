Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 306EF3533CD
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 13:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236622AbhDCLsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 07:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236496AbhDCLsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 07:48:14 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E43EC0613E6
        for <linux-kernel@vger.kernel.org>; Sat,  3 Apr 2021 04:48:11 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4FCFY24Jp2z9sRR;
        Sat,  3 Apr 2021 22:48:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1617450487;
        bh=YRLSj0a8S1jccv7CvoHZicpnAvcgRhWqMSGP1YSnTro=;
        h=From:To:Cc:Subject:Date:From;
        b=VL5Kt5/Um0Okt8pQTYg9UDAcP5sAs09gzUIJNaI4+ymmIz1GRR0G9ESm8xuJ6275t
         ykMqZ//W/YbUb2P2VJEyg8g0FeE43UIN4Yj0moBQeNFEbfr4lAjCOKkjkR75smKa8x
         ESFYVgyV0FBoRkLTf9c7GXgSAqYBNYNoQn1lAcw6I4AohK4pjk2dMdTheg9dvC7VD2
         SwGLTvlJJ5VmbD/+KB2SBSARTKccusp2dUEqQXkE53MQuUuBxAb5fy/HP8UWL0LcLU
         tOYcVneurhT+BjgaosQHIa5U14DnueXOf8h35vuXXDzTs+G1jhfJV2u7qGi1wmpjtk
         lH2yFCkcrc5Ug==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     aneesh.kumar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, nathanl@linux.ibm.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.12-5 tag
Date:   Sat, 03 Apr 2021 22:48:02 +1100
Message-ID: <871rbr1te5.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull some more powerpc fixes for 5.12:

The following changes since commit cc7a0bb058b85ea03db87169c60c7cfdd5d34678:

  PCI: rpadlpar: Fix potential drc_name corruption in store functions (2021-03-17 13:48:07 +1100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.12-5

for you to fetch changes up to 53f1d31708f6240e4615b0927df31f182e389e2f:

  powerpc/mm/book3s64: Use the correct storage key value when calling H_PROTECT (2021-03-26 22:19:39 +1100)

- ------------------------------------------------------------------
powerpc fixes for 5.12 #5

Fix a bug on pseries where spurious wakeups from H_PROD would prevent partition migration
from succeeding.

Fix oopses seen in pcpu_alloc(), caused by parallel faults of the percpu mapping causing
us to corrupt the protection key used for the mapping, and cause a fatal key fault.

Thanks to Aneesh Kumar K.V, Murilo Opsfelder Araujo, Nathan Lynch.

- ------------------------------------------------------------------
Aneesh Kumar K.V (1):
      powerpc/mm/book3s64: Use the correct storage key value when calling H_PROTECT

Nathan Lynch (2):
      powerpc/pseries/mobility: use struct for shared state
      powerpc/pseries/mobility: handle premature return from H_JOIN


 arch/powerpc/platforms/pseries/lpar.c     |  3 +-
 arch/powerpc/platforms/pseries/mobility.c | 48 ++++++++++++++++++--
 2 files changed, 46 insertions(+), 5 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmBoVTsACgkQUevqPMjh
pYDlFxAAkkiy2RiHbaAlWHpVekXVQN1/oRISHQ+9jRco3BQUAEq8wHJNrlArnab6
N7C/ig2SiugagpLelRsXeXWyM54U3syIQnX3NRg82PgUBxU/LGJmIcyWCgDIf9x0
/xbMrWcRMuzY1x916rX7MPuSVc8LcyVu9nByBrbFWNE6IqUrJ0ngrBNNsEyWbEf/
NBHYqUzpurXYv/OHEPOQu9GIOWej5SR8oOKGn3/aJ66cg3WoC7iC56seBjSIrcLe
zwhUenwRYM6YQ6boX0OBKs/NaPSeT9qy4JyZOe0Sqeo0Yvhj4VJs9W0napIYQde5
y6ieoyHk33xPawUWiTEtkLmvH2nZPVRXCfGOQmh5B4mvuS/rrv6hTeFkdLFZ74yJ
Fuan/ljnXSPTkT+xRITrOO/irZyTaRXJ4j0Ck3LrtluUFib9psf+OqtoIiqqy11w
u+E8T1GChRZTuy2iMZy1jiyvmKwa/S5v67YUU2xUXNYeRI8j3g3cPo/W9Skn3TS2
LiO5+/6Ws1ABn7TohGV2R7sTPu5AnJP7jyHVJuDbtf/Z79U1SMiNAOb8jA/8WNbW
0NtLSQsy1PHonsqUIJgJntmstA46Xnsr1ruA2wR7GEuaaBrjSynw9cG55KlA4Lug
16kaOFPBnJhvkgjTDI7Xl7+ktr4yuR5EriDI0wJMqbhxn+IJ5VM=
=9cfb
-----END PGP SIGNATURE-----
