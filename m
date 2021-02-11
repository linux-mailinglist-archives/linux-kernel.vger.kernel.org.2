Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A1531961F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 23:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbhBKWza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 17:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhBKWzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 17:55:14 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB740C061793
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 14:53:56 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id g19so5466855pfo.19
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 14:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=PzZ3HqYXXMl4x2ko2AkyE6044tKsCbJJ6g3BR1Cqc4U=;
        b=VMR9fwBw+N+vaWHcFXK3rnI3ZsKDRmCwOY3WpZeIPfakOWfkpzv6nTp2m4BxJougLu
         A2yAYOJhIUSD1hhs64JoQjmNyH5A7WJs05SQcL2sC+vkVM6hkRrlA7AC+xgoKHv9bKI8
         YzAMCxey9+mHDKWIlO1Ctl660ve7MgD+1YLon2hGTuxrUayqc+WMtU4lDCROP4+wG+Lu
         YBoY5jq97Wl+F7sgPnG8xifCNHHNfTxsCaUrN+DvVeP/A9Rx+Zvmw3Km8fmcXLKK0kR2
         WpbHlT9IroRY7+RWkcuqD5mrI5R3952W27wss+dOUNgkiPFSUFxYT3QoaJdsGeE56ahJ
         4Qng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PzZ3HqYXXMl4x2ko2AkyE6044tKsCbJJ6g3BR1Cqc4U=;
        b=W5KlTy7fyU/dwgTFb38ztbT3pBiKSVLAMy66RzFsBk0idzy9MLdIH/2+MxZSUqbHl6
         XUb+cNnMEBhgJuCzASXluHmP3yG4sUzaePhCJVFoa5ZA8Br3ZTmnTY3WqRT/e4UjVM6D
         5v+IErU8kpI5JyCKc47hlj50+6VXNtJPi5YSLJZQNJahFi98nZyveI41mHQeZBFJv22Q
         edqFHk7eocrbP57gFSa9KmHcF+LqsLMkQpBJ7+9m6b28gwvOltI8WGYzBV+rSBZTlHxZ
         l1VKEGr2bzYqygXN4Sfj1X4nzPQaR7rx9dWiogqF81dzz3UeiDVxMlVAP6jZj0+CWJSi
         AYVg==
X-Gm-Message-State: AOAM530cP6oMcwP7YrL+c4s4LkpWcKGsBgPeQiuPr9ZNO3UReph0xLoh
        QTelRgR8MafoY0pcMHRiGl1xRCV2YEs=
X-Google-Smtp-Source: ABdhPJxr7Lu0fj77ZerbVC8vr9ZFlGLKh5WjfVS661/jKvtGrdEM4EOTjautbcR2338CpJZzoQ2SJIKLixQ=
Sender: "satyat via sendgmr" <satyat@satyaprateek.c.googlers.com>
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a17:90b:1217:: with SMTP id
 gl23mr5924163pjb.163.1613084036078; Thu, 11 Feb 2021 14:53:56 -0800 (PST)
Date:   Thu, 11 Feb 2021 22:53:42 +0000
In-Reply-To: <20210211225343.3145732-1-satyat@google.com>
Message-Id: <20210211225343.3145732-5-satyat@google.com>
Mime-Version: 1.0
References: <20210211225343.3145732-1-satyat@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v5 4/5] dm: support key eviction from keyslot managers of
 underlying devices
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com
Cc:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that device mapper supports inline encryption, add the ability to
evict keys from all underlying devices. When an upper layer requests
a key eviction, we simply iterate through all underlying devices
and evict that key from each device.

Co-developed-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Satya Tangirala <satyat@google.com>
Reviewed-by: Eric Biggers <ebiggers@google.com>
---
 block/blk-crypto.c    |  1 +
 drivers/md/dm-table.c | 53 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/block/blk-crypto.c b/block/blk-crypto.c
index 5da43f0973b4..c2be8f15006c 100644
--- a/block/blk-crypto.c
+++ b/block/blk-crypto.c
@@ -409,3 +409,4 @@ int blk_crypto_evict_key(struct request_queue *q,
 	 */
 	return blk_crypto_fallback_evict_key(key);
 }
+EXPORT_SYMBOL_GPL(blk_crypto_evict_key);
diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index fbaadfc6eed9..b036a349aaad 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1214,6 +1214,58 @@ struct dm_keyslot_manager {
 	struct mapped_device *md;
 };
 
+struct dm_keyslot_evict_args {
+	const struct blk_crypto_key *key;
+	int err;
+};
+
+static int dm_keyslot_evict_callback(struct dm_target *ti, struct dm_dev *dev,
+				     sector_t start, sector_t len, void *data)
+{
+	struct dm_keyslot_evict_args *args = data;
+	int err;
+
+	err = blk_crypto_evict_key(bdev_get_queue(dev->bdev), args->key);
+	if (!args->err)
+		args->err = err;
+	/* Always try to evict the key from all devices. */
+	return 0;
+}
+
+/*
+ * When an inline encryption key is evicted from a device-mapper device, evict
+ * it from all the underlying devices.
+ */
+static int dm_keyslot_evict(struct blk_keyslot_manager *ksm,
+			    const struct blk_crypto_key *key, unsigned int slot)
+{
+	struct dm_keyslot_manager *dksm = container_of(ksm,
+						       struct dm_keyslot_manager,
+						       ksm);
+	struct mapped_device *md = dksm->md;
+	struct dm_keyslot_evict_args args = { key };
+	struct dm_table *t;
+	int srcu_idx;
+	int i;
+	struct dm_target *ti;
+
+	t = dm_get_live_table(md, &srcu_idx);
+	if (!t)
+		return 0;
+	for (i = 0; i < dm_table_get_num_targets(t); i++) {
+		ti = dm_table_get_target(t, i);
+		if (!ti->type->iterate_devices)
+			continue;
+		ti->type->iterate_devices(ti, dm_keyslot_evict_callback, &args);
+	}
+	dm_put_live_table(md, srcu_idx);
+	return args.err;
+}
+
+static struct blk_ksm_ll_ops dm_ksm_ll_ops = {
+	.keyslot_evict = dm_keyslot_evict,
+};
+
 static int device_intersect_crypto_modes(struct dm_target *ti,
 					 struct dm_dev *dev, sector_t start,
 					 sector_t len, void *data)
@@ -1271,6 +1323,7 @@ dm_table_construct_keyslot_manager(struct dm_table *t)
 
 	ksm = &dksm->ksm;
 	blk_ksm_init_passthrough(ksm);
+	ksm->ksm_ll_ops = dm_ksm_ll_ops;
 	ksm->max_dun_bytes_supported = UINT_MAX;
 	memset(ksm->crypto_modes_supported, 0xFF,
 	       sizeof(ksm->crypto_modes_supported));
-- 
2.30.0.478.g8a0d178c01-goog

