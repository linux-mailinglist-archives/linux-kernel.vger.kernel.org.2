Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 100B9438C1D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 23:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbhJXV20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 17:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbhJXV2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 17:28:14 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E90C061767
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 14:25:53 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id b4so6061265uaq.9
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 14:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CsYmpFKWOiWQ03jQad0Q3T5GnVeBFD+8qIGd8B/YeyY=;
        b=JPAwHuqEg5OBJ3gqusFUTC8GAHeSKNv+lB1wjHmRjh8VCr9e9tjJFqc5tTL8u10NoD
         QzM3RIhX3qBj6XF6/UtIp/dTkt3cmnit+rvRoKwaJqQH73mlUqOzwzOyEHMJwbY/F+1U
         u6lCo6nphuGSU54ykEzL+fByO/50ZRB6Ecaeo62E5gvCVvmEkO/AGM9ZLZW1m3BelRVU
         GEhqPUCYprL1aHyZUC7LON0oxinDh2RccwDKe0l/WHFkhKF7gLWZ1xwfyBLbgTMgupr8
         MNGOeAO/x2PxXQ55wiO0bWzplHd3hEDg0RvLK95k5FuuqbjSEdg8xbAixZx8ZxbF0XcL
         Vd7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CsYmpFKWOiWQ03jQad0Q3T5GnVeBFD+8qIGd8B/YeyY=;
        b=nL/ksREL9MGDaTOVUgq/PldL4IqCMBPcVRTkroPnTdkb9FgWqnR1NKi6wgSgtY7Z/P
         yFL3quaO/6NAsbpWDhd+0kV0csfcvccCYxlN1UXeWLZ5doQzj4PmALD5PsKYtUsnFDGn
         iSF5iLCRfzhJuH0pjU6JoCSbBdbQ9huo83CG1zleqUkK1bCjXtzSQ6eLFxVaU+7Bwpzc
         ys6aEO3Ey8toX8TwN+Umtb81ix3GrG7l/aTcScrlQsk6sZeXkw4QjkgM8FOQf+j2mz4S
         TZyfwO3r78GB2lEm+z3ZENPW59+Z3IceRlhYZATItTgn3lZB9Vv0QSSVreIeMYuCzDa1
         FcfA==
X-Gm-Message-State: AOAM533ogM3pDHKEB3G/RfLbd+potidC8v26gafcu3UTQ+rMH+hZEDxl
        I1iatJ/72IGqIu5GR9I1NMw=
X-Google-Smtp-Source: ABdhPJw3Z50PnALm/Vittr9/gmw0CgP7YCwh9FKl6QYIV10vcyW9unkPO+zMDXnqpXBuGQuvXjaxhg==
X-Received: by 2002:a05:6102:21b8:: with SMTP id i24mr355424vsb.51.1635110752482;
        Sun, 24 Oct 2021 14:25:52 -0700 (PDT)
Received: from localhost.localdomain ([191.83.215.63])
        by smtp.gmail.com with ESMTPSA id 45sm8847869uaq.8.2021.10.24.14.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 14:25:52 -0700 (PDT)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        stefan.wahren@i2se.com, arnd@arndb.de, dan.carpenter@oracle.com,
        ojaswin98@gmail.com, amarjargal16@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, gascoar@gmail.com
Subject: [PATCH v2 4/8] staging: vchiq_core.h: use preferred kernel types
Date:   Sun, 24 Oct 2021 18:25:20 -0300
Message-Id: <20211024212524.370078-5-gascoar@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211024212524.370078-1-gascoar@gmail.com>
References: <20211024212524.370078-1-gascoar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change types from uint32_t and uint64_t to the preferred ones u32 and
u64.

Reported by checkpatch.pl, with the exception of the one in function
vchiq_log_dump_mem().

Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
---
 .../vc04_services/interface/vchiq_arm/vchiq_core.h   | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
index 383c3bcf787e..a107c72ce3a6 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
@@ -74,7 +74,7 @@
 	((fourcc) >>  8) & 0xff, \
 	(fourcc) & 0xff
 
-typedef uint32_t BITSET_T;
+typedef u32 BITSET_T;
 
 static_assert((sizeof(BITSET_T) * 8) == 32);
 
@@ -231,10 +231,10 @@ struct vchiq_service {
 		int bulk_tx_count;
 		int bulk_rx_count;
 		int bulk_aborted_count;
-		uint64_t ctrl_tx_bytes;
-		uint64_t ctrl_rx_bytes;
-		uint64_t bulk_tx_bytes;
-		uint64_t bulk_rx_bytes;
+		u64 ctrl_tx_bytes;
+		u64 ctrl_rx_bytes;
+		u64 bulk_tx_bytes;
+		u64 bulk_rx_bytes;
 	} stats;
 
 	int msg_queue_read;
@@ -622,7 +622,7 @@ extern void
 vchiq_set_conn_state(struct vchiq_state *state, enum vchiq_connstate newstate);
 
 extern void
-vchiq_log_dump_mem(const char *label, uint32_t addr, const void *void_mem, size_t num_bytes);
+vchiq_log_dump_mem(const char *label, u32 addr, const void *void_mem, size_t num_bytes);
 
 extern enum vchiq_status vchiq_remove_service(unsigned int service);
 
-- 
2.33.1

