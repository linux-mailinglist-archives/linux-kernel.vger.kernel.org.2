Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 448E835F8F4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 18:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352713AbhDNQ0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 12:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233964AbhDNQ0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 12:26:45 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C312C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 09:26:20 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id u17so32359008ejk.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 09:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7OJ5/q27rVQyMJMOKx5XsjrMcpogAT1Y8irqV1uKSxE=;
        b=nZJiQUOjb34oGOxyGs8MPrzzBpINEaVqRnwnQlby3J29ZlZ2LSD+RySg/Em1usx/sp
         VBK0JbsrcRrXtuDOhdLMWmFY6LgzU0M6QaaU8WoaImzFI4CKqOFK1JrAP0WCyW/2hupo
         Y1jCnX4zRNDAlYQ91iTrV2Z0rolLlrV5hTsarOY7velbj2TE31ngP89BS2CFogI0lFmX
         wtCS3p6NgPyLU267rbHlsAVf7mS34XhhHUx8qk1qor69S/3fx1hg6lCg7eLUw65IDKHA
         o1ag3yhq5Q51sdXKtj0m+Nks9Gkv7RoGHXT8QgPR2/P/L+CZDl0T+A1sp1vNR8wsHr9m
         zx2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7OJ5/q27rVQyMJMOKx5XsjrMcpogAT1Y8irqV1uKSxE=;
        b=cUli5h6kHj6EkZSOZV5AvS/XOC6DCfoDCbwPzb+5KmjrfaetiC/s63FvQkJfCPUstR
         wp9FoVMhR6qXIW6/bCqshhSPiM0p5mMBLdDSAFs/zO4hlD+HbrOSmaxU/Oy+MSfcuhw3
         CjZ+mCI2cg+eRzt8pMgTyF0ppJyRI7J6c6uTMWc4dYP+cOt/ei8cfbcV6UMNAW4CXqTS
         925ZhY7j0boDH/tH5t6CtXRKIN6pfTo29KC40iqfZcz+ABCHfhPUESN3wnViW864P1t/
         reFLvOXe/y6auUNRPUQA5ePh5NIXlG7IZAk9sxXj9nBWEmaPBMKt7S53BBZIqzNH2zBA
         INLA==
X-Gm-Message-State: AOAM5332QQOWHjY03I7QnNsp/npOOrLXnFYw9fusBwCIgMVQdhvX+2TK
        vreH3UOD+Rd0s48pCyJH40o=
X-Google-Smtp-Source: ABdhPJwYhgLyWRyMP6WBDuERSnqYTcUVjV949pj88yA1MgehFGue4mztsNvAkffFSHyBSdPJd/UZ6g==
X-Received: by 2002:a17:906:a385:: with SMTP id k5mr6548344ejz.148.1618417579300;
        Wed, 14 Apr 2021 09:26:19 -0700 (PDT)
Received: from linux.local (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id s17sm20803ejx.10.2021.04.14.09.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 09:26:18 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [Outreachy kernel] [PATCH v2] staging: rtl8723bs: Remove useless led_blink_hdl()
Date:   Wed, 14 Apr 2021 18:26:14 +0200
Message-Id: <20210414162614.14867-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed useless led_blink_hdl() prototype and definition. In wlancmds[]
the slot #60 is now set to NULL using the macro GEN_MLME_EXT_HANDLER. This
change has not unwanted side effects because the code in rtw_cmd.c checks
if the function pointer is valid before using it.

Reported-by: Julia Lawall <julia.lawall@inria.fr>
Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

Changes since v1: Corrected a bad solution to this issue that made use of
an unnecessary dummy function.

 drivers/staging/rtl8723bs/core/rtw_cmd.c         | 2 +-
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c    | 9 ---------
 drivers/staging/rtl8723bs/include/rtw_mlme_ext.h | 1 -
 3 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index 0297fbad7bce..f82dbd4f4c3d 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -150,7 +150,7 @@ static struct cmd_hdl wlancmds[] = {
 
 	GEN_MLME_EXT_HANDLER(0, h2c_msg_hdl) /*58*/
 	GEN_MLME_EXT_HANDLER(sizeof(struct SetChannelPlan_param), set_chplan_hdl) /*59*/
-	GEN_MLME_EXT_HANDLER(sizeof(struct LedBlink_param), led_blink_hdl) /*60*/
+	GEN_MLME_EXT_HANDLER(0, NULL) /*60*/
 
 	GEN_MLME_EXT_HANDLER(sizeof(struct SetChannelSwitch_param), set_csa_hdl) /*61*/
 	GEN_MLME_EXT_HANDLER(sizeof(struct TDLSoption_param), tdls_hdl) /*62*/
diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 873d3792ac8e..963ea80083c8 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -6189,15 +6189,6 @@ u8 set_chplan_hdl(struct adapter *padapter, unsigned char *pbuf)
 	return	H2C_SUCCESS;
 }
 
-u8 led_blink_hdl(struct adapter *padapter, unsigned char *pbuf)
-{
-
-	if (!pbuf)
-		return H2C_PARAMETERS_ERROR;
-
-	return	H2C_SUCCESS;
-}
-
 u8 set_csa_hdl(struct adapter *padapter, unsigned char *pbuf)
 {
 	return	H2C_REJECTED;
diff --git a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
index 5e6cf63956b8..472818c5fd83 100644
--- a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
+++ b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
@@ -745,7 +745,6 @@ u8 chk_bmc_sleepq_hdl(struct adapter *padapter, unsigned char *pbuf);
 u8 tx_beacon_hdl(struct adapter *padapter, unsigned char *pbuf);
 u8 set_ch_hdl(struct adapter *padapter, u8 *pbuf);
 u8 set_chplan_hdl(struct adapter *padapter, unsigned char *pbuf);
-u8 led_blink_hdl(struct adapter *padapter, unsigned char *pbuf);
 u8 set_csa_hdl(struct adapter *padapter, unsigned char *pbuf);	/* Kurt: Handling DFS channel switch announcement ie. */
 u8 tdls_hdl(struct adapter *padapter, unsigned char *pbuf);
 u8 run_in_thread_hdl(struct adapter *padapter, u8 *pbuf);
-- 
2.31.1

