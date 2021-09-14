Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2236340BA6E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 23:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235115AbhINVjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 17:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234893AbhINVjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 17:39:02 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBB1C061764
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 14:37:44 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id a13so619806qvo.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 14:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sN887L5dw+wolgQTxQ/Mi09l/5z12JpLwvV7NlzvMdY=;
        b=Om58aM4UuMcBrVCOPH8vqo0wAIVhL0KjYsQ1osJufp464nG9URvJjW+MJT57oEbCCo
         Cih3N0uZZwY176vyJmiIe5gkU44EEswkJORnmKmTVkxlF+NqX0Nj461cptOmAWa1RwpP
         DEqtK6IpSDYcpu+9CMpu0bZVWaH/fPdPgK7fxqvvTBu7/1EANsCkfnEbLHTlQ0vlKPdl
         qGLnKRXZIYiFgHVJHGf3PyCLd0vge+GSIGDRLKFWxwCiHPk7MxOuyi1AQw0n822tlKxK
         5NOa1F0Dynan7n9SQRotwPkwRJiO0t3a6QDATqG6k9HygSlk7+PBBTZCUx4IWbMiFTqw
         o8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sN887L5dw+wolgQTxQ/Mi09l/5z12JpLwvV7NlzvMdY=;
        b=VPRdKPaxI5tJvXVzUnOjDIkfrXjT0C28zr09mITtDoWMxR1+e3zb4CUjg0g93XiGT4
         FaJIKhnTuLYMIlrkqdH8HJvc9/Y6CQbI2CHqrg5D4TjTcNYuFM99bBR1pl5HnG1at+BI
         V7TaPyajKX0HFPff/bpVf7+YoXzgKuOYtyPOYZifxfCizWD5X2tSsHyHz/z8SKDC7eOm
         b4ZNX4cAB7LOXaEov2caZwEwnrmBSKTLaXiGNj/I3X+HykxWz/waHoBKP1dYIwS2c1nB
         1CMiugc1qpf+eQlvLZGWuDuodAXBD7PKACsE4AuXwTsE9UXevutQmb8kk3DQChiSr+tC
         S2mg==
X-Gm-Message-State: AOAM532GFJrMXOi/zaHkt8SImPNX0526rGdPvdVu/KmABTDmmI5Izxul
        RCv3ZCtSk/p6a06nEWj2yuk=
X-Google-Smtp-Source: ABdhPJzMRDhqa4mXzcHqmNPW45fcwjAo/ztjQhsIyC+dpiqiuISSJw0z5wrXutsAHo27RhhOnMN28w==
X-Received: by 2002:a0c:8e05:: with SMTP id v5mr7698418qvb.25.1631655463525;
        Tue, 14 Sep 2021 14:37:43 -0700 (PDT)
Received: from localhost.localdomain ([191.84.239.65])
        by smtp.gmail.com with ESMTPSA id o7sm6716611qtw.87.2021.09.14.14.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 14:37:43 -0700 (PDT)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        stefan.wahren@i2se.com, arnd@arndb.de, dan.carpenter@oracle.com,
        ojaswin98@gmail.com, amarjargal16@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, gascoar@gmail.com
Subject: [PATCH 6/8] staging: vchiq_arm: fix quoted strings split across lines
Date:   Tue, 14 Sep 2021 18:35:36 -0300
Message-Id: <20210914213532.396654-6-gascoar@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210914213532.396654-1-gascoar@gmail.com>
References: <20210914213532.396654-1-gascoar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoted strings should not be split across lines. Quoting 
Documentation/process/coding-style.rst: "never break user-visible
strings such as printk messages because that breaks the ability to grep
for them."

Reported by checkpatch.pl
---
 .../staging/vc04_services/interface/vchiq_arm/vchiq_arm.c    | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index ffacf1c7212b..72d9a6e37ae9 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -1613,9 +1613,8 @@ vchiq_dump_service_use_state(struct vchiq_state *state)
 	read_unlock_bh(&arm_state->susp_res_lock);
 
 	if (only_nonzero)
-		vchiq_log_warning(vchiq_susp_log_level, "Too many active "
-			"services (%d).  Only dumping up to first %d services "
-			"with non-zero use-count", active_services, found);
+		vchiq_log_warning(vchiq_susp_log_level, "Too many active services (%d). Only dumping up to first %d services with non-zero use-count",
+				  active_services, found);
 
 	for (i = 0; i < found; i++) {
 		vchiq_log_warning(vchiq_susp_log_level, "----- %c%c%c%c:%d service count %d %s",
-- 
2.33.0

