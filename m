Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08CA94584C6
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 17:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238255AbhKUQws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 11:52:48 -0500
Received: from mo4-p04-ob.smtp.rzone.de ([81.169.146.223]:14394 "EHLO
        mo4-p04-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbhKUQwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 11:52:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1637513325;
    s=strato-dkim-0002; d=chronox.de;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=/TSmcN/n7kxYqfAHv6+b2maMsUsJ0KpiPXEetUjFJ5s=;
    b=I+bxrIPR4gOTDCY6xQOToZBc3gV0066O296ZZpbXF989iB+vwSAGjqTrM2Q3AY3B8R
    piq3UwGnZ5S842hlQhKxID70xkSzQziCSEQwe2cwVrzBUKU8IMqdxZjf6RgBW/lcdAlu
    KnUbghWe5VmKYwKiT4/tWQlyRVc1lXk+PDqPXxRPwWrWP8wnPUDsNE/6IcWSbXQeTo9t
    VeRwk0+jdu7RoQqe6VZE1jPKkYdtAtw8HezMawX67tcFutQ90oziUo0osVA0F2v5URc6
    XllnfLjwjbT6POZtMUgcf/vnRcLT1iWegJ09AHQBgWbmCCbSFo2O5ZGM8aDTByET2zx+
    sOrw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPbJvSfE+K2"
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
    by smtp.strato.de (RZmta 47.34.5 DYNA|AUTH)
    with ESMTPSA id U02dfbxALGmi3Wp
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 21 Nov 2021 17:48:44 +0100 (CET)
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
        Alexander Lobakin <alobakin@mailbox.org>,
        Jirka Hladky <jhladky@redhat.com>
Subject: [PATCH v43 00/15] /dev/random - a new approach
Date:   Sun, 21 Nov 2021 17:39:28 +0100
Message-ID: <2036923.9o76ZdvQCi@positron.chronox.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch set provides a complete production-
ready and yet different approach to /dev/random which is called Linux
Random Number Generator (LRNG) to collect entropy within the Linux kernel.
It provides the same API and ABI and can be used as a drop-in replacement.
A general overview is given with [6].

The LRNG was presented at the Linux Security Summit 2021. The video of the
presentation can be found at [7].

Patches 1 through 5 provide the solution that is functionality equivalent
with the existing /dev/random implementation. Those patches can be applied
all by themselves and provide a fully functional LRNG. Each subsequent
patch provides a stand-alone additional function.

The LRNG implements at least all features of the existing /dev/random such =
as
NUMA-node-local DRNGs. The following advantages compared to the existing
/dev/random implementation are present:

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

 - Block device data path is not instrumented by LRNG which implies that
   the LRNG does not add any delays compared to the legacy /dev/random.

 - Configurable data collection sizes to accommodate small environments
   and big environments via CONFIG_LRNG_COLLECTION_SIZE.

 - Entropy collection using an almost never contended lock to benefit
   large parallel systems - worst case rate of contention is the number
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
   entropy source data of the interrupt entropy source to identify
   degradation of the available entropy as documented in [2] section
   2.5.2. Such health tests are important today due to virtual machine
   monitors reducing the resolution of or disabling the high-resolution
   timer.

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

* Entropy collection of the internal interrupt entropy source

 - The LRNG is shipped with test tools allowing the collection of
   raw unconditioned entropy during runtime and boot time available at
   [1].

 - Full entropy assessment and description is provided with [2] chapter 3,
   specifically section 3.3.6.

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

  + Selectively enabling of each entropy source and configuring their
    entropy rate.

  + Enabling of interrupt entropy source health tests.

  + Enabling of test interface allowing to enable each test interface
    individually.

  + Enabling of the power-up self test.

  + At compile time, the entropy rate used to credit the internal
    interrupt entropy source, the external CPU-based noise source
    and Jitter RNG noise source can be configured including setting an
    entropy rate of zero or full entropy =E2=80=93 see sections 2.5.1, 2.9.=
1 and
    2.8.1 in [2]. A rate of zero implies that the entropy source still
    provides data which is credited with zero bits of entropy.

 - At boot-time, the SP800-90B health tests for the internal interrupt
   entropy source can be enabled as outlined in [2] section 2.5.2.

 - Configurable seeding strategies are provided following different
   concepts.

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

 - Back-port patches are available at [5] to apply the LRNG to LTS Linux
   kernel versions of 5.10, 5.4, 4.19, 4.14, and 4.4. In addition,
   backport patches for the kernel version 5.8, 4.12 and 4.10 are
   provided. Patches for other kernel versions are easily derived from
   the existing ones.

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

* RISC-V

* testing with GCC and Clang

[1] https://www.chronox.de/lrng.html - If the patch is accepted, I would
be volunteering to convert the documentation into RST format and
contribute it to the Linux kernel documentation directory.

[2] https://www.chronox.de/lrng/doc/lrng.pdf

[3] https://www.chronox.de/chacha20_drng.html

[4] https://www.bsi.bund.de/SharedDocs/Downloads/EN/BSI/Publications/Studie=
s/
LinuxRNG/LinuxRNG_EN_V4_1.pdf

[5] https://github.com/smuellerDD/lrng/tree/master/backports

[6] https://www.chronox.de/lrng/doc/lrng_presentation_v43.pdf

[7] https://www.youtube.com/watch?v=3D8DuhbwWkMQw&list=3DPLbzoR-pLrL6owx0I6=
v2MSwjxhtsRdtFzG&index=3D16

Changes (compared to the previous patch set) - individual patches
are visible at https://github.com/smuellerDD/lrng/commits/master:

=2D Replace '/**' with '/*' in comments

=2D Jitter RNG ES: if configured to have zero entropy, it still returns data

=2D CPU ES: if configured to have zero entropy, it still returns data;
  allow disabling it with config option - extract CPU ES into its own
  patch for better assessment (patch 5)

=2D IRQ ES: if configured to have zero entropy, it still returns data;
  allow disabling it with config option - extract IRQ ES into its own
  patch for better assessment (patch 2)

=2D use hash lock only when LRNG switching support is enabled

=2D write_wakeup now contains the wakeup threshold in bits and is updated
  when the hash is updated

=2D fix: do not expect user space to provide entropy if it is woken up -
  this allows haveged to fully work

=2D rearrange patch set: patches 01 through 05 are the baseline to get the =
LRNG
  running covering all use cases currently available. Even this base
  would provide better functionality than the existing /dev/random
  implementation considering the use of SHA-256 and a much faster IRQ
  handler.

=2D fix: ensure that applying the oversampling rate implies a larger or equ=
al
  interrupt collection  in case no highres timer is present

=2D fix: PowerISA DARN specifies that it only delivers 0.5 bits of entropy
  -> CPU ES takes this into account when configured to trust CPU

=2D add compression support for CPU entropy sources without full entropy

Stephan Mueller (15):
  Linux Random Number Generator
  LRNG - IRQ entropy source
  LRNG - sysctls and /proc interface
  LRNG - allocate one DRNG instance per NUMA node
  LRNG - CPU entropy source
  LRNG - add switchable DRNG support
  LRNG - add common generic hash support
  crypto: DRBG - externalize DRBG functions for LRNG
  LRNG - add SP800-90A DRBG extension
  LRNG - add kernel crypto API PRNG extension
  crypto: move Jitter RNG header include dir
  LRNG - add Jitter RNG fast noise source
  LRNG - add SP800-90B compliant health tests
  LRNG - add interface for gathering of raw entropy
  LRNG - add power-on and runtime self-tests

 MAINTAINERS                                   |   7 +
 crypto/drbg.c                                 |  16 +-
 crypto/jitterentropy-kcapi.c                  |   3 +-
 crypto/jitterentropy.c                        |   2 +-
 drivers/char/Kconfig                          |   2 +
 drivers/char/Makefile                         |   9 +-
 drivers/char/lrng/Kconfig                     | 589 +++++++++++++
 drivers/char/lrng/Makefile                    |  21 +
 drivers/char/lrng/lrng_aux.c                  | 136 +++
 drivers/char/lrng/lrng_chacha20.c             | 321 +++++++
 drivers/char/lrng/lrng_chacha20.h             |  25 +
 drivers/char/lrng/lrng_drbg.c                 | 198 +++++
 drivers/char/lrng/lrng_drng.c                 | 451 ++++++++++
 drivers/char/lrng/lrng_es_archrandom.c        | 226 +++++
 drivers/char/lrng/lrng_es_aux.c               | 294 +++++++
 drivers/char/lrng/lrng_es_irq.c               | 823 ++++++++++++++++++
 drivers/char/lrng/lrng_es_irq.h               |  71 ++
 drivers/char/lrng/lrng_es_jent.c              |  97 +++
 drivers/char/lrng/lrng_es_mgr.c               | 373 ++++++++
 drivers/char/lrng/lrng_health.c               | 410 +++++++++
 drivers/char/lrng/lrng_interfaces.c           | 654 ++++++++++++++
 drivers/char/lrng/lrng_internal.h             | 485 +++++++++++
 drivers/char/lrng/lrng_kcapi.c                | 227 +++++
 drivers/char/lrng/lrng_kcapi_hash.c           | 103 +++
 drivers/char/lrng/lrng_kcapi_hash.h           |  20 +
 drivers/char/lrng/lrng_numa.c                 | 122 +++
 drivers/char/lrng/lrng_proc.c                 | 199 +++++
 drivers/char/lrng/lrng_selftest.c             | 386 ++++++++
 drivers/char/lrng/lrng_switch.c               | 226 +++++
 drivers/char/lrng/lrng_testing.c              | 689 +++++++++++++++
 include/crypto/drbg.h                         |   7 +
 .../crypto/internal}/jitterentropy.h          |   0
 include/linux/lrng.h                          |  81 ++
 33 files changed, 7263 insertions(+), 10 deletions(-)
 create mode 100644 drivers/char/lrng/Kconfig
 create mode 100644 drivers/char/lrng/Makefile
 create mode 100644 drivers/char/lrng/lrng_aux.c
 create mode 100644 drivers/char/lrng/lrng_chacha20.c
 create mode 100644 drivers/char/lrng/lrng_chacha20.h
 create mode 100644 drivers/char/lrng/lrng_drbg.c
 create mode 100644 drivers/char/lrng/lrng_drng.c
 create mode 100644 drivers/char/lrng/lrng_es_archrandom.c
 create mode 100644 drivers/char/lrng/lrng_es_aux.c
 create mode 100644 drivers/char/lrng/lrng_es_irq.c
 create mode 100644 drivers/char/lrng/lrng_es_irq.h
 create mode 100644 drivers/char/lrng/lrng_es_jent.c
 create mode 100644 drivers/char/lrng/lrng_es_mgr.c
 create mode 100644 drivers/char/lrng/lrng_health.c
 create mode 100644 drivers/char/lrng/lrng_interfaces.c
 create mode 100644 drivers/char/lrng/lrng_internal.h
 create mode 100644 drivers/char/lrng/lrng_kcapi.c
 create mode 100644 drivers/char/lrng/lrng_kcapi_hash.c
 create mode 100644 drivers/char/lrng/lrng_kcapi_hash.h
 create mode 100644 drivers/char/lrng/lrng_numa.c
 create mode 100644 drivers/char/lrng/lrng_proc.c
 create mode 100644 drivers/char/lrng/lrng_selftest.c
 create mode 100644 drivers/char/lrng/lrng_switch.c
 create mode 100644 drivers/char/lrng/lrng_testing.c
 rename {crypto =3D> include/crypto/internal}/jitterentropy.h (100%)
 create mode 100644 include/linux/lrng.h

=2D-=20
2.31.1




