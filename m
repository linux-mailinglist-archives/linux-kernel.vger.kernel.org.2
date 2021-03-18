Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28992340A13
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 17:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbhCRQWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 12:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbhCRQWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 12:22:03 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1607FC06174A;
        Thu, 18 Mar 2021 09:22:03 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id h7so4492552qtx.3;
        Thu, 18 Mar 2021 09:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=v5j6GsQ8vHTvN2BKBHKR/KZ/Jo+Q52naC77HAhp4AOM=;
        b=sUgU8N5sc7IYWX+VlkzY6CULRmkY70XqFMGNlsvkhpaGGLgk/iJtBZouxRom+13YTg
         6Spf+FMtLsLNzX+TuBtW/zJplev1LBmOAg2/wCCarNzYJM/zLF63B3IJ7MlNwv4xh3po
         XazHWdB0Lz/OrJ1FOzFQJqayB0p5tjERYtDKh28/YnR6gWE/Yyk2z7ScGhmZjaqPSTxv
         0hyHRL4sUKeyOULLHdlsxr5kDYHw7TEwUcCh8WX5hwcVZBDzlYWVXbCN7ReaiARf5mbY
         iGayOzbr61KzjfKnuOPxNpMWvWoDFbEZwtx7cTv7eHDwCUTDybKfH2x4ofbHIRNN/GrI
         9VpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v5j6GsQ8vHTvN2BKBHKR/KZ/Jo+Q52naC77HAhp4AOM=;
        b=iaUjw4iFLqcpYQFfTwrFyrRdMa67uMJ8DS3RV7XDwsyIGg8UAuXVJKyXrk4kTtyHjI
         81JRNfW/xQvfL0L95Dkp5xYxMd7zJHUZmdwBqtgUci7R8+bYgUs/eFpRvmJHDlsidby3
         +rVp6KxvES6E0y3QDcHByEF0AO6+0pP5iQZGV6+08Nx7nSWn/eC3m8OC6sIjT0gBxbN3
         Qd2BRKWWEwDiwQY1tOBu32ysz2NaVCNOBrAG1VTUqYbqFytGgo+4kBDeehqDP3B4cA0e
         XpKZz1ik7oOC+ZpuJcplAEfVFErf0310O13jBhgyO3o+T4qCaM1WRkkT8O2zrpGD5Jwv
         NDGg==
X-Gm-Message-State: AOAM5337kb7vkgK/tQ7xaAW+Yww8KBOpGdavpF+quKWQwiKcGS8nu9mL
        9YkWGAB/2YvvF9yIpPvrCk0=
X-Google-Smtp-Source: ABdhPJxkjEUltUxrulH9McwBVYu6P3ak/KDMEO8zP6AIC+xi7VBeUIC3AVqpsBhLFwQB2atP9ZNY7g==
X-Received: by 2002:ac8:5cd2:: with SMTP id s18mr4481064qta.129.1616084522331;
        Thu, 18 Mar 2021 09:22:02 -0700 (PDT)
Received: from tong-desktop.local ([2601:5c0:c200:27c6:d4e9:423a:4aca:b208])
        by smtp.googlemail.com with ESMTPSA id d14sm2230722qkg.33.2021.03.18.09.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 09:22:02 -0700 (PDT)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Tong Zhang <ztong0001@gmail.com>,
        Fiona Trahe <fiona.trahe@intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>, qat-linux@intel.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wojciech Ziemba <wojciech.ziemba@intel.com>
Subject: [PATCH v4 2/2] crypto: qat: ADF_STATUS_PF_RUNNING should be set after adf_dev_init
Date:   Thu, 18 Mar 2021 12:21:05 -0400
Message-Id: <20210318162105.378239-3-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YFN6hlz/L7erLO0H@silpixa00400314>
References: <YFN6hlz/L7erLO0H@silpixa00400314>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ADF_STATUS_PF_RUNNING is (only) used and checked by adf_vf2pf_shutdown()
before calling adf_iov_putmsg()->mutex_lock(vf2pf_lock), however the
vf2pf_lock is initialized in adf_dev_init(), which can fail and when it
fail, the vf2pf_lock is either not initialized or destroyed, a subsequent
use of vf2pf_lock will cause issue.
To fix this issue, only set this flag if adf_dev_init() returns 0.

