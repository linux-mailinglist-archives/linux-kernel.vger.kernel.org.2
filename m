Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E24753FA6E8
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 19:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbhH1RJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 13:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234632AbhH1RJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 13:09:38 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9160DC061756
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 10:08:47 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id h13so15585942wrp.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 10:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/M9cHDkNGnyftZAmMuET/ghbO+Y/OsvzwGvOvRO+R8I=;
        b=L/FuFsIhSiI0pLHBLFAWAtNIxLstdFgoBCndCkPruuR1FrH6CKs/W8h74TvI9PW2Z8
         2BCq71+HpEKdo114l/iufj/1I2zWXTmq6iQlv8B69s/nKMpPlvIT7A5N0UPVrl/uzzRz
         1Hi3S+oaItK98BY3KDlBWDntmmOHGRfwXcf2gOwUawBoCVtt3iz6X3d//VydUVqTpf4d
         JdEbk3fIjLBuFnYloNsryrQgDkOjApRllO0zo3Dav7iF3om2LJn5cq/DbOtih0CtaDeS
         9Oz2SwQ13NAL7I5LkmfnhKGIXIs0RrTtdwLbNURMJkv43tJ+ZLU/PfvxWks9bEdlsZYy
         A0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/M9cHDkNGnyftZAmMuET/ghbO+Y/OsvzwGvOvRO+R8I=;
        b=HQzXhGP32jMqe9eTfJP7KyhOGeFbkPABPNQUNmgi8c3cNv1SVC8udtNUBgsM0D4RoA
         BCO7nD3ggAFPo8uZFf8UDE9SJBoNA9yW4AfL76Kk+itpxQK+jjDengwGCclFqVrS4Uwt
         DGRtPhvFoBgakoD1f4u0ymTnbuYOOrCEI2bZzrC6MNoqKUGINAcwtvi3i47amwf+3IeE
         z+HCQU1BHJoPyg44jkHgj8agd2LsM9m0c/Ofs2+XdOu00BcwB81PPAV97f5xx8uSao43
         5RFiiG6O6cL4XMDnjSN7Zw7L+vQJSajhzXe4hVj6qQrXtse8AVP9YpiAFUXPGa2YMAE0
         /U4g==
X-Gm-Message-State: AOAM531WVoKA2Y2QIozQrxBNOiSUZ5iOOo5ncnAaJs8eod0dO2Nm2aMF
        MGvxdBR4YPFRuplCwdM+shQ=
X-Google-Smtp-Source: ABdhPJyuVWF+RCSSeQbAjAlQLBuJVEgVxNqVXXW1Fcq5NtLdB3rBckep650iXwncHh2rjf/AVRRhdw==
X-Received: by 2002:adf:b785:: with SMTP id s5mr16246909wre.30.1630170526269;
        Sat, 28 Aug 2021 10:08:46 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::884b])
        by smtp.gmail.com with ESMTPSA id u10sm10046515wrt.14.2021.08.28.10.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 10:08:46 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/2] staging: r8188eu: remove rtl8188e_PHY_ConfigRFWithParaFile()
Date:   Sat, 28 Aug 2021 19:08:34 +0200
Message-Id: <20210828170834.31388-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210828170834.31388-1-straube.linux@gmail.com>
References: <20210828170834.31388-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtl8188e_PHY_ConfigRFWithParaFile() is unused, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c | 20 -------------------
 .../staging/r8188eu/include/Hal8188EPhyCfg.h  |  4 ----
 2 files changed, 24 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
index 30a9dca8f453..1c1906161da2 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_phycfg.c
@@ -609,26 +609,6 @@ int PHY_RFConfig8188E(struct adapter *Adapter)
 	return rtStatus;
 }
 
-/*-----------------------------------------------------------------------------
- * Function:    PHY_ConfigRFWithParaFile()
- *
- * Overview:    This function read RF parameters from general file format, and do RF 3-wire
- *
- * Input:	struct adapter *Adapter
- *			ps8					pFileName
- *			enum rf_radio_path eRFPath
- *
- * Output:      NONE
- *
- * Return:      RT_STATUS_SUCCESS: configuration file exist
- *
- * Note:		Delay may be required for RF configuration
- *---------------------------------------------------------------------------*/
-int rtl8188e_PHY_ConfigRFWithParaFile(struct adapter *Adapter, u8 *pFileName, enum rf_radio_path eRFPath)
-{
-	return _SUCCESS;
-}
-
 void
 rtl8192c_PHY_GetHWRegOriginalValue(
 		struct adapter *Adapter
diff --git a/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h b/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
index d15ff69b8485..ea83c2e17913 100644
--- a/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
+++ b/drivers/staging/r8188eu/include/Hal8188EPhyCfg.h
@@ -185,10 +185,6 @@ int PHY_MACConfig8188E(struct adapter *adapter);
 int PHY_BBConfig8188E(struct adapter *adapter);
 int PHY_RFConfig8188E(struct adapter *adapter);
 
-/* RF config */
-int rtl8188e_PHY_ConfigRFWithParaFile(struct adapter *adapter, u8 *filename,
-				      enum rf_radio_path rfpath);
-
 /* Read initi reg value for tx power setting. */
 void rtl8192c_PHY_GetHWRegOriginalValue(struct adapter *adapter);
 
-- 
2.32.0

