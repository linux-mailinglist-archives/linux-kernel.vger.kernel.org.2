Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2EB73B0246
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 13:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhFVLGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 07:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbhFVLGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 07:06:20 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EABC061756
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 04:04:04 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id y14so5340644pgs.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 04:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=IS3LFDSh9WBpJRpWSUSUKpW8cEizKGrSK8G3jB+9ZR4=;
        b=cMlo0KnmR45RSxcBN0dA5H3DwgqdpYUcSPZ0BwjcaKxclY5k9oCcpx2zA/I1HsYXRX
         S0N7c48b9/RLG/3SeAykw2V6Y27MNmE/KL8i9YOfTevsJryuFTeN9e0/psf6WX+yBe0f
         c3qnZdwrfe00ZnnhumgGNnD7OEqnXecSCFveiPsnHoUiZjyWCkCVArlotcJzqqaoJwRk
         +5Ul38Gj/6cuL8QAhSDlQPZzUKv1TwKO4Wx9oobhmYm5H+C/U0SGw6WE6xFzLbXoet//
         lcdo7Gzpd7zcV+Til3pbqASKzAjCI9KfIjEAcw9lJkoe2MwENobbu9km9mlSU8Ge5kv/
         UDiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IS3LFDSh9WBpJRpWSUSUKpW8cEizKGrSK8G3jB+9ZR4=;
        b=pfVvBUuTZhjIEYEYlCEsIPvngiVaQtJr7v2zutkyfyRHyeqMYjGON0N+iHF2Oa7BuU
         CBogfWT0qSLQmwvipb2waas3p58RWJriE16ki+nBUkiA1hbMsUPXvIONKQ3yIjyDypce
         smIuZFkOw5tF/5IluOP23PbJGC49U2rYIXI/gH47pe4i9f0XIksWxrYGg1wZVbs9Pt/l
         E3AfpiT4aAKU1oClbtuAqPiybs0yAQ7+8cO1pqbZ72yL4uefTPFu64V7Gpja1i5JdL/0
         SFVV3XSWYf7krMVLll8Nee4b0H+XAD08kFpe0/2lVZ0B746Byv2rd7it+m4Tu/RjFdnD
         eYRw==
X-Gm-Message-State: AOAM531w2NGV2qm3anRocwwfC/ziDfW23ySXbrHgo3mDRWFQtjXflKlY
        QDb+O2/zYAkSIEVRBOIHciRhSd7yjCErkQ==
X-Google-Smtp-Source: ABdhPJzCtm6DMYzcxQC9eiqLMb8iixLoGjOSVDJom6vhIFR75cRuWqK7i99bDsrfMIUwYy7ylZzv0w==
X-Received: by 2002:a63:e04e:: with SMTP id n14mr3190008pgj.324.1624359844320;
        Tue, 22 Jun 2021 04:04:04 -0700 (PDT)
Received: from localhost.lan (p1284205-ipngn14601marunouchi.tokyo.ocn.ne.jp. [153.205.193.205])
        by smtp.gmail.com with ESMTPSA id u10sm18007220pfh.123.2021.06.22.04.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 04:04:03 -0700 (PDT)
Received: from x2.lan (localhost [127.0.0.1])
        by localhost.lan (Postfix) with ESMTPSA id 8D0A59015AB;
        Tue, 22 Jun 2021 11:04:01 +0000 (GMT)
From:   Vincent Pelletier <plr.vincent@gmail.com>
To:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        David Abdurachmanov <david.abdurachmanov@sifive.com>
Subject: [PATCH v2 1/2] regulator: da9063: Use __stringify_1
Date:   Tue, 22 Jun 2021 11:03:55 +0000
Message-Id: <b04c90a1a1a489d980bf8c524288f71b8f0a6982.1624359253.git.plr.vincent@gmail.com>
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

