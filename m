Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A20543213F1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 11:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhBVKQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 05:16:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbhBVKQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 05:16:46 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CE4C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 02:16:05 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id s16so7431196plr.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 02:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DEyKy5mx0dMuKE/TR0/MfCGJrJdUfSMNm7rgBnd8nC8=;
        b=ka5Mjfco5GPDZIy/EYuD06J9MmfbGkHtLRu76/NxtzUCZEMfkXQNn0pWhUCogc9+LI
         gynf0G3viWhdlJyBI9qNoMOUHYiA/FK8Pxy/QjwB1WyLN+Zw9OJUN8glc+Bg+T9mw1Ey
         RAST6dMBPCAvMMaPF3ovRtqMeAMybefqwXkQ56bqbQZuOkr4REsv8m4+pRZahyd50JvH
         DZWuHJpZ6rdw8hKxdkssclEllaGLdwGTHu22Pah5GXq9pZhqKcXsYrDx6ccUYVGg+VHd
         i1vrmwSugLBcFUjphpQxYVoOv5WhhwJlchfSi51tv4CaSR9TJU5dBmo592ujRaSNdz+E
         /Ncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DEyKy5mx0dMuKE/TR0/MfCGJrJdUfSMNm7rgBnd8nC8=;
        b=dtz4JgPTk4/AngVzJsaR/QrVyQcaKEjGBa5tQgacCEWYOzL2bKEp9q1NZYB8+pcmBM
         3Ti5nHRLCP4YXCbQR28km/p4xpEGZCOMF8gZhx/a3C3ixpHYnVHxd65VGGzfhgLiU2ne
         sKFwsjTTq1M5KxJXiW599//X3gKl/vQQ4Asnf8BRVHC9w6ldpRRbN+9tP11HFakU4CHv
         KRoCvOD6o8P37t2bGDCFzYpYsD9ybfn/z/+2zlQwIs9LmkGYvVHFbogUvPMtLVZwm7lC
         1o56XM2mG548AEnlVBIPSDcSo8c1dBourNl/OY19sbNxICMTgiXnnrKJi9e2adlJvRRf
         ULcA==
X-Gm-Message-State: AOAM5325LBqOtG0YItMsKTwvHVd57eQaHxwJ5ofxVuooJx9ewwwEOp/6
        dutlxDxa/4rZ3ag+6PdiFy8=
X-Google-Smtp-Source: ABdhPJwD2XP8n1aSRMGIyeJRfQ7R8q+ukTW9z6ndbeinSJuxwIHLPliSjfJ11aMk5dx5le7NNU4hxg==
X-Received: by 2002:a17:902:8b89:b029:e3:dbc0:bc4c with SMTP id ay9-20020a1709028b89b02900e3dbc0bc4cmr9725220plb.5.1613988965368;
        Mon, 22 Feb 2021 02:16:05 -0800 (PST)
Received: from localhost.localdomain ([49.36.150.223])
        by smtp.gmail.com with ESMTPSA id mp20sm17229814pjb.34.2021.02.22.02.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 02:16:04 -0800 (PST)
From:   Amrit Khera <amritkhera98@gmail.com>
To:     gregkh@linuxfoundation.org, lee.jones@linaro.org,
        johannes@sipsolutions.net, mail@anirudhrb.com, arnd@arndb.de,
        amritkhera98@gmail.com, memxor@gmail.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] staging: wimax: Fix block comment style issue in stack.c
Date:   Mon, 22 Feb 2021 15:45:42 +0530
Message-Id: <20210222101541.2571-1-amritkhera98@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change fixes a checkpatch warning for "Block comments use
* on subsequent lines". It removes the unnecessary block comment.

Signed-off-by: Amrit Khera <amritkhera98@gmail.com>
---
 Changes in v3:
 - Updated commit message, as suggested by Greg KH <gregkh@linuxfoundation.org>
 - Removed the whole comment, as suggested by Dan Carpenter <dan.carpenter@oracle.com>

 drivers/staging/wimax/stack.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/staging/wimax/stack.c b/drivers/staging/wimax/stack.c
index ace24a6dfd2d..0d2e3d5f3691 100644
--- a/drivers/staging/wimax/stack.c
+++ b/drivers/staging/wimax/stack.c
@@ -55,20 +55,6 @@ MODULE_PARM_DESC(debug,
 		 "are the different debug submodules and VALUE are the "
 		 "initial debug value to set.");
 
-/*
- * Authoritative source for the RE_STATE_CHANGE attribute policy
- *
- * We don't really use it here, but /me likes to keep the definition
- * close to where the data is generated.
- */
-/*
-static const struct nla_policy wimax_gnl_re_status_change[WIMAX_GNL_ATTR_MAX + 1] = {
-	[WIMAX_GNL_STCH_STATE_OLD] = { .type = NLA_U8 },
-	[WIMAX_GNL_STCH_STATE_NEW] = { .type = NLA_U8 },
-};
-*/
-
-
 /*
  * Allocate a Report State Change message
  *
-- 
2.20.1

