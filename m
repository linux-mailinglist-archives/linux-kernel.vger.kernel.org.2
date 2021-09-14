Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9173040BA70
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 23:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235171AbhINVjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 17:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234675AbhINVjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 17:39:45 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5479C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 14:38:27 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id r21so408781qtw.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 14:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gTyzltWgTFXOPjw+JtVdJBDzeHI6HlS3kPelko2mAhw=;
        b=pTJXXzRDKNPU9M1obXdrsuGlbMwi0taGqkvHnjZmaU4JR8i2I/61GJlKgJl73KlWAl
         1tJeDR25y7tSKG2u7mIL/9kaEgY11SGN/Y/3Orpbt3heF0j5nu7n5BoHanImH0Bf7sFI
         BhiiuTQytiILqQsx+dj9HwGu4OjxuchYWvsmZWvdpZOO4K8eoxP3UF9ci2Rvl6nIU8+t
         rFP3s1csAXONWuyqUE+/blK9iUExireE6XvtJkCZTSgsBO5OQuOnWMY3PANTm/919Ytf
         pAC3048sHWVfZE5D7bqZo4VCtGhVNsExZgtXqoxHEw9pS5dQz3FOryzx9bYE7toAT+os
         gbmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gTyzltWgTFXOPjw+JtVdJBDzeHI6HlS3kPelko2mAhw=;
        b=U+OV2WbE6QXVnruB1br2TRkHl1v91FrcwEwdH/eB4ru7ou1DGsS9KsA7xA4ahLSLts
         FksIje+pfhpA9JroCuUTFG8JqDqL1lOyR172Jm3h2CDHVCSU5UD1Nnkpne6AmkNK2G98
         YdIXiZwbKzKRcuMekCHHWPa/X01VnT/kmKfNWpDBmYGMcUt6ItZPs5epvRqnMi9qNI3b
         9ZgxGZQGeSLfNaC1lsSg3qFRcD3bqCThyQYYS6ozLaUBz3H853U+tMPuWASh7EzlUBrK
         JSn1/si3sBveJ4TljEaNiLVtfuFuxTN42KEOME5iT3x309urYF/UauXgheXwooAjQ0l/
         z4zg==
X-Gm-Message-State: AOAM5316K0bF9Sz67ubpEUg3ltMoCVw3HRZ7UUY6/STVuTj6r5kAn1Eb
        5KuEOjLwCGF/mZcYp8xnlQY=
X-Google-Smtp-Source: ABdhPJyWMHfuCic8pX9ljyiNAr9gMqISRMOcByncvz5LKp6v6+PdH7vYTqxTcP1pVbEqgYtrKinMUw==
X-Received: by 2002:ac8:4905:: with SMTP id e5mr6898010qtq.415.1631655507126;
        Tue, 14 Sep 2021 14:38:27 -0700 (PDT)
Received: from localhost.localdomain ([191.84.239.65])
        by smtp.gmail.com with ESMTPSA id o7sm6716611qtw.87.2021.09.14.14.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 14:38:26 -0700 (PDT)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        stefan.wahren@i2se.com, arnd@arndb.de, dan.carpenter@oracle.com,
        ojaswin98@gmail.com, amarjargal16@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, gascoar@gmail.com
Subject: [PATCH 8/8] staging: vchiq_arm: use __func__ to get function name in debug message
Date:   Tue, 14 Sep 2021 18:35:40 -0300
Message-Id: <20210914213532.396654-8-gascoar@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210914213532.396654-1-gascoar@gmail.com>
References: <20210914213532.396654-1-gascoar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid hardcoded function name using "%s", __func__. This prevents
potential naming conflict if the function is eventually renamed.

Reported by checkpatch.pl
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 72d9a6e37ae9..2d498fb0d19f 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -1025,7 +1025,7 @@ service_callback(enum vchiq_reason reason, struct vchiq_header *header,
 			spin_unlock(&msg_queue_spinlock);
 			DEBUG_TRACE(SERVICE_CALLBACK_LINE);
 			DEBUG_COUNT(MSG_QUEUE_FULL_COUNT);
-			vchiq_log_trace(vchiq_arm_log_level, "service_callback - msg queue full");
+			vchiq_log_trace(vchiq_arm_log_level, "%s - msg queue full", __func__);
 			/*
 			 * If there is no MESSAGE_AVAILABLE in the completion
 			 * queue, add one
-- 
2.33.0

