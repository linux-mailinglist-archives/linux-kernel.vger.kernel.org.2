Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF57940CDD3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 22:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbhIOUUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 16:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbhIOUUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 16:20:22 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A3DC061766
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 13:19:03 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id u4so3565778qta.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 13:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mKpje/Y92jR84VIMNNbzSjTlUCixt6FDWJQ+8cv/w1Q=;
        b=gSiuigEIwU1wjsEmm18oxIpET62h6EDABgcWUonBTQvBUPtHtnzv45eDDfKkXVBjIc
         ZeaZVNJw9hoKhK/oZX0yy/P3HOTruOIYv5f//lDBEiDNEagMYy1P19902oEvqR3ur3lP
         NziIAcie8NFs/skCe2cnkvn2pLxQnYH0auim7siVOOmzmZAPaclDVYrmGutjYQnWoi6v
         vSHo8AjaVpRZ+veCE/fv803jVCAWc7o/918wFZBuOqhFL0XI4J2vu5cQHgDM/s0jgnPK
         SC3zYj8SoNM/2FeFex7oigyxTxaYlj7aXVJfAQ2VpLzZx0ungRDBl6nhF19eRVpuOS7S
         xL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mKpje/Y92jR84VIMNNbzSjTlUCixt6FDWJQ+8cv/w1Q=;
        b=S+Bn2M90YfhbIbhKI7FUtMy+HoD/9hSHHcJ15t6BA87kILhrs7hwBEFKTp81qTy1SV
         7w3kZPsv6IP7jBbzRr8oRGSrY8ifFd2obOAKCUrCnEW6rmD5FjP4mtdxJikyN/m9AL9L
         QQQKjTkF97OJ6R+IB8sOy7ys4aIAS0jNrEGKYsdEii8mIN9IoqOns7Uk85Bz+hKJH48A
         yc4ktEN/N3jP82Yv+9dBk198GzDpD9BXSPRAIfmv0fPxGg4VvBgYciY+q5Q2C5bRMom3
         Y8JLg5fYVrAtb9HKZLmvZOVCzaG49cxNubrmsRXDlwWFzTz63t3tPpFgF/LkhlsJMEI7
         hF7A==
X-Gm-Message-State: AOAM533SM19F5AfhpiaHjSaFHZGUEujuvXSsdYbohn0zQcBumq5SeVC1
        h9E8RW8f2mty9hHWypecSiY=
X-Google-Smtp-Source: ABdhPJzH6iLvJ6Y6ofAT6FP6w2noAViWq+EhkXChEKeGsyWBbsMwf4pHBh+lNzuex90XiKgeFTU1ag==
X-Received: by 2002:ac8:5194:: with SMTP id c20mr1751717qtn.68.1631737142661;
        Wed, 15 Sep 2021 13:19:02 -0700 (PDT)
Received: from debianG.lan ([181.166.206.110])
        by smtp.gmail.com with ESMTPSA id g8sm752834qkm.25.2021.09.15.13.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 13:19:02 -0700 (PDT)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        stefan.wahren@i2se.com, arnd@arndb.de, dan.carpenter@oracle.com,
        ojaswin98@gmail.com, amarjargal16@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, gascoar@gmail.com
Subject: [PATCH 3/7] staging: vchiq_arm: clarify multiplication expressions
Date:   Wed, 15 Sep 2021 17:18:20 -0300
Message-Id: <20210915201824.413202-3-gascoar@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210915201824.413202-1-gascoar@gmail.com>
References: <20210915201824.413202-1-gascoar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add spaces around '*' in multiplication expressions to enhance
readability.

Reported by checkpatch.pl

Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index e8b84b2b1ac3..9464a4777ff6 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -466,8 +466,8 @@ int vchiq_platform_init(struct platform_device *pdev, struct vchiq_state *state)
 
 	g_free_fragments = g_fragments_base;
 	for (i = 0; i < (MAX_FRAGMENTS - 1); i++) {
-		*(char **)&g_fragments_base[i*g_fragments_size] =
-			&g_fragments_base[(i + 1)*g_fragments_size];
+		*(char **)&g_fragments_base[i * g_fragments_size] =
+			&g_fragments_base[(i + 1) * g_fragments_size];
 	}
 	*(char **)&g_fragments_base[i * g_fragments_size] = NULL;
 	sema_init(&g_free_fragments_sema, MAX_FRAGMENTS);
-- 
2.33.0

