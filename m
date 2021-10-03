Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAEF84203D4
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 22:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbhJCUCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 16:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbhJCUCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 16:02:14 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE78C0613EC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 13:00:27 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id n17so17223092vsr.10
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 13:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7TZJXDTQsGNUDbvRjCz8RKRMYb6ELQrEA+DO5zTgBNA=;
        b=Xem6Lg1b0/aTrHz0hbJGM3loVtZcnOUMJXf/3g28tS48IffCaxi1MVyB09csLYYRD/
         9bOV2VOpccaAhtykLsqneDU8ofwdA1EKWzBNln5c5C1aRMD8Is49jz7kfxiITMugaRQ9
         +CLIkYFkG8bjHYEjOC59Y2OP1Txpi06KAkDq2c8pDrxEEuLNGGRu4NCJoeOVM6dz54hE
         RCaCyaf4X/0KEWofME/Xf84+xe2w8vVNqtDjBykDp81wTtr9QbzdOlxnTYjviOu5tDJM
         j95l0/CEm8gMEmED5zqTSBp1xGMqykG6SUswRhf5qCVz236YfJqRQZFf5zdDnICc/Czq
         puJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7TZJXDTQsGNUDbvRjCz8RKRMYb6ELQrEA+DO5zTgBNA=;
        b=aCkveylqYn2dA9T5mJVaqOzjiWgb1pBMddFCvamvC5qjK0/NabOh1O7ruypJ7rJ7Kj
         L5jLF+yoQqrX7IaVYtItC4AkWeBnzlVssZGmT+BPW5hLloDN+cHZ3+ciWD0xxr+qQiTl
         YbgFrIM+qa5n9oD1uGG2tSTEQZyezIwuiNImxxUPCaWKbfuqS1kNOFMp0w2I4PgPoArn
         wBGVnYWwAynXYNIDJPwI5bu0IsvZkivRIvINkcgDuBWgRoAIz1DeCG6yPx59n/8u38IN
         Sip+EymA5P2LSnktfoPydJPv84Z1dHwnIYUZzRYRCiXqWnjK0d91S1SCqq55i3x2dOFn
         MA/w==
X-Gm-Message-State: AOAM530DRg16LeooFJ4abwIXdHkdh1N6JEEIoWDU+iHlvKgZqkaktF2O
        x/4SPO7W9W6sqeixvdL8Btw=
X-Google-Smtp-Source: ABdhPJw1JjvUugGtOTVTqq7ofJV35mRcutZofY6BZ1Lz2nA6gqxT3W3b1s8PAzGPV0klg+cqGQLjyQ==
X-Received: by 2002:a67:c187:: with SMTP id h7mr1634122vsj.29.1633291226351;
        Sun, 03 Oct 2021 13:00:26 -0700 (PDT)
Received: from localhost.localdomain ([181.23.73.135])
        by smtp.gmail.com with ESMTPSA id x21sm6691019uao.2.2021.10.03.13.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 13:00:26 -0700 (PDT)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        stefan.wahren@i2se.com, arnd@arndb.de, dan.carpenter@oracle.com,
        ojaswin98@gmail.com, amarjargal16@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, gascoar@gmail.com
Subject: [PATCH 1/9] staging: vchiq_core: cleanup blank lines
Date:   Sun,  3 Oct 2021 16:57:51 -0300
Message-Id: <20211003195758.36572-2-gascoar@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211003195758.36572-1-gascoar@gmail.com>
References: <20211003195758.36572-1-gascoar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary blank lines.

Reported by checkpatch.pl

Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c | 2 --
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h | 3 ---
 2 files changed, 5 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 083abfd8e212..45858607282c 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -257,7 +257,6 @@ find_service_by_handle(unsigned int handle)
 struct vchiq_service *
 find_service_by_port(struct vchiq_state *state, int localport)
 {
-
 	if ((unsigned int)localport <= VCHIQ_PORT_MAX) {
 		struct vchiq_service *service;
 
@@ -3207,7 +3206,6 @@ enum vchiq_status vchiq_bulk_transfer(unsigned int handle,
 	}
 
 	state = service->state;
-
 	queue = (dir == VCHIQ_BULK_TRANSMIT) ?
 		&service->bulk_tx : &service->bulk_rx;
 
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
index 3ef4cbe1053c..de1e861c4ed3 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h
@@ -14,7 +14,6 @@
 
 #include "vchiq_cfg.h"
 
-
 /* Do this so that we can test-build the code on non-rpi systems */
 #if IS_ENABLED(CONFIG_RASPBERRYPI_FIRMWARE)
 
@@ -260,7 +259,6 @@ struct vchiq_service_quota {
 };
 
 struct vchiq_shared_state {
-
 	/* A non-zero value here indicates that the content is valid. */
 	int initialised;
 
@@ -449,7 +447,6 @@ struct vchiq_config {
 	short version_min;  /* The minimum compatible version of VCHIQ */
 };
 
-
 extern spinlock_t bulk_waiter_spinlock;
 
 extern int vchiq_core_log_level;
-- 
2.33.0

