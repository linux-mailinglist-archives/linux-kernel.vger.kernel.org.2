Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61652326D3B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 14:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhB0NrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Feb 2021 08:47:14 -0500
Received: from mo4-p04-ob.smtp.rzone.de ([85.215.255.123]:32662 "EHLO
        mo4-p04-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbhB0Npc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Feb 2021 08:45:32 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1614433251; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=l2MuWJ9Cx6CI3hzWLFJoLMw+k+0SWXaNJcmbed9er3Cb1oYtzOUg96l0VnYhucb+V7
    5WHnRox7bWuiPws3rAODceVZp3t+V2zVwAcXAMWMV9A8ZR16QPbfyyq7sa7LTSQBWuR7
    3vkImqni69v4t9DL7NR4BYzzaiR+2qyRZN8JmU51eBHUBu6GmNNdKETNnZtJRhM90Ees
    Vt/uTX6IYIHApOZmE3tqN3kjkUU5pGWjksVY07oO5wBoKw82mdu3FTeT0b2arptr+aBx
    vbaYC40Q5PpkC8BnVJlmmM5g3SjvlLvoVRDLBGJCN4EdJw9fUfJdF8Y1NNYViPpJrkgS
    jQAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1614433251;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=o9u1zbioHXlOZoNYXCnstY+KQJcyUg3HLQvx1N5kQCA=;
    b=Hc+se9cs2430IstbCWNGhjO6mnAYrS/iAOeC7TMyZH70n+CM1QMj6+Cb/2jOBLnxZs
    zutZMK+aD1IxCdfRDK17e7X7KFYoBSnpe1OBZU5LqerD/+VV5x6usVRWG3jpzkepRif8
    qsVL+VvOXSl4JfDEUhSlHONRzcY27vxK2R9+Fb/3g/iuhVpSKGo+B4YbNJCstphuXrsr
    R79xbv78rhJ73ZSlDLiSHw/tOsy8QfCsZR3vLDAGkEqBKglmO27VVHdpKoTcs7ROQGB4
    aMiIfLgu1fj5XyBJ4AxERkB5eUBxL7VtcIw9n2Osd3QyfH8iL9ePeLGhb7fjwP8j+7R1
    TkKA==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1614433251;
    s=strato-dkim-0002; d=chronox.de;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=o9u1zbioHXlOZoNYXCnstY+KQJcyUg3HLQvx1N5kQCA=;
    b=mjcu8uEaQKO6xW7PIY0bACyKdaA8WqVqSJcrF1uFK1zpQnlbbAGYCMkjjxrGcfF7mA
    2x30fi3roMTFXsJQsoxVGIIEmxUTIb5JQ/RrsziTLl71ri33ybwiRlso3IsDw93XqaZ+
    JUM7JnDnnBasrRPuZ4G1H0c7kM/nuaJP38Z6fiyj2cfknkTwtLnBRded8pylzCtKpwf5
    J7Tk8PywgbWsHSlVq+6aalw6PvTtaK02aoo5elu6kdWb69GIHOWco/P06JFvgZTPSBIc
    P0qy8n9GSDVltD88eod99OgL0EzlwUsNk9b1e4UTqfyH7kpmQONN++PcD7q/9QNNyImR
    Qztw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPZIfSc8k+7"
X-RZG-CLASS-ID: mo00
Received: from positron.chronox.de
    by smtp.strato.de (RZmta 47.19.0 DYNA|AUTH)
    with ESMTPSA id 608030x1RDeoUDD
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 27 Feb 2021 14:40:50 +0100 (CET)
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
Subject: [PATCH v38 08/13] LRNG - add kernel crypto API PRNG extension
Date:   Sat, 27 Feb 2021 14:37:51 +0100
Message-ID: <5144355.Sb9uPGUboI@positron.chronox.de>
In-Reply-To: <3277560.QJadu78ljV@positron.chronox.de>
References: <3277560.QJadu78ljV@positron.chronox.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add runtime-pluggable support for all PRNGs that are accessible via
the kernel crypto API, including hardware PRNGs. The PRNG is selected
with the module parameter drng_name where the name must be one that the
kernel crypto API can resolve into an RNG.

This allows using of the kernel crypto API PRNG implementations that
provide an interface to hardware PRNGs. Using this extension,
the LRNG uses the hardware PRNGs to generate random numbers. An
example is the S390 CPACF support providing such a PRNG.

The hash is provided by a kernel crypto API SHASH whose digest size
complies with the seedsize of the PRNG.

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
Reviewed-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
Reviewed-by: Roman Drahtmueller <draht@schaltsekun.de>
Tested-by: Roman Drahtm=FCller <draht@schaltsekun.de>
Tested-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
Tested-by: Neil Horman <nhorman@redhat.com>
Signed-off-by: Stephan Mueller <smueller@chronox.de>
=2D--
 drivers/char/lrng/Kconfig      |  13 ++
 drivers/char/lrng/Makefile     |   1 +
 drivers/char/lrng/lrng_kcapi.c | 225 +++++++++++++++++++++++++++++++++
 3 files changed, 239 insertions(+)
 create mode 100644 drivers/char/lrng/lrng_kcapi.c

diff --git a/drivers/char/lrng/Kconfig b/drivers/char/lrng/Kconfig
index 0b94a96e4729..f16bd237ab9e 100644
=2D-- a/drivers/char/lrng/Kconfig
+++ b/drivers/char/lrng/Kconfig
@@ -141,6 +141,19 @@ config LRNG_DRBG
 	  Enable the SP800-90A DRBG support for the LRNG. Once the
 	  module is loaded, output from /dev/random, /dev/urandom,
 	  getrandom(2), or get_random_bytes_full is provided by a DRBG.
+
+config LRNG_KCAPI
+	tristate "Kernel Crypto API support for the LRNG"
+	depends on CRYPTO
+	depends on !LRNG_DRBG
+	select CRYPTO_RNG
+	select LRNG_KCAPI_HASH
+	help
+	  Enable the support for generic pseudo-random number
+	  generators offered by the kernel crypto API with the
+	  LRNG. Once the module is loaded, output from /dev/random,
+	  /dev/urandom, getrandom(2), or get_random_bytes is
+	  provided by the selected kernel crypto API RNG.
 endif # LRNG_DRNG_SWITCH
=20
 endif # LRNG
diff --git a/drivers/char/lrng/Makefile b/drivers/char/lrng/Makefile
index 6ebd252db12f..97d2b13d3227 100644
=2D-- a/drivers/char/lrng/Makefile
+++ b/drivers/char/lrng/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_SYSCTL)		+=3D lrng_proc.o
 obj-$(CONFIG_LRNG_DRNG_SWITCH)	+=3D lrng_switch.o
 obj-$(CONFIG_LRNG_KCAPI_HASH)	+=3D lrng_kcapi_hash.o
 obj-$(CONFIG_LRNG_DRBG)		+=3D lrng_drbg.o
