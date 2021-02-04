Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0DF30A110
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 06:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbhBAFLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 00:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhBAFLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 00:11:12 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68F8AC0613ED
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 21:10:30 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id m21so9829982qtp.6
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 21:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=OYJeK0hVnx58UggyO2F28C91EjwnMSUOQRtxvIVo72M=;
        b=hhBMcbrNpjg+7F40lsDSYrGfjddDSjDzLPjNoj37hrryrdNJI3HjA17Ec9iLbnAXT2
         NsTQ5vwhzCaClkLOdwTBzvR61b3KFX42FjZ65Aojdi9MhgvT0we1qz0PH78vA+zxFuTR
         W+RfF1bSkIg+HRpUwem3hDBagASF30L+8GiMtJStszxT1UTYU9Wa3luhii9ptuNeXsEY
         54L0tlZA1hTQyBvW4Mws9poX3Q+BHgCEW2VufY8TgVLS/2iQngS1gYDAS1aT6e8BejDp
         UFfrClUcXHtmchVdffrO+GNNlbRVMVKZDPs+sZYUSclSWT7ompouF/NTGnmr1d5zKALx
         0DGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OYJeK0hVnx58UggyO2F28C91EjwnMSUOQRtxvIVo72M=;
        b=IOoiTu8mQLeiKicgyD781kLZTe/hm8LMHu34IFb9f99OVjgmkvrHzaxALZklk5M1EM
         Kfb9EVQgMByERwVliO1uNrPflHaoBCn3xWzd94lGh1UXfjws3cQjd0K4PguosB2G1PkP
         xmit0pfSUDt4PE4BaCAGtc/bG3C2qIqwL7LooG1oqwNPEWf1ehDt2xMUWK57jlUhqtLg
         NviQpen8uGl777h6PzSJhhdtDZrhdC2BxdrqrK7aE1JINJREn3hQXienKtwUjSBALI9/
         mu9uqg7YOfwc20jFAbDOPaJD9Gcf5zsVl15SbTZWJAcjObg3dHyxHEBS3wBEh3i+HjY6
         eRSg==
X-Gm-Message-State: AOAM533wgQhSM3XwYoJpTZG9Dl8pUR9gdzTk+rDEQB2b5r6gow9jUuVg
        pdH4sVoWwpDXpnjPHXNECZZ1Ksz74QA=
X-Google-Smtp-Source: ABdhPJzA4ai7ItUQd6ZhrYgFG/L5lCvckpTLSTAjIG3efXljDLlJWi4+i8Dybs8vpLbTmOxvCmAX9oNJGns=
Sender: "satyat via sendgmr" <satyat@satyaprateek.c.googlers.com>
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a05:6214:48f:: with SMTP id
 ay15mr13728404qvb.58.1612156229581; Sun, 31 Jan 2021 21:10:29 -0800 (PST)
Date:   Mon,  1 Feb 2021 05:10:15 +0000
In-Reply-To: <20210201051019.1174983-1-satyat@google.com>
Message-Id: <20210201051019.1174983-2-satyat@google.com>
Mime-Version: 1.0
References: <20210201051019.1174983-1-satyat@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v4 1/5] block: keyslot-manager: Introduce passthrough keyslot manager
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

The device mapper may map over devices that have inline encryption
capabilities, and to make use of those capabilities, the DM device must
itself advertise those inline encryption capabilities. One way to do this
would be to have the DM device set up a keyslot manager with a
"sufficiently large" number of keyslots, but that would use a lot of
memory. Also, the DM device itself has no "keyslots", and it doesn't make
much sense to talk about "programming a key into a DM device's keyslot
manager", so all that extra memory used to represent those keyslots is just
wasted. All a DM device really needs to be able to do is advertise the
crypto capabilities of the underlying devices in a coherent manner and
expose a way to evict keys from the underlying devices.

There are also devices with inline encryption hardware that do not
have a limited number of keyslots. One can send a raw encryption key along
with a bio to these devices (as opposed to typical inline encryption
hardware that require users to first program a raw encryption key into a
keyslot, and send the index of that keyslot along with the bio). These
devices also only need the same things from the keyslot manager that DM
devices need - a way to advertise crypto capabilities and potentially a way
to expose a function to evict keys from hardware.

