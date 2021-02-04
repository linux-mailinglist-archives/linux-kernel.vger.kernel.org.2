Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3137830A11A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 06:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhBAFNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 00:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbhBAFLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 00:11:53 -0500
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E9EC061573
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 21:10:36 -0800 (PST)
Received: by mail-qk1-x74a.google.com with SMTP id j78so12366981qke.11
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 21:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=5dbuBvoORvra44H0T//SJ47+OoScs3v/BXdSuFHjKFQ=;
        b=YYLSuKZvMvJN3+8Egj6021PwOceEC1MTq0YtNWRJvEr4Q36pKZ9q/t8tj6+MpC4TW/
         fZViS+F3wFWZxIb1zEy3fB0s5/iAGRCNqMZxtTeQeUScAXjaFh4TlScrXzDyBXXIteGK
         QFL9v9Zr/cVzT+t4ddZgZPhy40WtJOX+1pHbkY8eB9CVvwrKbRSE1N0i2vx+oGAAxWI3
         fPCThmUtSOrTgz7kmyFgYKJeESNDFrmm8JKxkfg2osDQtHRhVnHwi5bmqR/4wUyjM+Lw
         2HzjZDZatjt8Dvqv5X+BqYK33TK92SNj+BT11ncZohxiCawVQ2zq2cs6a07CPYRpr8zz
         a5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5dbuBvoORvra44H0T//SJ47+OoScs3v/BXdSuFHjKFQ=;
        b=O3zj3q/klCKhfGBv3VO75NnjugX9WVfjBazf3dsX/OR3/+XKvCDylTEHbWncXdjIkF
         OU0zslcmvBgmXDYLe2uXLHCGnAIA28PUUpQGVD5BrHANBSbuRsz8bIsAu38lHsvsVVTk
         NW+43YSzcSFQrvo0diFyTKiQ2Qpe6IV4rC4jKxkhKa1Tzzg+43AmN14QXBnM3nWXTSH3
         0gZEgHyt0r8Qr3j6x3hP/+uPvoQmpYGn2Il5qRhzeSoHtGmEn+pg3xwHOvFru7ABYuJK
         zcGCMUK4hfhPPnC3y4ou6IBIFlclltI9m9x8kN7TARmxzqkqhorteoGR5DudyxKe/CmI
         tV8A==
X-Gm-Message-State: AOAM531foy7ZQ/9RDhkEFe/mVL5j7cfOZq25Rf5ERjCWqPYbcgJPfQD+
        XoLrTsnYwuAuAcyYWTwibq8wAPWoEXA=
X-Google-Smtp-Source: ABdhPJx2Pz6TVDQTUDY5UjV6VySHGazkLYybFgOpdTP2fqdUKVzBm7DGVFWGS8nr/koqhTJ4IyZGDdXh7Lo=
Sender: "satyat via sendgmr" <satyat@satyaprateek.c.googlers.com>
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a05:6214:1103:: with SMTP id
 e3mr14313403qvs.12.1612156235204; Sun, 31 Jan 2021 21:10:35 -0800 (PST)
Date:   Mon,  1 Feb 2021 05:10:18 +0000
In-Reply-To: <20210201051019.1174983-1-satyat@google.com>
Message-Id: <20210201051019.1174983-5-satyat@google.com>
Mime-Version: 1.0
References: <20210201051019.1174983-1-satyat@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v4 4/5] dm: support key eviction from keyslot managers of
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
index b37f69343923..3eacc5329603 100644
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
@@ -1269,6 +1321,7 @@ dm_table_construct_keyslot_manager(struct dm_table *t)
 
 	ksm = &dksm->ksm;
 	blk_ksm_init_passthrough(ksm);
+	ksm->ksm_ll_ops = dm_ksm_ll_ops;
 	ksm->max_dun_bytes_supported = UINT_MAX;
 	memset(ksm->crypto_modes_supported, 0xFF,
 	       sizeof(ksm->crypto_modes_supported));
-- 
2.30.0.365.g02bc693789-goog

