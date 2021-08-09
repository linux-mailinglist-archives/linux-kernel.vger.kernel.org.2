Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9085D3E4795
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 16:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235155AbhHIOdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 10:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233130AbhHIOcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 10:32:06 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8D5C061799
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 07:31:45 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id z3so16511661plg.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 07:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ca+mdvNKYy7Q+DeiqSRqH1IkVbPyTgWTcRPI66QULXY=;
        b=Zd+s/KE+cfMe8QuzJJopWobvCGXq/gj/RMPmzGX5JGU2muoEswq5MPhWd3+y8tGVDM
         sFza2QZZ9Gprbah3M51WfqS59ALZgzM3+8nWU4OtIvBKKoFv9v2B/gynuVxcGeVNobL9
         2YamlAjG2WWjp//M7rDZhFfigxh/CCCJnQKWIBV5gBv17URkASBu7nCzis9rKvReAl4i
         4J/mSy6tOFkIgsxesWzfM9iTvZb1nQ8tmRNIVSwh7btHrlKeVbdvNjAvdDH4YjKXIaK/
         IaXFfE0+mrtIxXeRPHlAu3w1/C0vnGclWsDtUSbv9JBDWPl18aZxVPrXGo8SMmiTPGf9
         GQxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ca+mdvNKYy7Q+DeiqSRqH1IkVbPyTgWTcRPI66QULXY=;
        b=UJLsGKcKPJQV3zjx2HSOApa07a8P+Z7cgVjCAYK3L7O7DgiqmpegwIRwMnH2tCoMsk
         Czwurs6O5cHuJaMXMZKycd5ztBDhR460+mj4/ZBuRizYyTTuBRMehEIeD69sTiUnxH2E
         7I66RMBjDZMO+f9z/4eM5KopSIKXTuDCLXCNlZwxHaWKXSde0CvSMaQxOL6TSgvgOp7u
         IzXC1eq5l5vuSsTFKa2Azqxx0jB2+cL+0ogUVP6aWH+OQa867ZPGZKDXLWtZrAQV8YK0
         rZe0v2WeYcULmPJOJRe+QgD1LQeKyaEEtZ5K9eqVIhLIbl3E5tW3Gdmcz+dAOIFRvEXi
         Ks9A==
X-Gm-Message-State: AOAM533KDYOcUhZoJdsRMzsOqSzDf+uhs85FB0HNz5lfyXD7MmvMy5BC
        f7FP8Btv3PhcjVMEZy7JxX6sCVCxni8ouHfN
X-Google-Smtp-Source: ABdhPJwNExqbeVMUVBjcXPapn/Q/Aj25pfpDrVDHKpKYp66ih2c1bHkliEKI81ySash7pnxPi67Vig==
X-Received: by 2002:a05:6a00:791:b029:3be:500a:2017 with SMTP id g17-20020a056a000791b02903be500a2017mr24253612pfu.44.1628519505169;
        Mon, 09 Aug 2021 07:31:45 -0700 (PDT)
Received: from localhost.localdomain ([154.16.166.217])
        by smtp.gmail.com with ESMTPSA id g19sm9369747pfc.168.2021.08.09.07.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 07:31:44 -0700 (PDT)
From:   Dongliang Mu <mudongliangabcd@gmail.com>
To:     Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        Lv Yunlong <lyl2019@mail.ustc.edu.cn>,
        Randy Dunlap <rdunlap@infradead.org>,
        Aditya Srivastava <yashsri421@gmail.com>
Cc:     industrypack-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] ipack: tpci200: move tpci200_unregister close to tpci200_register
Date:   Mon,  9 Aug 2021 22:30:29 +0800
Message-Id: <20210809143049.3531188-4-mudongliangabcd@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210809143049.3531188-1-mudongliangabcd@gmail.com>
References: <20210809143049.3531188-1-mudongliangabcd@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move tpci200_unregister close to tpci200_register, then it is easier to
review the code related to the registration and unregistration

Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
 drivers/ipack/carriers/tpci200.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/ipack/carriers/tpci200.c b/drivers/ipack/carriers/tpci200.c
index 307f94f59c18..d553b4941539 100644
--- a/drivers/ipack/carriers/tpci200.c
+++ b/drivers/ipack/carriers/tpci200.c
@@ -84,20 +84,6 @@ static void tpci200_set_mask(struct tpci200_board *tpci200,
 	spin_unlock_irqrestore(&tpci200->regs_lock, flags);
 }
 
-static void tpci200_unregister(struct tpci200_board *tpci200)
-{
-	free_irq(tpci200->info->pdev->irq, (void *) tpci200);
-
-	iounmap(tpci200->info->pdev, tpci200->info->interface_regs);
-
-	pci_release_region(tpci200->info->pdev, TPCI200_IP_INTERFACE_BAR);
-	pci_release_region(tpci200->info->pdev, TPCI200_IO_ID_INT_SPACES_BAR);
-	pci_release_region(tpci200->info->pdev, TPCI200_MEM16_SPACE_BAR);
-	pci_release_region(tpci200->info->pdev, TPCI200_MEM8_SPACE_BAR);
-
-	pci_disable_device(tpci200->info->pdev);
-}
-
 static void tpci200_enable_irq(struct tpci200_board *tpci200,
 			       int islot)
 {
@@ -236,6 +222,20 @@ static int tpci200_request_irq(struct ipack_device *dev,
 	return res;
 }
 
+static void tpci200_unregister(struct tpci200_board *tpci200)
+{
+	free_irq(tpci200->info->pdev->irq, (void *) tpci200);
+
+	iounmap(tpci200->info->pdev, tpci200->info->interface_regs);
+
+	pci_release_region(tpci200->info->pdev, TPCI200_IP_INTERFACE_BAR);
+	pci_release_region(tpci200->info->pdev, TPCI200_IO_ID_INT_SPACES_BAR);
+	pci_release_region(tpci200->info->pdev, TPCI200_MEM16_SPACE_BAR);
+	pci_release_region(tpci200->info->pdev, TPCI200_MEM8_SPACE_BAR);
+
+	pci_disable_device(tpci200->info->pdev);
+}
+
 static int tpci200_register(struct tpci200_board *tpci200)
 {
 	int i;
-- 
2.25.1

