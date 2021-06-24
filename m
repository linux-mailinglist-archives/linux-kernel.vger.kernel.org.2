Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2FA13B253C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 04:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhFXC7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 22:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbhFXC7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 22:59:13 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E689C061574;
        Wed, 23 Jun 2021 19:56:55 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id l11so2594714pji.5;
        Wed, 23 Jun 2021 19:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a4f7LucUmwk1fs1/j6b+mHE2Wk/ES6e/RtiKDnV2oVM=;
        b=jvHWPz+7fwYV/KxX1NYTkBsmIiSsvkc7wgBTpLkO10iIJObO0E+2+iQy3UD9kJHVHk
         sETrqwbHmhG/HTguyik+wF+UhG5eWwx02lHhXKUsjg9iCfUdOq5u07r4C3p7JR0Ni5sp
         5ySkaN7pAo2QJzUmSBl0UFisxhl298QcsUiVhRvqf36YLc7JWJzpIZ3uzTVsFfkAyGA9
         CpkGq/EtPhvEf/idkYvHNHTUSomO6zY8A703K70cIMUIvgJTh0q/KQvGpjxLTAGXSf+V
         kqI9+pCLwYYPPJ4GlujFCrilHGSv8ATZ90l5jMx7YOfdHOqDXTpqMRmg3N/FQhVUFVci
         3Iqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a4f7LucUmwk1fs1/j6b+mHE2Wk/ES6e/RtiKDnV2oVM=;
        b=Ly+WJT46/zpuHEZ90YlKNZ5gBDvAFwI6pu/K5aU0wAvMMb0hRcjXKSq1MM0MLmXpEV
         cL7tHYhWcRy6/JWCgRgSpWUYKZVokrHrO0m5zpCviRVEEo4XBJb1EInbJ6+geONcqr4A
         SjyvYA/6kDtf4c6C6reKGag7CZixNPMj+C3+Z+H0VFRYHOqiOzS9pNx1eCa0iWy4S3pG
         GuITKbEOz1pCd4YK8hCXVifFw+lIeyM3Grgp2vFYkQd9e+qTNUpb8lK8nc5meDTrB2Z9
         D5domUBsy/c+JOFe51IdniAAjaE6QRdjYJlAO/YafSqqNdSq+3ANKVMNbJW7MTYpJHJm
         Xs+w==
X-Gm-Message-State: AOAM530nZKQs565tcmWuxK0WePWqBDjrwBBYLHzRkun8IFIC2fW1QrVw
        HHHpBB65C33WsZ3RufA2de4=
X-Google-Smtp-Source: ABdhPJz3H0LKYO4d7CHYIe6f69eBXOh4LlmP5C92YyhBWRIEAQA0j/m9OXcGsACr7xhigfZpVYNp/A==
X-Received: by 2002:a17:90b:a0c:: with SMTP id gg12mr2826179pjb.138.1624503415074;
        Wed, 23 Jun 2021 19:56:55 -0700 (PDT)
Received: from gli-System-Product-Name.genesyslogic.com.tw (220-128-190-163.HINET-IP.hinet.net. [220.128.190.163])
        by smtp.gmail.com with ESMTPSA id a23sm1034089pfk.146.2021.06.23.19.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 19:56:54 -0700 (PDT)
From:   Renius Chen <reniuschengl@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ben.Chuang@genesyslogic.com.tw,
        Renius Chen <reniuschengl@gmail.com>
Subject: [PATCH] mmc: sdhci-pci-gli: Finetune GL9763E L1 Entry Delay
Date:   Thu, 24 Jun 2021 10:56:47 +0800
Message-Id: <20210624025647.101387-1-reniuschengl@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Finetune the L1 entry delay to 20us for better balance of performance and
battery life.

Signed-off-by: Renius Chen <reniuschengl@gmail.com>
---
 drivers/mmc/host/sdhci-pci-gli.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
index 302a7579a9b3..4e3c0561354d 100644
--- a/drivers/mmc/host/sdhci-pci-gli.c
+++ b/drivers/mmc/host/sdhci-pci-gli.c
@@ -90,7 +90,7 @@
 
 #define PCIE_GLI_9763E_CFG2      0x8A4
 #define   GLI_9763E_CFG2_L1DLY     GENMASK(28, 19)
-#define   GLI_9763E_CFG2_L1DLY_MID 0x54
+#define   GLI_9763E_CFG2_L1DLY_MID 0x50
 
 #define PCIE_GLI_9763E_MMC_CTRL  0x960
 #define   GLI_9763E_HS400_SLOW     BIT(3)
@@ -810,7 +810,7 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
 
 	pci_read_config_dword(pdev, PCIE_GLI_9763E_CFG2, &value);
 	value &= ~GLI_9763E_CFG2_L1DLY;
-	/* set ASPM L1 entry delay to 21us */
+	/* set ASPM L1 entry delay to 20us */
 	value |= FIELD_PREP(GLI_9763E_CFG2_L1DLY, GLI_9763E_CFG2_L1DLY_MID);
 	pci_write_config_dword(pdev, PCIE_GLI_9763E_CFG2, value);
 
-- 
2.27.0

