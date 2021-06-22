Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5BEC3B050E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 14:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbhFVMrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 08:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbhFVMro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:47:44 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA950C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 05:45:27 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id h1so10394101plt.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 05:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=abGJazoOmIVzD93zNKhvcuUhymU12vCT+TAJPdB7S2E=;
        b=HfnvL+ymm736/oFh86dPGr4hyQ3cCQ0BtaXcGUAnuleyzKNblfNO5hgDOvGhW3k/NE
         PyIGLhKcRTLftARCNgHFMwdNIL20821HUftkjcrTOHYK1Da+mbmrEq38IeuPHA/mem7o
         +I9KnJCDhVEimpvWTvKe5No0jb7iQwsFiBW1McRpFdvaIorLLGKkOwRQgO3LiG5aGIjF
         kmN8sztNudRgUajpDp4K215yprN1Fp4u/QSBii0jN9gFG2UZHhtzaPIEHtXlxXjJH6v6
         e7KXuIIn3KdFmXttj0vFZnKn0mm69qou+/bWPZorVmpRh7mKgAnljYHRSCr4PAnnheMh
         HeKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=abGJazoOmIVzD93zNKhvcuUhymU12vCT+TAJPdB7S2E=;
        b=avI2Ts5AWcrmmZ+LPbOCxC+laASL+fCSldBRUFKL3kVjLC9k8cLdBOtbtl1FwR/IDY
         IX2LoLWaeHg8zu89yV8s48H5OLcKwiquLcPjNedPmkl8em8kGckoyErnECPGcr0OxgvF
         T07t42Ahanw5dPQTn7FhRyHQuv/2LYearCUAmE92juqDeW3Xff1/4SAj2f23I9pb5ZJ/
         2kVXd3poo3KKFr7/zrIVNWpf0MC29NL4sw1DCdSshewlw8Evx2kayva6bDwLpo3DaCEv
         MzL9VUJsdu5WcO/rUi6ISwgpqVe12PTJaqDLkvuQW5rRvuupPXLo3Z3BPmPX0uULCvOK
         UEFQ==
X-Gm-Message-State: AOAM533pWwF3unWtlgzB20uSVolbTJPXTzsjcP34ErhoPTD150ZPni/8
        f4lD3ESpSc25IugqC5gUqS4=
X-Google-Smtp-Source: ABdhPJwvopCp6+eKkG+8KelCuQIH4nLu8jB1sHVrMycc/74OJDlNslQJHdq/x6sRAXwfdiZRW4M3Kg==
X-Received: by 2002:a17:90b:1e09:: with SMTP id pg9mr3873629pjb.208.1624365927323;
        Tue, 22 Jun 2021 05:45:27 -0700 (PDT)
Received: from localhost.lan ([2400:4070:175b:7500::7a7])
        by smtp.gmail.com with ESMTPSA id x7sm2233226pjf.56.2021.06.22.05.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 05:45:26 -0700 (PDT)
Received: from x2.lan (localhost [127.0.0.1])
        by localhost.lan (Postfix) with ESMTPSA id A68C19015AB;
        Tue, 22 Jun 2021 12:45:23 +0000 (GMT)
From:   Vincent Pelletier <plr.vincent@gmail.com>
To:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        David Abdurachmanov <david.abdurachmanov@sifive.com>
Subject: [PATCH v3 1/2] regulator: da9063: Use __stringify_1
Date:   Tue, 22 Jun 2021 12:45:19 +0000
Message-Id: <b04c90a1a1a489d980bf8c524288f71b8f0a6982.1624365748.git.plr.vincent@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <ad5355c28c25fc273a450a11bc82f201fffad8cf.1624147922.git.plr.vincent@gmail.com>
References: <ad5355c28c25fc273a450a11bc82f201fffad8cf.1624147922.git.plr.vincent@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Indirect stringification is not intended here, and generated names may
unintentionally conflict with macros.

Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
---
V2 -> V3: no change
V1 -> V2:
- new patch for a cosmetic bug uncovered by 2/2
- cc linux-kernel ML
- fix subject prefix

 drivers/regulator/da9063-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/da9063-regulator.c b/drivers/regulator/da9063-regulator.c
index cf7d5341750e..21f4ddb37b09 100644
--- a/drivers/regulator/da9063-regulator.c
+++ b/drivers/regulator/da9063-regulator.c
@@ -88,7 +88,7 @@ struct da9063_regulator_info {
 /* Macros for LDO */
 #define DA9063_LDO(chip, regl_name, min_mV, step_mV, max_mV) \
 	.desc.id = chip##_ID_##regl_name, \
-	.desc.name = __stringify(chip##_##regl_name), \
+	.desc.name = __stringify_1(chip##_##regl_name), \
 	.desc.ops = &da9063_ldo_ops, \
 	.desc.min_uV = (min_mV) * 1000, \
 	.desc.uV_step = (step_mV) * 1000, \
@@ -108,7 +108,7 @@ struct da9063_regulator_info {
 #define DA9063_BUCK(chip, regl_name, min_mV, step_mV, max_mV, limits_array, \
 		    creg, cmask) \
 	.desc.id = chip##_ID_##regl_name, \
-	.desc.name = __stringify(chip##_##regl_name), \
+	.desc.name = __stringify_1(chip##_##regl_name), \
 	.desc.ops = &da9063_buck_ops, \
 	.desc.min_uV = (min_mV) * 1000, \
 	.desc.uV_step = (step_mV) * 1000, \
-- 
2.32.0

