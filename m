Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A46E3A99C3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 14:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbhFPMCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 08:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232730AbhFPMB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 08:01:59 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9B4C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 04:59:52 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id i11-20020a17090a2acbb029016f0cce7c3fso1389035pjg.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 04:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WfSzf8q0eDZEzZPtPn8LE1Enrwc2IXUI8dRvj+qdHQ8=;
        b=SX6MbQxJx5bNXDC6+qbOT/3mfAikMaXeRvr8mtzXSi6Y5nk1XvlW2FSIFqRFGkhdk+
         lb16UwwjM1g39AKfZTTox6tw9FqQEwswEy2CJEA7hsl+Re1jouxBGvYLl33FwhLeinLS
         RlWV7aL4DzGOEHg9qE6BijM0jE4SRM/TyJRoLA5LzFA+FPK1pcUrQS6aEuQziKTrg9Kb
         zTZNWFnixekHNIE6K2Ui/OtxeNj1eEq37lo4qTU9k+7ArbNCpvA5Vn2oQVsIZiZG2L5s
         7JEpp+rWWH3Kv5G1nYpmrHl4bEMh8S9ecNy6pVkxn4c7ejSHN/pKApheynl7n6MTpO7f
         QC8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WfSzf8q0eDZEzZPtPn8LE1Enrwc2IXUI8dRvj+qdHQ8=;
        b=etJNpVSEbaMV8384Rtl8bQTJw42iDZrSVFpd3Z8qT6pQden5IgI+SW8K1J/s+pqKQX
         qbqcqUOwrgcArOcLz7PFu9Wx34BwRsTBiazmHiSSU9hxnEgVp4l/C81vYSP8g8tn55VK
         gOGQB3HTGinpcDoaZH5oikMB1SrMgoo/s19lezejbZvV3sMQfJVXjIjiGK92ml0AHtlg
         tGO4jRwAel0grVzOcrTe323k587EyXu76LlCVUuaZLdfzvwvVBBJHYcPPchwPPI9HnGu
         YH41oeicz3X/Ttzba8rHCvt+dJFqOtgzx+opeOcknq7Pn4zA0QG+7t4HkI3OEzizgLwn
         UcWQ==
X-Gm-Message-State: AOAM530nTXvDYlnq/yOuEXr2EsNPZ+NcQ8ajISvSjhX19UYyYtfMhyRD
        x1tlBKVPNzEdZiaTSOMynEvb
X-Google-Smtp-Source: ABdhPJzOXaw9Lc+Rhu2YNag2D4DTkzJU8HQpS1MnTFqW8OP6Smn+UtaBaZt1gceNdtNTIErDnOwVKA==
X-Received: by 2002:a17:90b:3b92:: with SMTP id pc18mr4589519pjb.100.1623844792049;
        Wed, 16 Jun 2021 04:59:52 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:280:c67a:95b5:d877:b175:798e])
        by smtp.gmail.com with ESMTPSA id m1sm2307646pjk.35.2021.06.16.04.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 04:59:51 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@ti.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        smohanad@codeaurora.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/5] PCI: endpoint: Add BME notifier support
Date:   Wed, 16 Jun 2021 17:29:10 +0530
Message-Id: <20210616115913.138778-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210616115913.138778-1-manivannan.sadhasivam@linaro.org>
References: <20210616115913.138778-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to notify the EPF device about the Bus Master Enable (BME)
event received by the EPC device from the Root complex.

Usage:
======

EPC
---

```
static irqreturn_t pcie_ep_irq(int irq, void *data)
{
...
	case PCIE_EP_INT_BME:
		pci_epc_bme_notify(epc);
		break;
...
}
```

EPF
---

```
static int pci_epf_notifier(struct notifier_block *nb, unsigned long val,
			    void *data)
{
...
	case BME:
		/* Handle BME event */
		break;
...
}
```

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/endpoint/pci-epc-core.c | 17 +++++++++++++++++
 include/linux/pci-epc.h             |  1 +
 include/linux/pci-epf.h             |  1 +
 3 files changed, 19 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index f29d78c18438..7e42a83a4877 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -675,6 +675,23 @@ void pci_epc_init_notify(struct pci_epc *epc)
 }
 EXPORT_SYMBOL_GPL(pci_epc_init_notify);
 
+/**
+ * pci_epc_bme_notify() - Notify the EPF device that the EPC device has received
+ *			  the BME event from the Root complex
+ * @epc: the EPC device that received the BME event
+ *
+ * Invoke to Notify the EPF device that the EPC device has received the Bus
+ * Master Enable (BME) event from the Root complex
+ */
+void pci_epc_bme_notify(struct pci_epc *epc)
+{
+	if (!epc || IS_ERR(epc))
+		return;
+
+	atomic_notifier_call_chain(&epc->notifier, BME, NULL);
+}
+EXPORT_SYMBOL_GPL(pci_epc_bme_notify);
+
 /**
  * pci_epc_destroy() - destroy the EPC device
  * @epc: the EPC device that has to be destroyed
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 23590efc13e7..6c2cff33f670 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -204,6 +204,7 @@ int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf,
 void pci_epc_linkup(struct pci_epc *epc);
 void pci_epc_linkdown(struct pci_epc *epc);
 void pci_epc_init_notify(struct pci_epc *epc);
+void pci_epc_bme_notify(struct pci_epc *epc);
 void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf,
 			enum pci_epc_interface_type type);
 int pci_epc_write_header(struct pci_epc *epc, u8 func_no,
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index e9ad634b1575..063a59a58e3c 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -21,6 +21,7 @@ enum pci_notify_event {
 	CORE_INIT,
 	LINK_UP,
 	LINK_DOWN,
+	BME,
 };
 
 enum pci_barno {
-- 
2.25.1

