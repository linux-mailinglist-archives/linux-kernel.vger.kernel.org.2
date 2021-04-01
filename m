Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2CB335120E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234056AbhDAJXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbhDAJWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:22:17 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285EDC061797
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 02:22:14 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id r12so1849497ejr.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 02:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I/KAqN7OiukR9pBEx+MKuFI87FFsRG2Q+q0C2pJM29M=;
        b=loAVXciDRZdkPztNwIQ+ey82oQ8OSHqjHdoqboHEC2X0pV8y6yiZOJsQEImqX8w9Y8
         VnjHQONh/ZVw58U+Cg3zHoGXDGG6uu1QeQ2HXcIaYRKtz5Wtqgp6Y8O+WIZgxbqXTahy
         52J0iUCGMfUxx0S/rMxjXt0eLGQ8KXAsDE8sKIV9yLyYFu3cdapvr8Ig+1OuNmhV+gaP
         uc0NfWH5+T2rm7vjQ4cqTqbz60tkoDbD+Y5wM2Tv9KWyMC9T1j2PNirGaaFX5fOx+Rln
         76zdeszStIO3TFzCXYRPi6FiZ7RLJj55ddDdfTHhyG5lEuj6uJvyGPfIZ0P2iv2MsHkW
         OJaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I/KAqN7OiukR9pBEx+MKuFI87FFsRG2Q+q0C2pJM29M=;
        b=J9M0sSKj8z4ZN2KM4ACQ4yzWI3o3+KaZZXeCDoucO6A/tyHsN+QlXdudBobupQFGQM
         LoYGtyTYr1oJSBa0hdYQDjQetPt0fO9Kj+Iy2Ev1R0/HHb0jZHbAwXHTmcT+tB3WXKv2
         yl4XJHwRx8DRs68nzoOte9ub3aYw91ddhONydlvR0NAuWmcA4B9xghUIN/30Iwc2h2Ny
         X+bho116w4W7xKVtTraf7e+HAxY1KTCsAleb5KNP/WPwfieIJVRFztRM7sjsTPzYIddE
         rqbdZxErXingZ8sTRyCSv/7Hx52dtYbspcTQCwYcfuiEYwRjH246ILg/ujhaV1sCn9yv
         I4Gg==
X-Gm-Message-State: AOAM532HewZ8QaOLmXLez9FG2fvJsIG3RBQnutvUqC5t97+uT1kBkTQ/
        UFbNmZqCQgf9xsjLTEtidC0=
X-Google-Smtp-Source: ABdhPJzsf8yfWIT88QUZaZCb9RdM8YCBPVq1FcTLqxxaFzTrGsj7nW9aBdWRanfU9kw2ocsRfQXvaA==
X-Received: by 2002:a17:906:ecaa:: with SMTP id qh10mr8106448ejb.425.1617268932981;
        Thu, 01 Apr 2021 02:22:12 -0700 (PDT)
Received: from agape ([5.171.80.247])
        by smtp.gmail.com with ESMTPSA id i11sm2480604ejc.101.2021.04.01.02.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 02:22:12 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, dan.carpenter@oracle.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 30/49] staging: rtl8723bs: remove RT_TRACE logs in hal/sdio_ops.c
Date:   Thu,  1 Apr 2021 11:21:00 +0200
Message-Id: <b5a21d803030584597a264c8554b64297eec3542.1617268327.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617268327.git.fabioaiuto83@gmail.com>
References: <cover.1617268327.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove all RT_TRACE logs

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/sdio_ops.c | 31 ------------------------
 1 file changed, 31 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c b/drivers/staging/rtl8723bs/hal/sdio_ops.c
index a24a39e70454..4777793e752d 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_ops.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_ops.c
@@ -777,30 +777,10 @@ void EnableInterrupt8723BSdio(struct adapter *adapter)
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
-
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
-
 	/*  */
 	/*  <Roger_Notes> There are some C2H CMDs have been sent before system interrupt is enabled, e.g., C2H, CPWM. */
 	/*  So we need to clear all C2H events that FW has notified, otherwise FW won't schedule any commands anymore. */
@@ -894,7 +874,6 @@ static struct recv_buf *sd_recv_rxfifo(struct adapter *adapter, u32 size)
 	readbuf = recvbuf->pskb->data;
 	ret = sdio_read_port(&adapter->iopriv.intf, WLAN_RX0FF_DEVICE_ID, readsize, readbuf);
 	if (ret == _FAIL) {
-		RT_TRACE(_module_hci_ops_os_c_, _drv_err_, ("%s: read port FAIL!\n", __func__));
 		return NULL;
 	}
 
@@ -1062,9 +1041,6 @@ void sd_int_hdl(struct adapter *adapter)
 
 		sd_int_dpc(adapter);
 	} else {
-		RT_TRACE(_module_hci_ops_c_, _drv_err_,
-				("%s: HISR(0x%08x) and HIMR(0x%08x) not match!\n",
-				__func__, hal->sdio_hisr, hal->sdio_himr));
 	}
 }
 
@@ -1088,13 +1064,6 @@ u8 HalQueryTxBufferStatus8723BSdio(struct adapter *adapter)
 	numof_free_page = SdioLocalCmd53Read4Byte(adapter, SDIO_REG_FREE_TXPG);
 
 	memcpy(hal->SdioTxFIFOFreePage, &numof_free_page, 4);
-	RT_TRACE(_module_hci_ops_c_, _drv_notice_,
-			("%s: Free page for HIQ(%#x), MIDQ(%#x), LOWQ(%#x), PUBQ(%#x)\n",
-			__func__,
-			hal->SdioTxFIFOFreePage[HI_QUEUE_IDX],
-			hal->SdioTxFIFOFreePage[MID_QUEUE_IDX],
-			hal->SdioTxFIFOFreePage[LOW_QUEUE_IDX],
-			hal->SdioTxFIFOFreePage[PUBLIC_QUEUE_IDX]));
 
 	return true;
 }
-- 
2.20.1

