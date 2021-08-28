Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEB733FA5B4
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 14:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbhH1MrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 08:47:10 -0400
Received: from ozlabs.org ([203.11.71.1]:39511 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234012AbhH1MrB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 08:47:01 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Gxbt71cB7z9sxS;
        Sat, 28 Aug 2021 22:46:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1630154767;
        bh=Ib/F1AUkPbtr95ajbp8rWSPbdz/DrlSAGa1a1EJ/h+M=;
        h=From:To:Cc:Subject:Date:From;
        b=NwZyAE2XEmm2A8vpYoFnO19QxEBgrN7+eIlX6PY1yNuI0s7Gj62NydjsLEZAKwLCL
         sNnw/aStJ99SaSI4osnSeRJrQqZsgL9mez1hZjGxnWnn2fnrmrGXgsQqkyYaVlTp7Q
         IeHRFrSyk7SfltJx5jWLV4GY4oaLE/lbUaAWaUx5PXiMxhswoQ8vhfT8aoxmJX1XB6
         P52OcDlww+hIQMbf13zP54S0CufzPKkWbR5ttnRmO6RVr0x+HcFCDosizXuwKqP3xR
         eWfpZjA6e6KV37jcfKgM7KDJyAS7hTD/Zk9Yc+lZOvx/DFvP2LK3IMdBSfrUBa+ejB
         Sy1/hVuEuSdZQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        lukas.bulwahn@gmail.com, npiggin@gmail.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.14-7 tag
Date:   Sat, 28 Aug 2021 22:46:02 +1000
Message-ID: <874kb9g2k5.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull two more powerpc fixes for 5.14:

The following changes since commit 9f7853d7609d59172eecfc5e7ccf503bc1b690bd:

  powerpc/mm: Fix set_memory_*() against concurrent accesses (2021-08-19 09:41:54 +1000)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.14-7

for you to fetch changes up to 787c70f2f9990b5a197320152d2fc32cd8a6ad1a:

  powerpc/64s: Fix scv implicit soft-mask table for relocated kernels (2021-08-20 22:35:18 +1000)

- ------------------------------------------------------------------
powerpc fixes for 5.14 #7

 - Fix scv implicit soft-mask table for relocated (eg. kdump) kernels.
 - Re-enable ARCH_ENABLE_SPLIT_PMD_PTLOCK, which was disabled due to a typo.

Thanks to: Lukas Bulwahn, Nicholas Piggin, Daniel Axtens.

- ------------------------------------------------------------------
Lukas Bulwahn (1):
      powerpc: Re-enable ARCH_ENABLE_SPLIT_PMD_PTLOCK

Nicholas Piggin (1):
      powerpc/64s: Fix scv implicit soft-mask table for relocated kernels


 arch/powerpc/kernel/exceptions-64s.S   | 7 ++++---
 arch/powerpc/platforms/Kconfig.cputype | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmEqL8QACgkQUevqPMjh
pYDvjQ//dYPmb8eTLrWTRXUy6vLnem+CuJv6gyLEG+7s6T8qZMSA2uvKr4zXAvgF
2QOAoVYWDth6blxjfHc5zqpdERhZHhOq0o2ofuJYGz1J/HAymvIohGFmiIwvOu5n
rPI8NMmsw61W35jJS7dgRr86b3rBwZSzRpDL14g+zQRRzuCqnBdOCA3Ixxn5JQ/F
D1AhyWL61IpVdg0Tz6FRU8s+VKYHh4Yr/CsozkFRMgqZZ2k3zs7aTcluyN8JhEta
BoqejJStrgRt2KOJPr3HXk5fHaoz/9AJn3lSauhnEPFR/Li2ChjkDZPd9KQysHI/
f56HfO/jRx3lY/qhHQ3HeGVJ8rsQrzEILj7KqL0KHwfQoqAhP3E2sut6oqZBFWii
HzfNl0vDrVkjBW7WDV/Y1hlGYaeiGt6DgXwh6wifek6JhMSABwyrd+Uoi9efG7sg
fOUl11VHvBHHQoT+h526urQrdSvgNn+M2iwjElK3LC+tDStNVZTxEiS/KtvpK1vC
I7f7CuwS+z3y4kPs2lwr1t0qQOnmOsvJP82+IDb7Tq4LJRgajyFlGdUEtMrpxZvP
whpFxWrxlQabX6QEr3CGYTGjbiYaGUCfWLkwhwpcftp7QcadjYko7u6nxIyOjI2G
8XG3+CMcPkNB4fSo4Ijt5upaTjhjl4JUGEenLHbyzdcixfj9Z9w=
=yPpX
-----END PGP SIGNATURE-----
