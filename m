Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A97A3ADC1D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 01:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhFSXm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 19:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhFSXm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 19:42:56 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4EE0C061574
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 16:40:44 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4G6sjg4MXnz9sRN;
        Sun, 20 Jun 2021 09:40:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1624146041;
        bh=amvNJNy+ZWUWObBHVKZALCApYZ772MCSmqS8exnahqU=;
        h=From:To:Cc:Subject:Date:From;
        b=UBmgtB05/SVwKFjZD2cDLvE4cv+BfuimTIO0RR3f08Jq07Sa+f2Z5N0CDTtTI5ZwF
         Qpz29XamRsPkPV6UoLfEiN7+d1lyuyfR9E9llPw8hHx+Idq2V43ZfcZia1qaGj5BA3
         9QkaeEpL2nDp4mfQF418EvDmh1IElz053ydH0k4L0lQJCJsL0FOrNrWUNjxkL2TFcF
         mem+jEgIJ6CIGesD68o7SGhJFIo9PXRNlpzwhYgyAKv/YG1/Bfvcyz71lAdfXxGTzC
         JjfXdMEgGgypDN6ijvA/4iBM3fFWkYbOuNxi2vNE/Bum4bTkSE9uXl8cqmkkHC/FyI
         Ky3Iv+S6YMgXA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     atrajeev@linux.vnet.ibm.com, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.13-6 tag
Date:   Sun, 20 Jun 2021 09:40:38 +1000
Message-ID: <87lf752zk9.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull some more powerpc fixes for 5.13:

The following changes since commit 59cc84c802eb923805e7bba425976a3df5ce35d8:

  Revert "powerpc/kernel/iommu: Align size for IOMMU_PAGE_SIZE() to save TCEs" (2021-06-01 11:17:08 +1000)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.13-6

for you to fetch changes up to 60b7ed54a41b550d50caf7f2418db4a7e75b5bdc:

  powerpc/perf: Fix crash in perf_instruction_pointer() when ppmu is not set (2021-06-18 16:30:36 +1000)

- ------------------------------------------------------------------
powerpc fixes for 5.13 #6

Fix initrd corruption caused by our recent change to use relative jump labels.

Fix a crash using perf record on systems without a hardware PMU backend.

Rework our 64-bit signal handling slighty to make it more closely match the old behaviour,
after the recent change to use unsafe user accessors.

Thanks to: Anastasia Kovaleva, Athira Rajeev, Christophe Leroy, Daniel Axtens, Greg Kurz,
Roman Bolshakov.

- ------------------------------------------------------------------
Athira Rajeev (1):
      powerpc/perf: Fix crash in perf_instruction_pointer() when ppmu is not set

Christophe Leroy (1):
      powerpc/mem: Add back missing header to fix 'no previous prototype' error

Michael Ellerman (2):
      powerpc/signal64: Copy siginfo before changing regs->nip
      powerpc: Fix initrd corruption with relative jump labels


 arch/powerpc/include/asm/jump_label.h | 2 +-
 arch/powerpc/kernel/signal_64.c       | 9 ++++-----
 arch/powerpc/mm/mem.c                 | 1 +
 arch/powerpc/perf/core-book3s.c       | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmDOf4MACgkQUevqPMjh
pYCWZQ/+IFYW1st6xlM1jBDlLSItSn234dqOmvlihIo+9lCR82l72H4E4EWIj7A+
3GGzMllEdDcGooEF1jg+7+zUlx8i1WNlRCF4RNszGzpipiDWGPlxW2t5FqNeQRQ7
YyooMzrgPYlRxGHnG/KHfGiPJxxLj4ZsyRhWfoS6cY1EbS/YOX8SDX1Xz2qQu/Jr
qRzZvSZKkBpVdvcxEYcn7WSauDpqtZ9keWHdP8e6WRd/Bceu4nyxlxOI0z+pBUsr
3IhWzQexznJwCGClQBbaXg/uPmUDtEjx+LzhU0jTmSMLxVI+UFPVDIbco6bMX7AE
EevcU35aDLu8tclNd3IAA9Au/EZPUe8kMNUPmBncFAID4ek+gybRJuGO9b9XEJ1r
AZFFCb2rRugBvOeNtb5y3u9XNR0Ct0S2lsZygSOkCQ6R3Sf2yoVgP0M49PbFvEEO
fSVLnAMEWQDWfaLjYxFXp2S3vddyLw8G36lBzJo74Y/cRuz10g/87oWpIlFq5tqK
aMXTroINmErOv1XVALqix1ScrLeBnPlL2nH0gBSZ96W0A196kFjWkKaGsQFwXMEH
X2Om1rKYiC3/vKrLXRYcxSZcoRg7/a1es7ftVSv5DQAPGRGWDrplCJh70x5JW2Js
kA6IB2K8+Ehf3F0a7O+i5q5t1oTvOvR+wIEl2TpJdx5aMVGkBt0=
=CmCH
-----END PGP SIGNATURE-----
