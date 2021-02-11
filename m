Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2B23319615
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 23:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbhBKWyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 17:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhBKWyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 17:54:33 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44842C061788
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 14:53:53 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id p185so5758736qkc.9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 14:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=LEq8KQgToLHDFLukg3IA/L6jXFJZY5RJ8/C/8sWM9bg=;
        b=cfxPRfaeOWkFY/L/L9jNj52lieSncLRLXzemWHWWTufGS5U4atj4cLMfrds4Lffkca
         z5t8xUizN2KJpKzXb0gRePrKObrT1Tvpeo1rGlg5Ejo49NXLKgxvwxE6sPs+IKwTKROJ
         sOkvShGkJfcrA6ww9YXoHGcsU05ClCRcEKvdWYRf27uO/MVrL2yDhSeDPhonU6jRMg6q
         7oT8X9+DjByk88vNjjcn/5P2E0V46OKip/ZuTP1T6AX+pFp45shzxNxcCZoedymR2Vzv
         7Oxyw4RpYATCCq7kyJCa3mPpGaxe4a6IWtNpdpRgB5AQvfiGclBD1UcM/2fSuO+1EV5L
         wGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LEq8KQgToLHDFLukg3IA/L6jXFJZY5RJ8/C/8sWM9bg=;
        b=K/9xO+wjdZ/JbsHw4NZOEgGC6mzGyRfPyQQ8owlx50817e9sgRnZG08zbpd3upzo+P
         mLIXmVAaO9/UOr9GVtS2TXRm3p75ZJcQinFwAFA2/uJ1+8JP6ngATcaM2kJWECFeYbnt
         eX3vRSdm4IsePQCaO0T7xV5ykTJCXv1h1GQnCECMbjV9zVp1TJTM52ilnVAmS+OOpuNu
         iHfekshfg3ETIevbZ3LWMBVRaXTxGw8EKEaN7VtfG7IKjBvWQGN7DEx6kPrMJRdAl32l
         mzheO+bKStKsFnM/x8sISvFIPgA6kai/ODSTrnrTB1gJPw89Hr+/iagF2xdSQKGhNEMq
         6e+A==
X-Gm-Message-State: AOAM532xHLqGAA43rESTytmWdycFOwKleirTS983bXaSPtxG+oGFbS/R
        CJH51o+q6HgeaCvzPkfPAnqbigkcF8I=
X-Google-Smtp-Source: ABdhPJzU6jFScAHGFijK35P5cXMgSVrIx3//GWGgork74oEnZjzGA16Xgz8KrT+2lLzdU5IOp/ZdJhd9Et8=
Sender: "satyat via sendgmr" <satyat@satyaprateek.c.googlers.com>
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a05:6214:1110:: with SMTP id
 e16mr127390qvs.62.1613084032486; Thu, 11 Feb 2021 14:53:52 -0800 (PST)
Date:   Thu, 11 Feb 2021 22:53:40 +0000
In-Reply-To: <20210211225343.3145732-1-satyat@google.com>
Message-Id: <20210211225343.3145732-3-satyat@google.com>
Mime-Version: 1.0
References: <20210211225343.3145732-1-satyat@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH v5 2/5] block: keyslot-manager: Introduce functions for device
 mapper support
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

Introduce blk_ksm_update_capabilities() to update the capabilities of
a keyslot manager (ksm) in-place. The pointer to a ksm in a device's
request queue may not be easily replaced, because upper layers like
the filesystem might access it (e.g. for programming keys/checking
capabilities) at the same time the device wants to replace that
request queue's ksm (and free the old ksm's memory). This function
allows the device to update the capabilities of the ksm in its request
queue directly. Devices can safely update the ksm this way without any
synchronization with upper layers *only* if the updated (new) ksm
continues to support all the crypto capabilities that the old ksm did
(see description below for blk_ksm_is_superset() for why this is so).

Also introduce blk_ksm_is_superset() which checks whether one ksm's
capabilities are a (not necessarily strict) superset of another ksm's.
The blk-crypto framework requires that crypto capabilities that were
advertised when a bio was created continue to be supported by the
device until that bio is ended - in practice this probably means that
a device's advertised crypto capabilities can *never* "shrink" (since
there's no synchronization between bio creation and when a device may
want to change its advertised capabilities) - so a previously
advertised crypto capability must always continue to be supported.
This function can be used to check that a new ksm is a valid
replacement for an old ksm.

Signed-off-by: Satya Tangirala <satyat@google.com>
Reviewed-by: Eric Biggers <ebiggers@google.com>
Acked-by: Jens Axboe <axboe@kernel.dk>
---
 block/keyslot-manager.c         | 107 ++++++++++++++++++++++++++++++++
 include/linux/keyslot-manager.h |   9 +++
 2 files changed, 116 insertions(+)

diff --git a/block/keyslot-manager.c b/block/keyslot-manager.c
index ac7ce83a76e8..9f9494b80148 100644
--- a/block/keyslot-manager.c
+++ b/block/keyslot-manager.c
@@ -424,6 +424,113 @@ void blk_ksm_unregister(struct request_queue *q)
 	q->ksm = NULL;
 }
 