[    7.178404] BUG: KASAN: user-memory-access in __mutex_lock.isra.0+0x1ac/0x7c0
[    7.180345] Call Trace:
[    7.182576]  mutex_lock+0xc9/0xd0
[    7.183257]  adf_iov_putmsg+0x118/0x1a0 [intel_qat]
[    7.183541]  adf_vf2pf_shutdown+0x4d/0x7b [intel_qat]
[    7.183834]  adf_dev_shutdown+0x172/0x2b0 [intel_qat]
[    7.184127]  adf_probe+0x5e9/0x600 [qat_dh895xccvf]

Signed-off-by: Tong Zhang <ztong0001@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Fixes: 25c6ffb249f6 ("crypto: qat - check if PF is running")
Acked-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 drivers/crypto/qat/qat_c3xxxvf/adf_drv.c    | 4 ++--
 drivers/crypto/qat/qat_c62xvf/adf_drv.c     | 4 ++--
 drivers/crypto/qat/qat_dh895xccvf/adf_drv.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/qat/qat_c3xxxvf/adf_drv.c b/drivers/crypto/qat/qat_c3xxxvf/adf_drv.c
index 1d1532e8fb6d..067ca5e17d38 100644
--- a/drivers/crypto/qat/qat_c3xxxvf/adf_drv.c
+++ b/drivers/crypto/qat/qat_c3xxxvf/adf_drv.c
@@ -184,12 +184,12 @@ static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (ret)
 		goto out_err_free_reg;
 
-	set_bit(ADF_STATUS_PF_RUNNING, &accel_dev->status);
-
 	ret = adf_dev_init(accel_dev);
 	if (ret)
 		goto out_err_dev_shutdown;
 
+	set_bit(ADF_STATUS_PF_RUNNING, &accel_dev->status);
+
 	ret = adf_dev_start(accel_dev);
 	if (ret)
 		goto out_err_dev_stop;
diff --git a/drivers/crypto/qat/qat_c62xvf/adf_drv.c b/drivers/crypto/qat/qat_c62xvf/adf_drv.c
index 04742a6d91ca..51ea88c0b17d 100644
--- a/drivers/crypto/qat/qat_c62xvf/adf_drv.c
+++ b/drivers/crypto/qat/qat_c62xvf/adf_drv.c
@@ -184,12 +184,12 @@ static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (ret)
 		goto out_err_free_reg;
 
-	set_bit(ADF_STATUS_PF_RUNNING, &accel_dev->status);
-
 	ret = adf_dev_init(accel_dev);
 	if (ret)
 		goto out_err_dev_shutdown;
 
+	set_bit(ADF_STATUS_PF_RUNNING, &accel_dev->status);
+
 	ret = adf_dev_start(accel_dev);
 	if (ret)
 		goto out_err_dev_stop;
diff --git a/drivers/crypto/qat/qat_dh895xccvf/adf_drv.c b/drivers/crypto/qat/qat_dh895xccvf/adf_drv.c
index c972554a755e..29999da716cc 100644
--- a/drivers/crypto/qat/qat_dh895xccvf/adf_drv.c
+++ b/drivers/crypto/qat/qat_dh895xccvf/adf_drv.c
@@ -184,12 +184,12 @@ static int adf_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (ret)
 		goto out_err_free_reg;
 
-	set_bit(ADF_STATUS_PF_RUNNING, &accel_dev->status);
-
 	ret = adf_dev_init(accel_dev);
 	if (ret)
 		goto out_err_dev_shutdown;
 
+	set_bit(ADF_STATUS_PF_RUNNING, &accel_dev->status);
+
 	ret = adf_dev_start(accel_dev);
 	if (ret)
 		goto out_err_dev_stop;
-- 
2.25.1

