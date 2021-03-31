Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 601F1349B9F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 22:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbhCYV1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 17:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbhCYV1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 17:27:19 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E747C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 14:27:19 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id u17so4445825qvq.23
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 14:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dUjmY4UWd3q7eixbohcX5KFuYVowgvQqUqs3sF7t9LE=;
        b=PHOfcspCaLSxOPWiT0PUYJ0/TbzwKQY+raWW2nQ/najal+rd0Pzd+SzzH8ZecubzUj
         JMvkIodlDPQel5IaNC6Qy5fx57hbh+DsGBXOfb4ypClW1f+dzepwGSj2UA65ZvaAacgb
         TAIFs5BeKt5eDnX6fOzvGxDp8NMhZUC9OVps3+0qDar/sAg2PyTVTT8QWoGktSiO/1dW
         EtI9BSI+nVu7nOBVctM9IHjy/Gpjdz5fZad3ZbUXqHvv4xc2g5Z/be30SgB70nvBgCaQ
         /dFxTQ9lgOhyB9s2L/ada+0H4bSi6UpYGInvhhFF3oWuOYy/uLyJeR8Hz6mNnR4AjO6K
         S2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dUjmY4UWd3q7eixbohcX5KFuYVowgvQqUqs3sF7t9LE=;
        b=IgeT/YMV1h0xbRL6PzKNXoYWz71A7BW4YihIMSIlNTcRPeYJYAn0BL9PLBCtFgVsQm
         rHQcANjS2KvHJdalM4SYpE2p65UX5ltoRMFhAgRXF2V3ft31JyCRkuZv02UF50QZIL/X
         0kjMRFQRbRq5m21CGChI95sIYsAlb3QiiVg17j8qzLSNQCWoCzKeingoDQ2p2x3+FF/Y
         zWRyHS5pf4PLsTcl4vjqAAbrvTrJWDye92lVmQ1bZiobxvJQcjRtD3P6ojd+7gPWpwjU
         KDB5skNPxlVTCkbHx7NqJSJoBXnazNdhdtB93Q4FjnDG98oJ68TSW6gIribHZv3VMsce
         fbjg==
X-Gm-Message-State: AOAM533gfiTajRHVDGU0rojFokJDQrRHKBKEMriaXYLCVze1fLp57jF6
        UxUcsTGjpOOY6Q35sgDn4eb7a2M4w3g=
X-Google-Smtp-Source: ABdhPJwO9cWW0q7qtBIPG5hTf2c6Omk6kEypxSh0Mpl1s1xS7+QtraVXMaH12sHXYXP80LwldbP16YWV5Nc=
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:1092])
 (user=satyat job=sendgmr) by 2002:a0c:8f09:: with SMTP id z9mr10071688qvd.25.1616707638809;
 Thu, 25 Mar 2021 14:27:18 -0700 (PDT)
Date:   Thu, 25 Mar 2021 21:26:07 +0000
In-Reply-To: <20210325212609.492188-1-satyat@google.com>
Message-Id: <20210325212609.492188-7-satyat@google.com>
Mime-Version: 1.0
References: <20210325212609.492188-1-satyat@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v2 6/8] block: keyslot-manager: introduce blk_ksm_restrict_dus_to_queue_limits()
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all crypto data unit sizes might be supported by the block layer due to
certain queue limits. This new function checks the queue limits and
appropriately modifies the keyslot manager to reflect only the supported
crypto data unit sizes. blk_ksm_register() runs any given ksm through this
function before actually registering the ksm with a queue.

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 block/keyslot-manager.c | 59 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/block/keyslot-manager.c b/block/keyslot-manager.c
index 2a2b1a9785d2..fad6d9c4b649 100644
--- a/block/keyslot-manager.c
+++ b/block/keyslot-manager.c
@@ -450,12 +450,71 @@ bool blk_ksm_is_empty(struct blk_keyslot_manager *ksm)
 }
 EXPORT_SYMBOL_GPL(blk_ksm_is_empty);
 
+/*
+ * Restrict the supported data unit sizes of the ksm based on the request queue
+ * limits
+ */
+void blk_ksm_restrict_dus_to_queue_limits(struct blk_keyslot_manager *ksm,
+					  struct queue_limits *limits)
+{
+	/* The largest possible data unit size we support is PAGE_SIZE. */
+	unsigned long largest_dus = PAGE_SIZE;
+	unsigned int dus_allowed_mask;
+	int i;
+	bool dus_was_restricted = false;
+
+	/*
+	 * If the queue doesn't support SG gaps, a bio might get split in the
+	 * middle of a data unit. So require SG gap support for inline
+	 * encryption for any data unit size larger than a single sector.
+	 */
+	if (limits->virt_boundary_mask)
+		largest_dus = SECTOR_SIZE;
+
+	/*
+	 * If the queue has chunk_sectors, the bio might be split within a data
+	 * unit if the data unit size is larger than a single sector. So only
+	 * support a single sector data unit size in this case.
+	 */
+	if (limits->chunk_sectors)
+		largest_dus = SECTOR_SIZE;
+
+	/*
+	 * Any bio sent to the queue must be allowed to contain at least a
+	 * data_unit_size worth of data. Since each segment in a bio contains
+	 * at least a SECTOR_SIZE worth of data, it's sufficient that
+	 * queue_max_segments(q) * SECTOR_SIZE >= data_unit_size. So disable
+	 * all data_unit_sizes not satisfiable.
+	 */
+	largest_dus = min(largest_dus,
+			1UL << (fls(limits->max_segments) - 1 + SECTOR_SHIFT));
+
+	/* Clear all unsupported data unit sizes. */
+	dus_allowed_mask = (largest_dus << 1) - 1;
+	for (i = 0; i < ARRAY_SIZE(ksm->crypto_modes_supported); i++) {
+		if (ksm->crypto_modes_supported[i] & (~dus_allowed_mask))
+			dus_was_restricted = true;
+		ksm->crypto_modes_supported[i] &= dus_allowed_mask;
+	}
+
+	if (dus_was_restricted) {
+		pr_warn("Disallowed use of encryption data unit sizes above %lu bytes with inline encryption hardware because of device request queue limits.\n",
+			largest_dus);
+	}
+}
+
 bool blk_ksm_register(struct blk_keyslot_manager *ksm, struct request_queue *q)
 {
 	if (blk_integrity_queue_supports_integrity(q)) {
 		pr_warn("Integrity and hardware inline encryption are not supported together. Disabling hardware inline encryption.\n");
 		return false;
 	}
+
+	blk_ksm_restrict_dus_to_queue_limits(ksm, &q->limits);
+
+	if (blk_ksm_is_empty(ksm))
+		return false;
+
 	q->ksm = ksm;
 	return true;
 }
-- 
2.31.0.291.g576ba9dcdaf-goog

