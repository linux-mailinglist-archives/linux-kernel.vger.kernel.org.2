Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536DC393361
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 18:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237209AbhE0QPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 12:15:15 -0400
Received: from mo4-p04-ob.smtp.rzone.de ([85.215.255.122]:10622 "EHLO
        mo4-p04-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237201AbhE0QOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 12:14:39 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1622131896; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=DtZffMihNV170duonjR4CMeTGli0iNTOowLe7OSvw4kgNNxZQhZf2tlB82o2byPDiG
    17olHzc4iDygj+N2RkcqfOBtARbKE/ZLCDGXdEKmM7emmCZQgpVQzT0aqDtQ99THtLaL
    umlOadSeZ9seNfh6JgDtvRTS+itONYhwTLCmSalY5Or44sK0T51ijS0/t9phL3fiPzqZ
    lEItAO5Q9SOHff108SmQyZ/A0P0ytCKLNl+12wE1bZn/dKPLhcxS66dz9Jysr97U3/oG
    F5E39csneYWST2SRDyJ8m0c/iBQvmRqiDms5jiBzcJMXwv90nk8XN+eVcVZL9jxq5j6P
    j6AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1622131896;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=xgI661Pfwog9TJOigg0nSc0W2LbP/v2MKt6mytM+SjI=;
    b=SVO3AJeoXq/6iRhIyMiUOR7MVfU2y/OSMAXl87pJNNSUO0ciuxLcaw2H75uMY9MJGm
    KdRM+G84gawk8lzBnnZBN6IKZtaKOUGvXo1EXbTcZiusVbGKnQHV3cZ0ftHpMs2CRiJ7
    fTdgi5kmC6k9LdJbvw64v2DBdDZxfBEiQxkJulizHwUUnB+PKa7iHL2eJFpGeAnzUCWw
    uWvjwpAFMT/Pl7QRz1VPYwRr/t2KR0om5pD5s0s9vXdZVLN8vXlIiDs2d71J+SA+KlOk
    5g2wR3vYRzuIlCAlEOQcG516SrZOMVca5nbJt5nn7i9RIAAKZ+9r3vXSRJZqBov4wxgX
    SATg==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1622131896;
    s=strato-dkim-0002; d=chronox.de;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=xgI661Pfwog9TJOigg0nSc0W2LbP/v2MKt6mytM+SjI=;
    b=oYo0BX06nDk1bIdrOwM564E7NJuJ1IHwmP1JKEwkffNQMOwTs9/TMgitUq1HRfq68t
    oDTeyQvEaLBN/d2DmbYs+sdrASRDYQ7h4CFrCCvggd4gkHvwUCwt6E7BRgqUdvigXrfU
    xNCXWho5uuY/6RHcjZmvYLNmtYC4tG4Qt8YIMWpbNwtPcqhRgpCgjFIiM0/XG4geoeqT
    SwUapoUte4PaCAPTVCEAIMexz5Q5LKOtoZFQm1XG+M97Q+cx+X0+UZ9LVdhj9aRq0VBB
    QdkQQe+PIlFBP6EiCYiaGLPW/YRQTrstSOA92DFrJTao/YkdZhwnWTFJJO1HPQLRRUCk
    /Klg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPbJvSfFeK2"
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
    by smtp.strato.de (RZmta 47.26.3 DYNA|AUTH)
    with ESMTPSA id R0123ax4RGBZ0Tw
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 27 May 2021 18:11:35 +0200 (CEST)
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
        John Haxby <john.haxby@oracle.com>
Subject: [PATCH v40 01/13] Linux Random Number Generator
Date:   Thu, 27 May 2021 17:55:26 +0200
Message-ID: <2939683.iCPfFBJNGb@positron.chronox.de>
In-Reply-To: <18450229.rjpLZT9oXI@positron.chronox.de>
References: <18450229.rjpLZT9oXI@positron.chronox.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In an effort to provide a flexible implementation for a random number
generator that also delivers entropy during early boot time, allows
replacement of the deterministic random number generation mechanism,
implement the various components in separate code for easier
maintenance, and provide compliance to SP800-90[A|B|C], introduce
the Linux Random Number Generator (LRNG) framework.

The general design is as follows. Additional implementation details
are given in [1]. The LRNG consists of the following components:

1. The LRNG implements a DRNG. The DRNG always generates the
requested amount of output. When using the SP800-90A terminology
it operates without prediction resistance. The secondary DRNG
maintains a counter of how many bytes were generated since last
re-seed and a timer of the elapsed time since last re-seed. If either
the counter or the timer reaches a threshold, the secondary DRNG is
seeded from the entropy pool.

In case the Linux kernel detects a NUMA system, one secondary DRNG
instance per NUMA node is maintained.

2. The DRNG is seeded by concatenating the data from the
following sources:

(a) the output of the entropy pool,

(b) the Jitter RNG if available and enabled, and

(c) the CPU-based noise source such as Intel RDRAND if available and
enabled.

The entropy estimate of the data of all noise sources are added to
form the entropy estimate of the data used to seed the DRNG with.
The LRNG ensures, however, that the DRNG after seeding is at
maximum the security strength of the DRNG.

The LRNG is designed such that none of these noise sources can dominate
the other noise sources to provide seed data to the DRNG during due to
the following:

(a) During boot time, the amount of received interrupts are the trigger
points to (re)seed the DRNG.

(b) At runtime, the available entropy from the slow noise source is
concatenated with a pre-defined amount of data from the fast noise
sources. In addition, each DRNG reseed operation triggers external
noise source providers to deliver one block of data.

3. The entropy pool accumulates entropy obtained from certain events,
which will henceforth be collectively called "slow noise sources".
The entropy pool collects noise data from slow noise sources. Any data
received by the LRNG from the slow noise sources is inserted into a
per-CPU entropy pool using a hash operation that can be changed during
runtime. Per default, SHA-256 is used.

 (a) When an interrupt occurs, the high-resolution time stamp is mixed
into the per-CPU entropy pool. This time stamp is credited with
heuristically implied entropy.

 (b) HID event data like the key stroke or the mouse coordinates are
mixed into the per-CPU entropy pool. This data is not credited with
entropy by the LRNG.

 (c) Device drivers may provide data that is mixed into an auxiliary
pool using the same hash that is used to process the per-CPU entropy
pool. This data is not credited with entropy by the LRNG.

Any data provided from user space by either writing to /dev/random,
/dev/urandom or the IOCTL of RNDADDENTROPY on both device files
are always injected into the auxiliary pool.

In addition, when a hardware random number generator covered by the
Linux kernel HW generator framework wants to deliver random numbers,
it is injected into the auxiliary pool as well. HW generator noise source
is handled separately from the other noise source due to the fact that
the HW generator framework may decide by itself when to deliver data
whereas the other noise sources always requested for data driven by the
LRNG operation. Similarly any user space provided data is inserted into
the entropy pool.

When seed data for the DRNG is to be generated, all per-CPU
entropy pools and the auxiliary pool are hashed. The message digest
forms the new auxiliary pool state. At the same time, this data
is used for seeding the DRNG.

To speed up the interrupt handling code of the LRNG, the time stamp
collected for an interrupt event is truncated to the 8 least
significant bits. 64 truncated time stamps are concatenated and then
jointly inserted into the per-CPU entropy pool. During boot time,
until the fully seeded stage is reached, each time stamp with its
32 least significant bits is are concatenated. When 16 such events
are received, they are injected into the per-CPU entropy pool.

The LRNG allows the DRNG mechanism to be changed at runtime. Per default,
a ChaCha20-based DRNG is used. The ChaCha20-DRNG implemented for the
LRNG is also provided as a stand-alone user space deterministic random
number generator. The LRNG also offers an SP800-90A DRBG based on the
Linux kernel crypto API DRBG implementation.

The processing of entropic data from the noise source before injecting
them into the DRNG is performed with the following mathematical
operations:

1. Truncation: The received time stamps are truncated to 8 least
significant bits (or 32 least significant bits during boot time)

2. Concatenation: The received and truncated time stamps as well as
auxiliary 32 bit words are concatenated to fill the per-CPU data
array that is capable of holding 64 8-bit words.

3. Hashing: A set of concatenated time stamp data received from the
interrupts are hashed together with the current existing per-CPU
entropy pool state. The resulting message digest is the new per-CPU
entropy pool state.

4. Hashing: When new data is added to the auxiliary pool, the data
is hashed together with the auxiliary pool to form a new auxiliary
pool state.

5. Hashing: A message digest of all per-CPU entropy pools and the
auxiliary pool is calculated which forms the new auxiliary pool
state. At the same time, this message digest is used to fill the
slow noise source output buffer discussed in the following.

6. Truncation: The most-significant bits (MSB) defined by the
requested number of bits (commonly equal to the security strength
of the DRBG) or the entropy available transported with the buffer
(which is the minimum of the message digest size and the available
entropy in all entropy pools and the auxiliary pool), whatever is
smaller, are obtained from the slow noise source output buffer.

7. Concatenation: The temporary seed buffer used to seed the DRNG
is a concatenation of the slow noise source buffer, the Jitter RNG
output, the CPU noise source output, and the current time.

The DRNG always tries to seed itself with 256 bits of entropy, except
during boot. In any case, if the noise sources cannot deliver that
amount, the available entropy is used and the DRNG keeps track on how
much entropy it was seeded with. The entropy implied by the LRNG
available in the entropy pool may be too conservative. To ensure
that during boot time all available entropy from the entropy pool is
transferred to the DRNG, the hash_df function always generates 256
data bits during boot to seed the DRNG. During boot, the DRNG is
seeded as follows:

1. The DRNG is reseeded from the entropy pool and potentially the fast
noise sources if the entropy pool has collected at least 32 bits of
entropy from the interrupt noise source. The goal of this step is to
ensure that the DRNG receives some initial entropy as early as
possible. In addition it receives the entropy available from
the fast noise sources.

2. The DRNG is reseeded from the entropy pool and potentially the fast
noise sources if all noise sources collectively can provide at least
128 bits of entropy.

3. The DRNG is reseeded from the entropy pool and potentially the fast
noise sources if all noise sources collectivel can provide at least 256
bits.

At the time of the reseeding steps, the DRNG requests as much entropy as
is available in order to skip certain steps and reach the seeding level
of 256 bits. This may imply that one or more of the aforementioned steps
are skipped.

In all listed steps, the DRNG is (re)seeded with a number of random
bytes from the entropy pool that is at most the amount of entropy
present in the entropy pool. This means that when the entropy pool
contains 128 or 256 bits of entropy, the DRNG is seeded with that
amount of entropy as well.

Before the DRNG is seeded with 256 bits of entropy in step 3,
requests of random data from /dev/random and the getrandom system
call are not processed.

The hash operation providing random data from the entropy pools will
always require that all entropy sources collectively can deliver at
least 128 entropy bits.

The DRNG operates as deterministic random number generator with the
following properties:

* The maximum number of random bytes that can be generated with one
DRNG generate operation is limited to 4096 bytes. When longer random
numbers are requested, multiple DRNG generate operations are performed.
The ChaCha20 DRNG as well as the SP800-90A DRBGs implement an update of
their state after completing a generate request for backtracking
resistance.

* The secondary DRNG is reseeded with whatever entropy is available =E2=80=
=93
in the worst case where no additional entropy can be provided by the
noise sources, the DRNG is not re-seeded and continues its operation
to try to reseed again after again the expiry of one of these thresholds:

 - If the last reseeding of the secondary DRNG is more than 600 seconds
   ago, or

 - 2^20 DRNG generate operations are performed, whatever comes first, or

 - the secondary DRNG is forced to reseed before the next generation of
   random numbers if data has been injected into the LRNG by writing data
   into /dev/random or /dev/urandom.

The chosen values prevent high-volume requests from user space to cause
frequent reseeding operations which drag down the performance of the
DRNG.

With the automatic reseeding after 600 seconds, the LRNG is triggered
to reseed itself before the first request after a suspend that put the
hardware to sleep for longer than 600 seconds.

To support smaller devices including IoT environments, this patch
allows reducing the runtime memory footprint of the LRNG at compile
time by selecting smaller collection data sizes.

When selecting the compilation of a kernel for a small environment,
prevent the allocation of a buffer up to 4096 bytes to serve user space
requests. In this case, the stack variable of 64 bytes is used to serve
all user space requests.

The LRNG has the following properties:

* internal noise source: interrupts timing with fast boot time seeding

* high performance of interrupt handling code: The LRNG impact on the
interrupt handling has been reduced to a minimum. On one example
system, the LRNG interrupt handling code in its fastest configuration
executes within an average 55 cycles whereas the existing
/dev/random on the same device takes about 97 cycles when measuring
the execution time of add_interrupt_randomness().

* use of almost never contended lock for hashing operation to collect
  raw entropy supporting concurrency-free use of massive parallel
  systems - worst case rate of contention is the number of DRNG
  reseeds, usually: number of NUMA nodes contentions per 5 minutes.

* use of standalone ChaCha20 based RNG with the option to use a
  different DRNG selectable at compile time

* instantiate one DRNG per NUMA node

* support for runtime switchable output DRNGs

* use of runtime-switchable hash for conditioning implementation
following widely accepted approach

* compile-time selectable collection size

* support of small systems by allowing the reduction of the
runtime memory needs

=46urther details including the rationale for the design choices and
properties of the LRNG together with testing is provided at [1].
In addition, the documentation explains the conducted regression
tests to verify that the LRNG is API and ABI compatible with the
existing /dev/random implementation.

[1] https://www.chronox.de/lrng.html

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
Mathematical aspects Reviewed-by: "Peter, Matthias" <matthias.peter@bsi.bun=
d.de>
Reviewed-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
Reviewed-by: Roman Drahtmueller <draht@schaltsekun.de>
Tested-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
Tested-by: Neil Horman <nhorman@redhat.com>
Signed-off-by: Stephan Mueller <smueller@chronox.de>
=2D--
 MAINTAINERS                         |   7 +
 drivers/char/Kconfig                |   2 +
 drivers/char/Makefile               |   9 +-
 drivers/char/lrng/Kconfig           | 161 +++++++
 drivers/char/lrng/Makefile          |   9 +
 drivers/char/lrng/lrng_archrandom.c |  94 ++++
 drivers/char/lrng/lrng_aux.c        | 136 ++++++
 drivers/char/lrng/lrng_chacha20.c   | 320 ++++++++++++++
 drivers/char/lrng/lrng_chacha20.h   |  29 ++
 drivers/char/lrng/lrng_drng.c       | 428 ++++++++++++++++++
 drivers/char/lrng/lrng_interfaces.c | 651 ++++++++++++++++++++++++++++
 drivers/char/lrng/lrng_internal.h   | 443 +++++++++++++++++++
 drivers/char/lrng/lrng_pool.c       | 563 ++++++++++++++++++++++++
 drivers/char/lrng/lrng_sw_noise.c   | 649 +++++++++++++++++++++++++++
 drivers/char/lrng/lrng_sw_noise.h   |  71 +++
 include/linux/lrng.h                |  81 ++++
 16 files changed, 3652 insertions(+), 1 deletion(-)
 create mode 100644 drivers/char/lrng/Kconfig
 create mode 100644 drivers/char/lrng/Makefile
 create mode 100644 drivers/char/lrng/lrng_archrandom.c
 create mode 100644 drivers/char/lrng/lrng_aux.c
 create mode 100644 drivers/char/lrng/lrng_chacha20.c
 create mode 100644 drivers/char/lrng/lrng_chacha20.h
 create mode 100644 drivers/char/lrng/lrng_drng.c
 create mode 100644 drivers/char/lrng/lrng_interfaces.c
 create mode 100644 drivers/char/lrng/lrng_internal.h
 create mode 100644 drivers/char/lrng/lrng_pool.c
 create mode 100644 drivers/char/lrng/lrng_sw_noise.c
 create mode 100644 drivers/char/lrng/lrng_sw_noise.h
 create mode 100644 include/linux/lrng.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 9450e052f1b1..0684d24f298d 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10328,6 +10328,13 @@ F:	Documentation/litmus-tests/
 F:	Documentation/memory-barriers.txt
 F:	tools/memory-model/
=20
+LINUX RANDOM NUMBER GENERATOR (LRNG) DRIVER
+M:	Stephan Mueller <smueller@chronox.de>
+S:	Maintained
+W:	https://www.chronox.de/lrng.html
+F:	drivers/char/lrng/*
+F:	include/linux/lrng.h
+
 LIS3LV02D ACCELEROMETER DRIVER
 M:	Eric Piel <eric.piel@tremplin-utc.net>
 S:	Maintained
diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index d229a2d0c017..83b175655968 100644
=2D-- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -471,6 +471,8 @@ config ADI
 	  and SSM (Silicon Secured Memory).  Intended consumers of this
 	  driver include crash and makedumpfile.
=20
+source "drivers/char/lrng/Kconfig"
+
 endmenu
=20
 config RANDOM_TRUST_CPU
diff --git a/drivers/char/Makefile b/drivers/char/Makefile
index ffce287ef415..2110d3e28cf2 100644
=2D-- a/drivers/char/Makefile
+++ b/drivers/char/Makefile
@@ -3,7 +3,14 @@
 # Makefile for the kernel character device drivers.
 #
=20
=2Dobj-y				+=3D mem.o random.o
+obj-y				+=3D mem.o
+
+ifeq ($(CONFIG_LRNG),y)
+  obj-y				+=3D lrng/
+else
+  obj-y				+=3D random.o
+endif
+
 obj-$(CONFIG_TTY_PRINTK)	+=3D ttyprintk.o
 obj-y				+=3D misc.o
 obj-$(CONFIG_ATARI_DSP56K)	+=3D dsp56k.o
diff --git a/drivers/char/lrng/Kconfig b/drivers/char/lrng/Kconfig
new file mode 100644
index 000000000000..c9e35e808c77
=2D-- /dev/null
+++ b/drivers/char/lrng/Kconfig
@@ -0,0 +1,161 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Linux Random Number Generator configuration
+#
+
+menuconfig LRNG
+	bool "Linux Random Number Generator"
+	select CRYPTO_LIB_SHA256 if CRYPTO
+	help
+	  The Linux Random Number Generator (LRNG) is the replacement
+	  of the existing /dev/random provided with drivers/char/random.c.
+	  It generates entropy from different noise sources and
+	  delivers significant entropy during boot.
+
+if LRNG
+
+config LRNG_OVERSAMPLE_ENTROPY_SOURCES
+	bool "Oversample entropy sources"
+	default n
+	help
+	  When enabling this option, the entropy sources are
+	  over-sampled with the following approach: First, the
+	  the entropy sources are requested to provide 64 bits more
+	  entropy than the size of the entropy buffer. For example,
+	  if the entropy buffer is 256 bits, 320 bits of entropy
+	  is requested to fill that buffer.
+
+	  Second, the seed operation of the deterministic RNG
+	  requests 128 bits more data from each entropy source than
+	  the security strength of the DRNG during initialization.
+	  A prerequisite for this operation is that the digest size
+	  of the used hash must be at least equally large to generate
+	  that buffer. If the prerequisite is not met, this
+	  oversampling is not applied.
+
+	  This strategy is intended to offset the asymptotic entropy
+	  increase to reach full entropy in a buffer.
+
+	  The strategy is consistent with the requirements in
+	  NIST SP800-90C  and is only enforced with fips=3D1.
+
+	  If unsure, say N.
+
+config LRNG_OVERSAMPLE_ES_BITS
+	int
+	default 0 if !LRNG_OVERSAMPLE_ENTROPY_SOURCES
+	default 64 if LRNG_OVERSAMPLE_ENTROPY_SOURCES
+
+config LRNG_SEED_BUFFER_INIT_ADD_BITS
+	int
+	default 0 if !LRNG_OVERSAMPLE_ENTROPY_SOURCES
+	default 128 if LRNG_OVERSAMPLE_ENTROPY_SOURCES
+
+choice
+	prompt "Continuous entropy compression boot time setting"
+	default LRNG_CONTINUOUS_COMPRESSION_ENABLED
+	help
+	  Select the default behavior of the continuous compression
+	  operation.
+
+	  The Linux RNG collects entropy data during each interrupt.
+	  For performance reasons, a amount of entropy data defined by
+	  the LRNG entropy collection pool size is concatenated into
+	  an array. When that array is filled up, a hash is calculated
+	  to compress the entropy. That hash is calculated in
+	  interrupt context.
+
+	  In case such hash calculation in interrupt context is deemed
+	  too time-consuming, the continuous compression operation
+	  can be disabled. If disabled, the collection of entropy will
+	  not trigger a hash compression operation in interrupt context.
+	  The compression happens only when the DRNG is reseeded. This
+	  implies that old entropy data collected after the last
+	  DRNG-reseed is overwritten with newer entropy data instead
+	  of retaining its entropy with the compression operation.
+
+	config LRNG_CONTINUOUS_COMPRESSION_ENABLED
+		bool "Enable continuous compression (default)"
+
+	config LRNG_CONTINUOUS_COMPRESSION_DISABLED
+		bool "Disable continuous compression"
+endchoice
+
+config LRNG_ENABLE_CONTINUOUS_COMPRESSION
+	bool
+	default y if LRNG_CONTINUOUS_COMPRESSION_ENABLED
+	default n if LRNG_CONTINUOUS_COMPRESSION_DISABLED
+
+config LRNG_SWITCHABLE_CONTINUOUS_COMPRESSION
+	bool "Runtime-switchable continuous entropy compression"
+	help
+	  Per default, the continuous compression operation behavior
+	  is hard-wired into the kernel. Enable this option to allow
+	  it to be configurable at boot time.
+
+	  To modify the default behavior of the continuous
+	  compression operation, use the kernel command line option
+	  of lrng_sw_noise.lrng_pcpu_continuous_compression.
+
+	  If unsure, say N.
+
+choice
+	prompt "LRNG Entropy Collection Pool Size"
+	default LRNG_COLLECTION_SIZE_1024
+	help
+	  Select the size of the LRNG entropy collection pool
+	  storing data without performing a compression operation.
+	  The larger the collection size is, the faster the
+	  average interrupt handling will be. However, on the
+	  other hand the time until the LRNG received full entropy
+	  during boot time is longer because entropy is only awarded
+	  to events once they are compressed. The collection
+	  size represents the number of bytes of the per-CPU
+	  memory used to batch up entropy event data.
+
+	  The default value is good for regular operations. Choose
+	  larger sizes for servers whose boot time is of less
+	  interest. Runtime memory is precious, choose a smaller
+	  size.
+
+	  The collection size is unrelated to the entropy rate
+	  or the amount of entropy the LRNG can process.
+
+	config LRNG_COLLECTION_SIZE_32
+	depends on LRNG_CONTINUOUS_COMPRESSION_ENABLED
+	depends on !LRNG_SWITCHABLE_CONTINUOUS_COMPRESSION
+	depends on !LRNG_OVERSAMPLE_ENTROPY_SOURCES
+		bool "32 interrupt events"
+
+	config LRNG_COLLECTION_SIZE_256
+	depends on !LRNG_OVERSAMPLE_ENTROPY_SOURCES
+		bool "256 interrupt events"
+
+	config LRNG_COLLECTION_SIZE_512
+		bool "512 interrupt events"
+
+	config LRNG_COLLECTION_SIZE_1024
+		bool "1024 interrupt events (default)"
+
+	config LRNG_COLLECTION_SIZE_2048
+		bool "2048 interrupt events"
+
+	config LRNG_COLLECTION_SIZE_4096
+		bool "4096 interrupt events"
+
+	config LRNG_COLLECTION_SIZE_8192
+		bool "8192 interrupt events"
+
+endchoice
+
+config LRNG_COLLECTION_SIZE
+	int
+	default 32 if LRNG_COLLECTION_SIZE_32
+	default 256 if LRNG_COLLECTION_SIZE_256
+	default 512 if LRNG_COLLECTION_SIZE_512
+	default 1024 if LRNG_COLLECTION_SIZE_1024
+	default 2048 if LRNG_COLLECTION_SIZE_2048
+	default 4096 if LRNG_COLLECTION_SIZE_4096
+	default 8192 if LRNG_COLLECTION_SIZE_8192
+
+endif # LRNG
diff --git a/drivers/char/lrng/Makefile b/drivers/char/lrng/Makefile
new file mode 100644
index 000000000000..e72e01c15bb9
=2D-- /dev/null
+++ b/drivers/char/lrng/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for the Linux Random Number Generator.
+#
+
+obj-y				+=3D lrng_pool.o lrng_aux.o \
+				   lrng_sw_noise.o lrng_archrandom.o \
+				   lrng_drng.o lrng_chacha20.o \
+				   lrng_interfaces.o
diff --git a/drivers/char/lrng/lrng_archrandom.c b/drivers/char/lrng/lrng_a=
rchrandom.c
new file mode 100644
index 000000000000..2be4c89cabbc
=2D-- /dev/null
+++ b/drivers/char/lrng/lrng_archrandom.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/*
+ * LRNG Fast Noise Source: CPU-based noise source
+ *
+ * Copyright (C) 2016 - 2021, Stephan Mueller <smueller@chronox.de>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/random.h>
+
+#include "lrng_internal.h"
+
+/*
+ * Estimated entropy of data is a 32th of LRNG_DRNG_SECURITY_STRENGTH_BITS.
+ * As we have no ability to review the implementation of those noise sourc=
es,
+ * it is prudent to have a conservative estimate here.
+ */
+#define LRNG_ARCHRANDOM_DEFAULT_STRENGTH (LRNG_DRNG_SECURITY_STRENGTH_BITS=
>>5)
+#define LRNG_ARCHRANDOM_TRUST_CPU_STRENGTH LRNG_DRNG_SECURITY_STRENGTH_BITS
+#ifdef CONFIG_RANDOM_TRUST_CPU
+static u32 archrandom =3D LRNG_ARCHRANDOM_TRUST_CPU_STRENGTH;
+#else
+static u32 archrandom =3D LRNG_ARCHRANDOM_DEFAULT_STRENGTH;
+#endif
+module_param(archrandom, uint, 0644);
+MODULE_PARM_DESC(archrandom, "Entropy in bits of 256 data bits from CPU no=
ise source (e.g. RDRAND)");
+
+static int __init lrng_parse_trust_cpu(char *arg)
+{
+	int ret;
+	bool trust_cpu =3D false;
+
+	ret =3D kstrtobool(arg, &trust_cpu);
+	if (ret)
+		return ret;
+
+	if (trust_cpu) {
+		archrandom =3D LRNG_ARCHRANDOM_TRUST_CPU_STRENGTH;
+		/* Set the initial threshold */
+		lrng_set_entropy_thresh(
+			lrng_slow_noise_req_entropy(
+				LRNG_ARCHRANDOM_TRUST_CPU_STRENGTH));
+		/* Check if DRNG can be seeded. */
+		lrng_pool_add_irq();
+	} else {
+		archrandom =3D LRNG_ARCHRANDOM_DEFAULT_STRENGTH;
+	}
+
+	return 0;
+}
+early_param("random.trust_cpu", lrng_parse_trust_cpu);
+
+u32 lrng_archrandom_entropylevel(u32 requested_bits)
+{
+	return lrng_fast_noise_entropylevel(archrandom, requested_bits);
+}
+
+/**
+ * lrng_get_arch() - Get CPU noise source entropy
+ *
+ * @outbuf: buffer to store entropy of size LRNG_DRNG_SECURITY_STRENGTH_BY=
TES
+ *
+ * Return:
+ * * > 0 on success where value provides the added entropy in bits
+ * *   0 if no fast source was available
+ */
+u32 lrng_get_arch(u8 *outbuf, u32 requested_bits)
+{
+	u32 i, ent_bits =3D lrng_archrandom_entropylevel(requested_bits);
+
+	/* operate on full blocks */
+	BUILD_BUG_ON(LRNG_DRNG_SECURITY_STRENGTH_BYTES % sizeof(unsigned long));
+	BUILD_BUG_ON(CONFIG_LRNG_SEED_BUFFER_INIT_ADD_BITS %
+							 sizeof(unsigned long));
+	/* ensure we have aligned buffers */
+	BUILD_BUG_ON(LRNG_KCAPI_ALIGN % sizeof(unsigned long));
+
+	if (!ent_bits)
+		return 0;
+
+	for (i =3D 0; i < (requested_bits >> 3);
+	     i +=3D sizeof(unsigned long)) {
+		if (!arch_get_random_seed_long((unsigned long *)(outbuf + i)) &&
+		    !arch_get_random_long((unsigned long *)(outbuf + i))) {
+			archrandom =3D 0;
+			return 0;
+		}
+	}
+
+	pr_debug("obtained %u bits of entropy from CPU RNG noise source\n",
+		 ent_bits);
+	return ent_bits;
+}
diff --git a/drivers/char/lrng/lrng_aux.c b/drivers/char/lrng/lrng_aux.c
new file mode 100644
index 000000000000..a970bbc879ed
=2D-- /dev/null
+++ b/drivers/char/lrng/lrng_aux.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/*
+ * LRNG auxiliary interfaces
+ *
+ * Copyright (C) 2019 - 2021 Stephan Mueller <smueller@chronox.de>
+ * Copyright (C) 2017 Jason A. Donenfeld <Jason@zx2c4.com>. All
+ * Rights Reserved.
+ * Copyright (C) 2016 Jason Cooper <jason@lakedaemon.net>
+ */
+
+#include <linux/mm.h>
+#include <linux/random.h>
+
+#include "lrng_internal.h"
+
+struct batched_entropy {
+	union {
+		u64 entropy_u64[LRNG_DRNG_BLOCKSIZE / sizeof(u64)];
+		u32 entropy_u32[LRNG_DRNG_BLOCKSIZE / sizeof(u32)];
+	};
+	unsigned int position;
+	spinlock_t batch_lock;
+};
+
+/*
+ * Get a random word for internal kernel use only. The quality of the rand=
om
+ * number is as good as /dev/urandom, but there is no backtrack protection,
+ * with the goal of being quite fast and not depleting entropy.
+ */
+static DEFINE_PER_CPU(struct batched_entropy, batched_entropy_u64) =3D {
+	.batch_lock	=3D __SPIN_LOCK_UNLOCKED(batched_entropy_u64.lock),
+};
+
+u64 get_random_u64(void)
+{
+	u64 ret;
+	unsigned long flags;
+	struct batched_entropy *batch;
+
+	lrng_debug_report_seedlevel("get_random_u64");
+
+	batch =3D raw_cpu_ptr(&batched_entropy_u64);
+	spin_lock_irqsave(&batch->batch_lock, flags);
+	if (batch->position % ARRAY_SIZE(batch->entropy_u64) =3D=3D 0) {
+		lrng_drng_get_atomic((u8 *)batch->entropy_u64,
+				      LRNG_DRNG_BLOCKSIZE);
+		batch->position =3D 0;
+	}
+	ret =3D batch->entropy_u64[batch->position++];
+	spin_unlock_irqrestore(&batch->batch_lock, flags);
+	return ret;
+}
+EXPORT_SYMBOL(get_random_u64);
+
+static DEFINE_PER_CPU(struct batched_entropy, batched_entropy_u32) =3D {
+	.batch_lock	=3D __SPIN_LOCK_UNLOCKED(batched_entropy_u32.lock),
+};
+
+u32 get_random_u32(void)
+{
+	u32 ret;
+	unsigned long flags;
+	struct batched_entropy *batch;
+
+	lrng_debug_report_seedlevel("get_random_u32");
+
+	batch =3D raw_cpu_ptr(&batched_entropy_u32);
+	spin_lock_irqsave(&batch->batch_lock, flags);
+	if (batch->position % ARRAY_SIZE(batch->entropy_u32) =3D=3D 0) {
+		lrng_drng_get_atomic((u8 *)batch->entropy_u32,
+				      LRNG_DRNG_BLOCKSIZE);
+		batch->position =3D 0;
+	}
+	ret =3D batch->entropy_u32[batch->position++];
+	spin_unlock_irqrestore(&batch->batch_lock, flags);
+	return ret;
+}
+EXPORT_SYMBOL(get_random_u32);
+
+/*
+ * It's important to invalidate all potential batched entropy that might
+ * be stored before the crng is initialized, which we can do lazily by
+ * simply resetting the counter to zero so that it's re-extracted on the
+ * next usage.
+ */
+void invalidate_batched_entropy(void)
+{
+	int cpu;
+	unsigned long flags;
+
+	for_each_possible_cpu(cpu) {
+		struct batched_entropy *batched_entropy;
+
+		batched_entropy =3D per_cpu_ptr(&batched_entropy_u32, cpu);
+		spin_lock_irqsave(&batched_entropy->batch_lock, flags);
+		batched_entropy->position =3D 0;
+		spin_unlock(&batched_entropy->batch_lock);
+
+		batched_entropy =3D per_cpu_ptr(&batched_entropy_u64, cpu);
+		spin_lock(&batched_entropy->batch_lock);
+		batched_entropy->position =3D 0;
+		spin_unlock_irqrestore(&batched_entropy->batch_lock, flags);
+	}
+}
+
+/**
+ * randomize_page - Generate a random, page aligned address
+ * @start:	The smallest acceptable address the caller will take.
+ * @range:	The size of the area, starting at @start, within which the
+ *		random address must fall.
+ *
+ * If @start + @range would overflow, @range is capped.
+ *
+ * NOTE: Historical use of randomize_range, which this replaces, presumed =
that
+ * @start was already page aligned.  We now align it regardless.
+ *
+ * Return: A page aligned address within [start, start + range).  On error,
+ * @start is returned.
+ */
+unsigned long randomize_page(unsigned long start, unsigned long range)
+{
+	if (!PAGE_ALIGNED(start)) {
+		range -=3D PAGE_ALIGN(start) - start;
+		start =3D PAGE_ALIGN(start);
+	}
+
+	if (start > ULONG_MAX - range)
+		range =3D ULONG_MAX - start;
+
+	range >>=3D PAGE_SHIFT;
+
+	if (range =3D=3D 0)
+		return start;
+
+	return start + (get_random_long() % range << PAGE_SHIFT);
+}
diff --git a/drivers/char/lrng/lrng_chacha20.c b/drivers/char/lrng/lrng_cha=
cha20.c
new file mode 100644
index 000000000000..6df7ff67419b
=2D-- /dev/null
+++ b/drivers/char/lrng/lrng_chacha20.c
@@ -0,0 +1,320 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/*
+ * Backend for the LRNG providing the cryptographic primitives using
+ * ChaCha20 cipher implementations.
+ *
+ * Copyright (C) 2016 - 2021, Stephan Mueller <smueller@chronox.de>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <crypto/chacha.h>
+#include <linux/lrng.h>
+#include <linux/random.h>
+#include <linux/slab.h>
+
+#include "lrng_chacha20.h"
+#include "lrng_internal.h"
+
+/******************************* ChaCha20 DRNG ***************************=
****/
+
+#define CHACHA_BLOCK_WORDS	(CHACHA_BLOCK_SIZE / sizeof(u32))
+
+struct chacha20_state {
+	struct chacha20_block block;
+};
+
+/*
+ * Have a static memory blocks for the ChaCha20 DRNG instance to avoid cal=
ling
+ * kmalloc too early in the boot cycle. For subsequent allocation requests,
+ * such as per-NUMA-node DRNG instances, kmalloc will be used.
+ */
+struct chacha20_state chacha20 __latent_entropy;
+
+/**
+ * Update of the ChaCha20 state by either using an unused buffer part or by
+ * generating one ChaCha20 block which is half of the state of the ChaCha2=
0.
+ * The block is XORed into the key part of the state. This shall ensure
+ * backtracking resistance as well as a proper mix of the ChaCha20 state o=
nce
+ * the key is injected.
+ */
+static void lrng_chacha20_update(struct chacha20_state *chacha20_state,
+				 __le32 *buf, u32 used_words)
+{
+	struct chacha20_block *chacha20 =3D &chacha20_state->block;
+	u32 i;
+	__le32 tmp[CHACHA_BLOCK_WORDS];
+
+	BUILD_BUG_ON(sizeof(struct chacha20_block) !=3D CHACHA_BLOCK_SIZE);
+	BUILD_BUG_ON(CHACHA_BLOCK_SIZE !=3D 2 * CHACHA_KEY_SIZE);
+
+	if (used_words > CHACHA_KEY_SIZE_WORDS) {
+		chacha20_block(&chacha20->constants[0], (u8 *)tmp);
+		for (i =3D 0; i < CHACHA_KEY_SIZE_WORDS; i++)
+			chacha20->key.u[i] ^=3D le32_to_cpu(tmp[i]);
+		memzero_explicit(tmp, sizeof(tmp));
+	} else {
+		for (i =3D 0; i < CHACHA_KEY_SIZE_WORDS; i++)
+			chacha20->key.u[i] ^=3D le32_to_cpu(buf[i + used_words]);
+	}
+
+	/* Deterministic increment of nonce as required in RFC 7539 chapter 4 */
+	chacha20->nonce[0]++;
+	if (chacha20->nonce[0] =3D=3D 0)
+		chacha20->nonce[1]++;
+	if (chacha20->nonce[1] =3D=3D 0)
+		chacha20->nonce[2]++;
+
+	/* Leave counter untouched as it is start value is undefined in RFC */
+}
+
+/*
+ * Seed the ChaCha20 DRNG by injecting the input data into the key part of
+ * the ChaCha20 state. If the input data is longer than the ChaCha20 key s=
ize,
+ * perform a ChaCha20 operation after processing of key size input data.
+ * This operation shall spread out the entropy into the ChaCha20 state bef=
ore
+ * new entropy is injected into the key part.
+ */
+static int lrng_cc20_drng_seed_helper(void *drng, const u8 *inbuf, u32 inb=
uflen)
+{
+	struct chacha20_state *chacha20_state =3D (struct chacha20_state *)drng;
+	struct chacha20_block *chacha20 =3D &chacha20_state->block;
+
+	while (inbuflen) {
+		u32 i, todo =3D min_t(u32, inbuflen, CHACHA_KEY_SIZE);
+
+		for (i =3D 0; i < todo; i++)
+			chacha20->key.b[i] ^=3D inbuf[i];
+
+		/* Break potential dependencies between the inbuf key blocks */
+		lrng_chacha20_update(chacha20_state, NULL,
+				     CHACHA_BLOCK_WORDS);
+		inbuf +=3D todo;
+		inbuflen -=3D todo;
+	}
+
+	return 0;
+}
+
+/*
+ * Chacha20 DRNG generation of random numbers: the stream output of ChaCha=
20
+ * is the random number. After the completion of the generation of the
+ * stream, the entire ChaCha20 state is updated.
+ *
+ * Note, as the ChaCha20 implements a 32 bit counter, we must ensure
+ * that this function is only invoked for at most 2^32 - 1 ChaCha20 blocks
+ * before a reseed or an update happens. This is ensured by the variable
+ * outbuflen which is a 32 bit integer defining the number of bytes to be
+ * generated by the ChaCha20 DRNG. At the end of this function, an update
+ * operation is invoked which implies that the 32 bit counter will never be
+ * overflown in this implementation.
+ */
+static int lrng_cc20_drng_generate_helper(void *drng, u8 *outbuf, u32 outb=
uflen)
+{
+	struct chacha20_state *chacha20_state =3D (struct chacha20_state *)drng;
+	struct chacha20_block *chacha20 =3D &chacha20_state->block;
+	__le32 aligned_buf[CHACHA_BLOCK_WORDS];
+	u32 ret =3D outbuflen, used =3D CHACHA_BLOCK_WORDS;
+	int zeroize_buf =3D 0;
+
+	while (outbuflen >=3D CHACHA_BLOCK_SIZE) {
+		chacha20_block(&chacha20->constants[0], outbuf);
+		outbuf +=3D CHACHA_BLOCK_SIZE;
+		outbuflen -=3D CHACHA_BLOCK_SIZE;
+	}
+
+	if (outbuflen) {
+		chacha20_block(&chacha20->constants[0], (u8 *)aligned_buf);
+		memcpy(outbuf, aligned_buf, outbuflen);
+		used =3D ((outbuflen + sizeof(aligned_buf[0]) - 1) /
+			sizeof(aligned_buf[0]));
+		zeroize_buf =3D 1;
+	}
+
+	lrng_chacha20_update(chacha20_state, aligned_buf, used);
+
+	if (zeroize_buf)
+		memzero_explicit(aligned_buf, sizeof(aligned_buf));
+
+	return ret;
+}
+
+void lrng_cc20_init_state(struct chacha20_state *state)
+{
+	lrng_cc20_init_rfc7539(&state->block);
+}
+
+/*
+ * Allocation of the DRNG state
+ */
+static void *lrng_cc20_drng_alloc(u32 sec_strength)
+{
+	struct chacha20_state *state =3D NULL;
+
+	if (sec_strength > CHACHA_KEY_SIZE) {
+		pr_err("Security strength of ChaCha20 DRNG (%u bits) lower than requeste=
d by LRNG (%u bits)\n",
+			CHACHA_KEY_SIZE * 8, sec_strength * 8);
+		return ERR_PTR(-EINVAL);
+	}
+	if (sec_strength < CHACHA_KEY_SIZE)
+		pr_warn("Security strength of ChaCha20 DRNG (%u bits) higher than reques=
ted by LRNG (%u bits)\n",
+			CHACHA_KEY_SIZE * 8, sec_strength * 8);
+
+	state =3D kmalloc(sizeof(struct chacha20_state), GFP_KERNEL);
+	if (!state)
+		return ERR_PTR(-ENOMEM);
+	pr_debug("memory for ChaCha20 core allocated\n");
+
+	lrng_cc20_init_state(state);
+
+	return state;
+}
+
+static void lrng_cc20_drng_dealloc(void *drng)
+{
+	struct chacha20_state *chacha20_state =3D (struct chacha20_state *)drng;
+
+	if (drng =3D=3D &chacha20) {
+		memzero_explicit(chacha20_state, sizeof(*chacha20_state));
+		pr_debug("static ChaCha20 core zeroized\n");
+		return;
+	}
+
+	pr_debug("ChaCha20 core zeroized and freed\n");
+	kfree_sensitive(chacha20_state);
+}
+
+/******************************* Hash Operation **************************=
*****/
+
+#ifdef CONFIG_CRYPTO_LIB_SHA256
+
+#include <crypto/sha2.h>
+
+static u32 lrng_cc20_hash_digestsize(void *hash)
+{
+	return SHA256_DIGEST_SIZE;
+}
+
+static int lrng_cc20_hash_init(struct shash_desc *shash, void *hash)
+{
+	/*
+	 * We do not need a TFM - we only need sufficient space for
+	 * struct sha256_state on the stack.
+	 */
+	sha256_init(shash_desc_ctx(shash));
+	return 0;
+}
+
+static int lrng_cc20_hash_update(struct shash_desc *shash,
+				 const u8 *inbuf, u32 inbuflen)
+{
+	sha256_update(shash_desc_ctx(shash), inbuf, inbuflen);
+	return 0;
+}
+
+static int lrng_cc20_hash_final(struct shash_desc *shash, u8 *digest)
+{
+	sha256_final(shash_desc_ctx(shash), digest);
+	return 0;
+}
+
+static const char *lrng_cc20_hash_name(void)
+{
+	return "SHA-256";
+}
+
+static void lrng_cc20_hash_desc_zero(struct shash_desc *shash)
+{
+	memzero_explicit(shash_desc_ctx(shash), sizeof(struct sha256_state));
+}
+
+#else /* CONFIG_CRYPTO_LIB_SHA256 */
+
+#include <crypto/sha1.h>
+#include <crypto/sha1_base.h>
+
+/*
+ * If the SHA-256 support is not compiled, we fall back to SHA-1 that is a=
lways
+ * compiled and present in the kernel.
+ */
+static u32 lrng_cc20_hash_digestsize(void *hash)
+{
+	return SHA1_DIGEST_SIZE;
+}
+
+static void lrng_sha1_block_fn(struct sha1_state *sctx, const u8 *src,
+			       int blocks)
+{
+	u32 temp[SHA1_WORKSPACE_WORDS];
+
+	while (blocks--) {
+		sha1_transform(sctx->state, src, temp);
+		src +=3D SHA1_BLOCK_SIZE;
+	}
+	memzero_explicit(temp, sizeof(temp));
+}
+
+static int lrng_cc20_hash_init(struct shash_desc *shash, void *hash)
+{
+	/*
+	 * We do not need a TFM - we only need sufficient space for
+	 * struct sha1_state on the stack.
+	 */
+	sha1_base_init(shash);
+	return 0;
+}
+
+static int lrng_cc20_hash_update(struct shash_desc *shash,
+				 const u8 *inbuf, u32 inbuflen)
+{
+	return sha1_base_do_update(shash, inbuf, inbuflen, lrng_sha1_block_fn);
+}
+
+static int lrng_cc20_hash_final(struct shash_desc *shash, u8 *digest)
+{
+	return sha1_base_do_finalize(shash, lrng_sha1_block_fn) ?:
+	       sha1_base_finish(shash, digest);
+}
+
+static const char *lrng_cc20_hash_name(void)
+{
+	return "SHA-1";
+}
+
+static void lrng_cc20_hash_desc_zero(struct shash_desc *shash)
+{
+	memzero_explicit(shash_desc_ctx(shash), sizeof(struct sha1_state));
+}
+
+#endif /* CONFIG_CRYPTO_LIB_SHA256 */
+
+static void *lrng_cc20_hash_alloc(void)
+{
+	pr_info("Hash %s allocated\n", lrng_cc20_hash_name());
+	return NULL;
+}
+
+static void lrng_cc20_hash_dealloc(void *hash)
+{
+}
+
+static const char *lrng_cc20_drng_name(void)
+{
+	return "ChaCha20 DRNG";
+}
+
+const struct lrng_crypto_cb lrng_cc20_crypto_cb =3D {
+	.lrng_drng_name			=3D lrng_cc20_drng_name,
+	.lrng_hash_name			=3D lrng_cc20_hash_name,
+	.lrng_drng_alloc		=3D lrng_cc20_drng_alloc,
+	.lrng_drng_dealloc		=3D lrng_cc20_drng_dealloc,
+	.lrng_drng_seed_helper		=3D lrng_cc20_drng_seed_helper,
+	.lrng_drng_generate_helper	=3D lrng_cc20_drng_generate_helper,
+	.lrng_hash_alloc		=3D lrng_cc20_hash_alloc,
+	.lrng_hash_dealloc		=3D lrng_cc20_hash_dealloc,
+	.lrng_hash_digestsize		=3D lrng_cc20_hash_digestsize,
+	.lrng_hash_init			=3D lrng_cc20_hash_init,
+	.lrng_hash_update		=3D lrng_cc20_hash_update,
+	.lrng_hash_final		=3D lrng_cc20_hash_final,
+	.lrng_hash_desc_zero		=3D lrng_cc20_hash_desc_zero,
+};
diff --git a/drivers/char/lrng/lrng_chacha20.h b/drivers/char/lrng/lrng_cha=
cha20.h
new file mode 100644
index 000000000000..87361f26bc43
=2D-- /dev/null
+++ b/drivers/char/lrng/lrng_chacha20.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/*
+ * LRNG ChaCha20 definitions
+ *
+ * Copyright (C) 2016 - 2021, Stephan Mueller <smueller@chronox.de>
+ */
+
+#include <crypto/chacha.h>
+
+/* State according to RFC 7539 section 2.3 */
+struct chacha20_block {
+	u32 constants[4];
+	union {
+#define CHACHA_KEY_SIZE_WORDS (CHACHA_KEY_SIZE / sizeof(u32))
+		u32 u[CHACHA_KEY_SIZE_WORDS];
+		u8  b[CHACHA_KEY_SIZE];
+	} key;
+	u32 counter;
+	u32 nonce[3];
+};
+
+static inline void lrng_cc20_init_rfc7539(struct chacha20_block *chacha20)
+{
+	/* String "expand 32-byte k" */
+	chacha20->constants[0] =3D 0x61707865;
+	chacha20->constants[1] =3D 0x3320646e;
+	chacha20->constants[2] =3D 0x79622d32;
+	chacha20->constants[3] =3D 0x6b206574;
+}
diff --git a/drivers/char/lrng/lrng_drng.c b/drivers/char/lrng/lrng_drng.c
new file mode 100644
index 000000000000..c913e9e94080
=2D-- /dev/null
+++ b/drivers/char/lrng/lrng_drng.c
@@ -0,0 +1,428 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/*
+ * LRNG DRNG processing
+ *
+ * Copyright (C) 2016 - 2021, Stephan Mueller <smueller@chronox.de>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/fips.h>
+#include <linux/lrng.h>
+
+#include "lrng_internal.h"
+
+/*
+ * Maximum number of seconds between DRNG reseed intervals of the DRNG. No=
te,
+ * this is enforced with the next request of random numbers from the
+ * DRNG. Setting this value to zero implies a reseeding attempt before eve=
ry
+ * generated random number.
+ */
+int lrng_drng_reseed_max_time =3D 600;
+
+static atomic_t lrng_avail =3D ATOMIC_INIT(0);
+
+DEFINE_MUTEX(lrng_crypto_cb_update);
+
+/* DRNG for /dev/urandom, getrandom(2), get_random_bytes */
+static struct lrng_drng lrng_drng_init =3D {
+	.drng		=3D &chacha20,
+	.crypto_cb	=3D &lrng_cc20_crypto_cb,
+	.lock		=3D __MUTEX_INITIALIZER(lrng_drng_init.lock),
+	.spin_lock	=3D __SPIN_LOCK_UNLOCKED(lrng_drng_init.spin_lock),
+	.hash_lock	=3D __RW_LOCK_UNLOCKED(lrng_drng_init.hash_lock)
+};
+
+/*
+ * DRNG for get_random_bytes when called in atomic context. This
+ * DRNG will always use the ChaCha20 DRNG. It will never benefit from a
+ * DRNG switch like the "regular" DRNG. If there was no DRNG switch, the a=
tomic
+ * DRNG is identical to the "regular" DRNG.
+ *
+ * The reason for having this is due to the fact that DRNGs other than
+ * the ChaCha20 DRNG may sleep.
+ */
+static struct lrng_drng lrng_drng_atomic =3D {
+	.drng		=3D &chacha20,
+	.crypto_cb	=3D &lrng_cc20_crypto_cb,
+	.spin_lock	=3D __SPIN_LOCK_UNLOCKED(lrng_drng_atomic.spin_lock),
+	.hash_lock	=3D __RW_LOCK_UNLOCKED(lrng_drng_atomic.hash_lock)
+};
+
+/********************************** Helper *******************************=
*****/
+
+bool lrng_get_available(void)
+{
+	return likely(atomic_read(&lrng_avail));
+}
+
+void lrng_set_available(void)
+{
+	atomic_set(&lrng_avail, 1);
+}
+
+struct lrng_drng *lrng_drng_init_instance(void)
+{
+	return &lrng_drng_init;
+}
+
+struct lrng_drng *lrng_drng_atomic_instance(void)
+{
+	return &lrng_drng_atomic;
+}
+
+void lrng_drng_reset(struct lrng_drng *drng)
+{
+	atomic_set(&drng->requests, LRNG_DRNG_RESEED_THRESH);
+	drng->last_seeded =3D jiffies;
+	drng->fully_seeded =3D false;
+	drng->force_reseed =3D true;
+	pr_debug("reset DRNG\n");
+}
+
+/* Initialize the default DRNG during boot */
+static void lrng_drng_seed(struct lrng_drng *drng);
+void lrng_drngs_init_cc20(bool force_seed)
+{
+	unsigned long flags =3D 0;
+
+	if (lrng_get_available())
+		return;
+
+	lrng_drng_lock(&lrng_drng_init, &flags);
+	if (lrng_get_available()) {
+		lrng_drng_unlock(&lrng_drng_init, &flags);
+		if (force_seed)
+			goto seed;
+		return;
+	}
+
+	lrng_drng_reset(&lrng_drng_init);
+	lrng_cc20_init_state(&chacha20);
+	lrng_state_init_seed_work();
+	lrng_drng_unlock(&lrng_drng_init, &flags);
+
+	lrng_drng_lock(&lrng_drng_atomic, &flags);
+	lrng_drng_reset(&lrng_drng_atomic);
+	/*
+	 * We do not initialize the state of the atomic DRNG as it is identical
+	 * to the DRNG at this point.
+	 */
+	lrng_drng_unlock(&lrng_drng_atomic, &flags);
+
+	lrng_set_available();
+
+seed:
+	/* Seed the DRNG with any entropy available */
+	if (!lrng_pool_trylock()) {
+		lrng_drng_seed(&lrng_drng_init);
+		pr_info("ChaCha20 core initialized with first seeding\n");
+	} else {
+		pr_info("ChaCha20 core initialized without seeding\n");
+	}
+}
+
+bool lrng_sp80090c_compliant(void)
+{
+	if (!IS_ENABLED(CONFIG_LRNG_OVERSAMPLE_ENTROPY_SOURCES))
+		return false;
+
+	/* Entropy source hash must be capable of transporting enough entropy */
+	if (lrng_get_digestsize() <
+	    (LRNG_DRNG_SECURITY_STRENGTH_BITS +
+	     CONFIG_LRNG_SEED_BUFFER_INIT_ADD_BITS))
+		return false;
+
+	/* SP800-90C only requested in FIPS mode */
+	return fips_enabled;
+}
+
+/************************* Random Number Generation **********************=
*****/
+
+/* Inject a data buffer into the DRNG */
+static void lrng_drng_inject(struct lrng_drng *drng,
+			     const u8 *inbuf, u32 inbuflen)
+{
+	const char *drng_type =3D unlikely(drng =3D=3D &lrng_drng_atomic) ?
+				"atomic" : "regular";
+	unsigned long flags =3D 0;
+
+	BUILD_BUG_ON(LRNG_DRNG_RESEED_THRESH > INT_MAX);
+	pr_debug("seeding %s DRNG with %u bytes\n", drng_type, inbuflen);
+	lrng_drng_lock(drng, &flags);
+	if (drng->crypto_cb->lrng_drng_seed_helper(drng->drng,
+						   inbuf, inbuflen) < 0) {
+		pr_warn("seeding of %s DRNG failed\n", drng_type);
+		atomic_set(&drng->requests, 1);
+	} else {
+		pr_debug("%s DRNG stats since last seeding: %lu secs; generate calls: %d=
\n",
+			 drng_type,
+			 (time_after(jiffies, drng->last_seeded) ?
+			  (jiffies - drng->last_seeded) : 0) / HZ,
+			 (LRNG_DRNG_RESEED_THRESH -
+			  atomic_read(&drng->requests)));
+		drng->last_seeded =3D jiffies;
+		atomic_set(&drng->requests, LRNG_DRNG_RESEED_THRESH);
+		drng->force_reseed =3D false;
+
+		if (drng->drng =3D=3D lrng_drng_atomic.drng) {
+			lrng_drng_atomic.last_seeded =3D jiffies;
+			atomic_set(&lrng_drng_atomic.requests,
+				   LRNG_DRNG_RESEED_THRESH);
+			lrng_drng_atomic.force_reseed =3D false;
+		}
+	}
+	lrng_drng_unlock(drng, &flags);
+}
+
+/*
+ * Perform the seeding of the DRNG with data from noise source
+ */
+static inline void _lrng_drng_seed(struct lrng_drng *drng)
+{
+	struct entropy_buf seedbuf __aligned(LRNG_KCAPI_ALIGN);
+	u32 total_entropy_bits, requested_bits =3D lrng_security_strength();
+
+	/* Apply oversampling during initialization according to SP800-90C */
+	if (lrng_sp80090c_compliant() && !drng->fully_seeded)
+		requested_bits +=3D CONFIG_LRNG_SEED_BUFFER_INIT_ADD_BITS;
+
+	lrng_fill_seed_buffer(&seedbuf, requested_bits);
+
+	/* Allow the seeding operation to be called again */
+	lrng_pool_unlock();
+	lrng_init_ops(&seedbuf);
+
+	lrng_drng_inject(drng, (u8 *)&seedbuf, sizeof(seedbuf));
+	total_entropy_bits =3D seedbuf.a_bits + seedbuf.b_bits + seedbuf.c_bits +
+			     seedbuf.d_bits;
+	memzero_explicit(&seedbuf, sizeof(seedbuf));
+
+	if (total_entropy_bits >=3D requested_bits)
+		drng->fully_seeded =3D true;
+}
+
+static int lrng_drng_get(struct lrng_drng *drng, u8 *outbuf, u32 outbuflen=
);
+static void lrng_drng_seed(struct lrng_drng *drng)
+{
+	_lrng_drng_seed(drng);
+
+	BUILD_BUG_ON(LRNG_MIN_SEED_ENTROPY_BITS >
+		     LRNG_DRNG_SECURITY_STRENGTH_BITS);
+
+	/*
+	 * Reseed atomic DRNG from current DRNG,
+	 *
+	 * We can obtain random numbers from DRNG as the lock type
+	 * chosen by lrng_drng_get is usable with the current caller.
+	 */
+	if ((drng->drng !=3D lrng_drng_atomic.drng) &&
+	    (lrng_drng_atomic.force_reseed ||
+	     atomic_read(&lrng_drng_atomic.requests) <=3D 0 ||
+	     time_after(jiffies, lrng_drng_atomic.last_seeded +
+			lrng_drng_reseed_max_time * HZ))) {
+		u8 seedbuf[LRNG_DRNG_SECURITY_STRENGTH_BYTES]
+						__aligned(LRNG_KCAPI_ALIGN);
+		int ret =3D lrng_drng_get(drng, seedbuf, sizeof(seedbuf));
+
+		if (ret < 0) {
+			pr_warn("Error generating random numbers for atomic DRNG: %d\n",
+				ret);
+		} else {
+			lrng_drng_inject(&lrng_drng_atomic, seedbuf, ret);
+		}
+		memzero_explicit(&seedbuf, sizeof(seedbuf));
+	}
+}
+
+static inline void _lrng_drng_seed_work(struct lrng_drng *drng, u32 node)
+{
+	pr_debug("reseed triggered by interrupt noise source for DRNG on NUMA nod=
e %d\n",
+		 node);
+	lrng_drng_seed(drng);
+	if (drng->fully_seeded) {
+		/* Prevent reseed storm */
+		drng->last_seeded +=3D node * 100 * HZ;
+		/* Prevent draining of pool on idle systems */
+		lrng_drng_reseed_max_time +=3D 100;
+	}
+}
+
+/*
+ * DRNG reseed trigger: Kernel thread handler triggered by the schedule_wo=
rk()
+ */
+void lrng_drng_seed_work(struct work_struct *dummy)
+{
+	struct lrng_drng **lrng_drng =3D lrng_drng_instances();
+	u32 node;
+
+	if (lrng_drng) {
+		for_each_online_node(node) {
+			struct lrng_drng *drng =3D lrng_drng[node];
+
+			if (drng && !drng->fully_seeded) {
+				_lrng_drng_seed_work(drng, node);
+				goto out;
+			}
+		}
+		lrng_pool_all_numa_nodes_seeded();
+	} else {
+		if (!lrng_drng_init.fully_seeded)
+			_lrng_drng_seed_work(&lrng_drng_init, 0);
+	}
+
+out:
+	/* Allow the seeding operation to be called again */
+	lrng_pool_unlock();
+}
+
+/* Force all DRNGs to reseed before next generation */
+void lrng_drng_force_reseed(void)
+{
+	struct lrng_drng **lrng_drng =3D lrng_drng_instances();
+	u32 node;
+
+	if (!lrng_drng) {
+		lrng_drng_init.force_reseed =3D lrng_drng_init.fully_seeded;
+		pr_debug("force reseed of initial DRNG\n");
+		return;
+	}
+	for_each_online_node(node) {
+		struct lrng_drng *drng =3D lrng_drng[node];
+
+		if (!drng)
+			continue;
+
+		drng->force_reseed =3D drng->fully_seeded;
+		pr_debug("force reseed of DRNG on node %u\n", node);
+	}
+	lrng_drng_atomic.force_reseed =3D lrng_drng_atomic.fully_seeded;
+}
+
+/**
+ * lrng_drng_get() - Get random data out of the DRNG which is reseeded
+ * frequently.
+ *
+ * @outbuf: buffer for storing random data
+ * @outbuflen: length of outbuf
+ *
+ * Return:
+ * * < 0 in error case (DRNG generation or update failed)
+ * * >=3D0 returning the returned number of bytes
+ */
+static int lrng_drng_get(struct lrng_drng *drng, u8 *outbuf, u32 outbuflen)
+{
+	unsigned long flags =3D 0;
+	u32 processed =3D 0;
+
+	if (!outbuf || !outbuflen)
+		return 0;
+
+	outbuflen =3D min_t(size_t, outbuflen, INT_MAX);
+
+	lrng_drngs_init_cc20(false);
+
+	while (outbuflen) {
+		u32 todo =3D min_t(u32, outbuflen, LRNG_DRNG_MAX_REQSIZE);
+		int ret;
+
+		/* All but the atomic DRNG are seeded during generation */
+		if (atomic_dec_and_test(&drng->requests) ||
+		    drng->force_reseed ||
+		    time_after(jiffies, drng->last_seeded +
+			       lrng_drng_reseed_max_time * HZ)) {
+			if (likely(drng !=3D &lrng_drng_atomic)) {
+				if (lrng_pool_trylock())
+					atomic_set(&drng->requests, 1);
+				else
+					lrng_drng_seed(drng);
+			}
+		}
+
+		lrng_drng_lock(drng, &flags);
+		ret =3D drng->crypto_cb->lrng_drng_generate_helper(
+					drng->drng, outbuf + processed, todo);
+		lrng_drng_unlock(drng, &flags);
+		if (ret <=3D 0) {
+			pr_warn("getting random data from DRNG failed (%d)\n",
+				ret);
+			return -EFAULT;
+		}
+		processed +=3D ret;
+		outbuflen -=3D ret;
+	}
+
+	return processed;
+}
+
+int lrng_drng_get_atomic(u8 *outbuf, u32 outbuflen)
+{
+	return lrng_drng_get(&lrng_drng_atomic, outbuf, outbuflen);
+}
+
+int lrng_drng_get_sleep(u8 *outbuf, u32 outbuflen)
+{
+	struct lrng_drng **lrng_drng =3D lrng_drng_instances();
+	struct lrng_drng *drng =3D &lrng_drng_init;
+	int node =3D numa_node_id();
+
+	might_sleep();
+
+	if (lrng_drng && lrng_drng[node] && lrng_drng[node]->fully_seeded)
+		drng =3D lrng_drng[node];
+
+	return lrng_drng_get(drng, outbuf, outbuflen);
+}
+
+/* Reset LRNG such that all existing entropy is gone */
+static void _lrng_reset(struct work_struct *work)
+{
+	struct lrng_drng **lrng_drng =3D lrng_drng_instances();
+	unsigned long flags =3D 0;
+
+	if (!lrng_drng) {
+		lrng_drng_lock(&lrng_drng_init, &flags);
+		lrng_drng_reset(&lrng_drng_init);
+		lrng_drng_unlock(&lrng_drng_init, &flags);
+	} else {
+		u32 node;
+
+		for_each_online_node(node) {
+			struct lrng_drng *drng =3D lrng_drng[node];
+
+			if (!drng)
+				continue;
+			lrng_drng_lock(drng, &flags);
+			lrng_drng_reset(drng);
+			lrng_drng_unlock(drng, &flags);
+		}
+	}
+	lrng_set_entropy_thresh(
+		lrng_slow_noise_req_entropy(LRNG_INIT_ENTROPY_BITS +
+					    CONFIG_LRNG_OVERSAMPLE_ES_BITS));
+
+	lrng_reset_state();
+}
+
+static DECLARE_WORK(lrng_reset_work, _lrng_reset);
+
+void lrng_reset(void)
+{
+	schedule_work(&lrng_reset_work);
+}
+
+/***************************** Initialize LRNG ***************************=
****/
+
+static int __init lrng_init(void)
+{
+	lrng_drngs_init_cc20(false);
+
+	lrng_drngs_numa_alloc();
+	return 0;
+}
+
+late_initcall(lrng_init);
+
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_AUTHOR("Stephan Mueller <smueller@chronox.de>");
+MODULE_DESCRIPTION("Linux Random Number Generator");
diff --git a/drivers/char/lrng/lrng_interfaces.c b/drivers/char/lrng/lrng_i=
nterfaces.c
new file mode 100644
index 000000000000..efcadcfa79f2
=2D-- /dev/null
+++ b/drivers/char/lrng/lrng_interfaces.c
@@ -0,0 +1,651 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/*
+ * LRNG User and kernel space interfaces
+ *
+ * Copyright (C) 2016 - 2021, Stephan Mueller <smueller@chronox.de>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/freezer.h>
+#include <linux/fs.h>
+#include <linux/genhd.h>
+#include <linux/hw_random.h>
+#include <linux/kthread.h>
+#include <linux/poll.h>
+#include <linux/preempt.h>
+#include <linux/random.h>
+#include <linux/slab.h>
+#include <linux/syscalls.h>
+#include <linux/timex.h>
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/random.h>
+
+#include "lrng_internal.h"
+
+/*
+ * If the entropy count falls under this number of bits, then we
+ * should wake up processes which are selecting or polling on write
+ * access to /dev/random.
+ */
+u32 lrng_write_wakeup_bits =3D LRNG_WRITE_WAKEUP_ENTROPY;
+
+static LIST_HEAD(lrng_ready_list);
+static DEFINE_SPINLOCK(lrng_ready_list_lock);
+
+static DECLARE_WAIT_QUEUE_HEAD(lrng_write_wait);
+static DECLARE_WAIT_QUEUE_HEAD(lrng_init_wait);
+static struct fasync_struct *fasync;
+
+struct ctl_table random_table[];
+
+/********************************** Helper *******************************=
****/
+
+/* Is the DRNG seed level too low? */
+static inline bool lrng_need_entropy(void)
+{
+	return (lrng_avail_aux_entropy() < lrng_write_wakeup_bits);
+}
+
+void lrng_writer_wakeup(void)
+{
+	if (lrng_need_entropy() && wq_has_sleeper(&lrng_write_wait)) {
+		wake_up_interruptible(&lrng_write_wait);
+		kill_fasync(&fasync, SIGIO, POLL_OUT);
+	}
+}
+
+void lrng_init_wakeup(void)
+{
+	wake_up_all(&lrng_init_wait);
+	kill_fasync(&fasync, SIGIO, POLL_IN);
+}
+
+/**
+ * lrng_process_ready_list() - Ping all kernel internal callers waiting un=
til
+ * the DRNG is at least minimally seeded to inform that the DRNG reached t=
hat
+ * seed level.
+ *
+ * When the SP800-90B testing is enabled, the ping only happens if the SP8=
00-90B
+ * startup health tests are completed. This implies that kernel internal
+ * callers always have an SP800-90B compliant noise source when being
+ * pinged.
+ */
+void lrng_process_ready_list(void)
+{
+	unsigned long flags;
+	struct random_ready_callback *rdy, *tmp;
+
+	if (!lrng_sp80090b_startup_complete())
+		return;
+
+	spin_lock_irqsave(&lrng_ready_list_lock, flags);
+	list_for_each_entry_safe(rdy, tmp, &lrng_ready_list, list) {
+		struct module *owner =3D rdy->owner;
+
+		list_del_init(&rdy->list);
+		rdy->func(rdy);
+		module_put(owner);
+	}
+	spin_unlock_irqrestore(&lrng_ready_list_lock, flags);
+}
+
+void lrng_debug_report_seedlevel(const char *name)
+{
+#ifdef CONFIG_WARN_ALL_UNSEEDED_RANDOM
+	static void *previous =3D NULL;
+	void *caller =3D (void *) _RET_IP_;
+
+	if (READ_ONCE(previous) =3D=3D caller)
+		return;
+
+	if (!lrng_state_min_seeded())
+		pr_notice("%pS %s called without reaching mimimally seeded level (availa=
ble entropy %u)\n",
+			  caller, name, lrng_avail_entropy());
+
+	WRITE_ONCE(previous, caller);
+#endif
+}
+
+/************************ LRNG kernel input interfaces *******************=
*****/
+
+/**
+ * add_hwgenerator_randomness() - Interface for in-kernel drivers of true
+ * hardware RNGs.
+ *
+ * Those devices may produce endless random bits and will be throttled
+ * when our pool is full.
+ *
+ * @buffer: buffer holding the entropic data from HW noise sources to be u=
sed to
+ *	    insert into entropy pool.
+ * @count: length of buffer
+ * @entropy_bits: amount of entropy in buffer (value is in bits)
+ */
+void add_hwgenerator_randomness(const char *buffer, size_t count,
+				size_t entropy_bits)
+{
+	/*
+	 * Suspend writing if we are fully loaded with entropy.
+	 * We'll be woken up again once below lrng_write_wakeup_thresh,
+	 * or when the calling thread is about to terminate.
+	 */
+	wait_event_interruptible(lrng_write_wait,
+				lrng_need_entropy() ||
+				lrng_state_exseed_allow(lrng_noise_source_hw) ||
+				kthread_should_stop());
+	lrng_state_exseed_set(lrng_noise_source_hw, false);
+	lrng_pool_insert_aux(buffer, count, entropy_bits);
+}
+EXPORT_SYMBOL_GPL(add_hwgenerator_randomness);
+
+/**
+ * add_bootloader_randomness() - Handle random seed passed by bootloader.
+ *
+ * If the seed is trustworthy, it would be regarded as hardware RNGs. Othe=
rwise
+ * it would be regarded as device data.
+ * The decision is controlled by CONFIG_RANDOM_TRUST_BOOTLOADER.
+ *
+ * @buf: buffer holding the entropic data from HW noise sources to be used=
 to
+ *	 insert into entropy pool.
+ * @size: length of buffer
+ */
+void add_bootloader_randomness(const void *buf, unsigned int size)
+{
+	if (IS_ENABLED(CONFIG_RANDOM_TRUST_BOOTLOADER))
+		add_hwgenerator_randomness(buf, size, size * 8);
+	else
+		add_device_randomness(buf, size);
+}
+EXPORT_SYMBOL_GPL(add_bootloader_randomness);
+
+/*
+ * Callback for HID layer -- use the HID event values to stir the entropy =
pool
+ */
+void add_input_randomness(unsigned int type, unsigned int code,
+			  unsigned int value)
+{
+	static unsigned char last_value;
+
+	/* ignore autorepeat and the like */
+	if (value =3D=3D last_value)
+		return;
+
+	last_value =3D value;
+
+	lrng_pcpu_array_add_u32((type << 4) ^ code ^ (code >> 4) ^ value);
+}
+EXPORT_SYMBOL_GPL(add_input_randomness);
+
+/**
+ * add_device_randomness() - Add device- or boot-specific data to the entr=
opy
+ * pool to help initialize it.
+ *
+ * None of this adds any entropy; it is meant to avoid the problem of
+ * the entropy pool having similar initial state across largely
+ * identical devices.
+ *
+ * @buf: buffer holding the entropic data from HW noise sources to be used=
 to
+ *	 insert into entropy pool.
+ * @size: length of buffer
+ */
+void add_device_randomness(const void *buf, unsigned int size)
+{
+	lrng_pool_insert_aux((u8 *)buf, size, 0);
+}
+EXPORT_SYMBOL(add_device_randomness);
+
+#ifdef CONFIG_BLOCK
+void rand_initialize_disk(struct gendisk *disk) { }
+void add_disk_randomness(struct gendisk *disk) { }
+EXPORT_SYMBOL(add_disk_randomness);
+#endif
+
+/**
+ * del_random_ready_callback() - Delete a previously registered readiness
+ * callback function.
+ *
+ * @rdy: callback definition that was registered initially
+ */
+void del_random_ready_callback(struct random_ready_callback *rdy)
+{
+	unsigned long flags;
+	struct module *owner =3D NULL;
+
+	spin_lock_irqsave(&lrng_ready_list_lock, flags);
+	if (!list_empty(&rdy->list)) {
+		list_del_init(&rdy->list);
+		owner =3D rdy->owner;
+	}
+	spin_unlock_irqrestore(&lrng_ready_list_lock, flags);
+
+	module_put(owner);
+}
+EXPORT_SYMBOL(del_random_ready_callback);
+
+/**
+ * add_random_ready_callback() - Add a callback function that will be invo=
ked
+ * when the DRNG is mimimally seeded.
+ *
+ * @rdy: callback definition to be invoked when the LRNG is seeded
+ *
+ * Return:
+ * * 0 if callback is successfully added
+ * * -EALREADY if pool is already initialised (callback not called)
+ * * -ENOENT if module for callback is not alive
+ */
+int add_random_ready_callback(struct random_ready_callback *rdy)
+{
+	struct module *owner;
+	unsigned long flags;
+	int err =3D -EALREADY;
+
+	if (likely(lrng_state_min_seeded()))
+		return err;
+
+	owner =3D rdy->owner;
+	if (!try_module_get(owner))
+		return -ENOENT;
+
+	spin_lock_irqsave(&lrng_ready_list_lock, flags);
+	if (lrng_state_min_seeded())
+		goto out;
+
+	owner =3D NULL;
+
+	list_add(&rdy->list, &lrng_ready_list);
+	err =3D 0;
+
+out:
+	spin_unlock_irqrestore(&lrng_ready_list_lock, flags);
+
+	module_put(owner);
+
+	return err;
+}
+EXPORT_SYMBOL(add_random_ready_callback);
+
+/*********************** LRNG kernel output interfaces *******************=
*****/
+
+/**
+ * get_random_bytes() - Provider of cryptographic strong random numbers for
+ * kernel-internal usage.
+ *
+ * This function is appropriate for all in-kernel use cases. However,
+ * it will always use the ChaCha20 DRNG.
+ *
+ * @buf: buffer to store the random bytes
+ * @nbytes: size of the buffer
+ */
+void get_random_bytes(void *buf, int nbytes)
+{
+	lrng_drng_get_atomic((u8 *)buf, (u32)nbytes);
+	lrng_debug_report_seedlevel("get_random_bytes");
+}
+EXPORT_SYMBOL(get_random_bytes);
+
+/**
+ * get_random_bytes_full() - Provider of cryptographic strong random numbe=
rs
+ * for kernel-internal usage.
+ *
+ * This function is appropriate only for non-atomic use cases as this
+ * function may sleep. Though, it provides access to the full functionality
+ * of LRNG including the switchable DRNG support, that may support other
+ * DRNGs such as the SP800-90A DRBG.
+ *
+ * @buf: buffer to store the random bytes
+ * @nbytes: size of the buffer
+ */
+void get_random_bytes_full(void *buf, int nbytes)
+{
+	lrng_drng_get_sleep((u8 *)buf, (u32)nbytes);
+	lrng_debug_report_seedlevel("get_random_bytes_full");
+}
+EXPORT_SYMBOL(get_random_bytes_full);
+
+/**
+ * wait_for_random_bytes() - Wait for the LRNG to be seeded and thus
+ * guaranteed to supply cryptographically secure random numbers.
+ *
+ * This applies to: the /dev/urandom device, the get_random_bytes function,
+ * and the get_random_{u32,u64,int,long} family of functions. Using any of
+ * these functions without first calling this function forfeits the guaran=
tee
+ * of security.
+ *
+ * Return:
+ * * 0 if the LRNG has been seeded.
+ * * -ERESTARTSYS if the function was interrupted by a signal.
+ */
+int wait_for_random_bytes(void)
+{
+	if (likely(lrng_state_min_seeded()))
+		return 0;
+	return wait_event_interruptible(lrng_init_wait,
+					lrng_state_min_seeded());
+}
+EXPORT_SYMBOL(wait_for_random_bytes);
+
+/**
+ * get_random_bytes_arch() - This function will use the architecture-speci=
fic
+ * hardware random number generator if it is available.
+ *
+ * The arch-specific hw RNG will almost certainly be faster than what we c=
an
+ * do in software, but it is impossible to verify that it is implemented
+ * securely (as opposed, to, say, the AES encryption of a sequence number =
using
+ * a key known by the NSA).  So it's useful if we need the speed, but only=
 if
+ * we're willing to trust the hardware manufacturer not to have put in a b=
ack
+ * door.
+ *
+ * @buf: buffer allocated by caller to store the random data in
+ * @nbytes: length of outbuf
+ *
+ * Return: number of bytes filled in.
+ */
+int __must_check get_random_bytes_arch(void *buf, int nbytes)
+{
+	u8 *p =3D buf;
+
+	while (nbytes) {
+		unsigned long v;
+		int chunk =3D min_t(int, nbytes, sizeof(unsigned long));
+
+		if (!arch_get_random_long(&v))
+			break;
+
+		memcpy(p, &v, chunk);
+		p +=3D chunk;
+		nbytes -=3D chunk;
+	}
+
+	if (nbytes)
+		lrng_drng_get_atomic((u8 *)p, (u32)nbytes);
+
+	return nbytes;
+}
+EXPORT_SYMBOL(get_random_bytes_arch);
+
+/*
+ * Returns whether or not the LRNG has been seeded.
+ *
+ * Returns: true if the urandom pool has been seeded.
+ *          false if the urandom pool has not been seeded.
+ */
+bool rng_is_initialized(void)
+{
+	return lrng_state_operational();
+}
+EXPORT_SYMBOL(rng_is_initialized);
+
+/************************ LRNG user output interfaces ********************=
*****/
+
+static ssize_t lrng_read_common(char __user *buf, size_t nbytes)
+{
+	ssize_t ret =3D 0;
+	u8 tmpbuf[LRNG_DRNG_BLOCKSIZE] __aligned(LRNG_KCAPI_ALIGN);
+	u8 *tmp_large =3D NULL, *tmp =3D tmpbuf;
+	u32 tmplen =3D sizeof(tmpbuf);
+
+	if (nbytes =3D=3D 0)
+		return 0;
+
+	/*
+	 * Satisfy large read requests -- as the common case are smaller
+	 * request sizes, such as 16 or 32 bytes, avoid a kmalloc overhead for
+	 * those by using the stack variable of tmpbuf.
+	 */
+	if (!CONFIG_BASE_SMALL && (nbytes > sizeof(tmpbuf))) {
+		tmplen =3D min_t(u32, nbytes, LRNG_DRNG_MAX_REQSIZE);
+		tmp_large =3D kmalloc(tmplen + LRNG_KCAPI_ALIGN, GFP_KERNEL);
+		if (!tmp_large)
+			tmplen =3D sizeof(tmpbuf);
+		else
+			tmp =3D PTR_ALIGN(tmp_large, LRNG_KCAPI_ALIGN);
+	}
+
+	while (nbytes) {
+		u32 todo =3D min_t(u32, nbytes, tmplen);
+		int rc =3D 0;
+
+		/* Reschedule if we received a large request. */
+		if ((tmp_large) && need_resched()) {
+			if (signal_pending(current)) {
+				if (ret =3D=3D 0)
+					ret =3D -ERESTARTSYS;
+				break;
+			}
+			schedule();
+		}
+
+		rc =3D lrng_drng_get_sleep(tmp, todo);
+		if (rc <=3D 0) {
+			if (rc < 0)
+				ret =3D rc;
+			break;
+		}
+		if (copy_to_user(buf, tmp, rc)) {
+			ret =3D -EFAULT;
+			break;
+		}
+
+		nbytes -=3D rc;
+		buf +=3D rc;
+		ret +=3D rc;
+	}
+
+	/* Wipe data just returned from memory */
+	if (tmp_large)
+		kfree_sensitive(tmp_large);
+	else
+		memzero_explicit(tmpbuf, sizeof(tmpbuf));
+
+	return ret;
+}
+
+static ssize_t
+lrng_read_common_block(int nonblock, char __user *buf, size_t nbytes)
+{
+	if (nbytes =3D=3D 0)
+		return 0;
+
+	if (unlikely(!lrng_state_operational())) {
+		int ret;
+
+		if (nonblock)
+			return -EAGAIN;
+
+		ret =3D wait_event_interruptible(lrng_init_wait,
+					       lrng_state_operational());
+		if (unlikely(ret))
+			return ret;
+	}
+
+	return lrng_read_common(buf, nbytes);
+}
+
+static ssize_t lrng_drng_read_block(struct file *file, char __user *buf,
+				     size_t nbytes, loff_t *ppos)
+{
+	return lrng_read_common_block(file->f_flags & O_NONBLOCK, buf, nbytes);
+}
+
+static __poll_t lrng_random_poll(struct file *file, poll_table *wait)
+{
+	__poll_t mask;
+
+	poll_wait(file, &lrng_init_wait, wait);
+	poll_wait(file, &lrng_write_wait, wait);
+	mask =3D 0;
+	if (lrng_state_operational())
+		mask |=3D EPOLLIN | EPOLLRDNORM;
+	if (lrng_need_entropy() ||
+	    lrng_state_exseed_allow(lrng_noise_source_user))
+		mask |=3D EPOLLOUT | EPOLLWRNORM;
+	return mask;
+}
+
+static ssize_t lrng_drng_write_common(const char __user *buffer, size_t co=
unt,
+				      u32 entropy_bits)
+{
+	ssize_t ret =3D 0;
+	u8 buf[64] __aligned(LRNG_KCAPI_ALIGN);
+	const char __user *p =3D buffer;
+	u32 orig_entropy_bits =3D entropy_bits;
+
+	if (!lrng_get_available())
+		return -EAGAIN;
+
+	count =3D min_t(size_t, count, INT_MAX);
+	while (count > 0) {
+		size_t bytes =3D min_t(size_t, count, sizeof(buf));
+		u32 ent =3D min_t(u32, bytes<<3, entropy_bits);
+
+		if (copy_from_user(&buf, p, bytes))
+			return -EFAULT;
+		/* Inject data into entropy pool */
+		lrng_pool_insert_aux(buf, bytes, ent);
+
+		count -=3D bytes;
+		p +=3D bytes;
+		ret +=3D bytes;
+		entropy_bits -=3D ent;
+
+		cond_resched();
+	}
+
+	/* Force reseed of DRNG during next data request. */
+	if (!orig_entropy_bits)
+		lrng_drng_force_reseed();
+
+	return ret;
+}
+
+static ssize_t lrng_drng_read(struct file *file, char __user *buf,
+			      size_t nbytes, loff_t *ppos)
+{
+	if (!lrng_state_min_seeded())
+		pr_notice_ratelimited("%s - use of insufficiently seeded DRNG (%zu bytes=
 read)\n",
+				      current->comm, nbytes);
+	else if (!lrng_state_operational())
+		pr_debug_ratelimited("%s - use of not fully seeded DRNG (%zu bytes read)=
\n",
+				     current->comm, nbytes);
+
+	return lrng_read_common(buf, nbytes);
+}
+
+static ssize_t lrng_drng_write(struct file *file, const char __user *buffe=
r,
+			       size_t count, loff_t *ppos)
+{
+	return lrng_drng_write_common(buffer, count, 0);
+}
+
+static long lrng_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
+{
+	u32 digestsize_bits;
+	int size, ent_count_bits;
+	int __user *p =3D (int __user *)arg;
+
+	switch (cmd) {
+	case RNDGETENTCNT:
+		ent_count_bits =3D lrng_avail_entropy();
+		if (put_user(ent_count_bits, p))
+			return -EFAULT;
+		return 0;
+	case RNDADDTOENTCNT:
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+		if (get_user(ent_count_bits, p))
+			return -EFAULT;
+		ent_count_bits =3D (int)lrng_avail_entropy() + ent_count_bits;
+		if (ent_count_bits < 0)
+			ent_count_bits =3D 0;
+		digestsize_bits =3D lrng_get_digestsize();
+		if (ent_count_bits > digestsize_bits)
+			ent_count_bits =3D digestsize_bits;
+		lrng_pool_set_entropy(ent_count_bits);
+		return 0;
+	case RNDADDENTROPY:
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+		if (get_user(ent_count_bits, p++))
+			return -EFAULT;
+		if (ent_count_bits < 0)
+			return -EINVAL;
+		if (get_user(size, p++))
+			return -EFAULT;
+		if (size < 0)
+			return -EINVAL;
+		lrng_state_exseed_set(lrng_noise_source_user, false);
+		/* there cannot be more entropy than data */
+		ent_count_bits =3D min(ent_count_bits, size<<3);
+		return lrng_drng_write_common((const char __user *)p, size,
+					      ent_count_bits);
+	case RNDZAPENTCNT:
+	case RNDCLEARPOOL:
+		/* Clear the entropy pool counter. */
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+		lrng_pool_set_entropy(0);
+		return 0;
+	case RNDRESEEDCRNG:
+		/*
+		 * We leave the capability check here since it is present
+		 * in the upstream's RNG implementation. Yet, user space
+		 * can trigger a reseed as easy as writing into /dev/random
+		 * or /dev/urandom where no privilege is needed.
+		 */
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+		/* Force a reseed of all DRNGs */
+		lrng_drng_force_reseed();
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int lrng_fasync(int fd, struct file *filp, int on)
+{
+	return fasync_helper(fd, filp, on, &fasync);
+}
+
+const struct file_operations random_fops =3D {
+	.read  =3D lrng_drng_read_block,
+	.write =3D lrng_drng_write,
+	.poll  =3D lrng_random_poll,
+	.unlocked_ioctl =3D lrng_ioctl,
+	.compat_ioctl =3D compat_ptr_ioctl,
+	.fasync =3D lrng_fasync,
+	.llseek =3D noop_llseek,
+};
+
+const struct file_operations urandom_fops =3D {
+	.read  =3D lrng_drng_read,
+	.write =3D lrng_drng_write,
+	.unlocked_ioctl =3D lrng_ioctl,
+	.compat_ioctl =3D compat_ptr_ioctl,
+	.fasync =3D lrng_fasync,
+	.llseek =3D noop_llseek,
+};
+
+SYSCALL_DEFINE3(getrandom, char __user *, buf, size_t, count,
+		unsigned int, flags)
+{
+	if (flags & ~(GRND_NONBLOCK|GRND_RANDOM|GRND_INSECURE))
+		return -EINVAL;
+
+	/*
+	 * Requesting insecure and blocking randomness at the same time makes
+	 * no sense.
+	 */
+	if ((flags &
+	     (GRND_INSECURE|GRND_RANDOM)) =3D=3D (GRND_INSECURE|GRND_RANDOM))
+		return -EINVAL;
+
+	if (count > INT_MAX)
+		count =3D INT_MAX;
+
+	if (flags & GRND_INSECURE)
+		return lrng_drng_read(NULL, buf, count, NULL);
+
+	return lrng_read_common_block(flags & GRND_NONBLOCK, buf, count);
+}
diff --git a/drivers/char/lrng/lrng_internal.h b/drivers/char/lrng/lrng_int=
ernal.h
new file mode 100644
index 000000000000..37edbf98452e
=2D-- /dev/null
+++ b/drivers/char/lrng/lrng_internal.h
@@ -0,0 +1,443 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/*
+ * Copyright (C) 2018 - 2021, Stephan Mueller <smueller@chronox.de>
+ */
+
+#ifndef _LRNG_INTERNAL_H
+#define _LRNG_INTERNAL_H
+
+#include <crypto/sha1.h>
+#include <crypto/sha2.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+/*************************** General LRNG parameter **********************=
*****/
+
+/* Security strength of LRNG -- this must match DRNG security strength */
+#define LRNG_DRNG_SECURITY_STRENGTH_BYTES 32
+#define LRNG_DRNG_SECURITY_STRENGTH_BITS (LRNG_DRNG_SECURITY_STRENGTH_BYTE=
S * 8)
+#define LRNG_DRNG_BLOCKSIZE 64		/* Maximum of DRNG block sizes */
+
+/*
+ * SP800-90A defines a maximum request size of 1<<16 bytes. The given valu=
e is
+ * considered a safer margin.
+ *
+ * This value is allowed to be changed.
+ */
+#define LRNG_DRNG_MAX_REQSIZE		(1<<12)
+
+/*
+ * SP800-90A defines a maximum number of requests between reseeds of 2^48.
+ * The given value is considered a much safer margin, balancing requests f=
or
+ * frequent reseeds with the need to conserve entropy. This value MUST NOT=
 be
+ * larger than INT_MAX because it is used in an atomic_t.
+ *
+ * This value is allowed to be changed.
+ */
+#define LRNG_DRNG_RESEED_THRESH		(1<<20)
+
+/*
+ * Number of interrupts to be recorded to assume that DRNG security streng=
th
+ * bits of entropy are received.
+ * Note: a value below the DRNG security strength should not be defined as=
 this
+ *	 may imply the DRNG can never be fully seeded in case other noise
+ *	 sources are unavailable.
+ *
+ * This value is allowed to be changed.
+ */
+#define LRNG_IRQ_ENTROPY_BITS		LRNG_DRNG_SECURITY_STRENGTH_BITS
+
+/*
+ * Min required seed entropy is 128 bits covering the minimum entropy
+ * requirement of SP800-131A and the German BSI's TR02102.
+ *
+ * This value is allowed to be changed.
+ */
+#define LRNG_FULL_SEED_ENTROPY_BITS	LRNG_DRNG_SECURITY_STRENGTH_BITS
+#define LRNG_MIN_SEED_ENTROPY_BITS	128
+#define LRNG_INIT_ENTROPY_BITS		32
+
+/*
+ * Wakeup value
+ *
+ * This value is allowed to be changed but must not be larger than the
+ * digest size of the hash operation used update the aux_pool.
+ */
+#ifdef CONFIG_CRYPTO_LIB_SHA256
+# define LRNG_ATOMIC_DIGEST_SIZE	SHA256_DIGEST_SIZE
+#else
+# define LRNG_ATOMIC_DIGEST_SIZE	SHA1_DIGEST_SIZE
+#endif
+#define LRNG_WRITE_WAKEUP_ENTROPY	LRNG_ATOMIC_DIGEST_SIZE
+
+/*
+ * If the switching support is configured, we must provide support up to
+ * the largest digest size. Without switching support, we know it is only
+ * the built-in digest size.
+ */
+#ifdef CONFIG_LRNG_DRNG_SWITCH
+# define LRNG_MAX_DIGESTSIZE		64
+#else
+# define LRNG_MAX_DIGESTSIZE		LRNG_ATOMIC_DIGEST_SIZE
+#endif
+
+/*
+ * Oversampling factor of IRQ events to obtain
+ * LRNG_DRNG_SECURITY_STRENGTH_BYTES. This factor is used when a
+ * high-resolution time stamp is not available. In this case, jiffies and
+ * register contents are used to fill the entropy pool. These noise sources
+ * are much less entropic than the high-resolution timer. The entropy cont=
ent
+ * is the entropy content assumed with LRNG_IRQ_ENTROPY_BITS divided by
+ * LRNG_IRQ_OVERSAMPLING_FACTOR.
+ *
+ * This value is allowed to be changed.
+ */
+#define LRNG_IRQ_OVERSAMPLING_FACTOR	10
+
+/* Alignmask that is intended to be identical to CRYPTO_MINALIGN */
+#define LRNG_KCAPI_ALIGN		ARCH_KMALLOC_MINALIGN
+
+/************************ Default DRNG implementation ********************=
*****/
+
+extern struct chacha20_state chacha20;
+extern const struct lrng_crypto_cb lrng_cc20_crypto_cb;
+void lrng_cc20_init_state(struct chacha20_state *state);
+
+/********************************** /proc ********************************=
*****/
+
+static inline void lrng_pool_inc_numa_node(void) { }
+
+/****************************** LRNG interfaces **************************=
*****/
+
+extern u32 lrng_write_wakeup_bits;
+extern int lrng_drng_reseed_max_time;
+
+void lrng_writer_wakeup(void);
+void lrng_init_wakeup(void);
+void lrng_debug_report_seedlevel(const char *name);
+void lrng_process_ready_list(void);
+
+/* External interface to use of the switchable DRBG inside the kernel */
+void get_random_bytes_full(void *buf, int nbytes);
+
+/************************** Jitter RNG Noise Source **********************=
*****/
+
+#ifdef CONFIG_LRNG_JENT
+u32 lrng_get_jent(u8 *outbuf, u32 requested_bits);
+u32 lrng_jent_entropylevel(u32 requested_bits);
+#else /* CONFIG_CRYPTO_JITTERENTROPY */
+static inline u32 lrng_get_jent(u8 *outbuf, u32 requested_bits) { return 0=
; }
+static inline u32 lrng_jent_entropylevel(u32 requested_bits) { return 0; }
+#endif /* CONFIG_CRYPTO_JITTERENTROPY */
+
+/*************************** CPU-based Noise Source **********************=
*****/
+
+static inline u32 lrng_fast_noise_entropylevel(u32 ent_bits, u32 requested=
_bits)
+{
+	/* Obtain entropy statement */
+	ent_bits =3D ent_bits * requested_bits / LRNG_DRNG_SECURITY_STRENGTH_BITS;
+	/* Cap entropy to buffer size in bits */
+	ent_bits =3D min_t(u32, ent_bits, requested_bits);
+	return ent_bits;
+}
+
+u32 lrng_get_arch(u8 *outbuf, u32 requested_bits);
+u32 lrng_archrandom_entropylevel(u32 requested_bits);
+
+static inline u32 lrng_slow_noise_req_entropy(u32 requested_bits)
+{
+	u32 ent_bits =3D lrng_archrandom_entropylevel(requested_bits) +
+		       lrng_jent_entropylevel(requested_bits);
+
+	return (ent_bits > requested_bits) ? 0 : (requested_bits - ent_bits);
+}
+
+/****************************** DRNG processing **************************=
*****/
+
+/* DRNG state handle */
+struct lrng_drng {
+	void *drng;				/* DRNG handle */
+	void *hash;				/* Hash handle */
+	const struct lrng_crypto_cb *crypto_cb;	/* Crypto callbacks */
+	atomic_t requests;			/* Number of DRNG requests */
+	unsigned long last_seeded;		/* Last time it was seeded */
+	bool fully_seeded;			/* Is DRNG fully seeded? */
+	bool force_reseed;			/* Force a reseed */
+
+	/* Lock write operations on DRNG state, DRNG replacement of crypto_cb */
+	struct mutex lock;
+	spinlock_t spin_lock;
+	/* Lock *hash replacement - always take before DRNG lock */
+	rwlock_t hash_lock;
+};
+
+extern struct mutex lrng_crypto_cb_update;
+
+struct lrng_drng *lrng_drng_init_instance(void);
+struct lrng_drng *lrng_drng_atomic_instance(void);
+
+static __always_inline bool lrng_drng_is_atomic(struct lrng_drng *drng)
+{
+	return (drng->drng =3D=3D lrng_drng_atomic_instance()->drng);
+}
+
+/* Lock the DRNG */
+static __always_inline void lrng_drng_lock(struct lrng_drng *drng,
+					   unsigned long *flags)
+	__acquires(&drng->spin_lock)
+{
+	/* Use spin lock in case the atomic DRNG context is used */
+	if (lrng_drng_is_atomic(drng)) {
+		spin_lock_irqsave(&drng->spin_lock, *flags);
+
+		/*
+		 * In case a lock transition happened while we were spinning,
+		 * catch this case and use the new lock type.
+		 */
+		if (!lrng_drng_is_atomic(drng)) {
+			spin_unlock_irqrestore(&drng->spin_lock, *flags);
+			__acquire(&drng->spin_lock);
+			mutex_lock(&drng->lock);
+		}
+	} else {
+		__acquire(&drng->spin_lock);
+		mutex_lock(&drng->lock);
+	}
+}
+
+/* Unlock the DRNG */
+static __always_inline void lrng_drng_unlock(struct lrng_drng *drng,
+					     unsigned long *flags)
+	__releases(&drng->spin_lock)
+{
+	if (lrng_drng_is_atomic(drng)) {
+		spin_unlock_irqrestore(&drng->spin_lock, *flags);
+	} else {
+		mutex_unlock(&drng->lock);
+		__release(&drng->spin_lock);
+	}
+}
+
+void lrng_reset(void);
+void lrng_drngs_init_cc20(bool force_seed);
+bool lrng_sp80090c_compliant(void);
+bool lrng_get_available(void);
+void lrng_set_available(void);
+void lrng_drng_reset(struct lrng_drng *drng);
+int lrng_drng_get_atomic(u8 *outbuf, u32 outbuflen);
+int lrng_drng_get_sleep(u8 *outbuf, u32 outbuflen);
+void lrng_drng_force_reseed(void);
+void lrng_drng_seed_work(struct work_struct *dummy);
+
+static inline struct lrng_drng **lrng_drng_instances(void) { return NULL; }
+static inline void lrng_drngs_numa_alloc(void) { return; }
+
+/************************** Entropy pool management **********************=
*****/
+
+enum lrng_external_noise_source {
+	lrng_noise_source_hw,
+	lrng_noise_source_user
+};
+
+/* Status information about IRQ noise source */
+struct lrng_irq_info {
+	atomic_t num_events_thresh;	/* Reseed threshold */
+	atomic_t reseed_in_progress;	/* Flag for on executing reseed */
+	bool irq_highres_timer;	/* Is high-resolution timer available? */
+	u32 irq_entropy_bits;	/* LRNG_IRQ_ENTROPY_BITS? */
+};
+
+/*
+ * This is the entropy pool used by the slow noise source. Its size should
+ * be at least as large as LRNG_DRNG_SECURITY_STRENGTH_BITS.
+ *
+ * The aux pool array is aligned to 8 bytes to comfort the kernel crypto A=
PI
+ * cipher implementations of the hash functions used to read the pool: for=
 some
+ * accelerated implementations, we need an alignment to avoid a realignment
+ * which involves memcpy(). The alignment to 8 bytes should satisfy all cr=
ypto
+ * implementations.
+ */
+struct lrng_pool {
+	/*
+	 * Storage for aux data - hash output buffer
+	 */
+	u8 aux_pool[LRNG_MAX_DIGESTSIZE];
+	atomic_t aux_entropy_bits;
+	/* All NUMA DRNGs seeded? */
+	bool all_online_numa_node_seeded;
+
+	/* Digest size of used hash */
+	atomic_t digestsize;
+	/* IRQ noise source status info */
+	struct lrng_irq_info irq_info;
+
+	/* Serialize read of entropy pool and update of aux pool */
+	spinlock_t lock;
+};
+
+u32 lrng_entropy_to_data(u32 entropy_bits);
+u32 lrng_data_to_entropy(u32 irqnum);
+u32 lrng_avail_aux_entropy(void);
+void lrng_set_digestsize(u32 digestsize);
+u32 lrng_get_digestsize(void);
+
+/* Obtain the security strength of the LRNG in bits */
+static inline u32 lrng_security_strength(void)
+{
+	/*
+	 * We use a hash to read the entropy in the entropy pool. According to
+	 * SP800-90B table 1, the entropy can be at most the digest size.
+	 * Considering this together with the last sentence in section 3.1.5.1.2
+	 * the security strength of a (approved) hash is equal to its output
+	 * size. On the other hand the entropy cannot be larger than the
+	 * security strength of the used DRBG.
+	 */
+	return min_t(u32, LRNG_FULL_SEED_ENTROPY_BITS,
+		     lrng_get_digestsize());
+}
+
+void lrng_set_entropy_thresh(u32 new);
+void lrng_update_entropy_thresh(u32 new_entropy_bits);
+void lrng_reset_state(void);
+
+bool lrng_pcpu_continuous_compression_state(void);
+void lrng_pcpu_check_compression_state(void);
+void lrng_pcpu_reset(void);
+u32 lrng_pcpu_avail_pool_size(void);
+u32 lrng_pcpu_avail_irqs(void);
+
+static inline u32 lrng_pcpu_avail_entropy(void)
+{
+	return lrng_data_to_entropy(lrng_pcpu_avail_irqs());
+}
+
+static inline u32 lrng_avail_entropy(void)
+{
+	return lrng_pcpu_avail_entropy() + lrng_avail_aux_entropy();
+}
+
+int lrng_pcpu_switch_hash(int node,
+			  const struct lrng_crypto_cb *new_cb, void *new_hash,
+			  const struct lrng_crypto_cb *old_cb);
+u32 lrng_pcpu_pool_hash(u8 *outbuf, u32 requested_bits, bool fully_seeded);
+void lrng_pcpu_array_add_u32(u32 data);
+
+bool lrng_state_exseed_allow(enum lrng_external_noise_source source);
+void lrng_state_exseed_set(enum lrng_external_noise_source source, bool ty=
pe);
+void lrng_state_init_seed_work(void);
+bool lrng_state_min_seeded(void);
+bool lrng_state_fully_seeded(void);
+bool lrng_state_operational(void);
+
+int lrng_pool_trylock(void);
+void lrng_pool_unlock(void);
+void lrng_pool_all_numa_nodes_seeded(void);
+bool lrng_pool_highres_timer(void);
+void lrng_pool_set_entropy(u32 entropy_bits);
+int lrng_pool_insert_aux(const u8 *inbuf, u32 inbuflen, u32 entropy_bits);
+void lrng_pool_add_irq(void);
+
+struct entropy_buf {
+	u8 a[LRNG_DRNG_SECURITY_STRENGTH_BYTES +
+	     (CONFIG_LRNG_SEED_BUFFER_INIT_ADD_BITS >> 3)];
+	u8 b[LRNG_DRNG_SECURITY_STRENGTH_BYTES +
+	     (CONFIG_LRNG_SEED_BUFFER_INIT_ADD_BITS >> 3)];
+	u8 c[LRNG_DRNG_SECURITY_STRENGTH_BYTES +
+	     (CONFIG_LRNG_SEED_BUFFER_INIT_ADD_BITS >> 3)];
+	u8 d[LRNG_DRNG_SECURITY_STRENGTH_BYTES +
+	     (CONFIG_LRNG_SEED_BUFFER_INIT_ADD_BITS >> 3)];
+	u32 now, a_bits, b_bits, c_bits, d_bits;
+};
+
+void lrng_fill_seed_buffer(struct entropy_buf *entropy_buf, u32 requested_=
bits);
+void lrng_init_ops(struct entropy_buf *eb);
+
+/************************** Health Test linking code *********************=
*****/
+
+enum lrng_health_res {
+	lrng_health_pass,		/* Health test passes on time stamp */
+	lrng_health_fail_use,		/* Time stamp unhealthy, but mix in */
+	lrng_health_fail_drop		/* Time stamp unhealthy, drop it */
+};
+
+#ifdef CONFIG_LRNG_HEALTH_TESTS
+bool lrng_sp80090b_startup_complete(void);
+bool lrng_sp80090b_compliant(void);
+
+enum lrng_health_res lrng_health_test(u32 now_time);
+void lrng_health_disable(void);
+
+#else	/* CONFIG_LRNG_HEALTH_TESTS */
+static inline bool lrng_sp80090b_startup_complete(void) { return true; }
+static inline bool lrng_sp80090b_compliant(void) { return false; }
+
+static inline enum lrng_health_res
+lrng_health_test(u32 now_time) { return lrng_health_pass; }
+static inline void lrng_health_disable(void) { }
+#endif	/* CONFIG_LRNG_HEALTH_TESTS */
+
+/****************************** Helper code ******************************=
*****/
+
+static inline u32 atomic_read_u32(atomic_t *v)
+{
+	return (u32)atomic_read(v);
+}
+
+/*************************** Auxiliary functions *************************=
*****/
+
+void invalidate_batched_entropy(void);
+
+/***************************** Testing code ******************************=
*****/
+
+#ifdef CONFIG_LRNG_RAW_HIRES_ENTROPY
+bool lrng_raw_hires_entropy_store(u32 value);
+#else	/* CONFIG_LRNG_RAW_HIRES_ENTROPY */
+static inline bool lrng_raw_hires_entropy_store(u32 value) { return false;=
 }
+#endif	/* CONFIG_LRNG_RAW_HIRES_ENTROPY */
+
+#ifdef CONFIG_LRNG_RAW_JIFFIES_ENTROPY
+bool lrng_raw_jiffies_entropy_store(u32 value);
+#else	/* CONFIG_LRNG_RAW_JIFFIES_ENTROPY */
+static inline bool lrng_raw_jiffies_entropy_store(u32 value) { return fals=
e; }
+#endif	/* CONFIG_LRNG_RAW_JIFFIES_ENTROPY */
+
+#ifdef CONFIG_LRNG_RAW_IRQ_ENTROPY
+bool lrng_raw_irq_entropy_store(u32 value);
+#else	/* CONFIG_LRNG_RAW_IRQ_ENTROPY */
+static inline bool lrng_raw_irq_entropy_store(u32 value) { return false; }
+#endif	/* CONFIG_LRNG_RAW_IRQ_ENTROPY */
+
+#ifdef CONFIG_LRNG_RAW_IRQFLAGS_ENTROPY
+bool lrng_raw_irqflags_entropy_store(u32 value);
+#else	/* CONFIG_LRNG_RAW_IRQFLAGS_ENTROPY */
+static inline bool lrng_raw_irqflags_entropy_store(u32 value) { return fal=
se; }
+#endif	/* CONFIG_LRNG_RAW_IRQFLAGS_ENTROPY */
+
+#ifdef CONFIG_LRNG_RAW_RETIP_ENTROPY
+bool lrng_raw_retip_entropy_store(u32 value);
+#else	/* CONFIG_LRNG_RAW_RETIP_ENTROPY */
+static inline bool lrng_raw_retip_entropy_store(u32 value) { return false;=
 }
+#endif	/* CONFIG_LRNG_RAW_RETIP_ENTROPY */
+
+#ifdef CONFIG_LRNG_RAW_REGS_ENTROPY
+bool lrng_raw_regs_entropy_store(u32 value);
+#else	/* CONFIG_LRNG_RAW_REGS_ENTROPY */
+static inline bool lrng_raw_regs_entropy_store(u32 value) { return false; }
+#endif	/* CONFIG_LRNG_RAW_REGS_ENTROPY */
+
+#ifdef CONFIG_LRNG_RAW_ARRAY
+bool lrng_raw_array_entropy_store(u32 value);
+#else	/* CONFIG_LRNG_RAW_ARRAY */
+static inline bool lrng_raw_array_entropy_store(u32 value) { return false;=
 }
+#endif	/* CONFIG_LRNG_RAW_ARRAY */
+
+#ifdef CONFIG_LRNG_IRQ_PERF
+bool lrng_perf_time(u32 start);
+#else /* CONFIG_LRNG_IRQ_PERF */
+static inline bool lrng_perf_time(u32 start) { return false; }
+#endif /*CONFIG_LRNG_IRQ_PERF */
+
+#endif /* _LRNG_INTERNAL_H */
diff --git a/drivers/char/lrng/lrng_pool.c b/drivers/char/lrng/lrng_pool.c
new file mode 100644
index 000000000000..2a73f4d74d44
=2D-- /dev/null
+++ b/drivers/char/lrng/lrng_pool.c
@@ -0,0 +1,563 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/*
+ * LRNG Entropy pool management
+ *
+ * Copyright (C) 2016 - 2021, Stephan Mueller <smueller@chronox.de>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <asm/irq_regs.h>
+#include <linux/lrng.h>
+#include <linux/percpu.h>
+#include <linux/random.h>
+#include <linux/utsname.h>
+#include <linux/workqueue.h>
+
+#include "lrng_internal.h"
+#include "lrng_sw_noise.h"
+
+struct lrng_state {
+	bool lrng_operational;		/* Is DRNG operational? */
+	bool lrng_fully_seeded;		/* Is DRNG fully seeded? */
+	bool lrng_min_seeded;		/* Is DRNG minimally seeded? */
+
+	/*
+	 * To ensure that external entropy providers cannot dominate the
+	 * internal noise sources but yet cannot be dominated by internal
+	 * noise sources, the following booleans are intended to allow
+	 * external to provide seed once when a DRNG reseed occurs. This
+	 * triggering of external noise source is performed even when the
+	 * entropy pool has sufficient entropy.
+	 */
+	bool lrng_seed_hw;		/* Allow HW to provide seed */
+	bool lrng_seed_user;		/* Allow user space to provide seed */
+
+	struct work_struct lrng_seed_work;	/* (re)seed work queue */
+};
+
+static struct lrng_pool lrng_pool __aligned(LRNG_KCAPI_ALIGN) =3D {
+	.aux_entropy_bits	=3D ATOMIC_INIT(0),
+	.digestsize		=3D ATOMIC_INIT(LRNG_ATOMIC_DIGEST_SIZE),
+	.irq_info		=3D {
+		.irq_entropy_bits	=3D LRNG_IRQ_ENTROPY_BITS,
+		.num_events_thresh	=3D ATOMIC_INIT(LRNG_INIT_ENTROPY_BITS),
+		/* Sample IRQ pointer data at least during boot */
+		.irq_highres_timer	=3D false },
+	.lock			=3D __SPIN_LOCK_UNLOCKED(lrng_pool.lock)
+};
+
+static struct lrng_state lrng_state =3D { false, false, false, true, true =
};
+
+static u32 irq_entropy __read_mostly =3D LRNG_IRQ_ENTROPY_BITS;
+module_param(irq_entropy, uint, 0444);
+MODULE_PARM_DESC(irq_entropy,
+		 "How many interrupts must be collected for obtaining 256 bits of entrop=
y\n");
+
+/********************************** Helper *******************************=
****/
+
+/* External entropy provider is allowed to provide seed data */
+bool lrng_state_exseed_allow(enum lrng_external_noise_source source)
+{
+	if (source =3D=3D lrng_noise_source_hw)
+		return lrng_state.lrng_seed_hw;
+	return lrng_state.lrng_seed_user;
+}
+
+/* Enable / disable external entropy provider to furnish seed */
+void lrng_state_exseed_set(enum lrng_external_noise_source source, bool ty=
pe)
+{
+	if (source =3D=3D lrng_noise_source_hw)
+		lrng_state.lrng_seed_hw =3D type;
+	else
+		lrng_state.lrng_seed_user =3D type;
+}
+
+static inline void lrng_state_exseed_allow_all(void)
+{
+	lrng_state_exseed_set(lrng_noise_source_hw, true);
+	lrng_state_exseed_set(lrng_noise_source_user, true);
+}
+
+/* Initialize the seed work queue */
+void lrng_state_init_seed_work(void)
+{
+	INIT_WORK(&lrng_state.lrng_seed_work, lrng_drng_seed_work);
+}
+
+/* Convert entropy in bits into number of IRQs with the same entropy conte=
nt. */
+u32 lrng_entropy_to_data(u32 entropy_bits)
+{
+	return ((entropy_bits * lrng_pool.irq_info.irq_entropy_bits) /
+		LRNG_DRNG_SECURITY_STRENGTH_BITS);
+}
+
+/* Convert number of IRQs into entropy value. */
+u32 lrng_data_to_entropy(u32 irqnum)
+{
+	return ((irqnum * LRNG_DRNG_SECURITY_STRENGTH_BITS) /
+		lrng_pool.irq_info.irq_entropy_bits);
+}
+
+/* Entropy in bits present in aux pool */
+u32 lrng_avail_aux_entropy(void)
+{
+	/* Cap available entropy with max entropy */
+	return min_t(u32, atomic_read_u32(&lrng_pool.digestsize) << 3,
+		     atomic_read_u32(&lrng_pool.aux_entropy_bits));
+}
+
+/* Set the digest size of the used hash in bytes */
+void lrng_set_digestsize(u32 digestsize)
+{
+	struct lrng_pool *pool =3D &lrng_pool;
+	u32 ent_bits =3D atomic_xchg_relaxed(&pool->aux_entropy_bits, 0),
+	    old_digestsize =3D lrng_get_digestsize();
+
+	atomic_set(&lrng_pool.digestsize, digestsize);
+
+	/*
+	 * In case the new digest is larger than the old one, cap the available
+	 * entropy to the old message digest used to process the existing data.
+	 */
+	ent_bits =3D min_t(u32, ent_bits, old_digestsize);
+	atomic_add(ent_bits, &pool->aux_entropy_bits);
+}
+
+/* Obtain the digest size provided by the used hash in bits */
+u32 lrng_get_digestsize(void)
+{
+	return atomic_read_u32(&lrng_pool.digestsize) << 3;
+}
+
+/* Set new entropy threshold for reseeding during boot */
+void lrng_set_entropy_thresh(u32 new_entropy_bits)
+{
+	atomic_set(&lrng_pool.irq_info.num_events_thresh,
+		   lrng_entropy_to_data(new_entropy_bits));
+}
+
+/* Update the seeding threshold new entropy from external sources arrives =
*/
+void lrng_update_entropy_thresh(u32 new_entropy_bits)
+{
+	if (unlikely(!lrng_state_fully_seeded()) && new_entropy_bits) {
+		/* if data arrive before fully seeded, lower trigger point */
+		struct lrng_irq_info *irq_info =3D &lrng_pool.irq_info;
+		u32 thresh =3D atomic_read_u32(&irq_info->num_events_thresh);
+		u32 new_irqs =3D lrng_entropy_to_data(new_entropy_bits);
+
+		thresh =3D new_irqs > thresh ? 0 : thresh - new_irqs;
+		atomic_set(&irq_info->num_events_thresh, thresh);
+	}
+}
+
+/*
+ * Reading of the LRNG pool is only allowed by one caller. The reading is
+ * only performed to (re)seed DRNGs. Thus, if this "lock" is already taken,
+ * the reseeding operation is in progress. The caller is not intended to w=
ait
+ * but continue with its other operation.
+ */
+int lrng_pool_trylock(void)
+{
+	return atomic_cmpxchg(&lrng_pool.irq_info.reseed_in_progress, 0, 1);
+}
+
+void lrng_pool_unlock(void)
+{
+	atomic_set(&lrng_pool.irq_info.reseed_in_progress, 0);
+}
+
+/*
+ * Reset LRNG state - the entropy counters are reset, but the data that may
+ * or may not have entropy remains in the pools as this data will not hurt.
+ */
+void lrng_reset_state(void)
+{
+	atomic_set(&lrng_pool.aux_entropy_bits, 0);
+	lrng_pcpu_reset();
+	lrng_state.lrng_operational =3D false;
+	lrng_state.lrng_fully_seeded =3D false;
+	lrng_state.lrng_min_seeded =3D false;
+	lrng_pool.all_online_numa_node_seeded =3D false;
+	pr_debug("reset LRNG\n");
+}
+
+/* Set flag that all DRNGs are fully seeded */
+void lrng_pool_all_numa_nodes_seeded(void)
+{
+	lrng_pool.all_online_numa_node_seeded =3D true;
+}
+
+/* Return boolean whether LRNG reached minimally seed level */
+bool lrng_state_min_seeded(void)
+{
+	return lrng_state.lrng_min_seeded;
+}
+
+/* Return boolean whether LRNG reached fully seed level */
+bool lrng_state_fully_seeded(void)
+{
+	return lrng_state.lrng_fully_seeded;
+}
+
+/* Return boolean whether LRNG is considered fully operational */
+bool lrng_state_operational(void)
+{
+	return lrng_state.lrng_operational;
+}
+
+/* Return boolean whether LRNG identified presence of high-resolution time=
r */
+bool lrng_pool_highres_timer(void)
+{
+	return lrng_pool.irq_info.irq_highres_timer;
+}
+
+/* Set entropy content in user-space controllable aux pool */
+void lrng_pool_set_entropy(u32 entropy_bits)
+{
+	atomic_set(&lrng_pool.aux_entropy_bits, entropy_bits);
+}
+
+static void lrng_pool_configure(bool highres_timer, u32 irq_entropy_bits)
+{
+	struct lrng_irq_info *irq_info =3D &lrng_pool.irq_info;
+
+	irq_info->irq_highres_timer =3D highres_timer;
+	if (irq_info->irq_entropy_bits !=3D irq_entropy_bits) {
+		irq_info->irq_entropy_bits =3D irq_entropy_bits;
+		/* Reset the threshold based on new oversampling factor. */
+		lrng_set_entropy_thresh(atomic_read_u32(
+						&irq_info->num_events_thresh));
+	}
+}
+
+static int __init lrng_init_time_source(void)
+{
+	/* Set a minimum number of interrupts that must be collected */
+	irq_entropy =3D max_t(u32, LRNG_IRQ_ENTROPY_BITS, irq_entropy);
+
+	if ((random_get_entropy() & LRNG_DATA_SLOTSIZE_MASK) ||
+	    (random_get_entropy() & LRNG_DATA_SLOTSIZE_MASK)) {
+		/*
+		 * As the highres timer is identified here, previous interrupts
+		 * obtained during boot time are treated like a lowres-timer
+		 * would have been present.
+		 */
+		lrng_pool_configure(true, irq_entropy);
+	} else {
+		lrng_health_disable();
+		lrng_pool_configure(false, irq_entropy *
+					   LRNG_IRQ_OVERSAMPLING_FACTOR);
+		pr_warn("operating without high-resolution timer and applying IRQ oversa=
mpling factor %u\n",
+			LRNG_IRQ_OVERSAMPLING_FACTOR);
+		lrng_pcpu_check_compression_state();
+	}
+
+	return 0;
+}
+
+core_initcall(lrng_init_time_source);
+
+/**
+ * lrng_init_ops() - Set seed stages of LRNG
+ *
+ * Set the slow noise source reseed trigger threshold. The initial thresho=
ld
+ * is set to the minimum data size that can be read from the pool: a word.=
 Upon
+ * reaching this value, the next seed threshold of 128 bits is set followed
+ * by 256 bits.
+ *
+ * @eb: buffer containing the size of entropy currently injected into DRNG
+ */
+void lrng_init_ops(struct entropy_buf *eb)
+{
+	struct lrng_state *state =3D &lrng_state;
+	u32 requested_bits, seed_bits, external_es, osr_bits;
+
+	if (state->lrng_operational)
+		return;
+
+	requested_bits =3D lrng_security_strength();
+	if (lrng_sp80090c_compliant())
+		requested_bits =3D CONFIG_LRNG_SEED_BUFFER_INIT_ADD_BITS;
+
+	/* Entropy provided by external entropy sources. */
+	external_es =3D eb->a_bits + eb->c_bits + eb->d_bits;
+	seed_bits =3D external_es + eb->b_bits;
+	osr_bits =3D lrng_sp80090c_compliant() ?
+					CONFIG_LRNG_OVERSAMPLE_ES_BITS : 0;
+
+	/* DRNG is seeded with full security strength */
+	if (state->lrng_fully_seeded) {
+		state->lrng_operational =3D lrng_sp80090b_startup_complete();
+		state->lrng_operational |=3D (requested_bits <=3D external_es);
+		lrng_process_ready_list();
+		lrng_init_wakeup();
+	} else if (seed_bits >=3D requested_bits) {
+		invalidate_batched_entropy();
+		state->lrng_fully_seeded =3D true;
+		state->lrng_operational =3D lrng_sp80090b_startup_complete();
+		state->lrng_operational |=3D (requested_bits <=3D external_es);
+		state->lrng_min_seeded =3D true;
+		pr_info("LRNG fully seeded with %u bits of entropy\n",
+			seed_bits);
+		lrng_set_entropy_thresh(requested_bits + osr_bits);
+		lrng_process_ready_list();
+		lrng_init_wakeup();
+
+	} else if (!state->lrng_min_seeded) {
+
+		/* DRNG is seeded with at least 128 bits of entropy */
+		if (seed_bits >=3D LRNG_MIN_SEED_ENTROPY_BITS) {
+			invalidate_batched_entropy();
+			state->lrng_min_seeded =3D true;
+			pr_info("LRNG minimally seeded with %u bits of entropy\n",
+				seed_bits);
+			lrng_set_entropy_thresh(
+				lrng_slow_noise_req_entropy(
+					lrng_security_strength() + osr_bits));
+			lrng_process_ready_list();
+			lrng_init_wakeup();
+
+		/* DRNG is seeded with at least LRNG_INIT_ENTROPY_BITS bits */
+		} else if (seed_bits >=3D LRNG_INIT_ENTROPY_BITS) {
+			pr_info("LRNG initial entropy level %u bits of entropy\n",
+				seed_bits);
+			lrng_set_entropy_thresh(
+				lrng_slow_noise_req_entropy(
+					LRNG_MIN_SEED_ENTROPY_BITS + osr_bits));
+		}
+	}
+}
+
+int __init rand_initialize(void)
+{
+	struct seed {
+		ktime_t time;
+		unsigned long data[(LRNG_MAX_DIGESTSIZE /
+				    sizeof(unsigned long))];
+		struct new_utsname utsname;
+	} seed __aligned(LRNG_KCAPI_ALIGN);
+	unsigned int i;
+
+	BUILD_BUG_ON(LRNG_MAX_DIGESTSIZE % sizeof(unsigned long));
+
+	seed.time =3D ktime_get_real();
+
+	for (i =3D 0; i < ARRAY_SIZE(seed.data); i++) {
+		if (!arch_get_random_seed_long_early(&(seed.data[i])) &&
+		    !arch_get_random_long_early(&seed.data[i]))
+			seed.data[i] =3D random_get_entropy();
+	}
+	memcpy(&seed.utsname, utsname(), sizeof(*(utsname())));
+
+	lrng_pool_insert_aux((u8 *)&seed, sizeof(seed), 0);
+	memzero_explicit(&seed, sizeof(seed));
+
+	lrng_drngs_init_cc20(true);
+	invalidate_batched_entropy();
+
+	return 0;
+}
+
+/*
+ * Insert data into auxiliary pool by hashing the input data together with
+ * the auxiliary pool. The message digest is the new state of the auxiliary
+ * pool.
+ */
+static int
+lrng_pool_insert_aux_locked(const u8 *inbuf, u32 inbuflen, u32 entropy_bit=
s)
+{
+	SHASH_DESC_ON_STACK(shash, NULL);
+	struct lrng_drng *drng =3D lrng_drng_init_instance();
+	const struct lrng_crypto_cb *crypto_cb;
+	struct lrng_pool *pool =3D &lrng_pool;
+	unsigned long flags;
+	void *hash;
+	u32 digestsize;
+	int ret;
+
+	if (entropy_bits > (inbuflen << 3))
+		entropy_bits =3D (inbuflen << 3);
+
+	read_lock_irqsave(&drng->hash_lock, flags);
+
+	crypto_cb =3D drng->crypto_cb;
+	hash =3D drng->hash;
+	digestsize =3D crypto_cb->lrng_hash_digestsize(hash);
+
+	ret =3D crypto_cb->lrng_hash_init(shash, hash) ?:
+	      /* Hash auxiliary pool ... */
+	      crypto_cb->lrng_hash_update(shash, pool->aux_pool, digestsize) ?:
+	      /* ... together with input data ... */
+	      crypto_cb->lrng_hash_update(shash, inbuf, inbuflen) ?:
+	      /* ... to form mew auxiliary pool state. */
+	      crypto_cb->lrng_hash_final(shash, pool->aux_pool);
+	if (ret)
+		goto out;
+
+	/*
+	 * Cap the available entropy to the hash output size compliant to
+	 * SP800-90B section 3.1.5.1 table 1.
+	 */
+	entropy_bits +=3D atomic_read_u32(&pool->aux_entropy_bits);
+	if (entropy_bits > digestsize << 3)
+		entropy_bits =3D digestsize << 3;
+	atomic_set(&pool->aux_entropy_bits, entropy_bits);
+
+out:
+	crypto_cb->lrng_hash_desc_zero(shash);
+	read_unlock_irqrestore(&drng->hash_lock, flags);
+
+	return ret;
+}
+
+int lrng_pool_insert_aux(const u8 *inbuf, u32 inbuflen, u32 entropy_bits)
+{
+	struct lrng_pool *pool =3D &lrng_pool;
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&pool->lock, flags);
+	ret =3D lrng_pool_insert_aux_locked(inbuf, inbuflen, entropy_bits);
+	spin_unlock_irqrestore(&pool->lock, flags);
+
+	lrng_update_entropy_thresh(entropy_bits);
+
+	return ret;
+}
+
+/* Hot code path during boot - mix data into entropy pool during boot */
+void lrng_pool_add_irq(void)
+{
+	/*
+	 * Once all DRNGs are fully seeded, the interrupt noise
+	 * sources will not trigger any reseeding any more.
+	 */
+	if (likely(lrng_pool.all_online_numa_node_seeded))
+		return;
+
+	/* Only try to reseed if the DRNG is alive. */
+	if (!lrng_get_available())
+		return;
+
+	/* Only trigger the DRNG reseed if we have collected enough IRQs. */
+	if (lrng_pcpu_avail_irqs() <
+	    atomic_read_u32(&lrng_pool.irq_info.num_events_thresh))
+		return;
+
+	/* Ensure that the seeding only occurs once at any given time. */
+	if (lrng_pool_trylock())
+		return;
+
+	/* Seed the DRNG with IRQ noise. */
+	schedule_work(&lrng_state.lrng_seed_work);
+}
+
+/************************* Get data from entropy pool ********************=
*****/
+
+/**
+ * Get auxiliary entropy pool and its entropy content for seed buffer.
+ * @outbuf: buffer to store data in with size requested_bits
+ * @requested_bits: Requested amount of entropy
+ * @return: amount of entropy in outbuf in bits.
+ */
+static inline u32 lrng_get_aux_pool(u8 *outbuf, u32 requested_bits)
+{
+	struct lrng_pool *pool =3D &lrng_pool;
+	u32 collected_ent_bits, returned_ent_bits, unused_bits =3D 0,
+	    osr_bits =3D lrng_sp80090c_compliant() ?
+					CONFIG_LRNG_OVERSAMPLE_ES_BITS : 0;
+
+	/* Ensure that no more than the size of aux_pool can be requested */
+	requested_bits =3D min_t(u32, requested_bits, (LRNG_MAX_DIGESTSIZE << 3));
+
+	/* Cap entropy with entropy counter from aux pool and the used digest */
+	collected_ent_bits =3D min_t(u32, lrng_get_digestsize(),
+			       atomic_xchg_relaxed(&pool->aux_entropy_bits, 0));
+
+	/* We collected too much entropy and put the overflow back */
+	if (collected_ent_bits > (requested_bits + osr_bits)) {
+		/* Amount of bits we collected too much */
+		unused_bits =3D collected_ent_bits - requested_bits;
+		/* Put entropy back */
+		atomic_add(unused_bits, &pool->aux_entropy_bits);
+		/* Fix collected entropy */
+		collected_ent_bits =3D requested_bits;
+	}
+
+	/* Apply oversampling: discount requested oversampling rate */
+	returned_ent_bits =3D (collected_ent_bits >=3D osr_bits) ?
+					(collected_ent_bits - osr_bits) : 0;
+
+	pr_debug("obtained %u bits by collecting %u bits of entropy from aux pool=
, %u bits of entropy remaining\n",
+		 returned_ent_bits, collected_ent_bits, unused_bits);
+
+	/*
+	 * Do not truncate the output size exactly to collected_ent_bits as
+	 * the aux pool may contain data that is not credited with entropy,
+	 * but we want to use them to stir the DRNG state.
+	 */
+	memcpy(outbuf, pool->aux_pool, requested_bits >> 3);
+
+	return returned_ent_bits;
+}
+
+/* Fill the seed buffer with data from the noise sources */
+void lrng_fill_seed_buffer(struct entropy_buf *entropy_buf, u32 requested_=
bits)
+{
+	struct lrng_pool *pool =3D &lrng_pool;
+	struct lrng_state *state =3D &lrng_state;
+	unsigned long flags;
+	u32 pcpu_request;
+
+	/* Guarantee that requested bits is a multiple of bytes */
+	BUILD_BUG_ON(LRNG_DRNG_SECURITY_STRENGTH_BITS % 8);
+
+	/* Require at least 128 bits of entropy for any reseed. */
+	if (state->lrng_fully_seeded &&
+	    (lrng_avail_entropy() <
+	     lrng_slow_noise_req_entropy(LRNG_MIN_SEED_ENTROPY_BITS)))
+		goto wakeup;
+
+	/* Ensure aux pool extraction and backtracking op are atomic */
+	spin_lock_irqsave(&pool->lock, flags);
+
+	/* Concatenate the output of the entropy sources. */
+	entropy_buf->a_bits =3D lrng_get_aux_pool(entropy_buf->a, requested_bits);
+
+	/*
+	 * If the aux pool returned entropy, pull respective less from per-CPU
+	 * pool, but attempt to at least get LRNG_MIN_SEED_ENTROPY_BITS entropy.
+	 */
+	pcpu_request =3D max_t(u32, requested_bits -
+			     entropy_buf->a_bits, LRNG_MIN_SEED_ENTROPY_BITS);
+	entropy_buf->b_bits =3D lrng_pcpu_pool_hash(entropy_buf->b, pcpu_request,
+						  state->lrng_fully_seeded);
+
+	entropy_buf->c_bits =3D lrng_get_arch(entropy_buf->c, requested_bits);
+	entropy_buf->d_bits =3D lrng_get_jent(entropy_buf->d, requested_bits);
+
+	/* also reseed the DRNG with the current time stamp */
+	entropy_buf->now =3D random_get_entropy();
+
+	/* Mix the extracted data back into pool for backtracking resistance */
+	if (lrng_pool_insert_aux_locked((u8 *)entropy_buf,
+					sizeof(struct entropy_buf), 0))
+		pr_warn("Backtracking resistance operation failed\n");
+
+	spin_unlock_irqrestore(&pool->lock, flags);
+
+	/* allow external entropy provider to provide seed */
+	lrng_state_exseed_allow_all();
+
+wakeup:
+	/*
+	 * Shall we wake up user space writers? This location covers
+	 * ensures that the user space provider does not dominate the internal
+	 * noise sources since in case the first call of this function finds
+	 * sufficient entropy in the entropy pool, it will not trigger the
+	 * wakeup. This implies that when the next /dev/urandom read happens,
+	 * the entropy pool is drained.
+	 */
+	lrng_writer_wakeup();
+}
diff --git a/drivers/char/lrng/lrng_sw_noise.c b/drivers/char/lrng/lrng_sw_=
noise.c
new file mode 100644
index 000000000000..10f802b4a670
=2D-- /dev/null
+++ b/drivers/char/lrng/lrng_sw_noise.c
@@ -0,0 +1,649 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/*
+ * LRNG Slow Noise Source: Interrupt data collection and random data gener=
ation
+ *
+ * Copyright (C) 2016 - 2021, Stephan Mueller <smueller@chronox.de>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <asm/irq_regs.h>
+#include <asm/ptrace.h>
+#include <crypto/hash.h>
+#include <linux/lrng.h>
+#include <linux/random.h>
+
+#include "lrng_internal.h"
+#include "lrng_sw_noise.h"
+
+/* Per-CPU array holding concatenated entropy events */
+static DEFINE_PER_CPU(u32 [LRNG_DATA_ARRAY_SIZE], lrng_pcpu_array)
+						__aligned(LRNG_KCAPI_ALIGN);
+static DEFINE_PER_CPU(u32, lrng_pcpu_array_ptr) =3D 0;
+static DEFINE_PER_CPU(atomic_t, lrng_pcpu_array_irqs) =3D ATOMIC_INIT(0);
+
+/*
+ * The entropy collection is performed by executing the following steps:
+ * 1. fill up the per-CPU array holding the time stamps
+ * 2. once the per-CPU array is full, a compression of the data into
+ *    the entropy pool is performed - this happens in interrupt context
+ *
+ * If step 2 is not desired in interrupt context, the following boolean
+ * needs to be set to false. This implies that old entropy data in the
+ * per-CPU array collected since the last DRNG reseed is overwritten with
+ * new entropy data instead of retaining the entropy with the compression
+ * operation.
+ *
+ * Impact on entropy:
+ *
+ * If continuous compression is enabled, the maximum entropy that is colle=
cted
+ * per CPU between DRNG reseeds is equal to the digest size of the used ha=
sh.
+ *
+ * If continuous compression is disabled, the maximum number of entropy ev=
ents
+ * that can be collected per CPU is equal to LRNG_DATA_ARRAY_SIZE. This am=
ount
+ * of events is converted into an entropy statement which then represents =
the
+ * maximum amount of entropy collectible per CPU between DRNG reseeds.
+ */
+static bool lrng_pcpu_continuous_compression __read_mostly =3D
+			IS_ENABLED(CONFIG_LRNG_ENABLE_CONTINUOUS_COMPRESSION);
+
+#ifdef CONFIG_LRNG_SWITCHABLE_CONTINUOUS_COMPRESSION
+module_param(lrng_pcpu_continuous_compression, bool, 0444);
+MODULE_PARM_DESC(lrng_pcpu_continuous_compression,
+		 "Perform entropy compression if per-CPU entropy data array is full\n");
+#endif
+
+/*
+ * Per-CPU entropy pool with compressed entropy event
+ *
+ * The per-CPU entropy pool is defined as the hash state. New data is simp=
ly
+ * inserted into the entropy pool by performing a hash update operation.
+ * To read the entropy pool, a hash final must be invoked. However, before
+ * the entropy pool is released again after a hash final, the hash init mu=
st
+ * be performed.
+ *
+ * This definition must provide a buffer that is equal to SHASH_DESC_ON_ST=
ACK
+ * as it will be casted into a struct shash_desc.
+ */
+#define LRNG_PCPU_POOL_SIZE	(sizeof(struct shash_desc) + HASH_MAX_DESCSIZE)
+static DEFINE_PER_CPU(u8 [LRNG_PCPU_POOL_SIZE], lrng_pcpu_pool)
+						__aligned(LRNG_KCAPI_ALIGN);
+/*
+ * Lock to allow other CPUs to read the pool - as this is only done during
+ * reseed which is infrequent, this lock is hardly contended.
+ */
+static DEFINE_PER_CPU(spinlock_t, lrng_pcpu_lock);
+static DEFINE_PER_CPU(bool, lrng_pcpu_lock_init) =3D false;
+
+static inline bool lrng_pcpu_pool_online(int cpu)
+{
+	return per_cpu(lrng_pcpu_lock_init, cpu);
+}
+
+bool lrng_pcpu_continuous_compression_state(void)
+{
+	return lrng_pcpu_continuous_compression;
+}
+
+void lrng_pcpu_check_compression_state(void)
+{
+	/* One pool must hold sufficient entropy for disabled compression */
+	if (!lrng_pcpu_continuous_compression) {
+		u32 max_ent =3D min_t(u32, lrng_get_digestsize(),
+				    lrng_data_to_entropy(LRNG_DATA_NUM_VALUES));
+		if (max_ent < LRNG_DRNG_SECURITY_STRENGTH_BITS) {
+			pr_warn("Force continuous compression operation to ensure LRNG can hold=
 enough entropy\n");
+			lrng_pcpu_continuous_compression =3D true;
+		}
+	}
+}
+
+/*
+ * Reset all per-CPU pools - reset entropy estimator but leave the pool da=
ta
+ * that may or may not have entropy unchanged.
+ */
+void lrng_pcpu_reset(void)
+{
+	int cpu;
+
+	for_each_online_cpu(cpu)
+		atomic_set(per_cpu_ptr(&lrng_pcpu_array_irqs, cpu), 0);
+}
+
+u32 lrng_pcpu_avail_pool_size(void)
+{
+	u32 max_size =3D 0, max_pool =3D lrng_get_digestsize();
+	int cpu;
+
+	if (!lrng_pcpu_continuous_compression)
+		max_pool =3D min_t(u32, max_pool, LRNG_DATA_NUM_VALUES);
+
+	for_each_online_cpu(cpu) {
+		if (lrng_pcpu_pool_online(cpu))
+			max_size +=3D max_pool;
+	}
+
+	return max_size;
+}
+
+/* Return number of unused IRQs present in all per-CPU pools. */
+u32 lrng_pcpu_avail_irqs(void)
+{
+	u32 digestsize_irqs, irq =3D 0;
+	int cpu;
+
+	/* Obtain the cap of maximum numbers of IRQs we count */
+	digestsize_irqs =3D lrng_entropy_to_data(lrng_get_digestsize());
+	if (!lrng_pcpu_continuous_compression) {
+		/* Cap to max. number of IRQs the array can hold */
+		digestsize_irqs =3D min_t(u32, digestsize_irqs,
+					LRNG_DATA_NUM_VALUES);
+	}
+
+	for_each_online_cpu(cpu) {
+		if (!lrng_pcpu_pool_online(cpu))
+			continue;
+		irq +=3D min_t(u32, digestsize_irqs,
+			     atomic_read_u32(per_cpu_ptr(&lrng_pcpu_array_irqs,
+							 cpu)));
+	}
+
+	return irq;
+}
+
+/**
+ * Trigger a switch of the hash implementation for the per-CPU pool.
+ *
+ * For each per-CPU pool, obtain the message digest with the old hash
+ * implementation, initialize the per-CPU pool again with the new hash
+ * implementation and inject the message digest into the new state.
+ *
+ * Assumption: the caller must guarantee that the new_cb is available duri=
ng the
+ * entire operation (e.g. it must hold the lock against pointer updating).
+ */
+int lrng_pcpu_switch_hash(int node,
+			  const struct lrng_crypto_cb *new_cb, void *new_hash,
+			  const struct lrng_crypto_cb *old_cb)
+{
+	u8 digest[LRNG_MAX_DIGESTSIZE];
+	u32 digestsize_irqs, found_irqs;
+	int ret, cpu;
+
+	for_each_online_cpu(cpu) {
+		struct shash_desc *pcpu_shash;
+		unsigned long flags;
+		spinlock_t *lock;
+
+		/*
+		 * Only switch the per-CPU pools for the current node because
+		 * the crypto_cb only applies NUMA-node-wide.
+		 */
+		if (cpu_to_node(cpu) !=3D node || !lrng_pcpu_pool_online(cpu))
+			continue;
+
+		pcpu_shash =3D (struct shash_desc *)per_cpu_ptr(lrng_pcpu_pool,
+							      cpu);
+
+		digestsize_irqs =3D old_cb->lrng_hash_digestsize(pcpu_shash);
+		digestsize_irqs =3D lrng_entropy_to_data(digestsize_irqs << 3);
+
+		if (pcpu_shash->tfm =3D=3D new_hash)
+			continue;
+
+		lock =3D per_cpu_ptr(&lrng_pcpu_lock, cpu);
+		spin_lock_irqsave(lock, flags);
+		/* Get the per-CPU pool hash with old digest ... */
+		ret =3D old_cb->lrng_hash_final(pcpu_shash, digest) ?:
+		      /* ... re-initialize the hash with the new digest ... */
+		      new_cb->lrng_hash_init(pcpu_shash, new_hash) ?:
+		      /*
+		       * ... feed the old hash into the new state. We may feed
+		       * uninitialized memory into the new state, but this is
+		       * considered no issue and even good as we have some more
+		       * uncertainty here.
+		       */
+		      new_cb->lrng_hash_update(pcpu_shash, digest,
+					       sizeof(digest));
+		spin_unlock_irqrestore(lock, flags);
+		if (ret)
+			goto out;
+
+		/*
+		 * In case the new digest is larger than the old one, cap
+		 * the available entropy to the old message digest used to
+		 * process the existing data.
+		 */
+		found_irqs =3D atomic_xchg_relaxed(
+				per_cpu_ptr(&lrng_pcpu_array_irqs, cpu), 0);
+		found_irqs =3D min_t(u32, found_irqs, digestsize_irqs);
+		atomic_add_return_relaxed(found_irqs,
+				per_cpu_ptr(&lrng_pcpu_array_irqs, cpu));
+
+		pr_debug("Re-initialize per-CPU entropy pool for CPU %d on NUMA node %d =
with hash %s\n",
+			 cpu, node, new_cb->lrng_hash_name());
+	}
+
+out:
+	memzero_explicit(digest, sizeof(digest));
+	return ret;
+}
+
+/*
+ * When reading the per-CPU message digest, make sure we use the crypto
+ * callbacks defined for the NUMA node the per-CPU pool is defined for bec=
ause
+ * the LRNG crypto switch support is only atomic per NUMA node.
+ */
+static inline u32
+lrng_pcpu_pool_hash_one(const struct lrng_crypto_cb *pcpu_crypto_cb,
+			void *pcpu_hash, int cpu, u8 *digest, u32 *digestsize)
+{
+	struct shash_desc *pcpu_shash =3D
+		(struct shash_desc *)per_cpu_ptr(lrng_pcpu_pool, cpu);
+	spinlock_t *lock =3D per_cpu_ptr(&lrng_pcpu_lock, cpu);
+	unsigned long flags;
+	u32 digestsize_irqs, found_irqs;
+
+	/* Lock guarding against reading / writing to per-CPU pool */
+	spin_lock_irqsave(lock, flags);
+
+	*digestsize =3D pcpu_crypto_cb->lrng_hash_digestsize(pcpu_hash);
+	digestsize_irqs =3D lrng_entropy_to_data(*digestsize << 3);
+
+	/* Obtain entropy statement like for the entropy pool */
+	found_irqs =3D atomic_xchg_relaxed(
+				per_cpu_ptr(&lrng_pcpu_array_irqs, cpu), 0);
+	/* Cap to maximum amount of data we can hold in hash */
+	found_irqs =3D min_t(u32, found_irqs, digestsize_irqs);
+
+	/* Cap to maximum amount of data we can hold in array */
+	if (!lrng_pcpu_continuous_compression)
+		found_irqs =3D min_t(u32, found_irqs, LRNG_DATA_NUM_VALUES);
+
+	/* Store all not-yet compressed data in data array into hash, ... */
+	if (pcpu_crypto_cb->lrng_hash_update(pcpu_shash,
+				(u8 *)per_cpu_ptr(lrng_pcpu_array, cpu),
+				LRNG_DATA_ARRAY_SIZE * sizeof(u32)) ?:
+	    /* ... get the per-CPU pool digest, ... */
+	    pcpu_crypto_cb->lrng_hash_final(pcpu_shash, digest) ?:
+	    /* ... re-initialize the hash, ... */
+	    pcpu_crypto_cb->lrng_hash_init(pcpu_shash, pcpu_hash) ?:
+	    /* ... feed the old hash into the new state, ... */
+	    pcpu_crypto_cb->lrng_hash_update(pcpu_shash, digest, *digestsize))
+		found_irqs =3D 0;
+
+	spin_unlock_irqrestore(lock, flags);
+	return found_irqs;
+}
+
+/**
+ * Hash all per-CPU pools and return the digest to be used as seed data for
+ * seeding a DRNG. The caller must guarantee backtracking resistance.
+ * The function will only copy as much data as entropy is available into t=
he
+ * caller-provided output buffer.
+ *
+ * This function handles the translation from the number of received inter=
rupts
+ * into an entropy statement. The conversion depends on LRNG_IRQ_ENTROPY_B=
ITS
+ * which defines how many interrupts must be received to obtain 256 bits of
+ * entropy. With this value, the function lrng_data_to_entropy converts a =
given
+ * data size (received interrupts, requested amount of data, etc.) into an
+ * entropy statement. lrng_entropy_to_data does the reverse.
+ *
+ * @outbuf: buffer to store data in with size requested_bits
+ * @requested_bits: Requested amount of entropy
+ * @fully_seeded: indicator whether LRNG is fully seeded
+ * @return: amount of entropy in outbuf in bits.
+ */
+u32 lrng_pcpu_pool_hash(u8 *outbuf, u32 requested_bits, bool fully_seeded)
+{
+	SHASH_DESC_ON_STACK(shash, NULL);
+	const struct lrng_crypto_cb *crypto_cb;
+	struct lrng_drng **lrng_drng =3D lrng_drng_instances();
+	struct lrng_drng *drng =3D lrng_drng_init_instance();
+	u8 digest[LRNG_MAX_DIGESTSIZE];
+	unsigned long flags, flags2;
+	u32 found_irqs, collected_irqs =3D 0, collected_ent_bits, requested_irqs,
+	    returned_ent_bits, osr_bits =3D lrng_sp80090c_compliant() ?
+					     CONFIG_LRNG_OVERSAMPLE_ES_BITS : 0;
+	int ret, cpu;
+	void *hash;
+
+	/* Lock guarding replacement of per-NUMA hash */
+	read_lock_irqsave(&drng->hash_lock, flags);
+
+	crypto_cb =3D drng->crypto_cb;
+	hash =3D drng->hash;
+
+	/* The hash state of filled with all per-CPU pool hashes, ... */
+	ret =3D crypto_cb->lrng_hash_init(shash, hash);
+	if (ret)
+		goto err;
+
+	requested_irqs =3D lrng_entropy_to_data(requested_bits) + osr_bits;
+
+	/*
+	 * Harvest entropy from each per-CPU hash state - even though we may
+	 * have collected sufficient entropy, we will hash all per-CPU pools.
+	 */
+	for_each_online_cpu(cpu) {
+		struct lrng_drng *pcpu_drng =3D drng;
+		u32 digestsize, pcpu_unused_irqs =3D 0;
+		int node =3D cpu_to_node(cpu);
+
+		/* If pool is not online, then no entropy is present. */
+		if (!lrng_pcpu_pool_online(cpu))
+			continue;
+
+		if (lrng_drng && lrng_drng[node])
+			pcpu_drng =3D lrng_drng[node];
+
+		if (pcpu_drng =3D=3D drng) {
+			found_irqs =3D lrng_pcpu_pool_hash_one(crypto_cb, hash,
+							     cpu, digest,
+							     &digestsize);
+		} else {
+			read_lock_irqsave(&pcpu_drng->hash_lock, flags2);
+			found_irqs =3D
+				lrng_pcpu_pool_hash_one(pcpu_drng->crypto_cb,
+							pcpu_drng->hash, cpu,
+							digest, &digestsize);
+			read_unlock_irqrestore(&pcpu_drng->hash_lock, flags2);
+		}
+
+		/* Inject the digest into the state of all per-CPU pools */
+		ret =3D crypto_cb->lrng_hash_update(shash, digest, digestsize);
+		if (ret)
+			goto err;
+
+		collected_irqs +=3D found_irqs;
+		if (collected_irqs > requested_irqs) {
+			pcpu_unused_irqs =3D collected_irqs - requested_irqs;
+			atomic_add_return_relaxed(pcpu_unused_irqs,
+				per_cpu_ptr(&lrng_pcpu_array_irqs, cpu));
+			collected_irqs =3D requested_irqs;
+		}
+		pr_debug("%u interrupts used from entropy pool of CPU %d, %u interrupts =
remain unused\n",
+			 found_irqs - pcpu_unused_irqs, cpu, pcpu_unused_irqs);
+	}
+
+	ret =3D crypto_cb->lrng_hash_final(shash, digest);
+	if (ret)
+		goto err;
+
+	collected_ent_bits =3D lrng_data_to_entropy(collected_irqs);
+	/* Cap to maximum entropy that can ever be generated with given hash */
+	collected_ent_bits =3D min_t(u32, collected_ent_bits,
+				   crypto_cb->lrng_hash_digestsize(hash) << 3);
+	/* Apply oversampling: discount requested oversampling rate */
+	returned_ent_bits =3D (collected_ent_bits >=3D osr_bits) ?
+					(collected_ent_bits - osr_bits) : 0;
+
+	pr_debug("obtained %u bits by collecting %u bits of entropy from entropy =
pool noise source\n",
+		 returned_ent_bits, collected_ent_bits);
+
+	/*
+	 * Truncate to available entropy as implicitly allowed by SP800-90B
+	 * section 3.1.5.1.1 table 1 which awards truncated hashes full
+	 * entropy.
+	 *
+	 * During boot time, we read requested_bits data with
+	 * returned_ent_bits entropy. In case our conservative entropy
+	 * estimate underestimates the available entropy we can transport as
+	 * much available entropy as possible. The entropy pool does not
+	 * operate compliant to the German AIS 21/31 NTG.1 yet.
+	 */
+	memcpy(outbuf, digest, fully_seeded ? returned_ent_bits >> 3 :
+					      requested_bits >> 3);
+
+out:
+	crypto_cb->lrng_hash_desc_zero(shash);
+	read_unlock_irqrestore(&drng->hash_lock, flags);
+	memzero_explicit(digest, sizeof(digest));
+	return returned_ent_bits;
+
+err:
+	returned_ent_bits =3D 0;
+	goto out;
+}
+
+/* Compress the lrng_pcpu_array array into lrng_pcpu_pool */
+static inline void lrng_pcpu_array_compress(void)
+{
+	struct shash_desc *shash =3D
+			(struct shash_desc *)this_cpu_ptr(lrng_pcpu_pool);
+	struct lrng_drng **lrng_drng =3D lrng_drng_instances();
+	struct lrng_drng *drng =3D lrng_drng_init_instance();
+	const struct lrng_crypto_cb *crypto_cb;
+	spinlock_t *lock =3D this_cpu_ptr(&lrng_pcpu_lock);
+	unsigned long flags, flags2;
+	int node =3D numa_node_id();
+	void *hash;
+	bool init =3D false;
+
+	/* Get NUMA-node local hash instance */
+	if (lrng_drng && lrng_drng[node])
+		drng =3D lrng_drng[node];
+
+	read_lock_irqsave(&drng->hash_lock, flags);
+	crypto_cb =3D drng->crypto_cb;
+	hash =3D drng->hash;
+
+	if (unlikely(!this_cpu_read(lrng_pcpu_lock_init))) {
+		init =3D true;
+		spin_lock_init(lock);
+		this_cpu_write(lrng_pcpu_lock_init, true);
+		pr_debug("Initializing per-CPU entropy pool for CPU %d on NUMA node %d w=
ith hash %s\n",
+			 raw_smp_processor_id(), node,
+			 crypto_cb->lrng_hash_name());
+	}
+
+	spin_lock_irqsave(lock, flags2);
+
+	if (unlikely(init) && crypto_cb->lrng_hash_init(shash, hash)) {
+		this_cpu_write(lrng_pcpu_lock_init, false);
+		pr_warn("Initialization of hash failed\n");
+	} else if (lrng_pcpu_continuous_compression) {
+		/* Add entire per-CPU data array content into entropy pool. */
+		if (crypto_cb->lrng_hash_update(shash,
+					(u8 *)this_cpu_ptr(lrng_pcpu_array),
+					LRNG_DATA_ARRAY_SIZE * sizeof(u32)))
+			pr_warn_ratelimited("Hashing of entropy data failed\n");
+	}
+
+	spin_unlock_irqrestore(lock, flags2);
+	read_unlock_irqrestore(&drng->hash_lock, flags);
+}
+
+/* Compress data array into hash */
+static inline void lrng_pcpu_array_to_hash(u32 ptr)
+{
+	u32 *array =3D this_cpu_ptr(lrng_pcpu_array);
+
+	/*
+	 * During boot time the hash operation is triggered more often than
+	 * during regular operation.
+	 */
+	if (unlikely(!lrng_state_fully_seeded())) {
+		if ((ptr & 31) && (ptr < LRNG_DATA_WORD_MASK))
+			return;
+	} else if (ptr < LRNG_DATA_WORD_MASK) {
+		return;
+	}
+
+	if (lrng_raw_array_entropy_store(*array)) {
+		u32 i;
+
+		/*
+		 * If we fed even a part of the array to external analysis, we
+		 * mark that the entire array and the per-CPU pool to have no
+		 * entropy. This is due to the non-IID property of the data as
+		 * we do not fully know whether the existing dependencies
+		 * diminish the entropy beyond to what we expect it has.
+		 */
+		atomic_set(this_cpu_ptr(&lrng_pcpu_array_irqs), 0);
+
+		for (i =3D 1; i < LRNG_DATA_ARRAY_SIZE; i++)
+			lrng_raw_array_entropy_store(*(array + i));
+	} else {
+		lrng_pcpu_array_compress();
+		/* Ping pool handler about received entropy */
+		lrng_pool_add_irq();
+	}
+}
+
+/*
+ * Concatenate full 32 bit word at the end of time array even when current
+ * ptr is not aligned to sizeof(data).
+ */
+static inline void _lrng_pcpu_array_add_u32(u32 data)
+{
+	/* Increment pointer by number of slots taken for input value */
+	u32 pre_ptr, mask, ptr =3D this_cpu_add_return(lrng_pcpu_array_ptr,
+						     LRNG_DATA_SLOTS_PER_UINT);
+	unsigned int pre_array;
+
+	/*
+	 * This function injects a unit into the array - guarantee that
+	 * array unit size is equal to data type of input data.
+	 */
+	BUILD_BUG_ON(LRNG_DATA_ARRAY_MEMBER_BITS !=3D (sizeof(data) << 3));
+
+	/*
+	 * The following logic requires at least two units holding
+	 * the data as otherwise the pointer would immediately wrap when
+	 * injection an u32 word.
+	 */
+	BUILD_BUG_ON(LRNG_DATA_NUM_VALUES <=3D LRNG_DATA_SLOTS_PER_UINT);
+
+	lrng_pcpu_split_u32(&ptr, &pre_ptr, &mask);
+
+	/* MSB of data go into previous unit */
+	pre_array =3D lrng_data_idx2array(pre_ptr);
+	/* zeroization of slot to ensure the following OR adds the data */
+	this_cpu_and(lrng_pcpu_array[pre_array], ~(0xffffffff &~ mask));
+	this_cpu_or(lrng_pcpu_array[pre_array], data & ~mask);
+
+	/* Invoke compression as we just filled data array completely */
+	if (unlikely(pre_ptr > ptr))
+		lrng_pcpu_array_to_hash(LRNG_DATA_WORD_MASK);
+
+	/* LSB of data go into current unit */
+	this_cpu_write(lrng_pcpu_array[lrng_data_idx2array(ptr)],
+		       data & mask);
+
+	if (likely(pre_ptr <=3D ptr))
+		lrng_pcpu_array_to_hash(ptr);
+}
+
+/* Concatenate a 32-bit word at the end of the per-CPU array */
+void lrng_pcpu_array_add_u32(u32 data)
+{
+	/*
+	 * Disregard entropy-less data without continuous compression to
+	 * avoid it overwriting data with entropy when array ptr wraps.
+	 */
+	if (lrng_pcpu_continuous_compression)
+		_lrng_pcpu_array_add_u32(data);
+}
+
+/* Concatenate data of max LRNG_DATA_SLOTSIZE_MASK at the end of time arra=
y */
+static inline void lrng_pcpu_array_add_slot(u32 data)
+{
+	/* Get slot */
+	u32 ptr =3D this_cpu_inc_return(lrng_pcpu_array_ptr) &
+							LRNG_DATA_WORD_MASK;
+	unsigned int array =3D lrng_data_idx2array(ptr);
+	unsigned int slot =3D lrng_data_idx2slot(ptr);
+
+	BUILD_BUG_ON(LRNG_DATA_ARRAY_MEMBER_BITS % LRNG_DATA_SLOTSIZE_BITS);
+	/* Ensure consistency of values */
+	BUILD_BUG_ON(LRNG_DATA_ARRAY_MEMBER_BITS !=3D
+		     sizeof(lrng_pcpu_array[0]) << 3);
+
+	/* zeroization of slot to ensure the following OR adds the data */
+	this_cpu_and(lrng_pcpu_array[array],
+		     ~(lrng_data_slot_val(0xffffffff & LRNG_DATA_SLOTSIZE_MASK,
+					  slot)));
+	/* Store data into slot */
+	this_cpu_or(lrng_pcpu_array[array], lrng_data_slot_val(data, slot));
+
+	lrng_pcpu_array_to_hash(ptr);
+}
+
+static inline void
+lrng_time_process_common(u32 time, void(*add_time)(u32 data))
+{
+	enum lrng_health_res health_test;
+
+	if (lrng_raw_hires_entropy_store(time))
+		return;
+
+	health_test =3D lrng_health_test(time);
+	if (health_test > lrng_health_fail_use)
+		return;
+
+	if (health_test =3D=3D lrng_health_pass)
+		atomic_inc_return(this_cpu_ptr(&lrng_pcpu_array_irqs));
+
+	add_time(time);
+}
+
+/*
+ * Batching up of entropy in per-CPU array before injecting into entropy p=
ool.
+ */
+static inline void lrng_time_process(void)
+{
+	u32 now_time =3D random_get_entropy();
+
+	if (unlikely(!lrng_state_fully_seeded())) {
+		/* During boot time, we process the full time stamp */
+		lrng_time_process_common(now_time, _lrng_pcpu_array_add_u32);
+	} else {
+		/* Runtime operation */
+		lrng_time_process_common(now_time & LRNG_DATA_SLOTSIZE_MASK,
+					 lrng_pcpu_array_add_slot);
+	}
+
+	lrng_perf_time(now_time);
+}
+
+/* Hot code path - Callback for interrupt handler */
+void add_interrupt_randomness(int irq, int irq_flg)
+{
+	if (lrng_pool_highres_timer()) {
+		lrng_time_process();
+	} else {
+		struct pt_regs *regs =3D get_irq_regs();
+		static atomic_t reg_idx =3D ATOMIC_INIT(0);
+		u64 ip;
+		u32 tmp;
+
+		if (regs) {
+			u32 *ptr =3D (u32 *)regs;
+			int reg_ptr =3D atomic_add_return_relaxed(1, &reg_idx);
+			size_t n =3D (sizeof(struct pt_regs) / sizeof(u32));
+
+			ip =3D instruction_pointer(regs);
+			tmp =3D *(ptr + (reg_ptr % n));
+			tmp =3D lrng_raw_regs_entropy_store(tmp) ? 0 : tmp;
+			_lrng_pcpu_array_add_u32(tmp);
+		} else {
+			ip =3D _RET_IP_;
+		}
+
+		lrng_time_process();
+
+		/*
+		 * The XOR operation combining the different values is not
+		 * considered to destroy entropy since the entirety of all
+		 * processed values delivers the entropy (and not each
+		 * value separately of the other values).
+		 */
+		tmp =3D lrng_raw_jiffies_entropy_store(jiffies) ? 0 : jiffies;
+		tmp ^=3D lrng_raw_irq_entropy_store(irq) ? 0 : irq;
+		tmp ^=3D lrng_raw_irqflags_entropy_store(irq_flg) ? 0 : irq_flg;
+		tmp ^=3D lrng_raw_retip_entropy_store(ip) ? 0 : ip;
+		tmp ^=3D ip >> 32;
+		_lrng_pcpu_array_add_u32(tmp);
+	}
+}
+EXPORT_SYMBOL(add_interrupt_randomness);
diff --git a/drivers/char/lrng/lrng_sw_noise.h b/drivers/char/lrng/lrng_sw_=
noise.h
new file mode 100644
index 000000000000..d21b629e0509
=2D-- /dev/null
+++ b/drivers/char/lrng/lrng_sw_noise.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/*
+ * LRNG Slow Noise Source: Time stamp array handling
+ *
+ * Copyright (C) 2016 - 2021, Stephan Mueller <smueller@chronox.de>
+ */
+
+/*
+ * To limit the impact on the interrupt handling, the LRNG concatenates
+ * entropic LSB parts of the time stamps in a per-CPU array and only
+ * injects them into the entropy pool when the array is full.
+ */
+
+/* Store multiple integers in one u32 */
+#define LRNG_DATA_SLOTSIZE_BITS		(8)
+#define LRNG_DATA_SLOTSIZE_MASK		((1 << LRNG_DATA_SLOTSIZE_BITS) - 1)
+#define LRNG_DATA_ARRAY_MEMBER_BITS	(4 << 3) /* ((sizeof(u32)) << 3) */
+#define LRNG_DATA_SLOTS_PER_UINT	(LRNG_DATA_ARRAY_MEMBER_BITS / \
+					 LRNG_DATA_SLOTSIZE_BITS)
+
+/*
+ * Number of time values to store in the array - in small environments
+ * only one atomic_t variable per CPU is used.
+ */
+#define LRNG_DATA_NUM_VALUES		(CONFIG_LRNG_COLLECTION_SIZE)
+/* Mask of LSB of time stamp to store */
+#define LRNG_DATA_WORD_MASK		(LRNG_DATA_NUM_VALUES - 1)
+
+#define LRNG_DATA_SLOTS_MASK		(LRNG_DATA_SLOTS_PER_UINT - 1)
+#define LRNG_DATA_ARRAY_SIZE		(LRNG_DATA_NUM_VALUES /	\
+					 LRNG_DATA_SLOTS_PER_UINT)
+
+/* Starting bit index of slot */
+static inline unsigned int lrng_data_slot2bitindex(unsigned int slot)
+{
+	return (LRNG_DATA_SLOTSIZE_BITS * slot);
+}
+
+/* Convert index into the array index */
+static inline unsigned int lrng_data_idx2array(unsigned int idx)
+{
+	return idx / LRNG_DATA_SLOTS_PER_UINT;
+}
+
+/* Convert index into the slot of a given array index */
+static inline unsigned int lrng_data_idx2slot(unsigned int idx)
+{
+	return idx & LRNG_DATA_SLOTS_MASK;
+}
+
+/* Convert value into slot value */
+static inline unsigned int lrng_data_slot_val(unsigned int val,
+					      unsigned int slot)
+{
+	return val << lrng_data_slot2bitindex(slot);
+}
+
+/*
+ * Return the pointers for the previous and current units to inject a u32 =
into.
+ * Also return the mask which which the u32 word is to be processed.
+ */
+static inline void lrng_pcpu_split_u32(u32 *ptr, u32 *pre_ptr, u32 *mask)
+{
+	/* ptr to previous unit */
+	*pre_ptr =3D (*ptr - LRNG_DATA_SLOTS_PER_UINT) & LRNG_DATA_WORD_MASK;
+	*ptr &=3D LRNG_DATA_WORD_MASK;
+
+	/* mask to split data into the two parts for the two units */
+	*mask =3D ((1 << (*pre_ptr & (LRNG_DATA_SLOTS_PER_UINT - 1)) *
+			LRNG_DATA_SLOTSIZE_BITS)) - 1;
+}
diff --git a/include/linux/lrng.h b/include/linux/lrng.h
new file mode 100644
index 000000000000..e9dc860a1ebb
=2D-- /dev/null
+++ b/include/linux/lrng.h
@@ -0,0 +1,81 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
+/*
+ * Copyright (C) 2018 - 2021, Stephan Mueller <smueller@chronox.de>
+ */
+
+#ifndef _LRNG_H
+#define _LRNG_H
+
+#include <crypto/hash.h>
+#include <linux/errno.h>
+#include <linux/types.h>
+
+/**
+ * struct lrng_crypto_cb - cryptographic callback functions
+ * @lrng_drng_name		Name of DRNG
+ * @lrng_hash_name		Name of Hash used for reading entropy pool
+ * @lrng_drng_alloc:		Allocate DRNG -- the provided integer should be
+ *				used for sanity checks.
+ *				return: allocated data structure or PTR_ERR on
+ *					error
+ * @lrng_drng_dealloc:		Deallocate DRNG
+ * @lrng_drng_seed_helper:	Seed the DRNG with data of arbitrary length
+ *				drng: is pointer to data structure allocated
+ *				      with lrng_drng_alloc
+ *				return: >=3D 0 on success, < 0 on error
+ * @lrng_drng_generate_helper:	Generate random numbers from the DRNG with
+ *				arbitrary length
+ * @lrng_hash_alloc:		Allocate the hash for reading the entropy pool
+ *				return: allocated data structure (NULL is
+ *					success too) or ERR_PTR on error
+ * @lrng_hash_dealloc:		Deallocate Hash
+ * @lrng_hash_digestsize:	Return the digestsize for the used hash to read
+ *				out entropy pool
+ *				hash: is pointer to data structure allocated
+ *				      with lrng_hash_alloc
+ *				return: size of digest of hash in bytes
+ * @lrng_hash_init:		Initialize hash
+ *				hash: is pointer to data structure allocated
+ *				      with lrng_hash_alloc
+ *				return: 0 on success, < 0 on error
+ * @lrng_hash_update:		Update hash operation
+ *				hash: is pointer to data structure allocated
+ *				      with lrng_hash_alloc
+ *				return: 0 on success, < 0 on error
+ * @lrng_hash_final		Final hash operation
+ *				hash: is pointer to data structure allocated
+ *				      with lrng_hash_alloc
+ *				return: 0 on success, < 0 on error
+ * @lrng_hash_desc_zero		Zeroization of hash state buffer
+ *
+ * Assumptions:
+ *
+ * 1. Hash operation will not sleep
+ * 2. The hash' volatile state information is provided with *shash by call=
er.
+ */
+struct lrng_crypto_cb {
+	const char *(*lrng_drng_name)(void);
+	const char *(*lrng_hash_name)(void);
+	void *(*lrng_drng_alloc)(u32 sec_strength);
+	void (*lrng_drng_dealloc)(void *drng);
+	int (*lrng_drng_seed_helper)(void *drng, const u8 *inbuf, u32 inbuflen);
+	int (*lrng_drng_generate_helper)(void *drng, u8 *outbuf, u32 outbuflen);
+	void *(*lrng_hash_alloc)(void);
+	void (*lrng_hash_dealloc)(void *hash);
+	u32 (*lrng_hash_digestsize)(void *hash);
+	int (*lrng_hash_init)(struct shash_desc *shash, void *hash);
+	int (*lrng_hash_update)(struct shash_desc *shash, const u8 *inbuf,
+				u32 inbuflen);
+	int (*lrng_hash_final)(struct shash_desc *shash, u8 *digest);
+	void (*lrng_hash_desc_zero)(struct shash_desc *shash);
+};
+
+/* Register cryptographic backend */
+#ifdef CONFIG_LRNG_DRNG_SWITCH
+int lrng_set_drng_cb(const struct lrng_crypto_cb *cb);
+#else	/* CONFIG_LRNG_DRNG_SWITCH */
+static inline int
+lrng_set_drng_cb(const struct lrng_crypto_cb *cb) { return -EOPNOTSUPP; }
+#endif	/* CONFIG_LRNG_DRNG_SWITCH */
+
+#endif /* _LRNG_H */
=2D-=20
2.31.1




