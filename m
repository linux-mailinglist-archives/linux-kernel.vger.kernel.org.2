Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743E140F4ED
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 11:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245644AbhIQJj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 05:39:57 -0400
Received: from mo4-p04-ob.smtp.rzone.de ([85.215.255.124]:32073 "EHLO
        mo4-p04-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245571AbhIQJju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 05:39:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1631871138;
    s=strato-dkim-0002; d=chronox.de;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=I4Y+uurDyefWuY5lU9l8aIUYlMUSW5HUACiND4PC1/Q=;
    b=eOJ35IEKFzQnKDeWEbPi1CdGk8iPk1NGl9QMairiav8s1Orw0iVesIecLGg275MG2V
    nSW79M+4wdlmBXIqUsQWpqmo3lsipXXcfYHQGEynQou67Ip8+tBuHSxSvx1dBriBmFft
    vJBS/1f69mD6XIGwb+zTUr1gVn25HbuzqeTBBl6sF0rAPl8fys0ySfIdswA+PUXqvJvv
    yIkL+Pc1fW/n/dYRY39jOeMe8YtP5IG4oOzf0pkuxrftmsO9d8MjvhCzukWNgCpp61EP
    OCkk0iyWCev0jN42Axhqocy3wG3bNe22uIMYt1Ehr9S7qRaeGMAU+aiwm3d11oJ8xhHi
    DXag==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXvSOeicf6o="
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
    by smtp.strato.de (RZmta 47.33.3 DYNA|AUTH)
    with ESMTPSA id f080d4x8H9WHcpX
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 17 Sep 2021 11:32:17 +0200 (CEST)
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
Subject: [PATCH v42 07/13] LRNG - add SP800-90A DRBG extension
Date:   Thu, 16 Sep 2021 12:14:13 +0200
Message-ID: <1714111.Mqn43L3ZAO@positron.chronox.de>
In-Reply-To: <2294055.9jK4hKOXjS@positron.chronox.de>
References: <2294055.9jK4hKOXjS@positron.chronox.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using the LRNG switchable DRNG support, the SP800-90A DRBG extension is
implemented.

The DRBG uses the kernel crypto API DRBG implementation. In addition, it
uses the kernel crypto API SHASH support to provide the hashing
operation.

The DRBG supports the choice of either a CTR DRBG using AES-256, HMAC
DRBG with SHA-512 core or Hash DRBG with SHA-512 core. The used core can
be selected with the module parameter lrng_drbg_type. The default is the
CTR DRBG.

When compiling the DRBG extension statically, the DRBG is loaded at
late_initcall stage which implies that with the start of user space, the
user space interfaces of getrandom(2), /dev/random and /dev/urandom
provide random data produced by an SP800-90A DRBG.

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
Reviewed-by: Roman Drahtmueller <draht@schaltsekun.de>
Tested-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
Tested-by: Neil Horman <nhorman@redhat.com>
Signed-off-by: Stephan Mueller <smueller@chronox.de>
---
 drivers/char/lrng/Kconfig     |  10 ++
 drivers/char/lrng/Makefile    |   1 +
 drivers/char/lrng/lrng_drbg.c | 198 ++++++++++++++++++++++++++++++++++
 3 files changed, 209 insertions(+)
 create mode 100644 drivers/char/lrng/lrng_drbg.c

diff --git a/drivers/char/lrng/Kconfig b/drivers/char/lrng/Kconfig
index ab17c45a356b..aa611363b97e 100644
--- a/drivers/char/lrng/Kconfig
+++ b/drivers/char/lrng/Kconfig
@@ -215,6 +215,16 @@ config LRNG_KCAPI_HASH
 	bool
 	select CRYPTO_HASH
 
+config LRNG_DRBG
+	tristate "SP800-90A support for the LRNG"
+	depends on CRYPTO
+	select CRYPTO_DRBG_MENU
+	select CRYPTO_SHA512
+	select LRNG_KCAPI_HASH
+	help
+	  Enable the SP800-90A DRBG support for the LRNG. Once the
+	  module is loaded, output from /dev/random, /dev/urandom,
+	  getrandom(2), or get_random_bytes_full is provided by a DRBG.
 endif # LRNG_DRNG_SWITCH
 
 endif # LRNG
diff --git a/drivers/char/lrng/Makefile b/drivers/char/lrng/Makefile
index 299715bb0ec2..7e5acb8cac3d 100644
--- a/drivers/char/lrng/Makefile
+++ b/drivers/char/lrng/Makefile
@@ -12,3 +12,4 @@ obj-$(CONFIG_NUMA)		+= lrng_numa.o
 obj-$(CONFIG_SYSCTL)		+= lrng_proc.o
 obj-$(CONFIG_LRNG_DRNG_SWITCH)	+= lrng_switch.o
 obj-$(CONFIG_LRNG_KCAPI_HASH)	+= lrng_kcapi_hash.o
+obj-$(CONFIG_LRNG_DRBG)		+= lrng_drbg.o
diff --git a/drivers/char/lrng/lrng_drbg.c b/drivers/char/lrng/lrng_drbg.c
new file mode 100644
index 000000000000..6ca6b05eccf4
--- /dev/null
+++ b/drivers/char/lrng/lrng_drbg.c
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/*
+ * Backend for the LRNG providing the cryptographic primitives using the
+ * kernel crypto API and its DRBG.
+ *
+ * Copyright (C) 2016 - 2021, Stephan Mueller <smueller@chronox.de>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <crypto/drbg.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/lrng.h>
+
+#include "lrng_kcapi_hash.h"
+
+/*
+ * Define a DRBG plus a hash / MAC used to extract data from the entropy pool.
+ * For LRNG_HASH_NAME you can use a hash or a MAC (HMAC or CMAC) of your choice
+ * (Note, you should use the suggested selections below -- using SHA-1 or MD5
+ * is not wise). The idea is that the used cipher primitive can be selected to
+ * be the same as used for the DRBG. I.e. the LRNG only uses one cipher
+ * primitive using the same cipher implementation with the options offered in
+ * the following. This means, if the CTR DRBG is selected and AES-NI is present,
+ * both the CTR DRBG and the selected cmac(aes) use AES-NI.
+ *
+ * The security strengths of the DRBGs are all 256 bits according to
+ * SP800-57 section 5.6.1.
+ *
+ * This definition is allowed to be changed.
+ */
+#ifdef CONFIG_CRYPTO_DRBG_CTR
+static unsigned int lrng_drbg_type = 0;
+#elif defined CONFIG_CRYPTO_DRBG_HMAC
+static unsigned int lrng_drbg_type = 1;
+#elif defined CONFIG_CRYPTO_DRBG_HASH
+static unsigned int lrng_drbg_type = 2;
+#else
+#error "Unknown DRBG in use"
+#endif
+
+/* The parameter must be r/o in sysfs as otherwise races appear. */
+module_param(lrng_drbg_type, uint, 0444);
+MODULE_PARM_DESC(lrng_drbg_type, "DRBG type used for LRNG (0->CTR_DRBG, 1->HMAC_DRBG, 2->Hash_DRBG)");
+
+struct lrng_drbg {
+	const char *hash_name;
+	const char *drbg_core;
+};
+
+static const struct lrng_drbg lrng_drbg_types[] = {
+	{	/* CTR_DRBG with AES-256 using derivation function */
+		.hash_name = "sha512",
+		.drbg_core = "drbg_nopr_ctr_aes256",
+	}, {	/* HMAC_DRBG with SHA-512 */
+		.hash_name = "sha512",
+		.drbg_core = "drbg_nopr_hmac_sha512",
+	}, {	/* Hash_DRBG with SHA-512 using derivation function */
+		.hash_name = "sha512",
+		.drbg_core = "drbg_nopr_sha512"
+	}
+};
+
+static int lrng_drbg_drng_seed_helper(void *drng, const u8 *inbuf, u32 inbuflen)
+{
+	struct drbg_state *drbg = (struct drbg_state *)drng;
+	LIST_HEAD(seedlist);
+	struct drbg_string data;
+	int ret;
+
+	drbg_string_fill(&data, inbuf, inbuflen);
+	list_add_tail(&data.list, &seedlist);
+	ret = drbg->d_ops->update(drbg, &seedlist, drbg->seeded);
+
+	if (ret >= 0)
+		drbg->seeded = true;
+
+	return ret;
+}
+
+static int lrng_drbg_drng_generate_helper(void *drng, u8 *outbuf, u32 outbuflen)
+{
+	struct drbg_state *drbg = (struct drbg_state *)drng;
+
+	return drbg->d_ops->generate(drbg, outbuf, outbuflen, NULL);
+}
+
+static void *lrng_drbg_drng_alloc(u32 sec_strength)
+{
+	struct drbg_state *drbg;
+	int coreref = -1;
+	bool pr = false;
+	int ret;
+
+	drbg_convert_tfm_core(lrng_drbg_types[lrng_drbg_type].drbg_core,
+			      &coreref, &pr);
+	if (coreref < 0)
+		return ERR_PTR(-EFAULT);
+
+	drbg = kzalloc(sizeof(struct drbg_state), GFP_KERNEL);
+	if (!drbg)
+		return ERR_PTR(-ENOMEM);
+
+	drbg->core = &drbg_cores[coreref];
+	drbg->seeded = false;
+	ret = drbg_alloc_state(drbg);
+	if (ret)
+		goto err;
+
+	if (sec_strength > drbg_sec_strength(drbg->core->flags)) {
+		pr_err("Security strength of DRBG (%u bits) lower than requested by LRNG (%u bits)\n",
+			drbg_sec_strength(drbg->core->flags) * 8,
+			sec_strength * 8);
+		goto dealloc;
+	}
+
+	if (sec_strength < drbg_sec_strength(drbg->core->flags))
+		pr_warn("Security strength of DRBG (%u bits) higher than requested by LRNG (%u bits)\n",
+			drbg_sec_strength(drbg->core->flags) * 8,
+			sec_strength * 8);
+
+	pr_info("DRBG with %s core allocated\n", drbg->core->backend_cra_name);
+
+	return drbg;
+
+dealloc:
+	if (drbg->d_ops)
+		drbg->d_ops->crypto_fini(drbg);
+	drbg_dealloc_state(drbg);
+err:
+	kfree(drbg);
+	return ERR_PTR(-EINVAL);
+}
+
+static void lrng_drbg_drng_dealloc(void *drng)
+{
+	struct drbg_state *drbg = (struct drbg_state *)drng;
+
+	if (drbg && drbg->d_ops)
+		drbg->d_ops->crypto_fini(drbg);
+	drbg_dealloc_state(drbg);
+	kfree_sensitive(drbg);
+	pr_info("DRBG deallocated\n");
+}
+
+static void *lrng_drbg_hash_alloc(void)
+{
+	return lrng_kcapi_hash_alloc(lrng_drbg_types[lrng_drbg_type].hash_name);
+}
+
+static const char *lrng_drbg_name(void)
+{
+	return lrng_drbg_types[lrng_drbg_type].drbg_core;
+}
+
+static const char *lrng_hash_name(void)
+{
+	return lrng_drbg_types[lrng_drbg_type].hash_name;
+}
+
+static const struct lrng_crypto_cb lrng_drbg_crypto_cb = {
+	.lrng_drng_name			= lrng_drbg_name,
+	.lrng_hash_name			= lrng_hash_name,
+	.lrng_drng_alloc		= lrng_drbg_drng_alloc,
+	.lrng_drng_dealloc		= lrng_drbg_drng_dealloc,
+	.lrng_drng_seed_helper		= lrng_drbg_drng_seed_helper,
+	.lrng_drng_generate_helper	= lrng_drbg_drng_generate_helper,
+	.lrng_hash_alloc		= lrng_drbg_hash_alloc,
+	.lrng_hash_dealloc		= lrng_kcapi_hash_dealloc,
+	.lrng_hash_digestsize		= lrng_kcapi_hash_digestsize,
+	.lrng_hash_init			= lrng_kcapi_hash_init,
+	.lrng_hash_update		= lrng_kcapi_hash_update,
+	.lrng_hash_final		= lrng_kcapi_hash_final,
+	.lrng_hash_desc_zero		= lrng_kcapi_hash_zero,
+};
+
+static int __init lrng_drbg_init(void)
+{
+	if (lrng_drbg_type >= ARRAY_SIZE(lrng_drbg_types)) {
+		pr_err("lrng_drbg_type parameter too large (given %u - max: %lu)",
+		       lrng_drbg_type,
+		       (unsigned long)ARRAY_SIZE(lrng_drbg_types) - 1);
+		return -EAGAIN;
+	}
+	return lrng_set_drng_cb(&lrng_drbg_crypto_cb);
+}
+
+static void __exit lrng_drbg_exit(void)
+{
+	lrng_set_drng_cb(NULL);
+}
+
+late_initcall(lrng_drbg_init);
+module_exit(lrng_drbg_exit);
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_AUTHOR("Stephan Mueller <smueller@chronox.de>");
+MODULE_DESCRIPTION("Linux Random Number Generator - SP800-90A DRBG backend");
-- 
2.31.1




