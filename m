Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08DF93DCBC4
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 15:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbhHANQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 09:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbhHANQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 09:16:32 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810F6C06175F
        for <linux-kernel@vger.kernel.org>; Sun,  1 Aug 2021 06:16:24 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Gd1qS58V0z9sWw;
        Sun,  1 Aug 2021 23:16:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1627823780;
        bh=5AKuUXsX5mdXOPNOfHTKEXwhhJhi8/p1HRquQHqvrkw=;
        h=From:To:Cc:Subject:Date:From;
        b=VIluqYAR6Fg9PFcf8xb/t3xCBbKBPY85z53F3HuMNwHbxkeOwg2dn33juXcJhJgsa
         5+J92smUzeYb0qVnW3nD44nywkxl2idhbU9rBET9BMXz1q3FJ183kLfJ6ZHco78yaa
         wDI7PxqZh3MWbfvR2DAlpJa9jvh6+LFs9I/w8DPXHnAB/YHUrwhPwuvKG9CcZ5xXoC
         VI/5MQFLGGkP5btC2yfLz0XE3YiUjsBSd/jT75XwUw1CHhRiamfEalsZ04yK3Twaqx
         A9fipIsMB/vX5USujeo3sQUeqh4fY1qtzjMrRTcWSv+gnVQom76MATjyjp+5i9utZ7
         lDQsWU8CctNzg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        srikar@linux.vnet.ibm.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.14-4 tag
Date:   Sun, 01 Aug 2021 23:16:16 +1000
Message-ID: <87y29lz4nz.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull some more powerpc fixes for 5.14:

The following changes since commit d9c57d3ed52a92536f5fa59dc5ccdd58b4875076:

  KVM: PPC: Book3S HV Nested: Sanitise H_ENTER_NESTED TM state (2021-07-23 16:19:38 +1000)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.14-4

for you to fetch changes up to a88603f4b92ecef9e2359e40bcb99ad399d85dd7:

  powerpc/vdso: Don't use r30 to avoid breaking Go lang (2021-07-29 23:13:12 +1000)

- ------------------------------------------------------------------
powerpc fixes for 5.14 #4

 - Don't use r30 in VDSO code, to avoid breaking existing Go lang programs.

 - Change an export symbol to allow non-GPL modules to use spinlocks again.

Thanks to: Paul Menzel, Srikar Dronamraju.

- ------------------------------------------------------------------
Michael Ellerman (2):
      Merge branch 'fixes' into next
      powerpc/vdso: Don't use r30 to avoid breaking Go lang

Srikar Dronamraju (1):
      powerpc/pseries: Fix regression while building external modules


 arch/powerpc/kernel/vdso64/Makefile    | 7 +++++++
 arch/powerpc/platforms/pseries/setup.c | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmEGnawACgkQUevqPMjh
pYApeg/9E8l0SD4+NzC0ZwZxQ7sAxufs2X9uugWeTxjEMF3BvhnzAcfF3qPewP0+
Huy7UwhHYKMBGT9jpqqQuLMfxasbihizesdP89BAVIhzyL6odg6/fo+KaBVVADYr
F+jHugUXoimS47IntMyQa2HANpCLjl66ZIYWgqytuLgx8jnvIzCGbLmrTN/F4FTS
7mkNO7+wOmwEi4y3p1cCVnkBd7qkQnjkRgpwS/FQLbtE6G3qkcNhNK1v5AAuSblJ
eLJ0Lp/+z1OYKA/BSmyM5Aj7kytn9f5UjA2jBtS9O0sfcd19g5LTdKXxPftaAgO3
eNr947NTztadHQLkLdeeVCDyqrUnAZFZ7f4kn16JIc27ObCWFhFC/OQR+Ba9KGbN
0hgwVREZ+aqdquYPbqZTj4VWLeEQflgk9zfp9sZquZvOHoknBsvUmzvL24LLE8hw
ETYEoQwdtBZfCNCbEofCIu3BZXtvt99FUsJo65sUKGty7Vb2iuo3jq85jsgwrh21
8OhhQ1njfbw+InMYJO1LgFVAXE9f5FDLaV1oMJkkO6vhDZ73Lsac7AG5MP7TrB+z
dbT0BTfB6nevXzf+JX1OxHZtCXVriXuFWrzZpQVX65zkzbO4N6Q3+Wk28PmMU67P
oiDsdZWjBxk9rA4xXNGof6AIKr3SDt3/u2kMa/iR5r/mq1itZRk=
=dB85
-----END PGP SIGNATURE-----
