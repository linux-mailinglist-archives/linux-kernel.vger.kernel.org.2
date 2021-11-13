Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D68C244F3BC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 15:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234298AbhKMOc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 09:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbhKMOcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 09:32:55 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2863BC061766;
        Sat, 13 Nov 2021 06:30:03 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id x15so50065132edv.1;
        Sat, 13 Nov 2021 06:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rsXtq5cT+PS6ZLC3AGn+ReW0dldy/MCAJ1syGaHgkg4=;
        b=dleujFxy/lWRboStEM18XtEpfJtVeQ6+hTU3l7Aj0s1N6vxDnc6ynXeANDvRxk+05T
         YmFeVzOULDXVrbEFAKnG3rtHLzXwQ5wQlhOa3vifz4RU6WWOrcqrhljjQuaBMIXtRLlc
         IiPhVdAJcMab9BPT29tljlp3LnRotziMvhUSBGkhqMWwr3cr27T2dsTr1e1mn4NW/UCi
         Qvs7mTMWrDGKNnwtps0HSpn3kOKovdJ9njoNDlctmSITaeiqXD7T1K0sOQ1CPJM8vCmo
         mPAM1KqGtlVs0Zvy2k/3Yqn3tYR1lx46VtLDJJGe3CLYi3kPknCoshAWLP+81SMNtcPQ
         cvew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rsXtq5cT+PS6ZLC3AGn+ReW0dldy/MCAJ1syGaHgkg4=;
        b=niQltXwlzwTMZiYKhS8cuYAfAReWxkdRSLUXxStqDEqlpoFP+B3GQ8QfDpoor/xoAm
         rMHtKmQMFBCvJ/VdDeRd82h8pjs8CC0CwKEW2n12Y8yGlxcCrPRcXzMPFSOpBXRBtM7Y
         OxATueSeMfCo2N15ZkU0lrgFu6G7NpzBVIWM4gItyCHmpKIzW/6Xbx8KvD44chCJWM02
         Fb+R66b/bdqa84fWzEE3LWxSl0DFfsy9Ga8/WFYvJldeEk+qHDaczGqRZbqpxKE4gaVv
         1ebQNYw7bw62A9RHmCb5yfAzDbTc1dlh2fAy1e42Oz4AobVTDdRAn7L3X3KOO4+CTMd+
         Jz5g==
X-Gm-Message-State: AOAM531wp9K3W6vLDeg7pBN9tBq2IsMZornDjXGLHziPZFIDlIbSWi2O
        t1IuYFE11x2fdUzJBM6T5ovF2rxc50C0WQ==
X-Google-Smtp-Source: ABdhPJynddXZs31/tJaZG9DKhzJiY8hgFSr/ZBDe/1TOH6iCGOKDtiIJ5nqUhFwpA8AhHt3MeZFazA==
X-Received: by 2002:a05:6402:3513:: with SMTP id b19mr33699457edd.351.1636813801749;
        Sat, 13 Nov 2021 06:30:01 -0800 (PST)
Received: from agape (77-32-6-129.dyn.eolo.it. [77.32.6.129])
        by smtp.gmail.com with ESMTPSA id h10sm4561892edb.59.2021.11.13.06.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Nov 2021 06:30:01 -0800 (PST)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     balbi@kernel.org, arnd@arndb.de, hch@lst.de, sven@svenpeter.dev,
        hdegoede@redhat.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH] usb: dwc3: leave default DMA for PCI devices
Date:   Sat, 13 Nov 2021 15:29:59 +0100
Message-Id: <20211113142959.27191-1-fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

in case of a PCI dwc3 controller, leave the default DMA
mask. Calling of a 64 bit DMA mask breaks the driver on
cherrytrail based tablets like Cyberbook T116.

Fixes: 45d39448b4d0 ("usb: dwc3: support 64 bit DMA in platform driver")
Reported-by: Hans De Goede <hdegoede@redhat.com>
Tested-by: Fabio Aiuto <fabioaiuto83@gmail.com>
Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/usb/dwc3/core.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 643239d7d370..f4c09951b517 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1594,9 +1594,11 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	dwc3_get_properties(dwc);
 
-	ret = dma_set_mask_and_coherent(dwc->sysdev, DMA_BIT_MASK(64));
-	if (ret)
-		return ret;
+	if (!dwc->sysdev_is_parent) {
+		ret = dma_set_mask_and_coherent(dwc->sysdev, DMA_BIT_MASK(64));
+		if (ret)
+			return ret;
+	}
 
 	dwc->reset = devm_reset_control_array_get_optional_shared(dev);
 	if (IS_ERR(dwc->reset))
-- 
2.30.2

