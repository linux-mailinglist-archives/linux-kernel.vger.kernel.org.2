Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95FF234FD3E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234998AbhCaJlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234852AbhCaJkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:40:53 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CA4C061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:40:53 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ap14so15937849ejc.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+qjP3rPq6GRvudxmPUC4N1/IMA281UmIav1b4KbVRkI=;
        b=bUm98LScnGWacVl0SAvhYVeOMyhRNv/Zq/KDJnqAhoNDZd0JLdxMu0dUIBsDA//O3v
         939BArGYZM+PJa03351QuA2AtmV5Be0bIOT1JzKKdgzqmrABrI1zoy4sjPehBzAyFMj8
         kjkBlyRBsEAFtkSlVot/CQIY4b0qQ0THCWcya3Cy7X0MDPmt0RprTowUmN9EdckWxep3
         V8dg4/5vWYJVVZczpMp3l/53FsxzrVRFbKaI8B8dH1iZhxipPYl6xDP4ze3795Gg2dQG
         /LiD6T+vrxEXTmmV2BTjXIJtGshkVdEnVmDfj3neNUhxzpaPmw6mzrIYiQyC2O4HewcM
         AIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+qjP3rPq6GRvudxmPUC4N1/IMA281UmIav1b4KbVRkI=;
        b=lsE4Yp/G5dcYyKMRHcTlY6xH85nYR8MKmbT/pvisFCszhxEs+E/6kHTZVsKPoHiKRw
         zn1OCTP+f2CJ4g2PsB316TlrGFw3Et0mQmwhBE/+3EdPmefzu3Lum3GP/j6/quF6fuEq
         90/ecc1I5XyIIrhLqtPq+mPwwMxt6zlsJ0NeiqP2RiVrJdLqFC7qaShzdwF2sbqKI3eU
         ii3h286xwerTm2Z69JEhpI+rJWqobvl2Lo6FJyAcuwa7ob5f7rrifq3C1QXmZkL4tkhs
         SzxKwfKGgiV9S3DMtduwuel7qoqK1YtidCwG/KtMXjc6h0gfISaSNCxPMOn8XJ4sW3Oo
         J35w==
X-Gm-Message-State: AOAM533IJBTL7+2oW6Se/0JnKfo3GBy+RevZmoD71R8iXF+E/N6ll+LM
        WdagRFghNPX5pu6vfx179A8=
X-Google-Smtp-Source: ABdhPJziRlAxm0ldTsyuh1V3luwNdWHu3hej7np0LbqVOVLp1S14bX73PYDM00k8gJTVKz1km6U5hw==
X-Received: by 2002:a17:906:3ac3:: with SMTP id z3mr2651828ejd.106.1617183652335;
        Wed, 31 Mar 2021 02:40:52 -0700 (PDT)
Received: from agape ([5.171.73.44])
        by smtp.gmail.com with ESMTPSA id t15sm1115832edw.84.2021.03.31.02.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 02:40:52 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 21/40] staging: rtl8723bs: replace RT_TRACE with public printk wrappers in hal/sdio_ops.c
Date:   Wed, 31 Mar 2021 11:39:49 +0200
Message-Id: <c6d2784da5b281d71600b1d1b9f5bf369b2cdb67.1617183374.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617183374.git.fabioaiuto83@gmail.com>
References: <cover.1617183374.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

replace private macro RT_TRACE for tracing with in-kernel
pr_* printk wrappers

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/sdio_ops.c | 42 ++++++++----------------
 1 file changed, 13 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c b/drivers/staging/rtl8723bs/hal/sdio_ops.c
index a24a39e70454..34531d6a6810 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_ops.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_ops.c
@@ -777,29 +777,15 @@ void EnableInterrupt8723BSdio(struct adapter *adapter)
 	himr = cpu_to_le32(haldata->sdio_himr);
 	sdio_local_write(adapter, SDIO_REG_HIMR, 4, (u8 *)&himr);
 