+obj-$(CONFIG_LRNG_KCAPI)	+=3D lrng_kcapi.o
diff --git a/drivers/char/lrng/lrng_kcapi.c b/drivers/char/lrng/lrng_kcapi.c
new file mode 100644
index 000000000000..caecb3841f5b
=2D-- /dev/null
+++ b/drivers/char/lrng/lrng_kcapi.c
@@ -0,0 +1,225 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+/*
+ * Backend for the LRNG providing the cryptographic primitives using the
+ * kernel crypto API.
+ *
+ * Copyright (C) 2018 - 2021, Stephan Mueller <smueller@chronox.de>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <crypto/hash.h>
+#include <crypto/rng.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/lrng.h>
+
+#include "lrng_kcapi_hash.h"
+
+static char *drng_name =3D NULL;
+module_param(drng_name, charp, 0444);
+MODULE_PARM_DESC(drng_name, "Kernel crypto API name of DRNG");
+
+static char *pool_hash =3D "sha512";
+module_param(pool_hash, charp, 0444);
+MODULE_PARM_DESC(pool_hash,
+		 "Kernel crypto API name of hash or keyed message digest to read the ent=
ropy pool");
+
+static char *seed_hash =3D NULL;
+module_param(seed_hash, charp, 0444);
+MODULE_PARM_DESC(seed_hash,
+		 "Kernel crypto API name of hash with output size equal to seedsize of D=
RNG to bring seed string to the size required by the DRNG");
+
+struct lrng_drng_info {
+	struct crypto_rng *kcapi_rng;
+	void *lrng_hash;
+};
+
+static void *lrng_kcapi_drng_hash_alloc(void)
+{
+	return lrng_kcapi_hash_alloc(pool_hash);
+}
+
+static int lrng_kcapi_drng_seed_helper(void *drng, const u8 *inbuf,
+				       u32 inbuflen)
+{
+	SHASH_DESC_ON_STACK(shash, NULL);
+	struct lrng_drng_info *lrng_drng_info =3D (struct lrng_drng_info *)drng;
+	struct crypto_rng *kcapi_rng =3D lrng_drng_info->kcapi_rng;
+	void *hash =3D lrng_drng_info->lrng_hash;
+	u32 digestsize =3D lrng_kcapi_hash_digestsize(hash);
+	u8 digest[64] __aligned(8);
+	int ret;
+
+	if (!hash)
+		return crypto_rng_reset(kcapi_rng, inbuf, inbuflen);
+
+	BUG_ON(digestsize > sizeof(digest));
+
+	ret =3D lrng_kcapi_hash_init(shash, hash) ?:
+	      lrng_kcapi_hash_update(shash, inbuf, inbuflen) ?:
+	      lrng_kcapi_hash_final(shash, digest);
+	if (ret)
+		return ret;
+
+	ret =3D crypto_rng_reset(kcapi_rng, digest, digestsize);
+	if (ret)
+		return ret;
+
+	memzero_explicit(digest, digestsize);
+	return 0;
+}
+
+static int lrng_kcapi_drng_generate_helper(void *drng, u8 *outbuf,
+					   u32 outbuflen)
+{
+	struct lrng_drng_info *lrng_drng_info =3D (struct lrng_drng_info *)drng;
+	struct crypto_rng *kcapi_rng =3D lrng_drng_info->kcapi_rng;
+	int ret =3D crypto_rng_get_bytes(kcapi_rng, outbuf, outbuflen);
+
+	if (ret < 0)
+		return ret;
+
+	return outbuflen;
+}
+
+static void *lrng_kcapi_drng_alloc(u32 sec_strength)
+{
+	struct lrng_drng_info *lrng_drng_info;
+	struct crypto_rng *kcapi_rng;
+	int seedsize;
+	void *ret =3D  ERR_PTR(-ENOMEM);
+
+	if (!drng_name) {
+		pr_err("DRNG name missing\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (!memcmp(drng_name, "drbg", 4) ||
+	    !memcmp(drng_name, "stdrng", 6) ||
+	    !memcmp(drng_name, "jitterentropy_rng", 17)) {
+		pr_err("Refusing to load the requested random number generator\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	lrng_drng_info =3D kmalloc(sizeof(*lrng_drng_info), GFP_KERNEL);
+	if (!lrng_drng_info)
+		return ERR_PTR(-ENOMEM);
+
+	kcapi_rng =3D crypto_alloc_rng(drng_name, 0, 0);
+	if (IS_ERR(kcapi_rng)) {
+		pr_err("DRNG %s cannot be allocated\n", drng_name);
+		ret =3D ERR_CAST(kcapi_rng);
+		goto free;
+	}
+	lrng_drng_info->kcapi_rng =3D kcapi_rng;
+
+	seedsize =3D  crypto_rng_seedsize(kcapi_rng);
+
+	if (sec_strength > seedsize)
+		pr_info("Seedsize DRNG (%u bits) lower than security strength of LRNG no=
ise source (%u bits)\n",
+			crypto_rng_seedsize(kcapi_rng) * 8, sec_strength * 8);
+
+	if (seedsize) {
+		void *lrng_hash;
+
+		if (!seed_hash) {
+			switch (seedsize) {
+			case 32:
+				seed_hash =3D "sha256";
+				break;
+			case 48:
+				seed_hash =3D "sha384";
+				break;
+			case 64:
+				seed_hash =3D "sha512";
+				break;
+			default:
+				pr_err("Seed size %d cannot be processed\n",
+				       seedsize);
+				goto dealloc;
+			}
+		}
+
+		lrng_hash =3D lrng_kcapi_hash_alloc(seed_hash);
+		if (IS_ERR(lrng_hash)) {
+			ret =3D ERR_CAST(lrng_hash);
+			goto dealloc;
+		}
+
+		if (seedsize !=3D lrng_kcapi_hash_digestsize(lrng_hash)) {
+			pr_err("Seed hash output size not equal to DRNG seed size\n");
+			lrng_kcapi_hash_dealloc(lrng_hash);
+			ret =3D ERR_PTR(-EINVAL);
+			goto dealloc;
+		}
+
+		lrng_drng_info->lrng_hash =3D lrng_hash;
+
+		pr_info("Seed hash %s allocated\n", seed_hash);
+	} else {
+		lrng_drng_info->lrng_hash =3D NULL;
+	}
+
+	pr_info("Kernel crypto API DRNG %s allocated\n", drng_name);
+
+	return lrng_drng_info;
+
+dealloc:
+	crypto_free_rng(kcapi_rng);
+free:
+	kfree(lrng_drng_info);
+	return ret;
+}
+
+static void lrng_kcapi_drng_dealloc(void *drng)
+{
+	struct lrng_drng_info *lrng_drng_info =3D (struct lrng_drng_info *)drng;
+	struct crypto_rng *kcapi_rng =3D lrng_drng_info->kcapi_rng;
+
+	crypto_free_rng(kcapi_rng);
+	if (lrng_drng_info->lrng_hash)
+		lrng_kcapi_hash_dealloc(lrng_drng_info->lrng_hash);
+	kfree(lrng_drng_info);
+	pr_info("DRNG %s deallocated\n", drng_name);
+}
+
+static const char *lrng_kcapi_drng_name(void)
+{
+	return drng_name;
+}
+
+static const char *lrng_kcapi_pool_hash(void)
+{
+	return pool_hash;
+}
+
+static const struct lrng_crypto_cb lrng_kcapi_crypto_cb =3D {
+	.lrng_drng_name			=3D lrng_kcapi_drng_name,
+	.lrng_hash_name			=3D lrng_kcapi_pool_hash,
+	.lrng_drng_alloc		=3D lrng_kcapi_drng_alloc,
+	.lrng_drng_dealloc		=3D lrng_kcapi_drng_dealloc,
+	.lrng_drng_seed_helper		=3D lrng_kcapi_drng_seed_helper,
+	.lrng_drng_generate_helper	=3D lrng_kcapi_drng_generate_helper,
+	.lrng_hash_alloc		=3D lrng_kcapi_drng_hash_alloc,
+	.lrng_hash_dealloc		=3D lrng_kcapi_hash_dealloc,
+	.lrng_hash_digestsize		=3D lrng_kcapi_hash_digestsize,
+	.lrng_hash_init			=3D lrng_kcapi_hash_init,
+	.lrng_hash_update		=3D lrng_kcapi_hash_update,
+	.lrng_hash_final		=3D lrng_kcapi_hash_final,
+};
+
+static int __init lrng_kcapi_init(void)
+{
+	return lrng_set_drng_cb(&lrng_kcapi_crypto_cb);
+}
+static void __exit lrng_kcapi_exit(void)
+{
+	lrng_set_drng_cb(NULL);
+}
+
+late_initcall(lrng_kcapi_init);
+module_exit(lrng_kcapi_exit);
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_AUTHOR("Stephan Mueller <smueller@chronox.de>");
+MODULE_DESCRIPTION("Linux Random Number Generator - kernel crypto API DRNG=
 backend");
=2D-=20
2.29.2




