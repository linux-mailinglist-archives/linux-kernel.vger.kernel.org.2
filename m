Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC4C3444CB3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 01:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhKDAqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 20:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbhKDAqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 20:46:31 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817CFC06127A
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 17:43:54 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id k24so6734844ljg.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 17:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1eSkm1GpRtyX3va1o0mfl2NJ0JHmaWEpDja9I5uhN/U=;
        b=D9UflifN8D661FpjdtNhGUGaB6sgzlPjJI3VTq2EcutIfnO1kqmqYa6Cmpkd3HLGRC
         7L7Qf4uu8TM1EJ/NR7cf3tF3mn7lh2gLp2tSHcs48JsuDDNfN9aJhXql58ypfCMMm3lQ
         xUWdLiKHkCw9n6IkIqac7xosLVmmHZr9j8XmLv1o8NAexZJ1wt75zhDF1OTMsGCbppwu
         ocjsKHkuuXheFskd0oyaK83pkaDqM6+hLBLgcW8JeJ/4U7LCqT03GvEfuRE+fTrPe+Gh
         aVAucvnfD8VHK8exLZ29ayVV7bpV65Bgc4XNge+UBKlvB+mgNncDWgZrst4ubSNhYUhe
         YxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1eSkm1GpRtyX3va1o0mfl2NJ0JHmaWEpDja9I5uhN/U=;
        b=YOzdVJEdlIbOVusyTEX+u7pYYxFPzrYDnNLDTcxD9crnjAvy0ssIoPJnTzgDHfCGnh
         ba83By0ilEFDwBxN17RXID8QYZVuLGqyR6qivZGal0yJesq0saVkYBz8rb+hRzzHlvsB
         Qm66tfZXmaSM5Ybks0A1Yvc1aXI5BOYxNW4srvRQrMLofDO17RsCe9kph4H96JXiQWVm
         z58yPpzv45CsWuI/cr8JUpC7YDLWf9MJVblYJndQGgtoL7eIjTlbAwUhCKzB8R8b66Af
         8cyM/RgpaVyKXrvaVqtFUUcKBkvuZE0VB6cRLf1F1UFYHOAw/s4dLv6BZtx6I8prAVx/
         9RdA==
X-Gm-Message-State: AOAM533cNTdalN7esHOAAuao9xXSo0dLJlfpgU+P8pVQpczvalglRtgF
        ZGp3aFcUw0HyJb0/jgzanoux1k+MeUZlPg==
X-Google-Smtp-Source: ABdhPJxsOZl31izwRga4tPivLecWj5FqNk3eDeEBEhAvcZYzdQzS/VzZOhYf7RKt1ktSmFlP8j+oOQ==
X-Received: by 2002:a2e:a603:: with SMTP id v3mr46056763ljp.228.1635986632871;
        Wed, 03 Nov 2021 17:43:52 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id v11sm334465ljh.56.2021.11.03.17.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 17:43:52 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: qcom_spmi: do no register unused regulators
Date:   Thu,  4 Nov 2021 03:43:51 +0300
Message-Id: <20211104004351.2206578-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Typically SPMI interface to PMIC regulators on Qualcomm platforms is
used to supplement RPM interface in cases where direct control is
required (e.g. for the APCC or GFX regulators). Registering all possible
regulators is thus not required and may be potentially harmfull if
somebody tries to setup those directly. Thus register only regulators
that are really used in the device tree and ignore all unused
regulators.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/regulator/qcom_spmi-regulator.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
index 41424a3366d0..5e68c3829e50 100644
--- a/drivers/regulator/qcom_spmi-regulator.c
+++ b/drivers/regulator/qcom_spmi-regulator.c
@@ -2147,20 +2147,29 @@ static int qcom_spmi_regulator_probe(struct platform_device *pdev)
 			dev_err(dev, "ERROR reading SAW regmap\n");
 	}
 
-	for (reg = match->data; reg->name; reg++) {
-
+	for_each_child_of_node(node, reg_node) {
 		if (saw_regmap) {
-			reg_node = of_get_child_by_name(node, reg->name);
 			reg_prop = of_find_property(reg_node, "qcom,saw-slave",
 						    &lenp);
-			of_node_put(reg_node);
 			if (reg_prop)
 				continue;
 		}
 
+		for (reg = match->data; reg->name; reg++) {
+			if (of_node_name_eq(reg_node, reg->name))
+				break;
+		}
+
+		if (!reg->name) {
+			dev_err(dev, "No regulator matches device node %pOF\n", reg_node);
+			continue;
+		}
+
 		vreg = devm_kzalloc(dev, sizeof(*vreg), GFP_KERNEL);
-		if (!vreg)
+		if (!vreg) {
+			of_node_put(reg_node);
 			return -ENOMEM;
+		}
 
 		vreg->dev = dev;
 		vreg->base = reg->base;
@@ -2211,6 +2220,7 @@ static int qcom_spmi_regulator_probe(struct platform_device *pdev)
 		rdev = devm_regulator_register(dev, &vreg->desc, &config);
 		if (IS_ERR(rdev)) {
 			dev_err(dev, "failed to register %s\n", name);
+			of_node_put(reg_node);
 			return PTR_ERR(rdev);
 		}
 
-- 
2.33.0

