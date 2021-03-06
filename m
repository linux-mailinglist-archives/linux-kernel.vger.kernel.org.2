Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E80432FAD5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 14:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbhCFNX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 08:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbhCFNXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 08:23:37 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180E4C06174A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Mar 2021 05:23:37 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id l2so3273154pgb.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 Mar 2021 05:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QNie7fvacg0VcMhJUcIkQPujOIJJT3GPp44PryGFraY=;
        b=ZsSwrn2q6uVcmRI4L15LCpuu4OkwZCBLAt3XsMRWKPvxSEYMnpHxcC7SqeIMi7E+Nk
         Ll2WgneSd9qFq/aARfpAFiyMqFRb5Mi6F5y8wUQLNAr2/EnW1MWBCWNf+jie8pDiJ10y
         S6IXVOFUOweMyB1aq2WdB0P3zgvoehcKyhxYbKJTKrmi1qtKTF4laUYHLbLJV7fB/frq
         v57hn/dMwo/LChiM5RNqfGww5xRZ33Xdz9nv4TakWeErcJjrekiS/U6DYbXDeElzPtN5
         CYiVseQpB3ukpnD3khsvwtCCMCqupNKpvRRbqCtdw1tbZgN1yQMf93YBzNk/U0+OXybq
         8hhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QNie7fvacg0VcMhJUcIkQPujOIJJT3GPp44PryGFraY=;
        b=r1MeZnsT0DSLslv9RqsaPXX7/WqnaA6F38++VL0fJ9bqs9nWvazMn8n79wOkrswHNs
         XddNVEtlQt7IC8CMa5b5mEI8JoNiWBdR3B33yLo15vuQijeaTNfJmKbbUTdStWz4hXab
         0k/XqKvmoEdOWA+/N4pNSAdfIq7HAGbX/aQmEgzPE7sfVRMN3nrUvCsZV7W1CuPJZM3g
         QP60KLUUZYKdLzDZHaqSKQYHNQjxli4f4hUxbhqdMsAXzmTnt/D0Fd9ub9QBLo1AuPx+
         tV8HRRjVQVhh65C3qM6k0JEgNbovf6CsGSzNsd0opX/jNO8y5N895cH8dav/rO7Nc/Cq
         tEkg==
X-Gm-Message-State: AOAM530JRumOMZTIspCOT8nFhE5N2HcjIoM4JL99PHHYoz0ZwoKIZjb2
        thmfqLeTf/DJ4zC26bmEXvk=
X-Google-Smtp-Source: ABdhPJxzeo+9H4+p0uAsSY2mO7pJES8TJr7rANuMY+Kq3XAv2Qz8x68JaHIM9oiVv9/CGktzV7yyuw==
X-Received: by 2002:a65:4243:: with SMTP id d3mr13351432pgq.180.1615037016632;
        Sat, 06 Mar 2021 05:23:36 -0800 (PST)
Received: from localhost.localdomain ([45.135.186.66])
        by smtp.gmail.com with ESMTPSA id d24sm5672441pfn.54.2021.03.06.05.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 05:23:36 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     nsaenzjulienne@suse.de, gregkh@linuxfoundation.org, arnd@arndb.de,
        dan.carpenter@oracle.com, phil@raspberrypi.com,
        amarjargal16@gmail.com
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] staging: vc04_services: vchiq_arm: fix error return code of vchiq_release_internal() and vchiq_use_internal()
Date:   Sat,  6 Mar 2021 05:22:45 -0800
Message-Id: <20210306132245.16811-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When arm_state is NULL, no error return code of vchiq_release_internal()
and vchiq_use_internal() is assigned.
To fix this bug, ret is assigned with VCHIQ_ERROR.

Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 .../staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 59e45dc03a97..8b2b4771f420 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -2332,8 +2332,10 @@ vchiq_use_internal(struct vchiq_state *state, struct vchiq_service *service,
 	int *entity_uc;
 	int local_uc;
 
-	if (!arm_state)
+	if (!arm_state) {
+		ret = VCHIQ_ERROR;
 		goto out;
+	}
 
 	vchiq_log_trace(vchiq_susp_log_level, "%s", __func__);
 
@@ -2389,8 +2391,10 @@ vchiq_release_internal(struct vchiq_state *state, struct vchiq_service *service)
 	char entity[16];
 	int *entity_uc;
 
-	if (!arm_state)
+	if (!arm_state) {
+		ret = VCHIQ_ERROR;
 		goto out;
+	}
 
 	vchiq_log_trace(vchiq_susp_log_level, "%s", __func__);
 
-- 
2.17.1

