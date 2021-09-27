Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F331419114
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 10:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbhI0IsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 04:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233443AbhI0Ir6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 04:47:58 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C897C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 01:46:20 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id e15so74134702lfr.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 01:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U0zut/STrbzFzEaYGrjx8N7OZIB3TgBNbxo/HurOdUQ=;
        b=VBqpJXNDaL4icGpXRQtO2EpchiZGOb5gwRgp6IuJymn7c5Lx3j0LZ4s9DVi8oAe6bw
         QDQzplH1FcaAZ3hvbKOfOxr3EXJ8fKgEKlLcwWo5cQWbezaXBMdMcxOnKhK/HxATUNrp
         t+N6o00WIUC6InRAFXAh1Ixc5tFW7SjZMzLkL3ThmqWzz+5bpSVWAM50FHKDcxD4RGzn
         rw60tIZ9LCzTIpbeGxMkwHuK+U/hFNIGv1aTZ7QxJh7IK2XmnHWoswxmt+vKjS+KHCuk
         7YCoZvkPJiwUaE+PgqBtEklKHuulNlsnyBwVMotvn4DQr7V8ScloLMWzvXFztV8/OqGP
         zGcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U0zut/STrbzFzEaYGrjx8N7OZIB3TgBNbxo/HurOdUQ=;
        b=O4B+LQPuxsMArzh4TjFXALZz0cqI9xsofvOXTgX9C1MhqMdNSeZpQGRPrFjGUKd85F
         sv75t4EEBdNl5eKgPLa4RlNtBJp1slcy4KaG9w4KAT3p041UXlrn2Bs2AZwiH+2L2Sh8
         r6yX1gghfF+wQesDJGqPxAUPr1WTCns6qnutLI6Own7D+QeNK+Ee8BC1KAaHrlCcgivY
         TDkWAsXtfDlIax/EOJHsX/nQnW8UW3AbSsEtEzYfLBefRi86MrQBRVp7tCbWjVW0nKxd
         x78EC1TUNC9ySKUJ5mHpYpAX5oiBFbadYO5omYhbeUbj+36WZaAOaQn2zVkBEZxAX6wK
         ZXQA==
X-Gm-Message-State: AOAM531RJIFejSqTlsdH4BupEPNKcKYFE0I3PuAyT/a+s3JhAzGVxRfr
        Ax0NnSd/nQ5pe4/SBJUD34JaMQ==
X-Google-Smtp-Source: ABdhPJyy4wq8y7JCvg1Nd9f2qhYuJ03dtZEMmiEuqunDVQyRQ2qJLc3EBEZlNTGNt7M0wqKYpIl0Zg==
X-Received: by 2002:a2e:145c:: with SMTP id 28mr19708234lju.295.1632732378811;
        Mon, 27 Sep 2021 01:46:18 -0700 (PDT)
Received: from localhost (c-9b28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.155])
        by smtp.gmail.com with ESMTPSA id c3sm128196ljf.113.2021.09.27.01.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 01:46:18 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com, jdelvare@suse.com,
        linux@roeck-us.net
Cc:     avri.altman@wdc.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCHv2] scsi: ufs: Kconfig: SCSI_UFS_HWMON depens on HWMON=y
Date:   Mon, 27 Sep 2021 10:46:15 +0200
Message-Id: <20210927084615.1938432-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <DM6PR04MB6575F2F6841B0573560E10ADFCA49@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <DM6PR04MB6575F2F6841B0573560E10ADFCA49@DM6PR04MB6575.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building an allmodconfig kernel, the following build error shows
up:

aarch64-linux-gnu-ld: drivers/scsi/ufs/ufs-hwmon.o: in function `ufs_hwmon_probe':
/kernel/next/drivers/scsi/ufs/ufs-hwmon.c:177: undefined reference to `hwmon_device_register_with_info'
/kernel/next/drivers/scsi/ufs/ufs-hwmon.c:177:(.text+0x510): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `hwmon_device_register_with_info'
aarch64-linux-gnu-ld: drivers/scsi/ufs/ufs-hwmon.o: in function `ufs_hwmon_remove':
/kernel/next/drivers/scsi/ufs/ufs-hwmon.c:195: undefined reference to `hwmon_device_unregister'
/kernel/next/drivers/scsi/ufs/ufs-hwmon.c:195:(.text+0x5c8): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `hwmon_device_unregister'
aarch64-linux-gnu-ld: drivers/scsi/ufs/ufs-hwmon.o: in function `ufs_hwmon_notify_event':
/kernel/next/drivers/scsi/ufs/ufs-hwmon.c:206: undefined reference to `hwmon_notify_event'
/kernel/next/drivers/scsi/ufs/ufs-hwmon.c:206:(.text+0x64c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `hwmon_notify_event'
aarch64-linux-gnu-ld: /home/anders/src/kernel/next/drivers/scsi/ufs/ufs-hwmon.c:209: undefined reference to `hwmon_notify_event'
/kernel/next/drivers/scsi/ufs/ufs-hwmon.c:209:(.text+0x66c): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `hwmon_notify_event'

Since fragment 'SCSI_UFS_HWMON' can't be build as a module,
'SCSI_UFS_HWMON' has to depend on 'HWMON=y'.

Fixes: e88e2d32200a ("scsi: ufs: core: Probe for temperature notification support")
Also-Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
Acked-by: Avri Altman <avri.altman@wdc.com>
---
 drivers/scsi/ufs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/Kconfig b/drivers/scsi/ufs/Kconfig
index 565e8aa6319d..2ca69f87e4de 100644
--- a/drivers/scsi/ufs/Kconfig
+++ b/drivers/scsi/ufs/Kconfig
@@ -202,7 +202,7 @@ config SCSI_UFS_FAULT_INJECTION
 
 config SCSI_UFS_HWMON
 	bool "UFS  Temperature Notification"
-	depends on SCSI_UFSHCD && HWMON
+	depends on SCSI_UFSHCD=HWMON || HWMON=y
 	help
 	  This provides support for UFS hardware monitoring. If enabled,
 	  a hardware monitoring device will be created for the UFS device.
-- 
2.33.0

