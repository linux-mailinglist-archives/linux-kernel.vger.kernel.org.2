Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DECB4584D5
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 17:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238540AbhKUQxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 11:53:12 -0500
Received: from mo4-p04-ob.smtp.rzone.de ([81.169.146.177]:29147 "EHLO
        mo4-p04-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238079AbhKUQwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 11:52:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1637513318;
    s=strato-dkim-0002; d=chronox.de;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=YUtaUGvXy4RCwHEdoN+oGR/T7eofnkQwvJGOX+pp5/s=;
    b=BUovignxOjM0jsdtw2/OZwtcEeVLWrBTSukaBoDwwA4wkpFWM4l9qyus3Cob57YdX+
    MR9Cq6z04gUUFzpxJ7ma6++vrt//RVXA0AqPUPEsgajUvFL1aKhXGaiCIi1ReuwMQuil
    3xT6MPkVE5CsypJt2zkRqGXzQNWJTJFqBOno3pUH7cWg1X9Waj6iQIPsi7aX3ayW7fcu
    aUbxYYO0syGoPKyNUDvr57hIdGlWdM/pvpGOv1aUfyJOixlWhzCaaBWu9DneFW1eb1fC
    +lQqSPwTbfDcfk9QxWqYxU0GO5eQi0AiJvCgA1tn7cKrB87dCt0yckDygb/VGG+jPZ55
    i8tA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPbJvSfE+K2"
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
    by smtp.strato.de (RZmta 47.34.5 DYNA|AUTH)
    with ESMTPSA id U02dfbxALGmb3Wk
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sun, 21 Nov 2021 17:48:37 +0100 (CET)
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
Subject: [PATCH v43 05/15] LRNG - CPU entropy source
Date:   Sun, 21 Nov 2021 17:42:09 +0100
Message-ID: <6686472.9J7NaK4W3v@positron.chronox.de>
In-Reply-To: <2036923.9o76ZdvQCi@positron.chronox.de>
References: <2036923.9o76ZdvQCi@positron.chronox.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Certain CPUs provide instructions giving access to an entropy source
(e.g. RDSEED on Intel/AMD, DARN on POWER, etc.). The LRNG can utilize
the entropy source to seed its DRNG from.

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
Reviewed-by: Alexander Lobakin <alobakin@pm.me>
Tested-by: Alexander Lobakin <alobakin@pm.me>
Mathematical aspects Reviewed-by: "Peter, Matthias" <matthias.peter@bsi.bund.de>
Reviewed-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
Reviewed-by: Roman Drahtmueller <draht@schaltsekun.de>
Tested-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
Tested-by: Neil Horman <nhorman@redhat.com>
Tested-by: Jirka Hladky <jhladky@redhat.com>
Reviewed-by: Jirka Hladky <jhladky@redhat.com>
Signed-off-by: Stephan Mueller <smueller@chronox.de>
---
 drivers/char/lrng/Kconfig              |  38 +++++
 drivers/char/lrng/Makefile             |   1 +
 drivers/char/lrng/lrng_es_archrandom.c | 226 +++++++++++++++++++++++++
 3 files changed, 265 insertions(+)
 create mode 100644 drivers/char/lrng/lrng_es_archrandom.c

diff --git a/drivers/char/lrng/Kconfig b/drivers/char/lrng/Kconfig
index a9ae35d9f648..d3abdfa28493 100644
--- a/drivers/char/lrng/Kconfig
+++ b/drivers/char/lrng/Kconfig
@@ -215,6 +215,44 @@ config LRNG_IRQ_ENTROPY_RATE
 	  interrupt entropy source will still deliver data but without
 	  being credited with entropy.
 
+comment "CPU Entropy Source"
+
+config LRNG_CPU
+	bool "Enable CPU Entropy Source as LRNG Seed Source"
+	default y
+	help
+	  Current CPUs commonly contain entropy sources which can be
+	  used to seed the LRNG. For example, the Intel RDSEED
+	  instruction, or the POWER DARN instruction will be sourced
+	  to seed the LRNG if this option is enabled.
+
+	  Note, if this option is enabled and the underlying CPU
+	  does not offer such entropy source, the LRNG will automatically
+	  detect this and ignore the hardware.
+
+config LRNG_CPU_FULL_ENT_MULTIPLIER
+	int
+	default 1 if !LRNG_TEST_CPU_ES_COMPRESSION
+	default 123 if LRNG_TEST_CPU_ES_COMPRESSION
+
+config LRNG_CPU_ENTROPY_RATE
+	int "CPU Entropy Source Entropy Rate"
+	depends on LRNG_CPU
+	range 0 256
+	default 8
+	help
+	  The option defines the amount of entropy the LRNG applies to 256
+	  bits of data obtained from the CPU entropy source. The LRNG
+	  enforces the limit that this value must be in the range between
+	  0 and 256.
+
+	  When configuring this value to 0, the CPU entropy source will
+	  provide 256 bits of data without being credited to contain
+	  entropy.
+
+	  Note, this option is overwritten when the option
+	  CONFIG_RANDOM_TRUST_CPU is set.
+
 endmenu # "Entropy Source Configuration"
 
 endif # LRNG
diff --git a/drivers/char/lrng/Makefile b/drivers/char/lrng/Makefile
index 1e722e0967e0..1e18e2c1016b 100644
--- a/drivers/char/lrng/Makefile
+++ b/drivers/char/lrng/Makefile
@@ -10,3 +10,4 @@ obj-y				+= lrng_es_mgr.o lrng_aux.o \
 obj-$(CONFIG_LRNG_IRQ)		+= lrng_es_irq.o
 obj-$(CONFIG_SYSCTL)		+= lrng_proc.o
 obj-$(CONFIG_NUMA)		+= lrng_numa.o
+obj-$(CONFIG_LRNG_CPU)		+= lrng_es_archrandom.o
diff --git a/drivers/char/lrng/lrng_es_archrandom.c b/drivers/char/lrng/lrng_es_archrandom.c
new file mode 100644
index 000000000000..6965f9b8ae50
--- /dev/null
+++ b/drivers/char/lrng/lrng_es_archrandom.c
@@ -0,0 +1,226 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/*
+ * LRNG Fast Entropy Source: CPU-based entropy source
+ *
+ * Copyright (C) 2016 - 2021, Stephan Mueller <smueller@chronox.de>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <crypto/hash.h>
+#include <linux/lrng.h>
+#include <linux/random.h>
+
+#include "lrng_internal.h"
+
+/*
+ * Estimated entropy of data is a 32th of LRNG_DRNG_SECURITY_STRENGTH_BITS.
+ * As we have no ability to review the implementation of those noise sources,
+ * it is prudent to have a conservative estimate here.
+ */
+#define LRNG_ARCHRANDOM_DEFAULT_STRENGTH CONFIG_LRNG_CPU_ENTROPY_RATE
+#define LRNG_ARCHRANDOM_TRUST_CPU_STRENGTH LRNG_DRNG_SECURITY_STRENGTH_BITS
+#ifdef CONFIG_RANDOM_TRUST_CPU
+static u32 archrandom = LRNG_ARCHRANDOM_TRUST_CPU_STRENGTH;
+#else
+static u32 archrandom = LRNG_ARCHRANDOM_DEFAULT_STRENGTH;
+#endif
+#ifdef CONFIG_LRNG_RUNTIME_ES_CONFIG
+module_param(archrandom, uint, 0644);
+MODULE_PARM_DESC(archrandom, "Entropy in bits of 256 data bits from CPU noise source (e.g. RDSEED)");
+#endif
+
+static int __init lrng_parse_trust_cpu(char *arg)
+{
+	int ret;
+	bool trust_cpu = false;
+
+	ret = kstrtobool(arg, &trust_cpu);
+	if (ret)
+		return ret;
+
+	if (trust_cpu) {
+		archrandom = LRNG_ARCHRANDOM_TRUST_CPU_STRENGTH;
+		lrng_pool_add_entropy();
+	} else {
+		archrandom = LRNG_ARCHRANDOM_DEFAULT_STRENGTH;
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
+static u32 lrng_get_arch_data(u8 *outbuf, u32 requested_bits)
+{
+	u32 i;
+
+	/* operate on full blocks */
+	BUILD_BUG_ON(LRNG_DRNG_SECURITY_STRENGTH_BYTES % sizeof(unsigned long));
+	BUILD_BUG_ON(CONFIG_LRNG_SEED_BUFFER_INIT_ADD_BITS %
+							 sizeof(unsigned long));
+	/* ensure we have aligned buffers */
+	BUILD_BUG_ON(LRNG_KCAPI_ALIGN % sizeof(unsigned long));
+
+	for (i = 0; i < (requested_bits >> 3);
+	     i += sizeof(unsigned long)) {
+		if (!arch_get_random_seed_long((unsigned long *)(outbuf + i)) &&
+		    !arch_get_random_long((unsigned long *)(outbuf + i))) {
+			archrandom = 0;
+			return 0;
+		}
+	}
+
+	return requested_bits;
+}
+
+static u32 inline lrng_get_arch_data_compress(u8 *outbuf, u32 requested_bits,
+					      u32 data_multiplier)
+{
+	SHASH_DESC_ON_STACK(shash, NULL);
+	const struct lrng_crypto_cb *crypto_cb;
+	struct lrng_drng *drng = lrng_drng_init_instance();
+	unsigned long flags;
+	u32 ent_bits = 0, i, partial_bits = 0,
+	    full_bits = requested_bits * data_multiplier;
+	void *hash;
+
+	/* Calculate oversampling for SP800-90C */
+	if (lrng_sp80090c_compliant()) {
+		/* Complete amount of bits to be pulled */
+		full_bits += CONFIG_LRNG_OVERSAMPLE_ES_BITS * data_multiplier;
+		/* Full blocks that will be pulled */
+		data_multiplier = full_bits / requested_bits;
+		/* Partial block in bits to be pulled */
+		partial_bits = full_bits - (data_multiplier * requested_bits);
+	}
+
+	lrng_hash_lock(drng, &flags);
+	crypto_cb = drng->crypto_cb;
+	hash = drng->hash;
+
+	if (crypto_cb->lrng_hash_init(shash, hash))
+		goto out;
+
+	/* Hash all data from the CPU entropy source */
+	for (i = 0; i < data_multiplier; i++) {
+		ent_bits = lrng_get_arch_data(outbuf, requested_bits);
+		if (!ent_bits)
+			goto out;
+
+		if (crypto_cb->lrng_hash_update(shash, outbuf, ent_bits >> 3))
+			goto err;
+	}
+
+	/* Hash partial block, if applicable */
+	ent_bits = lrng_get_arch_data(outbuf, partial_bits);
+	if (ent_bits &&
+	    crypto_cb->lrng_hash_update(shash, outbuf, ent_bits >> 3))
+		goto err;
+
+	pr_debug("pulled %u bits from CPU RNG entropy source\n", full_bits);
+
+	/* Generate the compressed data to be returned to the caller */
+	ent_bits = crypto_cb->lrng_hash_digestsize(hash) << 3;
+	if (requested_bits < ent_bits) {
+		u8 digest[LRNG_MAX_DIGESTSIZE];
+
+		if (crypto_cb->lrng_hash_final(shash, digest))
+			goto err;
+
+		/* Truncate output data to requested size */
+		memcpy(outbuf, digest, requested_bits >> 3);
+		memzero_explicit(digest, crypto_cb->lrng_hash_digestsize(hash));
+		ent_bits = requested_bits;
+	} else {
+		if (crypto_cb->lrng_hash_final(shash, outbuf))
+			goto err;
+	}
+
+out:
+	crypto_cb->lrng_hash_desc_zero(shash);
+	lrng_hash_unlock(drng, flags);
+	return ent_bits;
+
+err:
+	ent_bits = 0;
+	goto out;
+}
+
+/*
+ * If CPU entropy source requires does not return full entropy, return the
+ * multiplier of how much data shall be sampled from it.
+ */
+static u32 lrng_arch_multiplier(void)
+{
+	static u32 data_multiplier = 0;
+
+	if (data_multiplier > 0) {
+		return data_multiplier;
+	} else {
+		unsigned long v;
+
+		if (IS_ENABLED(CONFIG_X86) && !arch_get_random_seed_long(&v)) {
+			/*
+			 * Intel SPEC: pulling 512 blocks from RDRAND ensures
+			 * one reseed making it logically equivalent to RDSEED.
+			 */
+			data_multiplier = 512;
+		} else if (IS_ENABLED(CONFIG_PPC)) {
+			/*
+			 * PowerISA defines DARN to deliver at least 0.5 bits of
+			 * entropy per data bit.
+			 */
+			data_multiplier = 2;
+		} else {
+			/* CPU provides full entropy */
+			data_multiplier = CONFIG_LRNG_CPU_FULL_ENT_MULTIPLIER;
+		}
+	}
+	return data_multiplier;
+}
+
+/*
+ * lrng_get_arch() - Get CPU entropy source entropy
+ *
+ * @outbuf: buffer to store entropy of size requested_bits
+ *
+ * Return:
+ * * > 0 on success where value provides the added entropy in bits
+ * *   0 if no fast source was available
+ */
+u32 lrng_get_arch(u8 *outbuf, u32 requested_bits)
+{
+	u32 ent_bits, data_multiplier = lrng_arch_multiplier();
+
+	if (data_multiplier <= 1) {
+		ent_bits = lrng_get_arch_data(outbuf, requested_bits);
+	} else {
+		ent_bits = lrng_get_arch_data_compress(outbuf, requested_bits,
+						       data_multiplier);
+	}
+
+	ent_bits = lrng_archrandom_entropylevel(ent_bits);
+	pr_debug("obtained %u bits of entropy from CPU RNG entropy source\n",
+		 ent_bits);
+	return ent_bits;
+}
+
+void lrng_arch_es_state(unsigned char *buf, size_t buflen)
+{
+	const struct lrng_drng *lrng_drng_init = lrng_drng_init_instance();
+	u32 data_multiplier = lrng_arch_multiplier();
+
+	/* Assume the lrng_drng_init lock is taken by caller */
+	snprintf(buf, buflen,
+		 "CPU ES properties:\n"
+		 " Hash for compressing data: %s\n"
+		 " Data multiplier: %u\n",
+		 (data_multiplier <= 1) ?
+			"N/A" : lrng_drng_init->crypto_cb->lrng_hash_name(),
+		 data_multiplier);
+}
-- 
2.31.1




