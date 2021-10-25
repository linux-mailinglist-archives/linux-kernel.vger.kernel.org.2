Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE9743924E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 11:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbhJYJ3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 05:29:18 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:51794 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbhJYJ2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 05:28:18 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 337F21FD3A;
        Mon, 25 Oct 2021 09:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1635153956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PfzG/YhHZ46bUJ3sQk66DfwUYllgrdsVoZ2lNBIfPMo=;
        b=TeYFQYHsmPdv1Mu9YgSBUJPmGFFpPpv1bTOp+I9eugbPvXk5zt1tMuOvLWyrinw4ZW1VTe
        PGlk9YOVSniVfeaOXFa6WUU+KHaHjoUcXTUcMDMxt7eXwxyMZBQojbLPXxO6uui82PWj/V
        EQsBwK25iohxHIzJOeVtwe1rfAwavgs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1635153956;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PfzG/YhHZ46bUJ3sQk66DfwUYllgrdsVoZ2lNBIfPMo=;
        b=b245ypgT+4xHjb2/k98zdcu5TSb5XS8I9XWJQILu+ddpFWShAHtLdDc6hLVH6/aqCBViq+
        bswOmIjyF3jn2FDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1FDC41377E;
        Mon, 25 Oct 2021 09:25:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TzbFBiR4dmH5SQAAMHmgww
        (envelope-from <nstange@suse.de>); Mon, 25 Oct 2021 09:25:56 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     =?UTF-8?q?Stephan=20M=C3=BCller?= <smueller@chronox.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Torsten Duwe <duwe@suse.de>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nicolai Stange <nstange@suse.de>
Subject: [PATCH 6/6] crypto: DRBG - reseed 'nopr' drbgs periodically from get_random_bytes()
Date:   Mon, 25 Oct 2021 11:25:25 +0200
Message-Id: <20211025092525.12805-7-nstange@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211025092525.12805-1-nstange@suse.de>
References: <20211025092525.12805-1-nstange@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In contrast to the fully prediction resistant 'pr' DRBGs, the 'nopr'
variants get seeded once at boot and reseeded only rarely thereafter,
namely only after 2^20 requests have been served each. AFAICT, this
reseeding based on the number of requests served is primarily motivated
by information theoretic considerations, c.f. NIST SP800-90Ar1,
sec. 8.6.8 ("Reseeding").

However, given the relatively large seed lifetime of 2^20 requests, the
'nopr' DRBGs can hardly be considered to provide any prediction resistance
whatsoever, i.e. to protect against threats like side channel leaks of the
internal DRBG state (think e.g. leaked VM snapshots). This is expected and
completely in line with the 'nopr' naming, but as e.g. the
"drbg_nopr_hmac_sha512" implementation is potentially being used for
providing the "stdrng" and thus, the crypto_default_rng serving the
in-kernel crypto, it would certainly be desirable to achieve at least the
same level of prediction resistance as get_random_bytes() does.

Note that the chacha20 rngs underlying get_random_bytes() get reseeded
every CRNG_RESEED_INTERVAL == 5min: the secondary, per-NUMA node rngs from
the primary one and the primary rng in turn from the entropy pool, provided
sufficient entropy is available.

The 'nopr' DRBGs do draw randomness from get_random_bytes() for their
initial seed already, so making them to reseed themselves periodically from
get_random_bytes() in order to let them benefit from the latter's
prediction resistance is not such a big change conceptually.

In principle, it would have been also possible to make the 'nopr' DRBGs to
periodically invoke a full reseeding operation, i.e. to also consider the
jitterentropy source (if enabled) in addition to get_random_bytes() for the
seed value. However, get_random_bytes() is relatively lightweight as
compared to the jitterentropy generation process and thus, even though the
'nopr' reseeding is supposed to get invoked infrequently, it's IMO still
worthwhile to avoid occasional latency spikes for drbg_generate() and
stick to get_random_bytes() only. As an additional remark, note that
drawing randomness from the non-SP800-90B-conforming get_random_bytes()
only won't adversely affect SP800-90A conformance either: the very same is
being done during boot via drbg_seed_from_random() already once
rng_is_initialized() flips to true and it follows that if the DRBG
implementation does conform to SP800-90A now, it will continue to do so.

Make the 'nopr' DRBGs to reseed themselves periodically from
get_random_bytes() every CRNG_RESEED_INTERVAL == 5min.

