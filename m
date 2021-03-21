Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5EAA343131
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 06:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhCUFQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 01:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbhCUFP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 01:15:57 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC86C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 22:15:51 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4F35SK57g1z9sSC;
        Sun, 21 Mar 2021 16:15:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1616303747;
        bh=NuaqmDeUEq7U+V+o2OVKAvJoermIek4/PIHuFD5u7/M=;
        h=From:To:Cc:Subject:Date:From;
        b=hLs9Zd46xThlMGvFCxClRd+w5xtFqAbGKjF3KtZzNaSgW2omzEP0bTWxPqDkhP9/p
         SoDcsRAhc0MaMuLz72Qhrz9rR6x09ZAT1XHjhZLNaavGzgJlTtbGsbirtoWuf6Bbkf
         fn8gafnk5qQ9JHuCSdpPeUp20koQJGcPzj2O1dXBeSaU9LWH1RxT1mzLWdBaxkAZeJ
         IWmpwQQyDH1gG7dbpk4wu3qz561WQ7PrZKW+aIK7FpdaLMRY3wznnF2ROnIRHBRzGb
         sixgdsyQgqw1/Dd5t+y2oTqIo3E7p6deBaZAmspEIo4Xrum9vPnkAsZoC/4ETZO+zk
         m4pbh66yxo5Dw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, tyreld@linux.ibm.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.12-4 tag
Date:   Sun, 21 Mar 2021 16:15:35 +1100
Message-ID: <875z1lhytk.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull some more powerpc fixes for 5.12:

The following changes since commit 0b736881c8f1a6cd912f7a9162b9e097b28c1c30:

  powerpc/traps: unrecoverable_exception() is not an interrupt handler (2021-03-12 11:02:12 +1100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.12-4

for you to fetch changes up to cc7a0bb058b85ea03db87169c60c7cfdd5d34678:

  PCI: rpadlpar: Fix potential drc_name corruption in store functions (2021-03-17 13:48:07 +1100)

- ------------------------------------------------------------------
powerpc fixes for 5.12 #4

Fix a possible stack corruption and subsequent DLPAR failure in the rpadlpar_io
PCI hotplug driver.

Two build fixes for uncommon configurations.

Thanks to Christophe Leroy, Tyrel Datwyler.

- ------------------------------------------------------------------
Christophe Leroy (2):
      powerpc/vdso32: Add missing _restgpr_31_x to fix build failure
      powerpc: Force inlining of cpu_has_feature() to avoid build failure

Tyrel Datwyler (1):
      PCI: rpadlpar: Fix potential drc_name corruption in store functions


 arch/powerpc/include/asm/cpu_has_feature.h |  4 ++--
 arch/powerpc/kernel/vdso32/gettimeofday.S  | 11 +++++++++++
 drivers/pci/hotplug/rpadlpar_sysfs.c       | 14 ++++++--------
 3 files changed, 19 insertions(+), 10 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmBW1cQACgkQUevqPMjh
pYAhog/+KVrIL4frKx1m7bmM+FJ83heS20+F7i5yQWRovR2FdgYwwbIrtxNUKzRU
sNShwQbt9H6GVEGc12kusH5M+t6wGrHrYQ47kdkD6qhDTPfQzKXsoi5eWbgMkQnx
Hd3njqjzfGFEicmfp8l+1WmoWeYpL2MLR7E/KTtS/MYMq5Gsz2lZSMEsmXlAY5Cs
5lT8dBHdH0AX9krRJk9BzKrRqB0qjrK60/sg9oLJQ4sixeWaa+dSORnJq26jYV+n
MPyaNCWF3EUrs7BNyxfZOeFwAZ0FzRSBZrgIt6MNPreT/FaL6lo2McHHyQ9Ls5Qb
yPUmioNKLhXdtcU6AZ0+QOlQvyiGJ7xb3UTAbFFq8TifYHVS0v9srBkgfcvFHycc
yjDtdeTk18WB6NSDC8zVSc+Ut5q7WZa6RLKubiCPgd5DqDkpAKcYcTQSZZUgTb6Q
IyT7bwCBqW6Z5bNTsHhSZ+Ub06L6RLTQ1IfD4GXtqe16F1eeFlMOPCP2YzGUB6s9
IB7GQilliVtRZaFCGwYyVdZCHftHVdK5k7DV+3aImzPRYOKpL4YWwrBnDoqkccYs
Mhbw2YtO7oXSZ2yXGrsu/WF56QCDf6PFO5r28dvNFEi6qZWbfLEQQLZmv/0efFtC
Je1VKXKXCfuLD2VH02F8URZpzbg90dC8YRsTUpgSLCHgiGjEOcE=
=zfoH
-----END PGP SIGNATURE-----