-	RT_TRACE(
-		_module_hci_ops_c_,
-		_drv_notice_,
-		(
-			"%s: enable SDIO HIMR = 0x%08X\n",
-			__func__,
-			haldata->sdio_himr
-		)
-	);
+	pr_notice("%s %s: enable SDIO HIMR = 0x%08X\n",
+		  DRIVER_PREFIX, __func__, haldata->sdio_himr);
 
 	/*  Update current system IMR settings */
 	tmp = rtw_read32(adapter, REG_HSIMR);
 	rtw_write32(adapter, REG_HSIMR, tmp | haldata->SysIntrMask);
 
-	RT_TRACE(
-		_module_hci_ops_c_,
-		_drv_notice_,
-		(
-			"%s: enable HSIMR = 0x%08X\n",
-			__func__,
-			haldata->SysIntrMask
-		)
-	);
+	pr_notice("%s %s: enable HSIMR = 0x%08X\n",
+		  DRIVER_PREFIX, __func__, haldata->SysIntrMask);
 
 	/*  */
 	/*  <Roger_Notes> There are some C2H CMDs have been sent before system interrupt is enabled, e.g., C2H, CPWM. */
@@ -894,7 +880,7 @@ static struct recv_buf *sd_recv_rxfifo(struct adapter *adapter, u32 size)
 	readbuf = recvbuf->pskb->data;
 	ret = sdio_read_port(&adapter->iopriv.intf, WLAN_RX0FF_DEVICE_ID, readsize, readbuf);
 	if (ret == _FAIL) {
-		RT_TRACE(_module_hci_ops_os_c_, _drv_err_, ("%s: read port FAIL!\n", __func__));
+		pr_err("%s %s: read port FAIL!\n", DRIVER_PREFIX, __func__);
 		return NULL;
 	}
 
@@ -1062,9 +1048,8 @@ void sd_int_hdl(struct adapter *adapter)
 
 		sd_int_dpc(adapter);
 	} else {
-		RT_TRACE(_module_hci_ops_c_, _drv_err_,
-				("%s: HISR(0x%08x) and HIMR(0x%08x) not match!\n",
-				__func__, hal->sdio_hisr, hal->sdio_himr));
+		pr_err("%s %s: HISR(0x%08x) and HIMR(0x%08x) not match!\n",
+		       DRIVER_PREFIX, __func__, hal->sdio_hisr, hal->sdio_himr);
 	}
 }
 
@@ -1088,13 +1073,12 @@ u8 HalQueryTxBufferStatus8723BSdio(struct adapter *adapter)
 	numof_free_page = SdioLocalCmd53Read4Byte(adapter, SDIO_REG_FREE_TXPG);
 
 	memcpy(hal->SdioTxFIFOFreePage, &numof_free_page, 4);
-	RT_TRACE(_module_hci_ops_c_, _drv_notice_,
-			("%s: Free page for HIQ(%#x), MIDQ(%#x), LOWQ(%#x), PUBQ(%#x)\n",
-			__func__,
-			hal->SdioTxFIFOFreePage[HI_QUEUE_IDX],
-			hal->SdioTxFIFOFreePage[MID_QUEUE_IDX],
-			hal->SdioTxFIFOFreePage[LOW_QUEUE_IDX],
-			hal->SdioTxFIFOFreePage[PUBLIC_QUEUE_IDX]));
+	pr_notice("%s %s: Free page for HIQ(%#x), MIDQ(%#x), LOWQ(%#x), PUBQ(%#x)\n",
+		  DRIVER_PREFIX, __func__,
+		  hal->SdioTxFIFOFreePage[HI_QUEUE_IDX],
+		  hal->SdioTxFIFOFreePage[MID_QUEUE_IDX],
+		  hal->SdioTxFIFOFreePage[LOW_QUEUE_IDX],
+		  hal->SdioTxFIFOFreePage[PUBLIC_QUEUE_IDX]);
 
 	return true;
 }
-- 
2.20.1

