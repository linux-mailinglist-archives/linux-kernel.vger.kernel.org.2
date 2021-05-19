Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2B03889FC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 10:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344160AbhESI5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 04:57:55 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51177 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245727AbhESI5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 04:57:52 -0400
Received: from mail-ed1-f69.google.com ([209.85.208.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <juerg.haefliger@canonical.com>)
        id 1ljI0G-000445-Cs
        for linux-kernel@vger.kernel.org; Wed, 19 May 2021 08:56:32 +0000
Received: by mail-ed1-f69.google.com with SMTP id v18-20020a0564023492b029038d5ad7c8a8so2315377edc.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 01:56:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rxgTSGLGsPNE+HFZu6RZbhOQgcO/K1P0N9aRKRAr0to=;
        b=AUW08CHi8BGKWduKVxktMC8VRISuUjnlD+zu12gyCcz5BwBSy2kEoLqol/SJ4N2aDZ
         lQm8iLxBJZ3z5iQOnNG27KWXtojxRh83EHeE/MdEJB+nRiisGDJ/jHakF9mvZ49PJram
         tO2FVdqdoetC1FzwKlOF7my4/inxl0YoMCRE+K2aCv7V/3W8cggVVbM9oBkIPz/YUlR+
         uIfagq4bln+JIOiiCQuSEiAWefuRAGmT9GIgUvZwDz39bAftr17GmAuAKhXK+eGjNeq2
         oe9QKpDKubWuIgLbCdadgex9vGL6b8RA8CbG07O34mFiZAXyuFfAAdpfUthzcUdSraZZ
         JoPw==
X-Gm-Message-State: AOAM533WYcH1cBA5X0eKkutsu/F0XKrij31LMHUa7t+QSa4rzw6t+SBB
        16dWXNxJqFvwjp5zEG98rUJNAtt1ROX9CnayRuYQDeisvErYRdUnnQ2VWOCt36UTBza3pjWC3MQ
        g5RRWORMgCQ8o5VFZeSx09SD5Bx5vDJCcbGX43N5NpQ==
X-Received: by 2002:a05:6402:281:: with SMTP id l1mr5443487edv.58.1621414592144;
        Wed, 19 May 2021 01:56:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy5p+HilFZEesm7IJLBx/xeFdN1sN2PzqChZsE1Yf3YM6KA4aFN3PGm4tAME+XWzeliPAFPQA==
X-Received: by 2002:a05:6402:281:: with SMTP id l1mr5443472edv.58.1621414591927;
        Wed, 19 May 2021 01:56:31 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id l28sm1364816edc.29.2021.05.19.01.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 01:56:31 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH v2 3/3] block/Kconfig.iosched: Whitespace and indentation cleanups
Date:   Wed, 19 May 2021 10:56:15 +0200
Message-Id: <20210519085615.12101-4-juergh@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210519085615.12101-1-juergh@canonical.com>
References: <20210519085615.12101-1-juergh@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace multiple whitespaces with a tab and make the help text indendation
1 tab + 2 spaces which seems to be the convention.

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 block/Kconfig.iosched | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/block/Kconfig.iosched b/block/Kconfig.iosched
index 2f2158e05a91..57939e7e1ff3 100644
--- a/block/Kconfig.iosched
+++ b/block/Kconfig.iosched
@@ -21,28 +21,27 @@ config MQ_IOSCHED_KYBER
 config IOSCHED_BFQ
 	tristate "BFQ I/O scheduler"
 	help
-	BFQ I/O scheduler for BLK-MQ. BFQ distributes the bandwidth of
-	of the device among all processes according to their weights,
-	regardless of the device parameters and with any workload. It
-	also guarantees a low latency to interactive and soft
-	real-time applications.  Details in
-	Documentation/block/bfq-iosched.rst
+	  BFQ I/O scheduler for BLK-MQ. BFQ distributes the bandwidth of
+	  of the device among all processes according to their weights,
+	  regardless of the device parameters and with any workload. It
+	  also guarantees a low latency to interactive and soft
+	  real-time applications.  Details in
+	  Documentation/block/bfq-iosched.rst
 
 config BFQ_GROUP_IOSCHED
-       bool "BFQ hierarchical scheduling support"
-       depends on IOSCHED_BFQ && BLK_CGROUP
-       select BLK_CGROUP_RWSTAT
+	bool "BFQ hierarchical scheduling support"
+	depends on IOSCHED_BFQ && BLK_CGROUP
+	select BLK_CGROUP_RWSTAT
 	help
-
-       Enable hierarchical scheduling in BFQ, using the blkio
-       (cgroups-v1) or io (cgroups-v2) controller.
+	  Enable hierarchical scheduling in BFQ, using the blkio
+	  (cgroups-v1) or io (cgroups-v2) controller.
 
 config BFQ_CGROUP_DEBUG
 	bool "BFQ IO controller debugging"
 	depends on BFQ_GROUP_IOSCHED
 	help
-	Enable some debugging help. Currently it exports additional stat
-	files in a cgroup which can be useful for debugging.
+	  Enable some debugging help. Currently it exports additional stat
+	  files in a cgroup which can be useful for debugging.
 
 endmenu
 
-- 
2.27.0

