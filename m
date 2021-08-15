Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 131CD3EC924
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 14:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237977AbhHOMuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 08:50:10 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:36475 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238178AbhHOMtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 08:49:39 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4GncYN47Lgz9sRN;
        Sun, 15 Aug 2021 22:48:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1629031737;
        bh=UlGjLrp7DLkKq03VGEXAQ/aONvBaBW/ddkNONa3b97Y=;
        h=From:To:Cc:Subject:Date:From;
        b=jWBpZZfuI7zZXYCL1r4f4ZU9ESwVqhnIXYHyp/cnKY26oneMLYzgW4bN6pn/Yz/VX
         C9qq4k/VqIxDknSSQhms7Dv5w1vTzfRjqcKgq0SeeM2ez+KajYM2hPXJVTQJ6ffuq0
         lh0MyLcvLvFu/yVNKuLZmCNe+JBVEHLc5psP0gC6ZPpg+lERinhLywVJY5S0VPrxIX
         glVcyuTXeSLFvSBUOj2g7mwxScgW3foa0ocMlC+HDqQhCtWiQ4CFa9e63hRv8bXf6Q
         QYRRQjsziqlTiZ+Ykqf+WtlF19tUr03VrOCtjiYY1deAKPVJW0Dug7q1qotTclK/Eh
         qF5QMTB2/bxEQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     christophe.leroy@csgroup.eu, clg@kaod.org, ldufour@linux.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        pulehui@huawei.com
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.14-5 tag
Date:   Sun, 15 Aug 2021 22:48:51 +1000
Message-ID: <87tujqlvpo.fsf@mpe.ellerman.id.au>
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

The following changes since commit a88603f4b92ecef9e2359e40bcb99ad399d85dd7:

  powerpc/vdso: Don't use r30 to avoid breaking Go lang (2021-07-29 23:13:1=
2 +1000)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/po=
werpc-5.14-5

for you to fetch changes up to cbc06f051c524dcfe52ef0d1f30647828e226d30:

  powerpc/xive: Do not skip CPU-less nodes when creating the IPIs (2021-08-=
12 22:31:41 +1000)

- ------------------------------------------------------------------
powerpc fixes for 5.14 #5

 - Fix crashes coming out of nap on 32-bit Book3s (eg. powerbooks).
 - Fix critical and debug interrupts on BookE, seen as crashes when using p=
trace.
 - Fix an oops when running an SMP kernel on a UP system.
 - Update pseries LPAR security flavor after partition migration.
 - Fix an oops when using kprobes on BookE.
 - Fix oops on 32-bit pmac by not calling do_IRQ() from timer_interrupt().
 - Fix softlockups on CPU hotplug into a CPU-less node with xive (P9).

Thanks to: C=C3=A9dric Le Goater, Christophe Leroy, Finn Thain, Geetika Moo=
lchandani, Laurent
Dufour, Laurent Vivier, Nicholas Piggin, Pu Lehui, Radu Rendec, Srikar Dron=
amraju, Stan
Johnson.

- ------------------------------------------------------------------
Christophe Leroy (5):
      powerpc/32s: Fix napping restore in data storage interrupt (DSI)
      powerpc/32: Fix critical and debug interrupts on BOOKE
      powerpc/smp: Fix OOPS in topology_init()
      powerpc/interrupt: Fix OOPS by not calling do_IRQ() from timer_interr=
upt()
      powerpc/interrupt: Do not call single_step_exception() from other exc=
eptions

C=C3=A9dric Le Goater (1):
      powerpc/xive: Do not skip CPU-less nodes when creating the IPIs

Laurent Dufour (1):
      powerpc/pseries: Fix update of LPAR security flavor after LPM

Pu Lehui (1):
      powerpc/kprobes: Fix kprobe Oops happens in booke


 arch/powerpc/include/asm/interrupt.h   |  3 ++
 arch/powerpc/include/asm/irq.h         |  2 +-
 arch/powerpc/include/asm/ptrace.h      | 16 +++++++++
 arch/powerpc/kernel/asm-offsets.c      | 31 ++++++++---------
 arch/powerpc/kernel/head_book3s_32.S   |  2 +-
 arch/powerpc/kernel/head_booke.h       | 27 ++-------------
 arch/powerpc/kernel/irq.c              |  7 +++-
 arch/powerpc/kernel/kprobes.c          |  3 +-
 arch/powerpc/kernel/sysfs.c            |  2 +-
 arch/powerpc/kernel/time.c             |  2 +-
 arch/powerpc/kernel/traps.c            |  9 +++--
 arch/powerpc/platforms/pseries/setup.c |  5 +--
 arch/powerpc/sysdev/xive/common.c      | 35 ++++++++++++++------
 13 files changed, 82 insertions(+), 62 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAmEZDQQACgkQUevqPMjh
pYDVNQ//cV/JSIm1THeqbfjZFrx2iO5hcwgO0lXaRK6Lf4gXGAcQAGr6Co+JjsNy
A5vz3myCKHiTlCe7862Dm7X54FKeJKwhQsdzpWVfw8aeQwxdhkc1Wg4WtgKMT3/j
woN6je4+2/I9LctFgnRMqMV1ode4t91jgjX4wGCxqLYQxPtBXgkZ4jwwIvTh5xR8
DmkYr5ZFaHzVX+wHY/58aT4rtej5f88RXVdR1ClCw9APzgPzSP+t/arZm1B7TRGN
PFetXlHtyOzHcsf5OhfHXWJ4tjUxLsuHccPmnJKJsPAnfNP2fUEZv8fqHqJma+bj
YVG8wzCI4/OTdaoEzmgwdyKXsE0g5GSh0V2ok4DEUaRWrWCbSmsKvLLqW9gVn06K
9iLMne+MoxOmUh4z2ZI2PI+Ko31IEOlaRudsdeJGCYAYAqTRrbBdrrUK55Qjozv0
oGccwMZrqyWwlNfyx4kgD03x1N0zITr1/CstAIssfQilnrlrM6n4vWjc3tvMI1R7
Lgl5Ja8UYkLQsOmH5FD0iqEwmjaJgNuc7+Vt93rWvxk1Pk/s8Kx5dEer+/q0tLku
u7QabZMOd3DsVsgU3oNNNUDGA3RbvhlOj3H2J/RoHftmXg2UG0T4MBIVk9r5N+DP
MOgk1GP1zxLQ2B6FazRG3J5W/Ct9gHTMSFUpWGaz313VWp6gpJ4=3D
=3DNuwF
-----END PGP SIGNATURE-----