More specifically, introduce a new member ->last_seed_time to struct
drbg_state for recording in units of jiffies when the last seeding
operation had taken place. Make __drbg_seed() maintain it and let
drbg_generate() invoke a reseed from get_random_bytes() via
drbg_seed_from_random() if more than 5min have passed by since the last
seeding operation. Be careful to not to reseed if in testing mode though,
or otherwise the drbg related tests in crypto/testmgr.c would fail to
reproduce the expected output.

In order to keep the formatting clean in drbg_generate() wrap the logic
for deciding whether or not a reseed is due in a new helper,
drbg_nopr_reseed_interval_elapsed().

Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 crypto/drbg.c         | 26 +++++++++++++++++++++++++-
 include/crypto/drbg.h |  1 +
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/crypto/drbg.c b/crypto/drbg.c
index f5947211e0bf..65e5cd2335c1 100644
--- a/crypto/drbg.c
+++ b/crypto/drbg.c
@@ -100,6 +100,7 @@
 #include <crypto/drbg.h>
 #include <crypto/internal/cipher.h>
 #include <linux/kernel.h>
+#include <linux/jiffies.h>
 
 /***************************************************************
  * Backend cipher definitions available to DRBG
@@ -1044,6 +1045,7 @@ static inline int __drbg_seed(struct drbg_state *drbg, struct list_head *seed,
 		return ret;
 
 	drbg->seeded = new_seed_state;
+	drbg->last_seed_time = jiffies;
 	/* 10.1.1.2 / 10.1.1.3 step 5 */
 	drbg->reseed_ctr = 1;
 
@@ -1114,6 +1116,26 @@ static int drbg_seed_from_random(struct drbg_state *drbg)
 	return ret;
 }
 
+static bool drbg_nopr_reseed_interval_elapsed(struct drbg_state *drbg)
+{
+	unsigned long next_reseed;
+
+	/* Don't ever reseed from get_random_bytes() in test mode. */
+	if (list_empty(&drbg->test_data.list))
+		return false;
+
+	/*
+	 * Obtain fresh entropy for the nopr DRBGs after 300s have
+	 * elapsed in order to still achieve sort of partial
+	 * prediction resistance over the time domain at least. Note
+	 * that the period of 300s has been chosen to match the
+	 * CRNG_RESEED_INTERVAL of the get_random_bytes()' chacha
+	 * rngs.
+	 */
+	next_reseed = drbg->last_seed_time + 300 * HZ;
+	return time_after(jiffies, next_reseed);
+}
+
 /*
  * Seeding or reseeding of the DRBG
  *
@@ -1415,7 +1437,8 @@ static int drbg_generate(struct drbg_state *drbg,
 		/* 9.3.1 step 7.4 */
 		addtl = NULL;
 	} else if (rng_is_initialized() &&
-		   drbg->seeded == DRBG_SEED_STATE_PARTIAL) {
+		   (drbg->seeded == DRBG_SEED_STATE_PARTIAL ||
+		    drbg_nopr_reseed_interval_elapsed(drbg))) {
 		len = drbg_seed_from_random(drbg);
 		if (len)
 			goto err;
@@ -1571,6 +1594,7 @@ static int drbg_instantiate(struct drbg_state *drbg, struct drbg_string *pers,
 		drbg->core = &drbg_cores[coreref];
 		drbg->pr = pr;
 		drbg->seeded = DRBG_SEED_STATE_UNSEEDED;
+		drbg->last_seed_time = 0;
 		drbg->reseed_threshold = drbg_max_requests(drbg);
 
 		ret = drbg_alloc_state(drbg);
diff --git a/include/crypto/drbg.h b/include/crypto/drbg.h
index a6c3b8e7deb6..af5ad51d3eef 100644
--- a/include/crypto/drbg.h
+++ b/include/crypto/drbg.h
@@ -134,6 +134,7 @@ struct drbg_state {
 	struct scatterlist sg_in, sg_out;	/* CTR mode SGLs */
 
 	enum drbg_seed_state seeded;		/* DRBG fully seeded? */
+	unsigned long last_seed_time;
 	bool pr;		/* Prediction resistance enabled? */
 	bool fips_primed;	/* Continuous test primed? */
 	unsigned char *prev;	/* FIPS 140-2 continuous test value */
-- 
2.26.2

