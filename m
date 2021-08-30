Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B853D3FBCF1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 21:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbhH3TfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 15:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbhH3TfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 15:35:19 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDACC061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 12:34:23 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id z24-20020a17090acb1800b0018e87a24300so734057pjt.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 12:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=itfac-mrt-ac-lk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=38LoY1bNsBhMvANynurPzXetzfwZlkeGRm86uRmPJ4c=;
        b=t4MEIE9WX9a6k97UOj+ET1mjDCCJeWsbCGY8KiXnRCsC6kQqjeatz45N2Jo/WsM0Bt
         MC9WQxrrRjy2B+LzsguXI/QzPWFZ1ugO3SIPCAb0teasHtX6PPKvx1C4K9VsqlFKiUVs
         WSbA/Tr6i214yconXi+Ksmf6oH0sjjprU/wHEbOGbZCo2wNPKVR1R62IwB/AC4KR18Ig
         uXmdfDd29FQ+W3bWFRatsyp8XoTkPzVmfJKnFQctgdRe3GMhPeufPMV9MwMSXRegjlnj
         aZx8zqOdt3vESfFZoucLf9ySN2u42zkbx4kdjP1unFhWXkPG4VJRrXkZwxR1x2lRL7Yc
         os7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=38LoY1bNsBhMvANynurPzXetzfwZlkeGRm86uRmPJ4c=;
        b=tCWMa4D00+TgvSeLSwXnDrDP+mTa7fYdpyaw1zl+tVORsbG5NZvm8GsrirM14Ios9O
         Ojrjbes5Ky8Zg7kuAO2rMQew4ttnqCff+adzymW7qlhqDhyS+DXcUAGyJqvD3CF5eVNd
         kO8DYvAIWx8izo1ek2Fe1dM3yNx7irvB5kk21ak4WdUnXKRFhaByYcdVA3IfDT/c6+z7
         2Fdj6KuUADTl3xVKtksPCdE5Z1gwPvDHc/lMnC50ZXxjX6ld0he74zthEUt06CWRyWHH
         Ip9ybPy/keq2DVDKLNOnpJPfIqNl2IDwYSH3pxey//omAjFDoydQr9JtqYdyErLMnFeJ
         RHvA==
X-Gm-Message-State: AOAM530RPOiMMA1x0cwenuifSdbQD461jQ/901gv/PeXUAmxLoPl/CJq
        Q9C5lKxoYiDS87cI3TRFhq3Rhaod0GH4
X-Google-Smtp-Source: ABdhPJzkCDJYUXlLvj44fuDgqsck3vig3BGr9sMKa38tgv/2Q4vr+TIPgf0EuOIIbQQ91iAhh+fE0g==
X-Received: by 2002:a17:902:b193:b029:11a:a179:453a with SMTP id s19-20020a170902b193b029011aa179453amr1085200plr.69.1630352063227;
        Mon, 30 Aug 2021 12:34:23 -0700 (PDT)
Received: from localhost.localdomain ([123.231.122.209])
        by smtp.gmail.com with ESMTPSA id g3sm18016990pgj.66.2021.08.30.12.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 12:34:22 -0700 (PDT)
From:   "F.A.Sulaiman" <asha.16@itfac.mrt.ac.lk>
To:     gregkh@linuxfoundation.org
Cc:     "F.A.Sulaiman" <asha.16@itfac.mrt.ac.lk>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: fix memory leak error
Date:   Tue, 31 Aug 2021 01:03:55 +0530
Message-Id: <20210830193355.11338-1-asha.16@itfac.mrt.ac.lk>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch reported memory leak bug in rtl8723b_FirmwareDownload function. 
The problem is pFirmware memory is not released in release_fw1. 
Instead of redirecting to release_fw1 we can turn it into exit 
and free the memory.

Signed-off-by: F.A. SULAIMAN <asha.16@itfac.mrt.ac.lk>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index de8caa6cd418..b59c2aa3a9d8 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -436,7 +436,7 @@ s32 rtl8723b_FirmwareDownload(struct adapter *padapter, bool  bUsedWoWLANFw)
 	if (pFirmware->fw_length > FW_8723B_SIZE) {
 		rtStatus = _FAIL;
 		DBG_871X_LEVEL(_drv_emerg_, "Firmware size:%u exceed %u\n", pFirmware->fw_length, FW_8723B_SIZE);
-		goto release_fw1;
+		goto exit;
 	}
 
 	pFirmwareBuf = pFirmware->fw_buffer_sz;
@@ -512,7 +512,6 @@ s32 rtl8723b_FirmwareDownload(struct adapter *padapter, bool  bUsedWoWLANFw)
 exit:
 	kfree(pFirmware->fw_buffer_sz);
 	kfree(pFirmware);
-release_fw1:
 	kfree(pBTFirmware);
 	DBG_871X(" <=== rtl8723b_FirmwareDownload()\n");
 	return rtStatus;
-- 
2.17.1

