Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17BA343924C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 11:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbhJYJ2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 05:28:42 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51778 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbhJYJ2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 05:28:15 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F001D1FD36;
        Mon, 25 Oct 2021 09:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1635153952; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=10GFf33mgXbeXd7LtUVoCg5gNCuf7Fo2x1CgC+X5gdM=;
        b=VNu5ylDuMLbMh+0yHw8NxTPg3qqKCDE5dFFrtbJhIRGi4P4Rmrdp3su0z5glpRBhibCrn3
        Pk+iJXa6F5L3g0atAbV5zwNgoaj8vH7u/I/FFyS4et6Lk0v8e/tVvgi0Xkce1mrZ4H6879
        ZIuBhVNDTtQtOkh4wBeQjRY1CFi3dBA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1635153952;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=10GFf33mgXbeXd7LtUVoCg5gNCuf7Fo2x1CgC+X5gdM=;
        b=phRnBNg8Z6Da6T/f3Wqm/NiP3GK1urb+CH2v4mFc0MoPlp4aK/f8lwD3PJozS9vGfG44ff
        WqFVoVX2XMDIaYDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DA6FF1377E;
        Mon, 25 Oct 2021 09:25:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id szq/MyB4dmHsSQAAMHmgww
        (envelope-from <nstange@suse.de>); Mon, 25 Oct 2021 09:25:52 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     =?UTF-8?q?Stephan=20M=C3=BCller?= <smueller@chronox.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Torsten Duwe <duwe@suse.de>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nicolai Stange <nstange@suse.de>
Subject: [PATCH 4/6] crypto: DRBG - make reseeding from get_random_bytes() synchronous
Date:   Mon, 25 Oct 2021 11:25:23 +0200
Message-Id: <20211025092525.12805-5-nstange@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211025092525.12805-1-nstange@suse.de>
References: <20211025092525.12805-1-nstange@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_random_bytes() usually hasn't full entropy available by the time DRBG
instances are first getting seeded from it during boot. Thus, the DRBG
implementation registers random_ready_callbacks which would in turn
schedule some work for reseeding the DRBGs once get_random_bytes() has
sufficient entropy available.

