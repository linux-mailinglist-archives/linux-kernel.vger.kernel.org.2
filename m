Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A78D333EDA2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 10:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbhCQJ5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 05:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhCQJ5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 05:57:24 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA75C06174A;
        Wed, 17 Mar 2021 02:57:10 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id c6so936011qtc.1;
        Wed, 17 Mar 2021 02:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5DT/Tb82dfOUQn3pF6Xxk/zZfoQwDhnzs09a7hrsaJQ=;
        b=FJjZyLuy4Eo+5onI9+vOke1d2I6gth6cngQxmg42w8P4sE+UpfImquEqZjRXWmXHUi
         OijwX/Kis+r4z4yO4At9NKUslP94wJgfmZR4sNqna+b9rO2h29G8dWpourejztLkf9M8
         TQZOqiJUYBaeqPu8bg4wzk44nUrZYgSAH9vNNCXEtqsPlSel7ye3d2w/VMTK81SCmeXS
         ijZ4bSnXK9D/GF+0GTUZ7NpzH6MCJ5tDbBGJZHI9E1khyKfDGlSnoc9qLN0kkFNKEh4k
         ufU4QzgG/EF0gZsmKgmWygtSREzYnm1VUa901MXrB+VRUb0TzUNCusD1bZy4pRMcIydE
         pEKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5DT/Tb82dfOUQn3pF6Xxk/zZfoQwDhnzs09a7hrsaJQ=;
        b=MAJL58JOlas7v+cLqg70/ceWQIsqQR55jvvvfRnO69XrB8qQboe386mCbvwmKRXdi5
         SIGOXr7hi8g+9AVVsTuVPPkitS4evoYMaIiw2jsdmL+rL7dlT+c7JG2DEOP7XP2O2nqt
         9kcAoM3lnpwf+KAY46jpCT8tPvXTAKa7DodOPVSGE0SkushQ2Tx0klodlYvTDDPqbfTb
         QruibkK9SBhviBcfkm0Ud7p3gpHwjuSQzyAwb/CV4p+CVyzRyelTpcgqyN7cECsmTRvF
         R0+/Liz4NIXrQ2XnImxjWFKy8LLkxkAPVG8jqD1SLzq2+9NO1J7auXXziO32hDRxaaeY
         jI7Q==
X-Gm-Message-State: AOAM5308dKsOGb872NifiV8QcRXy7gyGFLzDKBGxKdsq17+BNRTMzRkr
        3mBb6Y4PoXlV/aPE4EQXkR4ekM1lzkcd7IeW
X-Google-Smtp-Source: ABdhPJyazJ+xhIZNmt+SRzMgC0RrSxlOcg8eL06vVrvK6jyA6eAGX++nM+qFYIBsVNKxqqlKFf3kTw==
X-Received: by 2002:a05:622a:11cd:: with SMTP id n13mr3175704qtk.52.1615975029425;
        Wed, 17 Mar 2021 02:57:09 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.48])
        by smtp.gmail.com with ESMTPSA id f136sm17494286qke.24.2021.03.17.02.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 02:57:08 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     andy@infradead.org, dvhart@infradead.org, vadimp@nvidia.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] platform: mellanox: Typo fix in the file mlxbf-bootctl.c
Date:   Wed, 17 Mar 2021 15:26:50 +0530
Message-Id: <20210317095650.2036419-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/progamming/programming/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/platform/mellanox/mlxbf-bootctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/mellanox/mlxbf-bootctl.c b/drivers/platform/mellanox/mlxbf-bootctl.c
index 5d21c6adf1ab..1c7a288b59a5 100644
--- a/drivers/platform/mellanox/mlxbf-bootctl.c
+++ b/drivers/platform/mellanox/mlxbf-bootctl.c
@@ -208,7 +208,7 @@ static ssize_t secure_boot_fuse_state_show(struct device *dev,
 	 * 0011 = version 1, 0111 = version 2, 1111 = version 3). Upper 4 bits
 	 * are a thermometer code indicating key programming has completed for
 	 * key n (same encodings as the start bits). This allows for detection
-	 * of an interruption in the progamming process which has left the key
+	 * of an interruption in the programming process which has left the key
 	 * partially programmed (and thus invalid). The process is to burn the
 	 * eFuse for the new key start bit, burn the key eFuses, then burn the
 	 * eFuse for the new key complete bit.
--
2.30.2

