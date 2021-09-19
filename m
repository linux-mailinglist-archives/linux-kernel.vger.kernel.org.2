Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4837410D90
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 00:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbhISWIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 18:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232969AbhISWH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 18:07:59 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0F7C061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 15:06:31 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id r18so10006339qvy.8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 15:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mKpje/Y92jR84VIMNNbzSjTlUCixt6FDWJQ+8cv/w1Q=;
        b=MawK2iJeLSjzey9cfpgZFpypwtawe4w+nousG5KvG26e+uw+bUs1IzP1D73/yt1L99
         0zshOirhW47/7sYHwjLDtg/NtQQ4hatop0WAY++cbPpffjV/qzK+H295wZHG60frStqs
         Fb9qFyfz3SfkpCqIvnEL6+QcO79A9BXWdP13kQFilelU4wZQ4v68UwI7EQ4YIPJi4omY
         3DvlyBS86P1YCKHi1GfbMTBPibVU+AoRdwRn/0eLTGv9QLl2fxLPafqMsXznMaP+A0ei
         pqITHkBhsKMI6gnlTxgimQwLoPVJUsad8b4XCh1eOoPQup+Pu3PFLp6joOVl4cu7+N8D
         FVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mKpje/Y92jR84VIMNNbzSjTlUCixt6FDWJQ+8cv/w1Q=;
        b=LHhZepX5mTmYzFpNPL7Nt5J/cAVAEQCNFca9x0ckiybSdOt0kj9QKJpDT4MQGZGhVz
         Iwws/TRGjL+vE1rCdu9ctv/30ojyOkCyiN9LtgsuiX/cnou8Q1dn9aGL/2Ne1LM14pRT
         5RiLKR+QL0w32mCTEhPPBodJOEFQUYdB6Pz/FCPnht2nB+/CY2MR8KSamaM+Bb8ml5tI
         SsVa833//5PJY2pR61y18KV4wgQ+Lr2pur5X/p7BVq99H5SJYcUEMf8OFWJZj5r4m/Fg
         XAafQgHr1p8VV5RsO8T17fzpdck2nSjYxqO1rTmD8FH1jnK/UUCHO+B6T3p5IsbYrPj4
         Migw==
X-Gm-Message-State: AOAM533iQjdiGw9ua93nJXZkLhIrn6No/wLeY1IBPZu5YwNzEspqtU/8
        9DFZfyXMTUTLTb11iMtoDM4=
X-Google-Smtp-Source: ABdhPJzbcP5EilKkmcub8FPrk1SASVA5fhYZpcc0aOEdoFaCI6DKYOs5D3IyNUN833zLkq3fd1xSzg==
X-Received: by 2002:a05:6214:1593:: with SMTP id m19mr22329365qvw.36.1632089190983;
        Sun, 19 Sep 2021 15:06:30 -0700 (PDT)
Received: from localhost.localdomain ([191.84.236.195])
        by smtp.gmail.com with ESMTPSA id t23sm246313qkj.31.2021.09.19.15.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 15:06:30 -0700 (PDT)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        stefan.wahren@i2se.com, arnd@arndb.de, dan.carpenter@oracle.com,
        ojaswin98@gmail.com, amarjargal16@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, gascoar@gmail.com
Subject: [PATCH v2 3/7] staging: vchiq_arm: clarify multiplication expressions
Date:   Sun, 19 Sep 2021 18:59:10 -0300
Message-Id: <20210919215914.539805-4-gascoar@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210919215914.539805-1-gascoar@gmail.com>
References: <20210919215914.539805-1-gascoar@gmail.com>
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

