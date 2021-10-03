Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8A14203D7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 22:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbhJCUDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 16:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbhJCUDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 16:03:08 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823F0C0613EC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 13:01:20 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id g10so2779690vsb.8
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 13:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HoLG1xadIhb37Moe2giR32FgTB7t+l3y/OOs4uvCyVs=;
        b=kRbNTeXD+RgsVyU+Ta1fIauroLL94BIu81u4UdVoSQ3vZ/s97G1QIAsvktd1ELdHqt
         3kyU7q5jZhJPN8a8LircbdF15h57AClMJ7m23KXXr8DFDaabNSNfxjD4/UnPv4Kmxb+l
         C1800PprDhyO1eu+vyGLSj0wEd3J4bmH0C+eMQ9Ag1XQ0F5MBNwZw2m7eVae7eTHlfM8
         yrgTzogDb4agXC3KLrqQRZPBH02PTlxzL5bToocS3rk22S581yPGbV7AOy63GNhn5T7o
         dAC26OGoOASnpRjoEgJ5Zge0mijYwQu1tJPhO/fGP3XJBV8S0fsGqR26nHlyFWrGaLGb
         8xwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HoLG1xadIhb37Moe2giR32FgTB7t+l3y/OOs4uvCyVs=;
        b=DrxKrNZnU41mAt1nJplqEVgWHQd/lQcFficUI1I0NgWpOyKERy07I2+8Qz836lwQ34
         YUTNoWP7Mb996IePcWeYFBjiN75Ze/AStaYRBv477jay3NLxXaIxo4p5f4BmbLnFWZyW
         YNX3Fs/z2zgBUGl0pdrbEsIxJCtkT3fit0zDmcOMifXJ6phsywBQcdCMG36h6EYMYaNC
         /HM2lHGU82Xz55XcNiO/YJfNkaQ6ag6I/vnB76KKsPCR5bvnn+O0qLtG/zv6Y7mgxDoM
         MUTlrf4oikdxAMQUWprTibaUJnYJFHa5gjbmmex3trDrcqP/1qEXt2YNTqGXs21L5o9X
         bhJA==
X-Gm-Message-State: AOAM531UyLCVDfq9ixze/OBzzJNkPr/jhimwtP2BbXJEN8v9uH0cV4MI
        /BNTcAO/ky0gwXr80ITFTqk=
X-Google-Smtp-Source: ABdhPJyeB65tXOofex2kQAVQOCCG+rInAXqURozdvA+f5Qf1SXX0kpuXaERC1WMRcV4As2POF2ghmw==
X-Received: by 2002:a05:6102:226f:: with SMTP id v15mr10767172vsd.50.1633291279744;
        Sun, 03 Oct 2021 13:01:19 -0700 (PDT)
Received: from localhost.localdomain ([181.23.73.135])
        by smtp.gmail.com with ESMTPSA id x21sm6691019uao.2.2021.10.03.13.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 13:01:19 -0700 (PDT)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        stefan.wahren@i2se.com, arnd@arndb.de, dan.carpenter@oracle.com,
        ojaswin98@gmail.com, amarjargal16@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, gascoar@gmail.com
Subject: [PATCH 4/9] staging: vchiq_core.h: use preferred kernel types
Date:   Sun,  3 Oct 2021 16:57:57 -0300
Message-Id: <20211003195758.36572-5-gascoar@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211003195758.36572-1-gascoar@gmail.com>
References: <20211003195758.36572-1-gascoar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change types from uint32_t and uint64_t to the preferred ones u32 and
u64.

Reported by checkpatch.pl

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
2.33.0

