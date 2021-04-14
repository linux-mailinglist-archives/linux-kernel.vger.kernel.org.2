Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8319C35F2F2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 13:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346028AbhDNLxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 07:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233166AbhDNLxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 07:53:12 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE9BC061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 04:52:50 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id g17so22604751edm.6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 04:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zkC+0GDSZPiBQ3vyP0mJ4e2YXFys3MEY7UtDz1Ik6bE=;
        b=H0dJqpPsPHMwV2BZsAoOIyrhgemVsMa6N45me+IX15vhIthYP25vRTOuuIxa9xRVdR
         zBD+Q9Ixc/PhzFZyrMAk7rxdA4W8B6Xqnal2gf9870r1lIYmiEPD/e9USKwa5HiklLQN
         80jKdh6Uq/tmVZWHqUaijnGIOBdFqlwb/+foVxKwlZNveAocTx5MxfyXztHnnQR9BsoT
         9RVn/Xdz6ClT1+sIMy7q+Rg27jxdoZP4UIyua9BsK2rB/zjk3Ju8uo2GjVkvasE4UleT
         9xNyrmxtPj+54iv53E/l2OUBgSrO889WE95EtEZNoUaJoe9CA919LvUAnBhx1izlULOd
         c+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zkC+0GDSZPiBQ3vyP0mJ4e2YXFys3MEY7UtDz1Ik6bE=;
        b=PGJUHemW2x9uwkbBGEpmIWkBJWuj4F5PYy/TaCpV9+PnQz5qEOMLOviN2Td92P8V03
         BihAol8kC4zuUOizPK3VNkv790TF/QFLlzNZwc7So9lnB6Zow8Md0fJi77oZ9aju8OVK
         ocmkJBmVZ9MLlkONrLjHXsgnULwxcmp0uh6QlUbAGfPfnFKW45edJGS+vX/EIW4Y/ufk
         VBc7G3DaS5R0RiKGgLdH3/5LqQR2fHzoXwm7fp1hjOqPTIXY6cuVDuV4SFRUVbgt32+I
         /IPZAxxOcjafoDnPkXxveutDcpjmMQ/M36TgyI+VsFsCtLqnnXDafd38l+21igVkUW2q
         uMAA==
X-Gm-Message-State: AOAM532JCzB00wQ3JW76lbH7pDDepPEHOQggYAYJOuLpIRkTvS9HFPO/
        ZzoKlp+4r+nTSOVBMrywNdA=
X-Google-Smtp-Source: ABdhPJxSiee1B4qPCKU2WSG9UQsIOve1omYnUdHKQJb/Gh1dsovc5oIrwc2QbTnunUZ+oJSwz9wYHA==
X-Received: by 2002:aa7:d588:: with SMTP id r8mr1003516edq.318.1618401169206;
        Wed, 14 Apr 2021 04:52:49 -0700 (PDT)
Received: from linux.local (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id ju23sm9780679ejc.17.2021.04.14.04.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 04:52:48 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [Outreachy kernel] [PATCH] staging: rtl8723bs: Remove useless led_blink_hdl()
Date:   Wed, 14 Apr 2021 13:52:43 +0200
Message-Id: <20210414115243.32716-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed the led_blink_hdl() function (declaration and definition).
Declared dummy_function() in include/rtw_mlme_ext.h and defined it in
core/rtw_cmd.c. Changed the second parameter of GEN_MLME_EXT_HANDLER
macro to make use of dummy_function().

Reported-by: Julia Lawall <julia.lawall@inria.fr>
Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_cmd.c         | 4 +++-
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c    | 9 ---------
 drivers/staging/rtl8723bs/include/rtw_mlme_ext.h | 3 ++-
 3 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index 0297fbad7bce..7b6102a2bb2c 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -87,6 +87,8 @@ static struct _cmd_callback rtw_cmd_callback[] = {
 	{GEN_CMD_CODE(_RunInThreadCMD), NULL},/*64*/
 };
 
+u8 dummy_functioni(struct adapter *var0, u8 *var1) { return 0; }
+
 static struct cmd_hdl wlancmds[] = {
 	GEN_DRV_CMD_HANDLER(0, NULL) /*0*/
 	GEN_DRV_CMD_HANDLER(0, NULL)
@@ -150,7 +152,7 @@ static struct cmd_hdl wlancmds[] = {
 
 	GEN_MLME_EXT_HANDLER(0, h2c_msg_hdl) /*58*/
 	GEN_MLME_EXT_HANDLER(sizeof(struct SetChannelPlan_param), set_chplan_hdl) /*59*/
-	GEN_MLME_EXT_HANDLER(sizeof(struct LedBlink_param), led_blink_hdl) /*60*/
+	GEN_MLME_EXT_HANDLER(sizeof(struct LedBlink_param), dummy_function) /*60*/
 
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
index 5e6cf63956b8..57977da78eb3 100644
--- a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
+++ b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
@@ -745,11 +745,12 @@ u8 chk_bmc_sleepq_hdl(struct adapter *padapter, unsigned char *pbuf);
 u8 tx_beacon_hdl(struct adapter *padapter, unsigned char *pbuf);
 u8 set_ch_hdl(struct adapter *padapter, u8 *pbuf);
 u8 set_chplan_hdl(struct adapter *padapter, unsigned char *pbuf);
-u8 led_blink_hdl(struct adapter *padapter, unsigned char *pbuf);
 u8 set_csa_hdl(struct adapter *padapter, unsigned char *pbuf);	/* Kurt: Handling DFS channel switch announcement ie. */
 u8 tdls_hdl(struct adapter *padapter, unsigned char *pbuf);
 u8 run_in_thread_hdl(struct adapter *padapter, u8 *pbuf);
 
+/* Dummy function used to fill elements of an array of function pointers */
+u8 dummy_function(struct adapter *, u8 *);
 
 #define GEN_DRV_CMD_HANDLER(size, cmd)	{size, &cmd ## _hdl},
 #define GEN_MLME_EXT_HANDLER(size, cmd)	{size, cmd},
-- 
2.31.1

