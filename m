Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4974140CDD6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 22:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbhIOUUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 16:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbhIOUUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 16:20:38 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4606AC0613E0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 13:19:14 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id b14so3608578qtb.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 13:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h/GsHeyvvkKJdskTxdNmQ/rhjzzyIPbBxi6Rx6oGxp0=;
        b=OPLjVdWj/J6qm2GAbb9pCHOHcNwy/EUQDdiWSwEfafPVyJzDOdHnIfhn3wJIZLw8tv
         O72oEqxtXbhBgHf+0NjMZT9HyH4iJe+yyEVsIvqUzuLGkZUL7lnJD1g8e+81dn74PN2s
         5s+EgXdbDDy+xXgxe5ulH3dSFjiIoN6fJ6PAYB9U5wQ6x+jkDksnBnK8mcwc3K8cYuJZ
         zgGolzYS4dMIpWyxawfgKfRNVVGv/bOMUEIoDROubFDF9QY/G7GNPs+883u463uGKDLg
         G8616MvtX89q0g/+/BHVXTLcMjzeo8/gdtKyhvHfdw64cqb2/giPgLHSgMhZKnMinyNN
         Ddmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h/GsHeyvvkKJdskTxdNmQ/rhjzzyIPbBxi6Rx6oGxp0=;
        b=AC26zSSRhBwomLGgkXLJKZfO3bk/q1sDZwY5aUNCcjCLHg6WGvo+3kU05wkSo0IZJV
         XMnA+o8kYJeyiZwVKoMmtZFzXn4YL/kEhEm4JBRx4M8tEhKhxoywwMz5/eAW2L7ru8FK
         97LEM5TCoKw/dsGf+lsbK4snkRKYudXE0Ib/hPtDiHCSErO+7PvQdSVUip88+eRmTtjr
         6up4B83k2xjJ03vG1yOiE+jlBnvh9ncCXJvT3PQKo11S2VZsrudAkzPYvob5BQY4ovm3
         nIM6CUCNr8xX5bodvMmRB0FweixYiPS6bdbSvOsrszhF8bAElNdeQs83Fi4mSaulEaQL
         SG3w==
X-Gm-Message-State: AOAM532NljFyUCpRoszJj7HZaABqgYIo1uJ9HJLfef/7BHRMLQ4xYK61
        EvI+YxBngZf/j9SYiV0D7kg=
X-Google-Smtp-Source: ABdhPJxZ1EBd1dS8DIl61uigIBDjQDvMDAwA6xYfYIZQ2gxXT9JtaQR3cQE41+4hbxcJ3UUEh6sbcw==
X-Received: by 2002:a05:622a:44e:: with SMTP id o14mr1717786qtx.33.1631737153540;
        Wed, 15 Sep 2021 13:19:13 -0700 (PDT)
Received: from debianG.lan ([181.166.206.110])
        by smtp.gmail.com with ESMTPSA id g8sm752834qkm.25.2021.09.15.13.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 13:19:13 -0700 (PDT)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        stefan.wahren@i2se.com, arnd@arndb.de, dan.carpenter@oracle.com,
        ojaswin98@gmail.com, amarjargal16@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, gascoar@gmail.com
Subject: [PATCH 7/7] staging: vchiq_arm: use __func__ to get function name in debug message
Date:   Wed, 15 Sep 2021 17:18:24 -0300
Message-Id: <20210915201824.413202-7-gascoar@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210915201824.413202-1-gascoar@gmail.com>
References: <20210915201824.413202-1-gascoar@gmail.com>
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