+/**
+ * blk_ksm_intersect_modes() - restrict supported modes by child device
+ * @parent: The keyslot manager for parent device
+ * @child: The keyslot manager for child device, or NULL
+ *
+ * Clear any crypto mode support bits in @parent that aren't set in @child.
+ * If @child is NULL, then all parent bits are cleared.
+ *
+ * Only use this when setting up the keyslot manager for a layered device,
+ * before it's been exposed yet.
+ */
+void blk_ksm_intersect_modes(struct blk_keyslot_manager *parent,
+			     const struct blk_keyslot_manager *child)
+{
+	if (child) {
+		unsigned int i;
+
+		parent->max_dun_bytes_supported =
+			min(parent->max_dun_bytes_supported,
+			    child->max_dun_bytes_supported);
+		for (i = 0; i < ARRAY_SIZE(child->crypto_modes_supported);
+		     i++) {
+			parent->crypto_modes_supported[i] &=
+				child->crypto_modes_supported[i];
+		}
+	} else {
+		parent->max_dun_bytes_supported = 0;
+		memset(parent->crypto_modes_supported, 0,
+		       sizeof(parent->crypto_modes_supported));
+	}
+}
+EXPORT_SYMBOL_GPL(blk_ksm_intersect_modes);
+
+/**
+ * blk_ksm_is_superset() - Check if a KSM supports a superset of crypto modes
+ *			   and DUN bytes that another KSM supports. Here,
+ *			   "superset" refers to the mathematical meaning of the
+ *			   word - i.e. if two KSMs have the *same* capabilities,
+ *			   they *are* considered supersets of each other.
+ * @ksm_superset: The KSM that we want to verify is a superset
+ * @ksm_subset: The KSM that we want to verify is a subset
+ *
+ * Return: True if @ksm_superset supports a superset of the crypto modes and DUN
+ *	   bytes that @ksm_subset supports.
+ */
+bool blk_ksm_is_superset(struct blk_keyslot_manager *ksm_superset,
+			 struct blk_keyslot_manager *ksm_subset)
+{
+	int i;
+
+	if (!ksm_subset)
+		return true;
+
+	if (!ksm_superset)
+		return false;
+
+	for (i = 0; i < ARRAY_SIZE(ksm_superset->crypto_modes_supported); i++) {
+		if (ksm_subset->crypto_modes_supported[i] &
+		    (~ksm_superset->crypto_modes_supported[i])) {
+			return false;
+		}
+	}
+
+	if (ksm_subset->max_dun_bytes_supported >
+	    ksm_superset->max_dun_bytes_supported) {
+		return false;
+	}
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(blk_ksm_is_superset);
+
+/**
+ * blk_ksm_update_capabilities() - Update the restrictions of a KSM to those of
+ *				   another KSM
+ * @target_ksm: The KSM whose restrictions to update.
+ * @reference_ksm: The KSM to whose restrictions this function will update
+ *		   @target_ksm's restrictions to.
+ *
+ * Blk-crypto requires that crypto capabilities that were
+ * advertised when a bio was created continue to be supported by the
+ * device until that bio is ended. This is turn means that a device cannot
+ * shrink its advertised crypto capabilities without any explicit
+ * synchronization with upper layers. So if there's no such explicit
+ * synchronization, @reference_ksm must support all the crypto capabilities that
+ * @target_ksm does
+ * (i.e. we need blk_ksm_is_superset(@reference_ksm, @target_ksm) == true).
+ *
+ * Note also that as long as the crypto capabilities are being expanded, the
+ * order of updates becoming visible is not important because it's alright
+ * for blk-crypto to see stale values - they only cause blk-crypto to
+ * believe that a crypto capability isn't supported when it actually is (which
+ * might result in blk-crypto-fallback being used if available, or the bio being
+ * failed).
+ */
+void blk_ksm_update_capabilities(struct blk_keyslot_manager *target_ksm,
+				 struct blk_keyslot_manager *reference_ksm)
+{
+	memcpy(target_ksm->crypto_modes_supported,
+	       reference_ksm->crypto_modes_supported,
+	       sizeof(target_ksm->crypto_modes_supported));
+
+	target_ksm->max_dun_bytes_supported =
+				reference_ksm->max_dun_bytes_supported;
+}
+EXPORT_SYMBOL_GPL(blk_ksm_update_capabilities);
+
 /**
  * blk_ksm_init_passthrough() - Init a passthrough keyslot manager
  * @ksm: The keyslot manager to init
diff --git a/include/linux/keyslot-manager.h b/include/linux/keyslot-manager.h
index 323e15dd6fa7..164568f52be7 100644
--- a/include/linux/keyslot-manager.h
+++ b/include/linux/keyslot-manager.h
@@ -103,6 +103,15 @@ void blk_ksm_reprogram_all_keys(struct blk_keyslot_manager *ksm);
 
 void blk_ksm_destroy(struct blk_keyslot_manager *ksm);
 
+void blk_ksm_intersect_modes(struct blk_keyslot_manager *parent,
+			     const struct blk_keyslot_manager *child);
+
 void blk_ksm_init_passthrough(struct blk_keyslot_manager *ksm);
 
+bool blk_ksm_is_superset(struct blk_keyslot_manager *ksm_superset,
+			 struct blk_keyslot_manager *ksm_subset);
+
+void blk_ksm_update_capabilities(struct blk_keyslot_manager *target_ksm,
+				 struct blk_keyslot_manager *reference_ksm);
+
 #endif /* __LINUX_KEYSLOT_MANAGER_H */
-- 
2.30.0.478.g8a0d178c01-goog

