Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0F4439244
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 11:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbhJYJ2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 05:28:14 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:33628 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232499AbhJYJ2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 05:28:10 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id ACD1A21916;
        Mon, 25 Oct 2021 09:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1635153947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DWP5nMcOPD+1vCspldVUcF00fOf/6ehdRFVsR+HwUbs=;
        b=kCgJGVcvzkpoU+KnTxj0Jv7zVC/UDqf/wUH/TkH4iP0e1FPt9gUjudp26K8IHVvBaEQuAU
        XBYuUwlgBKBG3Q0n1/Z2zEobo0wO1KjBIH2KCLMakOm/zaDyL99xfDYQoOT0o5YyVgFvZj
        81NDiCdGp9NGo+95bEuORHS+jDDVhps=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1635153947;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DWP5nMcOPD+1vCspldVUcF00fOf/6ehdRFVsR+HwUbs=;
        b=E6KAVnG2QhNYlY8NrQy36QZX2rhv9B4/TNs0hxuTDWpevGSaqaTPHqXJlzDPDdXgH/z6CZ
        NaMwhJAULcT1bNBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 988101377E;
        Mon, 25 Oct 2021 09:25:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LakBJBt4dmHgSQAAMHmgww
        (envelope-from <nstange@suse.de>); Mon, 25 Oct 2021 09:25:47 +0000
From:   Nicolai Stange <nstange@suse.de>
To:     =?UTF-8?q?Stephan=20M=C3=BCller?= <smueller@chronox.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Torsten Duwe <duwe@suse.de>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nicolai Stange <nstange@suse.de>
Subject: [PATCH 1/6] crypto: DRBG - prepare for more fine-grained tracking of seeding state
Date:   Mon, 25 Oct 2021 11:25:20 +0200
Message-Id: <20211025092525.12805-2-nstange@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211025092525.12805-1-nstange@suse.de>
References: <20211025092525.12805-1-nstange@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two different randomness sources the DRBGs are getting seeded
from, namely the jitterentropy source (if enabled) and get_random_bytes().
At initial DRBG seeding time during boot, the latter might not have
collected sufficient entropy for seeding itself yet and thus, the DRBG
implementation schedules a reseed work from a random_ready_callback once
that has happened. This is particularly important for the !->pr DRBG
instances, for which (almost) no further reseeds are getting triggered
during their lifetime.

Because collecting data from the jitterentropy source is a rather expensive
operation, the aforementioned asynchronously scheduled reseed work
restricts itself to get_random_bytes() only. That is, it in some sense
amends the initial DRBG seed derived from jitterentropy output at full
(estimated) entropy with fresh randomness obtained from get_random_bytes()
once that has been seeded with sufficient entropy itself.

With the advent of rng_is_initialized(), there is no real need for doing
the reseed operation from an asynchronously scheduled work anymore and a
subsequent patch will make it synchronous by moving it next to related
logic already present in drbg_generate().

However, for tracking whether a full reseed including the jitterentropy
source is required or a "partial" reseed involving only get_random_bytes()
would be sufficient already, the boolean struct drbg_state's ->seeded
member must become a tristate value.

Prepare for this by introducing the new enum drbg_seed_state and change
struct drbg_state's ->seeded member's type from bool to that type.

For facilitating review, enum drbg_seed_state is made to only contain
two members corresponding to the former ->seeded values of false and true
resp. at this point: DRBG_SEED_STATE_UNSEEDED and DRBG_SEED_STATE_FULL. A
third one for tracking the intermediate state of "seeded from jitterentropy
only" will be introduced with a subsequent patch.

There is no change in behaviour at this point.