So we introduce a "passthrough" keyslot manager that provides a way to
represent a keyslot manager that doesn't have just a limited number of
keyslots, and for which do not require keys to be programmed into keyslots.
DM devices can set up a passthrough keyslot manager in their request
queues, and advertise appropriate crypto capabilities based on those of the
underlying devices. Blk-crypto does not attempt to program keys into any
keyslots in the passthrough keyslot manager. Instead, if/when the bio is
resubmitted to the underlying device, blk-crypto will try to program the
key into the underlying device's keyslot manager.

Signed-off-by: Satya Tangirala <satyat@google.com>
Reviewed-by: Eric Biggers <ebiggers@google.com>
---
 block/keyslot-manager.c         | 39 +++++++++++++++++++++++++++++++++
 include/linux/keyslot-manager.h |  2 ++
 2 files changed, 41 insertions(+)

diff --git a/block/keyslot-manager.c b/block/keyslot-manager.c
index 86f8195d8039..ac7ce83a76e8 100644
--- a/block/keyslot-manager.c
+++ b/block/keyslot-manager.c
@@ -62,6 +62,11 @@ static inline void blk_ksm_hw_exit(struct blk_keyslot_manager *ksm)
 		pm_runtime_put_sync(ksm->dev);
 }
 
+static inline bool blk_ksm_is_passthrough(struct blk_keyslot_manager *ksm)
+{
+	return ksm->num_slots == 0;
+}
+
 /**
  * blk_ksm_init() - Initialize a keyslot manager
  * @ksm: The keyslot_manager to initialize.
@@ -205,6 +210,10 @@ blk_status_t blk_ksm_get_slot_for_key(struct blk_keyslot_manager *ksm,
 	int err;
 
 	*slot_ptr = NULL;
+
+	if (blk_ksm_is_passthrough(ksm))
+		return BLK_STS_OK;
+
 	down_read(&ksm->lock);
 	slot = blk_ksm_find_and_grab_keyslot(ksm, key);
 	up_read(&ksm->lock);
@@ -325,6 +334,16 @@ int blk_ksm_evict_key(struct blk_keyslot_manager *ksm,
 	struct blk_ksm_keyslot *slot;
 	int err = 0;
 
+	if (blk_ksm_is_passthrough(ksm)) {
+		if (ksm->ksm_ll_ops.keyslot_evict) {
+			blk_ksm_hw_enter(ksm);
+			err = ksm->ksm_ll_ops.keyslot_evict(ksm, key, -1);
+			blk_ksm_hw_exit(ksm);
+			return err;
+		}
+		return 0;
+	}
+
 	blk_ksm_hw_enter(ksm);
 	slot = blk_ksm_find_keyslot(ksm, key);
 	if (!slot)
@@ -360,6 +379,9 @@ void blk_ksm_reprogram_all_keys(struct blk_keyslot_manager *ksm)
 {
 	unsigned int slot;
 
+	if (blk_ksm_is_passthrough(ksm))
+		return;
+
 	/* This is for device initialization, so don't resume the device */
 	down_write(&ksm->lock);
 	for (slot = 0; slot < ksm->num_slots; slot++) {
@@ -401,3 +423,20 @@ void blk_ksm_unregister(struct request_queue *q)
 {
 	q->ksm = NULL;
 }
+
+/**
+ * blk_ksm_init_passthrough() - Init a passthrough keyslot manager
+ * @ksm: The keyslot manager to init
+ *
+ * Initialize a passthrough keyslot manager.
+ * Called by e.g. storage drivers to set up a keyslot manager in their
+ * request_queue, when the storage driver wants to manage its keys by itself.
+ * This is useful for inline encryption hardware that doesn't have the concept
+ * of keyslots, and for layered devices.
+ */
+void blk_ksm_init_passthrough(struct blk_keyslot_manager *ksm)
+{
+	memset(ksm, 0, sizeof(*ksm));
+	init_rwsem(&ksm->lock);
+}
+EXPORT_SYMBOL_GPL(blk_ksm_init_passthrough);
diff --git a/include/linux/keyslot-manager.h b/include/linux/keyslot-manager.h
index 18f3f5346843..323e15dd6fa7 100644
--- a/include/linux/keyslot-manager.h
+++ b/include/linux/keyslot-manager.h
@@ -103,4 +103,6 @@ void blk_ksm_reprogram_all_keys(struct blk_keyslot_manager *ksm);
 
 void blk_ksm_destroy(struct blk_keyslot_manager *ksm);
 
+void blk_ksm_init_passthrough(struct blk_keyslot_manager *ksm);
+
 #endif /* __LINUX_KEYSLOT_MANAGER_H */
-- 
2.30.0.365.g02bc693789-goog