For reference, the relevant history around handling DRBG (re)seeding in
the context of a not yet fully seeded get_random_bytes() is:

  commit 16b369a91d0d ("random: Blocking API for accessing
                        nonblocking_pool")
  commit 4c7879907edd ("crypto: drbg - add async seeding operation")

  commit 205a525c3342 ("random: Add callback API for random pool
                        readiness")
  commit 57225e679788 ("crypto: drbg - Use callback API for random
                        readiness")
  commit c2719503f5e1 ("random: Remove kernel blocking API")

However, some time later, the initialization state of get_random_bytes()
has been made queryable via rng_is_initialized() introduced with commit
9a47249d444d ("random: Make crng state queryable"). This primitive now
allows for streamlining the DRBG reseeding from get_random_bytes() by
replacing that aforementioned asynchronous work scheduling from
random_ready_callbacks with some simpler, synchronous code in
drbg_generate() next to the related logic already present therein. Apart
from improving overall code readability, this change will also enable DRBG
users to rely on wait_for_random_bytes() for ensuring that the initial
seeding has completed, if desired.

The previous patches already laid the grounds by making drbg_seed() to
record at each DRBG instance whether it was being seeded at a time when
rng_is_initialized() still had been false as indicated by
->seeded == DRBG_SEED_STATE_PARTIAL.

All that remains to be done now is to make drbg_generate() check for this
condition, determine whether rng_is_initialized() has flipped to true in
the meanwhile and invoke a reseed from get_random_bytes() if so.

Make this move:
- rename the former drbg_async_seed() work handler, i.e. the one in charge
  of reseeding a DRBG instance from get_random_bytes(), to
  "drbg_seed_from_random()",
- change its signature as appropriate, i.e. make it take a struct
  drbg_state rather than a work_struct and change its return type from
  "void" to "int" in order to allow for passing error information from
  e.g. its __drbg_seed() invocation onwards to callers,
- make drbg_generate() invoke this drbg_seed_from_random() once it
  encounters a DRBG instance with ->seeded == DRBG_SEED_STATE_PARTIAL by
  the time rng_is_initialized() has flipped to true and
- prune everything related to the former, random_ready_callback based
  mechanism.

As drbg_seed_from_random() is now getting invoked from drbg_generate() with
the ->drbg_mutex being held, it must not attempt to recursively grab it
once again. Remove the corresponding mutex operations from what is now
drbg_seed_from_random(). Furthermore, as drbg_seed_from_random() can now
report errors directly to its caller, there's no need for it to temporarily
switch the DRBG's ->seeded state to DRBG_SEED_STATE_UNSEEDED so that a
failure of the subsequently invoked __drbg_seed() will get signaled to
drbg_generate(). Don't do it then.

Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 crypto/drbg.c         | 64 +++++++++----------------------------------
 include/crypto/drbg.h |  2 --
 2 files changed, 13 insertions(+), 53 deletions(-)

diff --git a/crypto/drbg.c b/crypto/drbg.c
index 6aad210f101a..d9f7dddfd683 100644
--- a/crypto/drbg.c
+++ b/crypto/drbg.c
@@ -1087,12 +1087,10 @@ static inline int drbg_get_random_bytes(struct drbg_state *drbg,
 	return 0;
 }
 
-static void drbg_async_seed(struct work_struct *work)
+static int drbg_seed_from_random(struct drbg_state *drbg)
 {
 	struct drbg_string data;
 	LIST_HEAD(seedlist);
-	struct drbg_state *drbg = container_of(work, struct drbg_state,
-					       seed_work);
 	unsigned int entropylen = drbg_sec_strength(drbg->core->flags);
 	unsigned char entropy[32];
 	int ret;
@@ -1103,23 +1101,17 @@ static void drbg_async_seed(struct work_struct *work)
 	drbg_string_fill(&data, entropy, entropylen);
 	list_add_tail(&data.list, &seedlist);
 
-	mutex_lock(&drbg->drbg_mutex);
-
 	ret = drbg_get_random_bytes(drbg, entropy, entropylen);
 	if (ret)
-		goto unlock;
-
-	/* Reset ->seeded so that if __drbg_seed fails the next
-	 * generate call will trigger a reseed.
-	 */
-	drbg->seeded = DRBG_SEED_STATE_UNSEEDED;
-
-	__drbg_seed(drbg, &seedlist, true, DRBG_SEED_STATE_FULL);
+		goto out;
 
-unlock:
-	mutex_unlock(&drbg->drbg_mutex);
+	ret = __drbg_seed(drbg, &seedlist, true, DRBG_SEED_STATE_FULL);
+	if (ret)
+		goto out;
 
+out:
 	memzero_explicit(entropy, entropylen);
+	return ret;
 }
 
 /*
@@ -1422,6 +1414,11 @@ static int drbg_generate(struct drbg_state *drbg,
 			goto err;
 		/* 9.3.1 step 7.4 */
 		addtl = NULL;
+	} else if (rng_is_initialized() &&
+		   drbg->seeded == DRBG_SEED_STATE_PARTIAL) {
+		len = drbg_seed_from_random(drbg);
+		if (len)
+			goto err;
 	}
 
 	if (addtl && 0 < addtl->len)
@@ -1514,45 +1511,15 @@ static int drbg_generate_long(struct drbg_state *drbg,
 	return 0;
 }
 
-static void drbg_schedule_async_seed(struct random_ready_callback *rdy)
-{
-	struct drbg_state *drbg = container_of(rdy, struct drbg_state,
-					       random_ready);
-
-	schedule_work(&drbg->seed_work);
-}
-
 static int drbg_prepare_hrng(struct drbg_state *drbg)
 {
-	int err;
-
 	/* We do not need an HRNG in test mode. */
 	if (list_empty(&drbg->test_data.list))
 		return 0;
 
 	drbg->jent = crypto_alloc_rng("jitterentropy_rng", 0, 0);
 
-	INIT_WORK(&drbg->seed_work, drbg_async_seed);
-
-	drbg->random_ready.owner = THIS_MODULE;
-	drbg->random_ready.func = drbg_schedule_async_seed;
-
-	err = add_random_ready_callback(&drbg->random_ready);
-
-	switch (err) {
-	case 0:
-		break;
-
-	case -EALREADY:
-		err = 0;
-		fallthrough;
-
-	default:
-		drbg->random_ready.func = NULL;
-		return err;
-	}
-
-	return err;
+	return 0;
 }
 
 /*
@@ -1646,11 +1613,6 @@ static int drbg_instantiate(struct drbg_state *drbg, struct drbg_string *pers,
  */
 static int drbg_uninstantiate(struct drbg_state *drbg)
 {
-	if (drbg->random_ready.func) {
-		del_random_ready_callback(&drbg->random_ready);
-		cancel_work_sync(&drbg->seed_work);
-	}
-
 	if (!IS_ERR_OR_NULL(drbg->jent))
 		crypto_free_rng(drbg->jent);
 	drbg->jent = NULL;
diff --git a/include/crypto/drbg.h b/include/crypto/drbg.h
index 3ebdb1effe74..a6c3b8e7deb6 100644
--- a/include/crypto/drbg.h
+++ b/include/crypto/drbg.h
@@ -137,12 +137,10 @@ struct drbg_state {
 	bool pr;		/* Prediction resistance enabled? */
 	bool fips_primed;	/* Continuous test primed? */
 	unsigned char *prev;	/* FIPS 140-2 continuous test value */
-	struct work_struct seed_work;	/* asynchronous seeding support */
 	struct crypto_rng *jent;
 	const struct drbg_state_ops *d_ops;
 	const struct drbg_core *core;
 	struct drbg_string test_data;
-	struct random_ready_callback random_ready;
 };
 
 static inline __u8 drbg_statelen(struct drbg_state *drbg)
-- 
2.26.2

