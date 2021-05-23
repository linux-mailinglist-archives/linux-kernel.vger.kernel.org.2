Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B33238DAE6
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 12:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbhEWKd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 06:33:26 -0400
Received: from ozlabs.org ([203.11.71.1]:35859 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231666AbhEWKdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 06:33:24 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4FnxTx40NMz9s5R;
        Sun, 23 May 2021 20:31:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1621765915;
        bh=FLbc6qKDigIvCy3jzFRrVOrsSN0v00phVlCkkWEKrzA=;
        h=From:To:Cc:Subject:Date:From;
        b=eR0bvNCYTpv7jum/8Ab11xRfBf0r68qw75EPjz5xfLkll02LKA/cy9hxL+7X72oPD
         WNt1z1IyF1oLQIDS2vNVU2uss2fhbBNZFhvJXmF/o1tLow/K0I7augmLzZ1pWpVdVb
         j7FzhmiPWt6Vp57oYAbE474UJGi38Ow9dhywT7nGcMSLsfGSJJwZgf3dOW/TeUcDDi
         CWODAXBIzy/rMo6EOwu4ElRDMiIkf4resXKpp1AYXAiXO3wZx1UynFFnUtSCTLxjYC
         KlT/E4JIFsBmkWjc6jbHAN0YO01V6IcGWQia7nYASyLe4/1yXAgvDEVL91BVgQ6j55
         HQBjxUV1nGKxQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     aik@ozlabs.ru, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com,
        Kees Cook <keescook@chromium.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.13-4 tag
Date:   Sun, 23 May 2021 20:31:42 +1000
Message-ID: <87pmxhivw1.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull some more powerpc fixes for 5.13.

It's not obvious from the diff, but the seccomp_bpf.c change is entirely inside a
__powerpc__ ifdef.

cheers

The following changes since commit d07f6ca923ea0927a1024dfccafc5b53b61cfecc:

  Linux 5.13-rc2 (2021-05-16 15:27:44 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.13-4

for you to fetch changes up to d72500f992849d31ebae8f821a023660ddd0dcc2:

  powerpc/64s/syscall: Fix ptrace syscall info with scv syscalls (2021-05-21 00:58:56 +1000)

- ------------------------------------------------------------------
powerpc fixes for 5.13 #4

Fix breakage of strace (and other ptracers etc.) when using the new scv ABI (Power9 or
later with glibc >= 2.33).

Fix early_ioremap() on 64-bit, which broke booting on some machines.

Thanks to: Dmitry V. Levin, Nicholas Piggin, Alexey Kardashevskiy, Christophe Leroy.

- ------------------------------------------------------------------
Alexey Kardashevskiy (1):
      powerpc: Fix early setup to make early_ioremap() work

Nicholas Piggin (2):
      powerpc/64s/syscall: Use pt_regs.trap to distinguish syscall ABI difference between sc and scv syscalls
      powerpc/64s/syscall: Fix ptrace syscall info with scv syscalls


 Documentation/powerpc/syscall64-abi.rst       | 10 +++++
 arch/powerpc/include/asm/ptrace.h             | 45 +++++++++++---------
 arch/powerpc/include/asm/syscall.h            | 42 +++++++++++-------
 arch/powerpc/kernel/setup_64.c                |  4 +-
 tools/testing/selftests/seccomp/seccomp_bpf.c | 27 ++++++++----
 5 files changed, 82 insertions(+), 46 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmCqLoUACgkQUevqPMjh
pYBx+g/8Cn2ZwpkN2QZ9bB0sqdjuU74jPzaAnEn+6soqCjySQ7fQI6a61M1Iv8Tv
fuA04jAl07TKcE42JTEflFc0FxdvfYOhxHtRq68AdYBVCaA6Fd3hMY0WnWugUgPR
+UEeMptSeDjBYfzq0h8VSRJj/slMqkDfn5EMTzjaNtOIY17dz3Mhpz1uXmiSuS/1
6xTGKFvlmauaGzgdlM5rjJZcRU70nDqG1F6brpUgHjEJfgOPKtEQRghWhetEUKuw
EG3zi96no7L2WTFPlVLS2F1bYuItEnSmP8Abe0dttRDamFHX/gp349P8sOX+iwrI
QZszmprjWU/IjTN8FT3qyFp9zquKiz7b3zwiMlrIf9WuN5eDxE4hK76M5Gx13obP
3jEnQvukw0GqiY+hSEvNaudnN6WzTlQN307bK76gV5xgGGp7eF4q93lhKgpj8Heg
1DBCquOODVk0TyeKmKs7v2/7PXBLkzSlzrYsHJmMv6E+Hdb0A1pYWxBQgmYp3/ON
g3So3jTIruG3shukXYzn6Ay7Uq8rU7Pjhy1oWXGCTjv675Q06YS4X0ClIrkImayZ
Um/lDsmwahroD2GRfbEt+JZmrulV5FTdYoMGSWk/wUfrEwB8ms3tte1dqGrnrQrY
BUnJyLCXVhJknEnrOMxPgpzfTb91cseLE3/AI5HzdUf9Y963PRQ=
=kF6i
-----END PGP SIGNATURE-----
