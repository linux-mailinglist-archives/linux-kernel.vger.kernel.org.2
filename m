Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1397C324C7E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 10:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236173AbhBYJLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 04:11:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235200AbhBYJHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 04:07:14 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6749C061756
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 01:06:32 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id r5so3159410pfh.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 01:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7oTUgWWdsDaun/nhLkz8THldhf/BUoF8aFanx1A5q08=;
        b=u0xk/at+ZtV2khvMxKfg/zP8LeL19xpqF0Xd5cWwVG8yoHARHKPEqsTiTnyEo6I1O7
         NkC3kQ7dTtzUKk4vecHpwHKT1eszAEOpHA0JG22D5mF/yEs5sBqP/0Z2B3fh1zxzFeZw
         O6HsRtmOswKjNLckzz3ryGM/o13LgHMDpOs6jbOBDMV+SLSWYJ0/Ukr6NZ1AuW7JeuJt
         S9cM8HnM5rGAlrQ4JHw11trpx2Y+bjEx1lZqTM+HYQUAYgA9PAlON2sMKjG/tRYNd+X2
         g9xP79hWAGy8+Ben5MkmjZe/vZ5WyT/sMzfhLCZ550C+oHmNT3GcVG0Fxl6k26dTh495
         zsqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7oTUgWWdsDaun/nhLkz8THldhf/BUoF8aFanx1A5q08=;
        b=j433iGF6OpHSiCwm/z8atBOqG+kk2Weie5Dc4VreC2QoZs2vsQ7sGd1XqvYphtS0Ju
         2p1PCsDgOZI+8LkNTMocAeiisv18NFy8uiYV4pxoaaZl1EqtYBV/pKuGUBE5WJ/POs0I
         Eumler7g7N5yoPPRstMKlnIPDuAUGmcXxqEk3QXv8u914hVrA8P/G1MFScJh3HpR0Qsn
         3ochpwmpK5J7tlvHcFij1DYQcSDh29hHwehgSRutAzkFhNBm5QDnhZ05bKm3OgaI6CEg
         ti4IcUYNQ2HpuIdAUNKsOTRzs+sUj1qo87U88GDoQ7eHDyey1Wip6yVtdojGzC8uj6FN
         aFvw==
X-Gm-Message-State: AOAM532PY9F+Fp4Z0jSdv826mQOW3/A47tcH6BRhsQx1r09sBZupLkxR
        38iSfmWxuOdo9pBwb4v2AcQ=
X-Google-Smtp-Source: ABdhPJzMWkMeFQSn2LCxVvarxP+/8wbrRzI/vAosKX9EfFFQv/D/yZ8qn7MiuSgNIm6m71H4uskFrg==
X-Received: by 2002:a05:6a00:ac8:b029:1ed:f8dc:cb3b with SMTP id c8-20020a056a000ac8b02901edf8dccb3bmr2350632pfl.60.1614243992361;
        Thu, 25 Feb 2021 01:06:32 -0800 (PST)
Received: from localhost.localdomain ([49.207.194.79])
        by smtp.gmail.com with ESMTPSA id n11sm5098373pgm.30.2021.02.25.01.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 01:06:31 -0800 (PST)
From:   Allen Pais <allen.lkml@gmail.com>
To:     jens.wiklander@linaro.org, zajec5@gmail.com
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org,
        Allen Pais <apais@linux.microsoft.com>
Subject: [PATCH v2 1/2] optee: fix tee out of memory failure seen during kexec reboot
Date:   Thu, 25 Feb 2021 14:36:09 +0530
Message-Id: <20210225090610.242623-2-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210225090610.242623-1-allen.lkml@gmail.com>
References: <20210225090610.242623-1-allen.lkml@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Allen Pais <apais@linux.microsoft.com>

The following out of memory errors are seen on kexec reboot
from the optee core.

[    0.368428] tee_bnxt_fw optee-clnt0: tee_shm_alloc failed
[    0.368461] tee_bnxt_fw: probe of optee-clnt0 failed with error -22

tee_shm_release() is not invoked on dma shm buffer.

Implement .shutdown() method to handle the release of the buffers
correctly.

More info:
https://github.com/OP-TEE/optee_os/issues/3637

Signed-off-by: Allen Pais <apais@linux.microsoft.com>
---
 drivers/tee/optee/core.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index cf4718c6d35d..80e2774b5e2a 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -582,6 +582,13 @@ static optee_invoke_fn *get_invoke_func(struct device *dev)
 	return ERR_PTR(-EINVAL);
 }
 
+/* optee_remove - Device Removal Routine
+ * @pdev: platform device information struct
+ *
+ * optee_remove is called by platform subsystem to alter the driver
+ * that it should release the device
+ */
+
 static int optee_remove(struct platform_device *pdev)
 {
 	struct optee *optee = platform_get_drvdata(pdev);
@@ -612,6 +619,18 @@ static int optee_remove(struct platform_device *pdev)
 	return 0;
 }
 
+/* optee_shutdown - Device Removal Routine
+ * @pdev: platform device information struct
+ *
+ * platform_shutdown is called by the platform subsystem to alter
+ * the driver that a shutdown/reboot(or kexec) is happening and
+ * device must be disabled.
+ */
+static void optee_shutdown(struct platform_device *pdev)
+{
+	optee_disable_shm_cache(platform_get_drvdata(pdev));
+}
+
 static int optee_probe(struct platform_device *pdev)
 {
 	optee_invoke_fn *invoke_fn;
@@ -738,6 +757,7 @@ MODULE_DEVICE_TABLE(of, optee_dt_match);
 static struct platform_driver optee_driver = {
 	.probe  = optee_probe,
 	.remove = optee_remove,
+	.shutdown = optee_shutdown,
 	.driver = {
 		.name = "optee",
 		.of_match_table = optee_dt_match,
-- 
2.25.1

