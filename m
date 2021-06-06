Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E595339CFD0
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 17:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhFFPkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 11:40:51 -0400
Received: from mail-pl1-f171.google.com ([209.85.214.171]:43962 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbhFFPkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 11:40:45 -0400
Received: by mail-pl1-f171.google.com with SMTP id v12so7240127plo.10
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 08:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YsOV+D3j4skh61Wm0zDVfF8WisFizCBafqzZoQKmbdg=;
        b=lk23dNiFfCDT0MgIbsrESUnFqezRoKBrEo5JoYh95Bd2gHW/WegHopl0MpUIoTtUkv
         cTTk/vsURhVee7MK7F8Ew5pHTneg23J98qBF8dEXQ1ebCR50GuzF/wbjT/rzIPzNtg4B
         4wyAgyhP6GV2Py0NpnwuC7Zxl0W0yT5y+Rubobf1gQre36+LCHCrDjyDlbnEZelFJohg
         KZUySPA1plE8ZmsApVN1xcYbh5092/v2VENK3XkJE8HkgTOW3COMVybo3Xf6Lmi0olas
         T+GpYuWI+2jbeFe21B5xHa++39tRmtamlqPlZnS0SXD8ugQndXNghJw/UPvjEfS5Sozb
         qyTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YsOV+D3j4skh61Wm0zDVfF8WisFizCBafqzZoQKmbdg=;
        b=D36nUXor0kDZHMU3Y933irdrVcVwc417Qxf3V0bi6FfYaUrYl4NM4j4r2fquHZPlng
         kkQIRiz/OmaDFW91zjWWGSEc89CDYWeuKv35DsHzPYaydSGP9xwFB7rYj4GqFaljtVjX
         Tyf0CA7CWJ+ZXOcKsJlta1n5Au61HHT3/GlVF1BUVVODx9kghmKzoV4f+7xBvvFGWXDc
         SZ0muZjpZaZRnnuOYl6QLx+AvQxnTIdqi9z+9go8RB4yoGS6E99AVicRQ+gyKueHXjVF
         BNJTYsmGC7uDGOJIUqBMx0kKCEAnElO4jG2luOX+wkZg970+nPFnJvy+wstsm+qkBm6N
         AbFA==
X-Gm-Message-State: AOAM53367uDz2i+HsZivZd4iTfz0uUHPTEyP57al+tAUXa2Sb73Ayfop
        L378xW2dqBenYxsLeRLtC8Ik
X-Google-Smtp-Source: ABdhPJzCqeat33aetXAl0Rbjchum/bOpfUAeeuKc5vpK8HL+IlzmotxnzaGfuTOd/jqDNpxxJ2Pmvg==
X-Received: by 2002:a17:902:f688:b029:112:7c0e:d027 with SMTP id l8-20020a170902f688b02901127c0ed027mr1086773plg.34.1622993875709;
        Sun, 06 Jun 2021 08:37:55 -0700 (PDT)
Received: from localhost.localdomain ([120.138.12.59])
        by smtp.gmail.com with ESMTPSA id g29sm6497919pgm.11.2021.06.06.08.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 08:37:55 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        jarvis.w.jiang@gmail.com, loic.poulain@linaro.org,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Hulk Robot <hulkci@huawei.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/3] bus: mhi: pci_generic: Fix possible use-after-free in mhi_pci_remove()
Date:   Sun,  6 Jun 2021 21:07:40 +0530
Message-Id: <20210606153741.20725-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210606153741.20725-1-manivannan.sadhasivam@linaro.org>
References: <20210606153741.20725-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

This driver's remove path calls del_timer(). However, that function
does not wait until the timer handler finishes. This means that the
timer handler may still be running after the driver's remove function
has finished, which would result in a use-after-free.

Fix by calling del_timer_sync(), which makes sure the timer handler
has finished, and unable to re-schedule itself.

Fixes: 8562d4fe34a3 ("mhi: pci_generic: Add health-check")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Reviewed-by: Hemant kumar <hemantk@codeaurora.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Loic Poulain <loic.poulain@linaro.org>
Link: https://lore.kernel.org/r/20210413160318.2003699-1-weiyongjun1@huawei.com
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/pci_generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/mhi/pci_generic.c b/drivers/bus/mhi/pci_generic.c
index 8c7f6576e421..0a6619ad292c 100644
--- a/drivers/bus/mhi/pci_generic.c
+++ b/drivers/bus/mhi/pci_generic.c
@@ -708,7 +708,7 @@ static void mhi_pci_remove(struct pci_dev *pdev)
 	struct mhi_pci_device *mhi_pdev = pci_get_drvdata(pdev);
 	struct mhi_controller *mhi_cntrl = &mhi_pdev->mhi_cntrl;
 
-	del_timer(&mhi_pdev->health_check_timer);
+	del_timer_sync(&mhi_pdev->health_check_timer);
 	cancel_work_sync(&mhi_pdev->recovery_work);
 
 	if (test_and_clear_bit(MHI_PCI_DEV_STARTED, &mhi_pdev->status)) {
-- 
2.25.1

