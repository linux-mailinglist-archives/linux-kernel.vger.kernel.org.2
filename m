Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D269351215
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234301AbhDAJXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233901AbhDAJWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:22:19 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54BAC0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 02:22:18 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id u9so1837935ejj.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 02:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T/0KpG9qJzUFrcObdFWrqj3M4DpTo/B6MAsgxOwfgZw=;
        b=Mywg/Aw5tfjCqpn+8AAvs2eJ9ogyLGXlI7ivF47TcKwvkSg2Frtlnsh+2xzCEToCKV
         vZOdtCojJ4O6LBSw8MxuxacuayiG48O7Tx+lqSPyJVCWSbTL7xCS6dpmC3dKoGMrqf71
         5RgxtSdo6xncSg1Qa9MeNzqMcPKOBWF02xKslXnjZkfJG0ZyDl13VgrpE8E9jb6CbtYJ
         a6Kr8vq7bHnnHeGMPJl5yPm8Xu43WBa7/ajtvSqDxc5A4ydKWGtqdeFa69RG6A4YNHyt
         WbNFbTMz31ZnaKKJsD56UnUdbK+OOABkOHJMxgKhK/BxsOmkkFe8FW4kXvRch2IX4yb+
         51CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T/0KpG9qJzUFrcObdFWrqj3M4DpTo/B6MAsgxOwfgZw=;
        b=pyAv3o4WbmmYImUIWly3bUZtagx2sTNF6AP4l7UgGODVEvS6jebqjI0Gxg0uXkJ6Mj
         MKqZ/2MmjBDBhrhrF+YBnmKg+BdLakvsO0GF1F7gfv286G7oGLQltvFSoaOARSvFL/yO
         CU7ziGrcQ7YjQwYq3iLITG1N/7l1obU6HDUvjNq0BTALYhfMKp0hOG/kY/+2lgMbQOqf
         HSPSkfPPI1GzrxtoepzJk7j6v1J6RPWELObaGsQ9GZcv2Jvsp84H0kslUFb9oh0+4pT0
         AZWFXTvXtOJgmzoEEfnKjZ/ICWZNhtKTEc5nbPIdeBdgNLWo3bcfb1Qxl50gjW0XTwse
         VJ+g==
X-Gm-Message-State: AOAM532kPldV3aqF0fK3QndngBmq7bL1rPp4HR84JPLO02449R/b82Jm
        zfYpCwJxcCZcamPNTvswX70=
X-Google-Smtp-Source: ABdhPJyev3in+h/Z/oALvSw362KMO1ejUOBui9lugELGuzO8TUIrEIVOqFh7po3uhFFhn/qZQXk6GA==
X-Received: by 2002:a17:907:2062:: with SMTP id qp2mr8063522ejb.397.1617268937616;
        Thu, 01 Apr 2021 02:22:17 -0700 (PDT)
Received: from agape ([5.171.80.247])
        by smtp.gmail.com with ESMTPSA id u14sm2462629ejx.60.2021.04.01.02.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 02:22:17 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, dan.carpenter@oracle.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 33/49] staging: rtl8723bs: remove empty else-blocks in hal/rtl8723b_phycfg.c
Date:   Thu,  1 Apr 2021 11:21:03 +0200
Message-Id: <fd56a8d2c033988a9713113c8e7077c751da82ef.1617268327.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617268327.git.fabioaiuto83@gmail.com>
References: <cover.1617268327.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove empty else-blocks

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
index 2b9254000526..89d3c2fc0926 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
@@ -550,7 +550,6 @@ void PHY_SetTxPowerIndex(
 			DBG_871X("Invalid Rate!!\n");
 			break;
 		}
-	} else {
 	}
 }
 
@@ -649,8 +648,7 @@ static u8 phy_GetSecondaryChnl_8723B(struct adapter *Adapter)
 			SCSettingOf40 = VHT_DATA_SC_40_LOWER_OF_80MHZ;
 		else if (pHalData->nCur80MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_UPPER)
 			SCSettingOf40 = VHT_DATA_SC_40_UPPER_OF_80MHZ;
-		else
-			;
+
 		if (
 			(pHalData->nCur40MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_LOWER) &&
 			(pHalData->nCur80MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_LOWER)
@@ -671,15 +669,12 @@ static u8 phy_GetSecondaryChnl_8723B(struct adapter *Adapter)
 			(pHalData->nCur80MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_UPPER)
 		)
 			SCSettingOf20 = VHT_DATA_SC_20_UPPERST_OF_80MHZ;
-		else
-			;
+
 	} else if (pHalData->CurrentChannelBW == CHANNEL_WIDTH_40) {
 		if (pHalData->nCur40MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_UPPER)
 			SCSettingOf20 = VHT_DATA_SC_20_UPPER_OF_80MHZ;
 		else if (pHalData->nCur40MhzPrimeSC == HAL_PRIME_CHNL_OFFSET_LOWER)
 			SCSettingOf20 = VHT_DATA_SC_20_LOWER_OF_80MHZ;
-		else
-			;
 	}
 
 	return  (SCSettingOf40 << 4) | SCSettingOf20;
-- 
2.20.1

