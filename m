Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17657389BE7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 05:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbhETDel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 23:34:41 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50452 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhETDek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 23:34:40 -0400
Received: from mail-pl1-f197.google.com ([209.85.214.197])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <koba.ko@canonical.com>)
        id 1ljZR1-0007ia-4l
        for linux-kernel@vger.kernel.org; Thu, 20 May 2021 03:33:19 +0000
Received: by mail-pl1-f197.google.com with SMTP id t13-20020a170902dccdb02900f0bc643e1fso7228137pll.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 20:33:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YkQ4ceXLTuoJdgsh3J+Fp8JdGg+suqM/P8mBDtwI5y4=;
        b=uVCZTYK4dwbEPBpjLbmFEGnll4HPVs+Io627lLqn8/NQMDvtx1+JtS2xsSThNDUr02
         HeoNC19Kd+AvR7MYzOC7tRC0L6S2O57PWFjPCw+hIRrR1L/TmiYKXw7Xn5irkixY6Map
         NVGC2bZoI2iBKiXECSymE6lf1o1j4DtbwKcrJm4fPi1B+uyGLa5/b8/W69c1a1ZTKAa9
         mVKxmRZ43SfTfI+DCCe2do1f4ovAklKQPM0iSyGP7xtMk0d3h7WtyvKvG5IMZX9arHDA
         kTDa9RXTybLhoElMcYrbysqAaphCKYZMMPkCM0GJMV7gteLoXA+SE5VjjlDfLcZXms0F
         5OXA==
X-Gm-Message-State: AOAM530TIJhXKX/E3/Zi3G7WkaxGQRXGwru1k1yTFcIu/FkThFcjdlha
        PVVU6toTIQZ7fJebjMT3FbANkSI0Jz7vWcTq1rH3anXRdow3XJRqce0UkD4tw+eGISKeidmiY0O
        auxbdTlNd+Fk7RaHb7onJxUP9nUGcm63gWLcLf9OHVA==
X-Received: by 2002:a63:ba1b:: with SMTP id k27mr2391413pgf.381.1621481597723;
        Wed, 19 May 2021 20:33:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwEQdG/WIW+OBmm8n7TrD3C+K/NNVGnz6wyAx0m47BSdwHi2idQXGZs1SeQ5To8OtLR6AkvTg==
X-Received: by 2002:a63:ba1b:: with SMTP id k27mr2391389pgf.381.1621481597456;
        Wed, 19 May 2021 20:33:17 -0700 (PDT)
Received: from canonical.com (61-220-137-34.HINET-IP.hinet.net. [61.220.137.34])
        by smtp.gmail.com with ESMTPSA id 66sm687565pgj.9.2021.05.19.20.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 20:33:17 -0700 (PDT)
From:   Koba Ko <koba.ko@canonical.com>
To:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Henrik Juul Hansen <hjhansen2020@gmail.com>
Subject: [PATCH] nvme-pci: Avoid to go into d3cold if device can't use npss.
Date:   Thu, 20 May 2021 11:33:15 +0800
Message-Id: <20210520033315.490584-1-koba.ko@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During suspend, if the device can't use npss, driver would put
controller to shutdown simply and let host to control power management.
After resume, host can't change power state of the closed controller
from D3cold to D0.
For these devices, just avoid to go deeper than d3hot.

Tested-by: Henrik Juul Hansen <hjhansen2020@gmail.com>
Signed-off-by: Koba Ko <koba.ko@canonical.com>
---
 drivers/nvme/host/pci.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a29b170701fc..caaf52051689 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -26,6 +26,7 @@
 #include <linux/io-64-nonatomic-hi-lo.h>
 #include <linux/sed-opal.h>
 #include <linux/pci-p2pdma.h>
+#include <linux/pm_runtime.h>
 
 #include "trace.h"
 #include "nvme.h"
@@ -2958,6 +2959,15 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	dev_info(dev->ctrl.device, "pci function %s\n", dev_name(&pdev->dev));
 
+	if (pm_suspend_via_firmware() || !dev->ctrl.npss ||
+	    !pcie_aspm_enabled(pdev) ||
+	    dev->nr_host_mem_descs ||
+	    (dev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND)) {
+		pdev->d3cold_allowed = false;
+		pci_d3cold_disable(pdev);
+		pm_runtime_resume(&pdev->dev);
+	}
+
 	nvme_reset_ctrl(&dev->ctrl);
 	async_schedule(nvme_async_probe, dev);
 
-- 
2.25.1