Signed-off-by: Nicolai Stange <nstange@suse.de>
---
 crypto/drbg.c         | 19 ++++++++++---------
 include/crypto/drbg.h |  7 ++++++-
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/crypto/drbg.c b/crypto/drbg.c
index ea85d4a0fe9e..8651bd2c5c82 100644
--- a/crypto/drbg.c
+++ b/crypto/drbg.c
@@ -1043,7 +1043,7 @@ static inline int __drbg_seed(struct drbg_state *drbg, struct list_head *seed,
 	if (ret)
 		return ret;
 
-	drbg->seeded = true;
+	drbg->seeded = DRBG_SEED_STATE_FULL;
 	/* 10.1.1.2 / 10.1.1.3 step 5 */
 	drbg->reseed_ctr = 1;
 
@@ -1088,14 +1088,14 @@ static void drbg_async_seed(struct work_struct *work)
 	if (ret)
 		goto unlock;
 
-	/* Set seeded to false so that if __drbg_seed fails the
-	 * next generate call will trigger a reseed.
+	/* Reset ->seeded so that if __drbg_seed fails the next
+	 * generate call will trigger a reseed.
 	 */
-	drbg->seeded = false;
+	drbg->seeded = DRBG_SEED_STATE_UNSEEDED;
 
 	__drbg_seed(drbg, &seedlist, true);
 
-	if (drbg->seeded)
+	if (drbg->seeded == DRBG_SEED_STATE_FULL)
 		drbg->reseed_threshold = drbg_max_requests(drbg);
 
 unlock:
@@ -1386,13 +1386,14 @@ static int drbg_generate(struct drbg_state *drbg,
 	 * here. The spec is a bit convoluted here, we make it simpler.
 	 */
 	if (drbg->reseed_threshold < drbg->reseed_ctr)
-		drbg->seeded = false;
+		drbg->seeded = DRBG_SEED_STATE_UNSEEDED;
 
-	if (drbg->pr || !drbg->seeded) {
+	if (drbg->pr || drbg->seeded == DRBG_SEED_STATE_UNSEEDED) {
 		pr_devel("DRBG: reseeding before generation (prediction "
 			 "resistance: %s, state %s)\n",
 			 drbg->pr ? "true" : "false",
-			 drbg->seeded ? "seeded" : "unseeded");
+			 (drbg->seeded ==  DRBG_SEED_STATE_FULL ?
+			  "seeded" : "unseeded"));
 		/* 9.3.1 steps 7.1 through 7.3 */
 		len = drbg_seed(drbg, addtl, true);
 		if (len)
@@ -1578,7 +1579,7 @@ static int drbg_instantiate(struct drbg_state *drbg, struct drbg_string *pers,
 	if (!drbg->core) {
 		drbg->core = &drbg_cores[coreref];
 		drbg->pr = pr;
-		drbg->seeded = false;
+		drbg->seeded = DRBG_SEED_STATE_UNSEEDED;
 		drbg->reseed_threshold = drbg_max_requests(drbg);
 
 		ret = drbg_alloc_state(drbg);
diff --git a/include/crypto/drbg.h b/include/crypto/drbg.h
index c4165126937e..92a87b23ad2f 100644
--- a/include/crypto/drbg.h
+++ b/include/crypto/drbg.h
@@ -105,6 +105,11 @@ struct drbg_test_data {
 	struct drbg_string *testentropy; /* TEST PARAMETER: test entropy */
 };
 
+enum drbg_seed_state {
+	DRBG_SEED_STATE_UNSEEDED,
+	DRBG_SEED_STATE_FULL,
+};
+
 struct drbg_state {
 	struct mutex drbg_mutex;	/* lock around DRBG */
 	unsigned char *V;	/* internal state 10.1.1.1 1a) */
@@ -127,7 +132,7 @@ struct drbg_state {
 	struct crypto_wait ctr_wait;		/* CTR mode async wait obj */
 	struct scatterlist sg_in, sg_out;	/* CTR mode SGLs */
 
-	bool seeded;		/* DRBG fully seeded? */
+	enum drbg_seed_state seeded;		/* DRBG fully seeded? */
 	bool pr;		/* Prediction resistance enabled? */
 	bool fips_primed;	/* Continuous test primed? */
 	unsigned char *prev;	/* FIPS 140-2 continuous test value */
-- 
2.26.2

