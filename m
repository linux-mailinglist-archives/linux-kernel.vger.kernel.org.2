Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74E9A410D96
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 00:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbhISWIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 18:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233188AbhISWII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 18:08:08 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73017C061764
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 15:06:42 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id d207so10956011qkg.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 15:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h/GsHeyvvkKJdskTxdNmQ/rhjzzyIPbBxi6Rx6oGxp0=;
        b=EwRZXHZ2ZxDHgukg6GrKwx/vTr0nhMBZQfpi+FrmLDNCeENzzH1sf4puo5sCKCq/M+
         HkVrHJZtzMqa0US0pWeKBUMJgBO97pz3vFKIjj4aVl9KBsTT6x2Gdsd9yHFQlpFbA25B
         C7j2njdMeNH8sWHr2jONX+rLKoF4/IsZ29y9KLEoJ04xyaTFJBkJxXmqrfp2TW4rf49w
         Tj40Usf5WWP7bG2Oz4uptbmmFvpgVzr5KcvV44BVZTUYVYaSczVw3PcR/iTAzEaP8VRg
         SPuMDj/9C5oYnWGm60WEhEPcDYhAk/e4HdOo9Bc/ugArvAWNzHHk5sG8fOR6XMl12Wf0
         UTBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h/GsHeyvvkKJdskTxdNmQ/rhjzzyIPbBxi6Rx6oGxp0=;
        b=mpVKH+dW0i105/I74B9/71lW88wsLQEIXyk+A7mX8EsYw4XyzZD6y1mykiiLw7HndE
         SS6jWTvnjottuwL6EPKdKBNZ/97fNmS0bSCCE7k4Th700sS40XTExo06a+ykM8NXvQX0
         g5ruOPBmbjhuQcFRpAxfr72I3a67tNb7Q+ABNuIojfEvrGQygpe2bLhG732b9BFMvUFZ
         dhttabYUIaLqDYQybMDOdknKWaI3mhxdyjGLeYsCrW21tnf3k5CLYE3NDwGQi4jUuBfT
         kiexTRShycu36nsleGXIJm2/YT/UL5UnyQzOlpQrEaRrMv11E0IpUkhrl3oBN0/4/MXJ
         mIEw==
X-Gm-Message-State: AOAM5326Jj5+tZSXj3n+fSVKFNJImSlIVVxGTENxc4HLU/+7nVSPc2xU
        O3gpM83V36VUNQId2RBkVCo=
X-Google-Smtp-Source: ABdhPJyfsmmaw+e54+EKhacYU+CLQadhZShHYn6/qVyVc1PUf6FwE2BQXyPk/MBkIkFJiEBXwFX08w==
X-Received: by 2002:a37:f515:: with SMTP id l21mr21014533qkk.234.1632089201692;
        Sun, 19 Sep 2021 15:06:41 -0700 (PDT)
Received: from localhost.localdomain ([191.84.236.195])
        by smtp.gmail.com with ESMTPSA id t23sm246313qkj.31.2021.09.19.15.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 15:06:41 -0700 (PDT)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        stefan.wahren@i2se.com, arnd@arndb.de, dan.carpenter@oracle.com,
        ojaswin98@gmail.com, amarjargal16@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, gascoar@gmail.com
Subject: [PATCH v2 7/7] staging: vchiq_arm: use __func__ to get function name in debug message
Date:   Sun, 19 Sep 2021 18:59:14 -0300
Message-Id: <20210919215914.539805-8-gascoar@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210919215914.539805-1-gascoar@gmail.com>
References: <20210919215914.539805-1-gascoar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid hardcoded function name using "%s", __func__. This prevents
potential naming conflict if the function is eventually renamed.

Reported by checkpatch.pl

Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 3225f0738ef9..fcff2e5bd73f 100644
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

