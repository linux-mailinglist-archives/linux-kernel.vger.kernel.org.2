Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0CA33889F8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 10:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344079AbhESI5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 04:57:51 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51167 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245727AbhESI5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 04:57:50 -0400
Received: from mail-ed1-f69.google.com ([209.85.208.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <juerg.haefliger@canonical.com>)
        id 1ljI0D-00042w-Us
        for linux-kernel@vger.kernel.org; Wed, 19 May 2021 08:56:30 +0000
Received: by mail-ed1-f69.google.com with SMTP id n6-20020a0564020606b029038cdc241890so7258244edv.20
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 01:56:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jQfDTjDJ+zDw3M/+SAlmmPaFpSe9q5rG8eps/qbC3cs=;
        b=mE84VXou1Xv9CC/D6W+b6LebRSWtslC8e0j2hP5FpbpjZ2T9B5kXUhZ7hqBPcjs1h1
         TbYGSOXsxNRdf9/8Ui2YPedYu0z9UWvtz3wladXmfO+HVUEV8WAxHBssmGDl3GrxV/OD
         i5l1hb+jlFkIwvmEVTOFQ9ecqXm0U7x4qq536bloedbY0VhbsJmSwvyV0DGVHiJlCsjw
         wKlfJe6VoE3JyspU4gpTpfk0iWFHHSqcfelo+Mz0hOayai/nZqxWY27cTL8M34gJVE8R
         FJ6Xvi9CHgbIayT9cC0d5X00dyIPmkmJ0LXT9OY0rchIXpGi3KVWE+UR1JQI9jajFTB5
         i3zw==
X-Gm-Message-State: AOAM531G7CihSqrIxVaG/mI8gayvESDNpsxXOoPjC69DH/YPwpUHxgv1
        F5izDm3BhhLVArQD9vcxuKmNpXB5/3/U+zTfA35gdlmDGMYm3vPhTTwz5J3WnSyeUmWQ5jfn++Q
        UtGz2Ui6AGmpP0+wprmNvbL+qEQo7Xau37+U5+T5nUg==
X-Received: by 2002:a17:907:20d1:: with SMTP id qq17mr11194635ejb.329.1621414589709;
        Wed, 19 May 2021 01:56:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwB+8Df65yrqPlUbwTYU26pd/VZ5jLmYgsR92CH6s0Adxh/N6hJZG9Vr8XGPZysz8/V5nJlzw==
X-Received: by 2002:a17:907:20d1:: with SMTP id qq17mr11194623ejb.329.1621414589548;
        Wed, 19 May 2021 01:56:29 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id l28sm1364816edc.29.2021.05.19.01.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 01:56:29 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH v2 1/3] init/Kconfig: Move BLK_CGROUP to block/Kconfig
Date:   Wed, 19 May 2021 10:56:13 +0200
Message-Id: <20210519085615.12101-2-juergh@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210519085615.12101-1-juergh@canonical.com>
References: <20210519085615.12101-1-juergh@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While at it, make the option prompt more descriptive and fix the help
text indentation to be 1 tab + 2 spaces.

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 block/Kconfig | 23 +++++++++++++++++++++++
 init/Kconfig  | 22 ----------------------
 2 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/block/Kconfig b/block/Kconfig
index a2297edfdde8..fbc4cf1a2075 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -202,6 +202,29 @@ config BLK_INLINE_ENCRYPTION_FALLBACK
 	  by falling back to the kernel crypto API when inline
 	  encryption hardware is not present.
 
+config BLK_CGROUP
+	bool "Enable block IO cgroup controller"
+	depends on CGROUPS
+	default n
+	help
+	  Generic block IO controller cgroup interface. This is the common
+	  cgroup interface which should be used by various IO controlling
+	  policies.
+
+	  Currently, CFQ IO scheduler uses it to recognize task groups and
+	  control disk bandwidth allocation (proportional time slice allocation)
+	  to such task groups. It is also used by bio throttling logic in
+	  block layer to implement upper limit in IO rates on a device.
+
+	  This option only enables generic Block IO controller infrastructure.
+	  One needs to also enable actual IO controlling logic/policy. For
+	  enabling proportional weight division of disk bandwidth in CFQ, set
+	  CONFIG_BFQ_GROUP_IOSCHED=y; for enabling throttling policy, set
+	  CONFIG_BLK_DEV_THROTTLING=y.
+
+	  See Documentation/admin-guide/cgroup-v1/blkio-controller.rst for more
+	  information.
+
 menu "Partition Types"
 
 source "block/partitions/Kconfig"
diff --git a/init/Kconfig b/init/Kconfig
index 1ea12c64e4c9..5be10c091603 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -921,28 +921,6 @@ config MEMCG_KMEM
 	depends on MEMCG && !SLOB
 	default y
 
-config BLK_CGROUP
-	bool "IO controller"
-	depends on BLOCK
-	default n
-	help
-	Generic block IO controller cgroup interface. This is the common
-	cgroup interface which should be used by various IO controlling
-	policies.
-
-	Currently, CFQ IO scheduler uses it to recognize task groups and
-	control disk bandwidth allocation (proportional time slice allocation)
-	to such task groups. It is also used by bio throttling logic in
-	block layer to implement upper limit in IO rates on a device.
-
-	This option only enables generic Block IO controller infrastructure.
-	One needs to also enable actual IO controlling logic/policy. For
-	enabling proportional weight division of disk bandwidth in CFQ, set
-	CONFIG_BFQ_GROUP_IOSCHED=y; for enabling throttling policy, set
-	CONFIG_BLK_DEV_THROTTLING=y.
-
-	See Documentation/admin-guide/cgroup-v1/blkio-controller.rst for more information.
-
 config CGROUP_WRITEBACK
 	bool
 	depends on MEMCG && BLK_CGROUP
-- 
2.27.0

