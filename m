Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB8E9319672
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 00:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbhBKXQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 18:16:53 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:42967 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229625AbhBKXQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 18:16:51 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4DcCDT5ktbz9sB4;
        Fri, 12 Feb 2021 10:16:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1613085369;
        bh=JbKi0c2idc6mQ5P+7UOfhT57sxfNnkjIaB1g66SBgiI=;
        h=From:To:Cc:Subject:Date:From;
        b=lmS+g0ar9/UR2FqRNjQQ4PAjRXry97KjlKNIQLciIzmHujXJrQkLNabzt069V8ywA
         Zz4I9oST3URr/a19IqfG30YbQspKwT5bNPxHyNyDrcqm1C8sQlX4XGbWuRD++knW67
         hbNm/CXJjTdmxPOmxyK2MEOYZ/5ugUO+dAUjTU6WV9PjwOfoZqMr9t0QXeCQ18SMqj
         xFzFDiX80UIY/75GJSi+5vTXshVVFegIFgXc1wEhPGBYaZuwTy1iTgI7bh+AIlHH8C
         7pQN39bH/ANxYdT7Llo9ac/cUZMfMoTygI6XoJYNA7hDRzIfSG6+idJVOolFbEvu1v
         uCXURul9/inOg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     aneesh.kumar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.11-8 tag
Date:   Fri, 12 Feb 2021 10:15:59 +1100
Message-ID: <87blcqnqkw.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull one final powerpc fix for 5.11:

The following changes since commit 24321ac668e452a4942598533d267805f291fdc9:

  powerpc/64/signal: Fix regression in __kernel_sigtramp_rt64() semantics (2021-02-02 22:14:41 +1100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.11-8

for you to fetch changes up to 8c511eff1827239f24ded212b1bcda7ca5b16203:

  powerpc/kuap: Allow kernel thread to access userspace after kthread_use_mm (2021-02-06 23:13:04 +1100)

- ------------------------------------------------------------------
powerpc fixes for 5.11 #8

One fix for a regression seen in io_uring, introduced by our support for KUAP
(Kernel User Access Prevention) with the Hash MMU.

Thanks to: Aneesh Kumar K.V, Zorro Lang.

- ------------------------------------------------------------------
Aneesh Kumar K.V (1):
      powerpc/kuap: Allow kernel thread to access userspace after kthread_use_mm


 arch/powerpc/include/asm/book3s/64/kup.h   | 16 +++++++++++-----
 arch/powerpc/include/asm/book3s/64/pkeys.h |  4 ----
 arch/powerpc/mm/book3s64/pkeys.c           |  1 +
 3 files changed, 12 insertions(+), 9 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmAlumMACgkQUevqPMjh
pYBb9BAAqpyhvEjDiyP0xeHUTQ9UsNMnNUW7Hp03jJYH+EKWC9nT7kb3TY1eNyk5
KyMBOtXiQsggzWDE31bR32BpH/JChSeRPaCO4HHdDS9t+3ZIo16RTFksdiIhCN6m
nI4WhnfrdZszstMRsKWzfoLRVDGyNi0hyyQaMS3ypuKvRmozZk6u9K/YNXMa97Wf
ihhB0lYRdfMNgxMm66uaqEtzYt3Z4dRj9Y24LQirJnp32xK+sNgoleHl4gvvKG3m
r7CogqHlcExbkD3dl/PPe/SVEesfXpmTrQPCvJmi0qWm9NzkduQWrSEkUkUp1YQD
T0pBHnCxtI7GAAQpCphBA3gjrz03Og4/RAXmfESgI0JHyh7Vihx91XOwuonuJndn
5ThY2D9+nkZ2vnlis2/AoLx6ClbNgZysr0iAOsRyd2SYR9Er2CcPZ4OuNHXWTHlz
G4SmVYiZj9gnSrzqlEGIqBOVWdykV+x+xkLLQx86HUAI+7f1mFV1+dJ4E5NLGKzS
jB+XwwG2y6q6SnJt2iiybqDu9K1lPWnKFLNeb4at7GfpJ4riKNcRSYrkY9xYxmkR
kgKyXfW+rNt1RcIoy65kNa3hSnXi4p9wc5Lph7joS7zTkZIKR2E3QUJjGQao85Qa
rNxccSz3X7ZAL9OEJP/4nE72Zf3VXkzuKbB79D3dhFJ8SJmbPqQ=
=GDL5
-----END PGP SIGNATURE-----
