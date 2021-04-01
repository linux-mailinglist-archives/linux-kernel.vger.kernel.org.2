Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E56351E8B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237145AbhDASnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234525AbhDASVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:21:05 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD07AC022596
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 08:20:26 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id x21-20020a17090a5315b029012c4a622e4aso1198690pjh.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 08:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ww076wtEw/l52B1eQC1HZmnMQQ8Ebtr9JfK+3ViX3so=;
        b=KiGvVnSH66DmF8HdRytw6CJzuJoS03Rgw4NS/QOUBG/qyDfowjfjPJb4Uk9rl3tzSl
         FrtcqDfXNAt03yv2ZbMWSkUtZVxgRqCp/FxjadzOmk0LdPRI0xK8SS0cmsm50tBLUV8D
         LT2bSRIZNrc7c9mY8GZxdhUIy6Sv/F6+JsIxaTreMmGzoIVgcnJMnqibzvnhl7vEeCSS
         l+h74kxjQjZ+K2aItGMz6rzYzSTuvOU31WEx5Tonk1xxdAIDZpUuj/fNFiz29q66gypd
         vbgOy/k/jbxvAJwSS59FAbQ0k7tPzSO6eZoOEiGcRgHuJj++WFr95/LbkGkaTmvTBXB+
         F9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ww076wtEw/l52B1eQC1HZmnMQQ8Ebtr9JfK+3ViX3so=;
        b=c/LP953BNNsXKP+3wTBRPYGyXixnEvbTOb696BCCjVrwf5RT//kecNc20pEkiZ0/9C
         DLObCMJeJU3T8/go7y5kMl8rOlB0GDlhTn0p1/H4f0XITtwksTwZhZQI6UJ/pePoUQFa
         DTv2ccfDfwnWv0fQ15LM3IlVU54VcRkr4LGGUq8w7M0GIJSfpw+h76PhS6yqHqafPDVd
         0ag+b5p08MmLMv/WPaFc3XpiBJKQGBRatDokAwIT55vz7zmsRE4XcSvKBQe7eMrdpaUx
         yUiav7Uj40uaLOyJcnhDoIaCr9lY5Eufg5zJ2IJAWFL9vPIJN9YwWL8KtqDthgurpTa6
         IZ/g==
X-Gm-Message-State: AOAM531SCmHp2f9T2SdkNOpzOSZu9nBNteC0kxEpAh1uiiqLzK7AmG0/
        pYTkgTQ8Q8auttEI3ImUkYix
X-Google-Smtp-Source: ABdhPJxAqh+RohpPAzLbk35v/zOJ3CC1I1F2tWRwN3E0X6lfjAeYaDbNp7Smee2wXabf5ZYkF4rWoQ==
X-Received: by 2002:a17:902:c14c:b029:e5:cd82:a0b with SMTP id 12-20020a170902c14cb02900e5cd820a0bmr8410255plj.34.1617290426225;
        Thu, 01 Apr 2021 08:20:26 -0700 (PDT)
Received: from localhost.localdomain ([103.77.37.138])
        by smtp.gmail.com with ESMTPSA id l22sm6500919pjl.14.2021.04.01.08.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 08:20:25 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        boris.brezillon@collabora.com, Daniele.Palmas@telit.com,
        bjorn.andersson@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v10 4/4] mtd: rawnand: qcom: Add missing nand_cleanup() in error path
Date:   Thu,  1 Apr 2021 20:49:55 +0530
Message-Id: <20210401151955.143817-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210401151955.143817-1-manivannan.sadhasivam@linaro.org>
References: <20210401151955.143817-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing nand_cleanup() in the alloc_bam_transaction() error path
to cleanup the resources properly.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/mtd/nand/raw/qcom_nandc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 87c23bb320bf..fe74cf3aece5 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -2882,6 +2882,7 @@ static int qcom_nand_host_init_and_register(struct qcom_nand_controller *nandc,
 		if (!nandc->bam_txn) {
 			dev_err(nandc->dev,
 				"failed to allocate bam transaction\n");
+			nand_cleanup(chip);
 			return -ENOMEM;
 		}
 	}
-- 
2.25.1

