Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBDE539CFD3
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 17:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhFFPlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 11:41:08 -0400
Received: from mail-pl1-f171.google.com ([209.85.214.171]:33308 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhFFPlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 11:41:02 -0400
Received: by mail-pl1-f171.google.com with SMTP id c13so7281409plz.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 08:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6+x2D/lxfvdpb/kRO1O/4x7Jx1x5bjZzwFIZplCL9AU=;
        b=PhmIyidjuBJ3qAKsas3qnNHe7fOIFgvmz/lxjZn6KC+AbOCO7dgpxdNBuCgkhAuB6Y
         LcQKy66RF75wZxLiljYoxlZ7IMeiOEuzu7D+dRRM61wH3luJ2+wk8ppKmjq5Z7KiAZzn
         reuvRFeikj2powqHxqns9L5Ip3ZpyTa0VAju0DopDQ/D6CByK/6mbHRjNW+iE+JVwTpR
         XtYRvHAC5XKaDwyMslEuH0i62whd/IwUo1zELedlpHKZjsdMZkYvA6bZVpEO3N4Zutqp
         snm7RQrxRKvioADyTUbludTFW7+AHagyAHpp7jOW6WPRon17BdWME0p1lfpvhbMQkWiG
         6Ukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6+x2D/lxfvdpb/kRO1O/4x7Jx1x5bjZzwFIZplCL9AU=;
        b=JTiO/wklyrgg/tuzwi8hyCg42Npbp4BAgPlhgo6mbCkMUvOYQ9TiFlp+YA0N7omC+e
         ou943V/Jja4LeM89dFjEA9eAzFVZtOgyCdYapKK7S0PDJrDDLqOYfqXqvE9zxpOW1rei
         ReHZP3cD4Q4wNV9aPBn6BoPpzNUGdM5c2XMUmBFJUNTww0GBabc2sQCtnHK/Yi6FcL9n
         6jGr29Rm0pNaTGH+5OYbPSyTO+DF9eKPTYCtf8ricwEJiq2kKa+JuzObFoeNZtRk3U2c
         moUuLgA/okWk7H9Us8lm+LFVEhH49q7L6qD1j0ycSdHCpvYfBzGG3Feevc0i05U3dvh/
         rzIA==
X-Gm-Message-State: AOAM531TczEzjZTRvXlkJO32UKg8SLT/kVRURfDS7xvq0Z9VOThu8itc
        NPheozs0l/KKmJ/YD1rjJAHc
X-Google-Smtp-Source: ABdhPJy5YiPNgt9WCE8NA3Kpi5m5FfUp5jd9HShX7AG7Zo/6na0sDHeX9s3dEA9C5JEPZlL1Raj2Xw==
X-Received: by 2002:a17:90a:130a:: with SMTP id h10mr1834979pja.188.1622993879272;
        Sun, 06 Jun 2021 08:37:59 -0700 (PDT)
Received: from localhost.localdomain ([120.138.12.59])
        by smtp.gmail.com with ESMTPSA id g29sm6497919pgm.11.2021.06.06.08.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 08:37:58 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        jarvis.w.jiang@gmail.com, loic.poulain@linaro.org,
        Shujun Wang <wsj20369@163.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 3/3] bus: mhi: pci-generic: Fix hibernation
Date:   Sun,  6 Jun 2021 21:07:41 +0530
Message-Id: <20210606153741.20725-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210606153741.20725-1-manivannan.sadhasivam@linaro.org>
References: <20210606153741.20725-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Loic Poulain <loic.poulain@linaro.org>

This patch fixes crash after resuming from hibernation. The issue
occurs when mhi stack is builtin and so part of the 'restore-kernel',
causing the device to be resumed from 'restored kernel' with a no
more valid context (memory mappings etc...) and leading to spurious
crashes.

This patch fixes the issue by implementing proper freeze/restore
callbacks.

Reported-by: Shujun Wang <wsj20369@163.com>
Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Link: https://lore.kernel.org/r/1622571445-4505-1-git-send-email-loic.poulain@linaro.org
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/pci_generic.c | 36 ++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/mhi/pci_generic.c b/drivers/bus/mhi/pci_generic.c
index 0a6619ad292c..b3357a8a2fdb 100644
--- a/drivers/bus/mhi/pci_generic.c
+++ b/drivers/bus/mhi/pci_generic.c
@@ -935,9 +935,43 @@ static int __maybe_unused mhi_pci_resume(struct device *dev)
 	return ret;
 }
 
+static int __maybe_unused mhi_pci_freeze(struct device *dev)
+{
+	struct mhi_pci_device *mhi_pdev = dev_get_drvdata(dev);
+	struct mhi_controller *mhi_cntrl = &mhi_pdev->mhi_cntrl;
+
+	/* We want to stop all operations, hibernation does not guarantee that
+	 * device will be in the same state as before freezing, especially if
+	 * the intermediate restore kernel reinitializes MHI device with new
+	 * context.
+	 */
+	if (test_and_clear_bit(MHI_PCI_DEV_STARTED, &mhi_pdev->status)) {
+		mhi_power_down(mhi_cntrl, false);
+		mhi_unprepare_after_power_down(mhi_cntrl);
+	}
+
+	return 0;
+}
+
+static int __maybe_unused mhi_pci_restore(struct device *dev)
+{
+	struct mhi_pci_device *mhi_pdev = dev_get_drvdata(dev);
+
+	/* Reinitialize the device */
+	queue_work(system_long_wq, &mhi_pdev->recovery_work);
+
+	return 0;
+}
+
 static const struct dev_pm_ops mhi_pci_pm_ops = {
 	SET_RUNTIME_PM_OPS(mhi_pci_runtime_suspend, mhi_pci_runtime_resume, NULL)
-	SET_SYSTEM_SLEEP_PM_OPS(mhi_pci_suspend, mhi_pci_resume)
+#ifdef CONFIG_PM_SLEEP
+	.suspend = mhi_pci_suspend,
+	.resume = mhi_pci_resume,
+	.freeze = mhi_pci_freeze,
+	.thaw = mhi_pci_restore,
+	.restore = mhi_pci_restore,
+#endif
 };
 
 static struct pci_driver mhi_pci_driver = {
-- 
2.25.1

