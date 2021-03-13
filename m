Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 153C933A04D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 20:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234368AbhCMTV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 14:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbhCMTVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 14:21:02 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7EF5C061574;
        Sat, 13 Mar 2021 11:21:01 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id a11so6466086qto.2;
        Sat, 13 Mar 2021 11:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8WCY5ATMrHpqIBkJNP0CYNTT4f6cz/YmUdoof+B7AT0=;
        b=JKtcFnhHA85knc+Z5ZBbaLBPpQB1O0Elh3/N/T3GlqjMRbKcv/B7ZoUUSKRequTW67
         9USD1rtUhsdj2YQomvozTHj5MAIpArG3x2RmBHIoynG0th9deF9BcrG8gXseyG1215JI
         fx+GWZKczVhM1CzIdTuXVDAa9wMID/iElQnFNQ1gltPc15Q/2ytUFUmosDR262ednQfX
         UH3Vas9zZ4xODWbrgkd/jGC0rt+q5FA/Pcj1btY4yI9EmMAlSPiM12XFzfo1lG3PWq0w
         Wal7bKC97cYQv0cGdeBseDWT0WDw7B4jXABYxikojyPMLSSnRQiV9y3XrTo6p3ha4/Ia
         ALNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8WCY5ATMrHpqIBkJNP0CYNTT4f6cz/YmUdoof+B7AT0=;
        b=ddnElc2+buFiAKKQWd5zF4QSw2c+gXyMzvCf/5ljbuLycfhgwGKHm/3/cPrKqygz/J
         w4kQ9ZpOlq98DooQKvi2eU+oqttxT9OVLn0drz01Wu1C2MaK/62G49OC2/nY+SmdCXTY
         W7w67vAM29ca4/XqhG2P8FM98gOQ+mDJQzmuv9DPo9ZREQHieXMOUJzVJrbsca+SaIjz
         /mNhEER2nWRfjs9VmgEt6zM+DZlfu0mLtJ/88RtzSrBBmCyhvXWZhlA2zczP6XniyiLY
         m/KHMOsCAZPs+xiun1ttD8C/dfz7GS1WL+1nSaLqnsmeqpE0DAnrFn9GcICZKw8MhAHb
         R9oA==
X-Gm-Message-State: AOAM532JRvVrOgdt9Ukp9q8SliFSPAH8/hSZ9Zpru8VmFD8qKXNlTZdg
        AR2t0uy65jHX0sTyOkRoOSk=
X-Google-Smtp-Source: ABdhPJx+3XXL6PcJTLYoyK/iidanDFWK4jMRp/G+jTHfdvkJH8jEtBjFkkc7MYkjFDiDSj1NSGOUXA==
X-Received: by 2002:aed:29e5:: with SMTP id o92mr16673263qtd.29.1615663260736;
        Sat, 13 Mar 2021 11:21:00 -0800 (PST)
Received: from tong-desktop.local ([2601:5c0:c200:27c6:459d:aa36:3ddc:2a41])
        by smtp.googlemail.com with ESMTPSA id j12sm6474607qtn.36.2021.03.13.11.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 11:21:00 -0800 (PST)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Tong Zhang <ztong0001@gmail.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: gadget: udc: amd5536udc_pci fix crash if dma is used
Date:   Sat, 13 Mar 2021 14:20:32 -0500
Message-Id: <20210313192033.2611349-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

init_dma_pools() calls dma_pool_create(...dev->dev) to create dma pool.
however, dev->dev is actually set after calling init_dma_pools(), which
effectively makes dma_pool_create(..NULL) and cause crash.
To fix this issue, init dma only after dev->dev is set.

[    1.317993] RIP: 0010:dma_pool_create+0x83/0x290
[    1.323257] Call Trace:
[    1.323390]  ? pci_write_config_word+0x27/0x30
[    1.323626]  init_dma_pools+0x41/0x1a0 [snps_udc_core]
[    1.323899]  udc_pci_probe+0x202/0x2b1 [amd5536udc_pci]

Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
 drivers/usb/gadget/udc/amd5536udc_pci.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/udc/amd5536udc_pci.c b/drivers/usb/gadget/udc/amd5536udc_pci.c
index 8d387e0e4d91..c80f9bd51b75 100644
--- a/drivers/usb/gadget/udc/amd5536udc_pci.c
+++ b/drivers/usb/gadget/udc/amd5536udc_pci.c
@@ -153,6 +153,11 @@ static int udc_pci_probe(
 	pci_set_master(pdev);
 	pci_try_set_mwi(pdev);
 
+	dev->phys_addr = resource;
+	dev->irq = pdev->irq;
+	dev->pdev = pdev;
+	dev->dev = &pdev->dev;
+
 	/* init dma pools */
 	if (use_dma) {
 		retval = init_dma_pools(dev);
@@ -160,11 +165,6 @@ static int udc_pci_probe(
 			goto err_dma;
 	}
 
-	dev->phys_addr = resource;
-	dev->irq = pdev->irq;
-	dev->pdev = pdev;
-	dev->dev = &pdev->dev;
-
 	/* general probing */
 	if (udc_probe(dev)) {
 		retval = -ENODEV;
-- 
2.25.1

