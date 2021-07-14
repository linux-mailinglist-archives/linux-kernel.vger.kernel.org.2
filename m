Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6183C7E20
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 07:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237946AbhGNFyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 01:54:51 -0400
Received: from mo4-p04-ob.smtp.rzone.de ([85.215.255.122]:16464 "EHLO
        mo4-p04-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237802AbhGNFyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 01:54:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1626241864;
    s=strato-dkim-0002; d=chronox.de;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=tsGuc3e9CEkhnGOgzDJzuv6oj6nvA6m7tw8wy51xpZU=;
    b=n+NUuy7+gwqy6evzOvc468Rb/2s+WRcLT9WT26esEmN/DcsHLPeB870Y5Un+/cl21R
    XNGHxorP0U2kE8BC8s0Exnd7gBB0Fw4PohH9hpxgZI3SMmRSf9rsIrOdEJ6b5JoDQyBZ
    uEzNLgfmxCl8EQKWUqq5CiXygsJOd/u6Hi09l3HuOWP3k0TwhMLdat6BflFf64VXa7KW
    xICvEvqQks8bt2rXb2R+eniEW7oPxUhJeMVzWxKPGehSHMH55qQiSakG0mGdOE80YkIU
    myD0e5D6CgITZvwblda3mwFCDRc4aM81TKhcCK107AydhHxrT5aqSGWGpr6GuezIJVbs
    bseg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzHHXPSI/SaRQ=="
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
    by smtp.strato.de (RZmta 47.28.1 DYNA|AUTH)
    with ESMTPSA id N0753fx6E5p3wyg
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 14 Jul 2021 07:51:03 +0200 (CEST)
From:   Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
To:     Tso Ted <tytso@mit.edu>, linux-crypto@vger.kernel.org
Cc:     Willy Tarreau <w@1wt.eu>, Nicolai Stange <nstange@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Vito Caputo <vcaputo@pengaru.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, Ray Strode <rstrode@redhat.com>,
        William Jon McCann <mccann@jhu.edu>,
        zhangjs <zachary@baishancloud.com>,
        Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Peter Matthias <matthias.peter@bsi.bund.de>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        Neil Horman <nhorman@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andy Lavr <andy.lavr@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        John Haxby <john.haxby@oracle.com>,
        Alexander Lobakin <alobakin@mailbox.org>
Subject: [PATCH v41 00/13] /dev/random - a new approach
Date:   Wed, 14 Jul 2021 07:43:20 +0200
Message-ID: <7822794.ITf6fX9eNu@positron.chronox.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch set provides a different approach to /dev/random which
is called Linux Random Number Generator (LRNG) to collect entropy within
the Linux kernel. It provides the same API and ABI and can be used as a
drop-in replacement. A general overview is given with [6].

The LRNG implements at least all features of the existing /dev/random such =
as
NUMA-node-local DRNGs. Patches 1 through 3 provide the code that is feature-
identical. The following advantages compared to the existing /dev/random
implementation are present:

* Sole use of crypto for data processing:

 - Exclusive use of a hash operation for conditioning entropy data with
   a clear mathematical description as given in [2] section 2.2 -
   non-cryptographic operations like LFSR are not used.

 - The LRNG uses only properly defined and implemented cryptographic
   algorithms unlike the use of the SHA-1 transformation in the existing
   /dev/random implementation.

 - Hash operations use NUMA-node-local hash instances to benefit large
   parallel systems.

 - LRNG uses limited number of data post-processing steps as documented in
   [2] section 2.2 compared to the large variation of different
   post-processing steps in the existing /dev/random implementation that
   have no apparent mathematical description (see [2] section 4.5).

* Performance

 - Faster by up to 130% in the critical code path of the interrupt handler
   depending on data collection size configurable at kernel compile time -
   the default is now set such that the highest performance is achieved as
   outlined in [2] section 4.2.

 - Configurable data collection sizes to accommodate small environments
   and big environments via CONFIG_LRNG_COLLECTION_SIZE.

 - Entropy collection using an almost never contended lock to benefit
   large parallel systems =E2=80=93 worst case rate of contention is the nu=
mber
   of DRNG reseeds, usually the number of potential contentions per 10
   minutes is equal to number of NUMA nodes.

 - ChaCha20 DRNG is significantly faster as implemented in the existing
   /dev/random as demonstrated with [2] table 2.

 - Faster entropy collection during boot time to reach fully seeded
   level, including on virtual systems or systems with SSDs as outlined
   in [2] section 4.1.

 - Faster processing of external data added to LRNG via /dev/random
   or add_hwgenerator_randomness.

* Testing

 - Availability of run-time health tests of the raw unconditioned
   noise source to identify degradation of the available entropy as
   documented in [2] section 2.5.4. Such health tests are important
   today due to virtual machine monitors reducing the resolution of
   or disabling the high-resolution timer.

 - Heuristic entropy estimation is based on quantitative measurements
   and analysis following SP800-90B and not on coincidental
   underestimation of entropy applied by the existing /dev/random as
   outlined in [4] section 4.4.

 - Power-on self tests for critical deterministic components (ChaCha20
   DRNG, software hash implementation, and entropy collection logic)
   not already covered by power-up tests of the kernel crypto API as
   documented in [2] section 2.14.

 - Availability of test interfaces for all operational stages of the
   LRNG including boot-time raw entropy event data sampling as outlined
   in [2] section 2.15.

 - Fully testable ChaCha20 DRNG via a userspace ChaCha20 DRNG
   implementation [3].

 - In case of using the kernel crypto API SHASH hash implementation, it
   is fully testable and tested via the NIST ACVP test framework, for
   example certificates A734, A737, and A738.

 - The LRNG offers a test interface to validate the used software hash
   implementation and in particular that the LRNG invokes the hash
   correctly, allowing a NIST ACVP-compliant test cycle - see [2]
   section 2.15.

 - Availability of stress testing covering the different code paths for
   data and mechanism (de)allocations and code paths covered with locks.

 - Availability of regression tests verifying the different options provided
   with the LRNG.

* Entropy collection

 - The LRNG is shipped with test tools allowing the collection of
   raw unconditioned entropy during runtime and boot time available at
   [1].

 - Full entropy assessment and description is provided with [2] chapter 3,
   specifically section 3.2.6.

 - Guarantee that entropy events are not credited with entropy twice
   (the existing /dev/random implementation credits HID/disk and
   interrupt events with entropy which are a derivative of each other).

* Configurable

 - LRNG kernel configuration allows configuration that is functionally
   equivalent to the existing /dev/random. Non-compiled additional code
   is folded into no-ops.

 - The following additional functions are compile-time selectable
   independent of each other:

  + Enabling of switchable cryptographic implementation support. This
    allows enabling an SP800-90A DRBG.

  + Enabling of using Jitter RNG noise source.

  + Enabling of noise source health tests.

  + Enabling of test interface allowing to enable each test interface
    individually.

  + Enabling of the power-up self test.

 - At boot-time, the SP800-90B health tests can be enabled as outlined
   in [2] section 2.5.4.

 - At boot-time, the entropy rate used to credit the external CPU-based
   noise source and Jitter RNG noise source can be configured including
   setting an entropy rate of zero or full entropy - see [2] sections
   2.5.2 and 2.5.3.

* Run-time pluggable cryptographic implementations used for all data
  processing steps specified in [2] section 2.2

 - The DRNG can be replaced with a different implementation allowing
   any type of DRNG to provide data via the output interfaces. The LRNG
   provides the following types of DRNG implementations:

  + ChaCha20-based software implementation that is used per default.

  + SP800-90A DRBG using accelerated cryptographic implementations that
    may sleep.

  + Any DRNG that is accessible via the kernel crypto API RNG subsystem.

 - The hash component can be replaced with any other hash implementation
   provided the implementation does not sleep. The LRNG provides the
   access to the following types of non-sleeping hash implementations:

  + SHA-256 software implementation that is used per default. Due to
    kernel build system inconsistencies, the software SHA-1 implementation
    is used if the kernel crypto API is not compiled.

  + SHA-512 hash using the fastest hash implementation available via the
    kernel crypto API SHASH subsystem.

* Code structure

 - The LRNG source code is available for current upstream Linux kernel
   separate to the existing /dev/random which means that users who are
   conservative can use the unchanged existing /dev/random implementation.

 - Back-port patches are available at [5] to apply the LRNG to Linux
   kernel versions of 5.10, 5.8, 5.4, 4.19, 4.14, 4.12, 4.10, and 4.4. Patc=
hes
   for other kernel versions are easily derived from the existing ones.

Booting the patch with the kernel command line option
"dyndbg=3Dfile drivers/char/lrng/* +p" generates logs indicating the
operation of the LRNG. Each log is pre-pended with "lrng".

An entropy analysis is performed on the following systems - details
are given in [2] appendix C:

* x86 KVM virtualized guest 32 and 64 bit systems

* x86 bare metal

* older and newer ARMv7 system

* ARM64

* POWER7 LE and POWER 8 BE

* IBM Z System mainframe

* old MIPS embedded device

* testing with GCC and Clang

[1] https://www.chronox.de/lrng.html - If the patch is accepted, I would
be volunteering to convert the documentation into RST format and
contribute it to the Linux kernel documentation directory.

[2] https://www.chronox.de/lrng/doc/lrng.pdf

[3] https://www.chronox.de/chacha20_drng.html

[4] https://www.bsi.bund.de/SharedDocs/Downloads/EN/BSI/Publications/Studie=
s/LinuxRNG/LinuxRNG_EN_V4_1.pdf

[5] https://github.com/smuellerDD/lrng/tree/master/backports

[6] https://www.chronox.de/lrng/doc/lrng_presentation_v41.pdf

Changes (compared to the previous patch set) - individual patches
are visible at https://github.com/smuellerDD/lrng/commits/master:

=2D update seeding threshold when loading DRNG only if min seeded

=2D insert bootloader entropy directly into the aux pool

=2D RNDADDTOENTCNT - entropy estmate update of aux pool

=2D cleanup of initial seeding

=2D use work queue after initialization only

=2D add_random_ready_callback ping after full initialization

=2D zeroize seed buffer

=2D invoke processing of ready_list only if fully seeded

=2D invoke invalidate_batched_entropy after initialization

=2D always fill in the time stamp into seed buffer

=2D initialize entropy value if insufficient entropy available

=2D signal end of boot cycle in non-NUMA configuration

=2D set NUMA node online flag in proper condition

=2D harden entropy source configuration

=2D significantly enhance performance of aux pool

=2D fix LRNG reseed locking

=2D set LRNG to non-operational for 90C compliance

=2D fix increment of ChaCha20 nonce

=2D make switch functions a noop if switching is disabled

CC: Torsten Duwe <duwe@lst.de>
CC: "Eric W. Biederman" <ebiederm@xmission.com>
CC: "Alexander E. Patrakov" <patrakov@gmail.com>
CC: "Ahmed S. Darwish" <darwish.07@gmail.com>
CC: "Theodore Y. Ts'o" <tytso@mit.edu>
CC: Willy Tarreau <w@1wt.eu>
CC: Matthew Garrett <mjg59@srcf.ucam.org>
CC: Vito Caputo <vcaputo@pengaru.com>
CC: Andreas Dilger <adilger.kernel@dilger.ca>
CC: Jan Kara <jack@suse.cz>
CC: Ray Strode <rstrode@redhat.com>
CC: William Jon McCann <mccann@jhu.edu>
CC: zhangjs <zachary@baishancloud.com>
CC: Andy Lutomirski <luto@kernel.org>
CC: Florian Weimer <fweimer@redhat.com>
CC: Lennart Poettering <mzxreary@0pointer.de>
CC: Nicolai Stange <nstange@suse.de>
CC: Eric Biggers <ebiggers@kernel.org>
CC: Alexander Lobakin <alobakin@mailbox.org>
Tested-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>

Stephan Mueller (13):
  Linux Random Number Generator
  LRNG - allocate one DRNG instance per NUMA node
  LRNG - sysctls and /proc interface
  LRNG - add switchable DRNG support
  LRNG - add common generic hash support
  crypto: DRBG - externalize DRBG functions for LRNG
  LRNG - add SP800-90A DRBG extension
  LRNG - add kernel crypto API PRNG extension
  crypto: provide access to a static Jitter RNG state
  LRNG - add Jitter RNG fast noise source
  LRNG - add SP800-90B compliant health tests
  LRNG - add interface for gathering of raw entropy
  LRNG - add power-on and runtime self-tests

 MAINTAINERS                                   |   7 +
 crypto/drbg.c                                 |  16 +-
 crypto/jitterentropy-kcapi.c                  |   3 +-
 crypto/jitterentropy.c                        |  31 +-
 drivers/char/Kconfig                          |   2 +
 drivers/char/Makefile                         |   9 +-
 drivers/char/lrng/Kconfig                     | 515 +++++++++++++
 drivers/char/lrng/Makefile                    |  20 +
 drivers/char/lrng/lrng_archrandom.c           |  91 +++
 drivers/char/lrng/lrng_aux.c                  | 136 ++++
 drivers/char/lrng/lrng_chacha20.c             | 321 ++++++++
 drivers/char/lrng/lrng_chacha20.h             |  29 +
 drivers/char/lrng/lrng_drbg.c                 | 198 +++++
 drivers/char/lrng/lrng_drng.c                 | 422 +++++++++++
 drivers/char/lrng/lrng_health.c               | 410 ++++++++++
 drivers/char/lrng/lrng_interfaces.c           | 648 ++++++++++++++++
 drivers/char/lrng/lrng_internal.h             | 425 +++++++++++
 drivers/char/lrng/lrng_jent.c                 |  90 +++
 drivers/char/lrng/lrng_kcapi.c                | 227 ++++++
 drivers/char/lrng/lrng_kcapi_hash.c           | 103 +++
 drivers/char/lrng/lrng_kcapi_hash.h           |  20 +
 drivers/char/lrng/lrng_numa.c                 | 122 +++
 drivers/char/lrng/lrng_pool.c                 | 622 ++++++++++++++++
 drivers/char/lrng/lrng_proc.c                 | 185 +++++
 drivers/char/lrng/lrng_selftest.c             | 351 +++++++++
 drivers/char/lrng/lrng_sw_noise.c             | 702 ++++++++++++++++++
 drivers/char/lrng/lrng_sw_noise.h             |  71 ++
 drivers/char/lrng/lrng_switch.c               | 231 ++++++
 drivers/char/lrng/lrng_testing.c              | 689 +++++++++++++++++
 include/crypto/drbg.h                         |   7 +
 .../crypto/internal}/jitterentropy.h          |   3 +
 include/linux/lrng.h                          |  81 ++
 32 files changed, 6777 insertions(+), 10 deletions(-)
 create mode 100644 drivers/char/lrng/Kconfig
 create mode 100644 drivers/char/lrng/Makefile
 create mode 100644 drivers/char/lrng/lrng_archrandom.c
 create mode 100644 drivers/char/lrng/lrng_aux.c
 create mode 100644 drivers/char/lrng/lrng_chacha20.c
 create mode 100644 drivers/char/lrng/lrng_chacha20.h
 create mode 100644 drivers/char/lrng/lrng_drbg.c
 create mode 100644 drivers/char/lrng/lrng_drng.c
 create mode 100644 drivers/char/lrng/lrng_health.c
 create mode 100644 drivers/char/lrng/lrng_interfaces.c
 create mode 100644 drivers/char/lrng/lrng_internal.h
 create mode 100644 drivers/char/lrng/lrng_jent.c
 create mode 100644 drivers/char/lrng/lrng_kcapi.c
 create mode 100644 drivers/char/lrng/lrng_kcapi_hash.c
 create mode 100644 drivers/char/lrng/lrng_kcapi_hash.h
 create mode 100644 drivers/char/lrng/lrng_numa.c
 create mode 100644 drivers/char/lrng/lrng_pool.c
 create mode 100644 drivers/char/lrng/lrng_proc.c
 create mode 100644 drivers/char/lrng/lrng_selftest.c
 create mode 100644 drivers/char/lrng/lrng_sw_noise.c
 create mode 100644 drivers/char/lrng/lrng_sw_noise.h
 create mode 100644 drivers/char/lrng/lrng_switch.c
 create mode 100644 drivers/char/lrng/lrng_testing.c
 rename {crypto =3D> include/crypto/internal}/jitterentropy.h (84%)
 create mode 100644 include/linux/lrng.h

=2D-=20
2.31.1




