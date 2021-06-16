Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 786163A8E31
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 03:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbhFPBUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 21:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbhFPBUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 21:20:39 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687BCC061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 18:18:33 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id u18so292822plc.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 18:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TuDt1IbwqeVQA3BgOf64FsOM5Cx3ZLaB6istYzeB6+c=;
        b=WU58kTkuDyalCiOMwX5OQ3GRBQ6y/Zr8OHzfWNQC8YgWmOJOwctkxfq1Dc8kdSV9kX
         uNfjgSvcq0nXv/VFxXiIONVckwrF20PDXNaAEzpuXuV9WQms/6qN55mfqrpMUanpNIJP
         A7q+OsdyjjY8eEWWETYnVA9pIZIVmdq2PPUvmU04z9u6b7XxeJTHpV255cNPGgmQJYSQ
         qVl73/JbPWMpSNmBfj6PdZ0q2RUeIunJAoC+SCTq4M9ppbSZiI314SlqoYMB0/9CceVS
         93GLlgkXwtLNqH4OSsl/mHVsdDiZuNx345H06wu2ymRXRtLkStIwN9C+DDYK0kVgZrPM
         /ODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TuDt1IbwqeVQA3BgOf64FsOM5Cx3ZLaB6istYzeB6+c=;
        b=BselcM20JH37QufxQdB/bhLG/ntBo1pSPSn/KEjFw4wyuISJakogPLIuyUIdwUg0qv
         zENOrlJThDze8mEiliIyb0nqR0AU+FY6A+nyxQ6II4gyszQoch8pki2vCuZJgBxH/HV5
         LTZUQWiqa07qddO7Q/ufJomgUOfCG4n/KnaefJzfDlY3sguWpDBhQfkO2N74iEPNMgw5
         Nl513I/tahoGV6CaLorJIwpUCvvcYmtA1S4FsEfjA1wCDpy1B3hCRxZS9/xkwtsSgstc
         ojKsC9h7wKxg6JvEe0TE2DvPebZ9U9CHuPxyk68b8zfy1xSOJC4pqoqPyStjfwLcRj4g
         pkQg==
X-Gm-Message-State: AOAM533fXcSCqGzBMvBI0ZC8AkJAArBNzrFXJkkunQ9piipkXdMktlc0
        0aLe9f0vcSR/+BYLMO0uGZIZrnjrg0AfxUI+
X-Google-Smtp-Source: ABdhPJzhKmv1RxQL42rau3PVDTWYutqT8q26Ykh4WV9eUMe5AVYHe78aFwcQDoMzcMeJ2miKgUVglQ==
X-Received: by 2002:a17:90a:b64:: with SMTP id 91mr2114474pjq.24.1623806312884;
        Tue, 15 Jun 2021 18:18:32 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id t1sm302420pfe.61.2021.06.15.18.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 18:18:32 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     ChiYuan Huang <cy_huang@richtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: rt6160: Fix setting suspend voltage
Date:   Wed, 16 Jun 2021 09:18:16 +0800
Message-Id: <20210616011816.3479406-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vsel active level is for the normal voltage, the opposite level is
the suspend voltage.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
Hi ChiYuan,
I think fix it this way make the intention more clear.

 drivers/regulator/rt6160-regulator.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/rt6160-regulator.c b/drivers/regulator/rt6160-regulator.c
index ccd023da4318..5d7b0e7ad69a 100644
--- a/drivers/regulator/rt6160-regulator.c
+++ b/drivers/regulator/rt6160-regulator.c
@@ -128,13 +128,19 @@ static unsigned int rt6160_get_mode(struct regulator_dev *rdev)
 static int rt6160_set_suspend_voltage(struct regulator_dev *rdev, int uV)
 {
 	struct regmap *regmap = rdev_get_regmap(rdev);
+	unsigned int suspend_vsel_reg;
 	int vsel;
 
 	vsel = regulator_map_voltage_linear(rdev, uV, uV);
 	if (vsel < 0)
 		return vsel;
 
-	return regmap_update_bits(regmap, rdev->desc->vsel_reg,
+	if (rdev->desc->vsel_reg == RT6160_REG_VSELL)
+		suspend_vsel_reg = RT6160_REG_VSELH;
+	else
+		suspend_vsel_reg = RT6160_REG_VSELL;
+
+	return regmap_update_bits(regmap, suspend_vsel_reg,
 				  RT6160_VSEL_MASK, vsel);
 }
 
-- 
2.25.1

