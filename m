Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9381735FBA3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 21:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353383AbhDNT2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 15:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349391AbhDNT2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 15:28:22 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9714C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 12:28:00 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id r12so33153455ejr.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 12:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=av0jQOTJIUMGDZ5JlBg9J5NuC7eaxG6UgWRpBDlzXG0=;
        b=MQMgbj01xhogw78xBc3/IIZV83BqH13/t1wthxCFJtz4Sl9JrcOHGTzbCWuA/NWtCZ
         M0DL18mXdnJNHQBvb94FTB23AlzXykQI4sHguH+iAnDXREGWs/HPvnTe2Gdi+W+96Wsl
         XrjG0Ir0gti0N5CsFS/Ld6dJhlY3m+j1ypDK6LRIgGVXa2gYAyxurCT4PVMHq1wejSZa
         udLd4ytLxSrsXGAiNbuTSv4qW6WNOpbZZeElY+wMccY6EyPNZhZqg4EMUnutbbNYmJm0
         Y2lokRl9jntIn2icSEsLVVdrQlJwPdNTYKvfo4VoNJuzdUclKxY5T2cABxVfQE8Kv5V6
         05Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=av0jQOTJIUMGDZ5JlBg9J5NuC7eaxG6UgWRpBDlzXG0=;
        b=kWBrVN9x9nPFe/Z1zvFYVsVmR+b1vD9FZ0V3KZgOpI9xfmlYUrkcArIvPTq13TH6r+
         oz9MNv/PncvycU/QN9wCx7u7D2RGBjvHEVHk5aZlR4IYR+ixGpVpjX4QyXF64/dhFA1C
         udabmr6PPlBPVs6/0P3VvdQUotUDQLqJsQbsDPYEvbSIhKbWIaedbF5iM1d2VUxDxQAM
         PUYGd0z8GbZwmKHExVNlwnEd5ZrzG6Urrex9+8NsLuwEMMa0yJ6KYmhXYcsdy6wQ6iqt
         FRPC07AqS4PyEKPEKV3wVUw2fmYVXKGPEuA2Lmt+o6kC8Kv3EqfPNabFiUYvCCf82HgB
         fslg==
X-Gm-Message-State: AOAM530f5Fy44/qSgdJE1+VId0Voyb509AEeNbM9GSxsLNLY6zFoJtbe
        NN0dG5y+ZO9ljMAekuS4uKM=
X-Google-Smtp-Source: ABdhPJyFex+ge8v/9Ek1h+qTQrz66XUo4d0tRiPFga88An9U8iB+B1ngHuDY+uZcY5QGl49c/I8aKQ==
X-Received: by 2002:a17:906:8293:: with SMTP id h19mr418169ejx.217.1618428479653;
        Wed, 14 Apr 2021 12:27:59 -0700 (PDT)
Received: from linux.local (host-95-237-55-30.retail.telecomitalia.it. [95.237.55.30])
        by smtp.gmail.com with ESMTPSA id gn3sm259049ejc.2.2021.04.14.12.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 12:27:59 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [Outreachy patch] [PATCH v3 1/2] staging: rtl8723bs: Remove useless led_blink_hdl()
Date:   Wed, 14 Apr 2021 21:27:49 +0200
Message-Id: <20210414192750.4974-2-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210414192750.4974-1-fmdefrancesco@gmail.com>
References: <20210414192750.4974-1-fmdefrancesco@gmail.com>
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
Suggested-by: Matthew Wilcox <willy@infradead.org>
Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

Changes from v2: no changes.
Changes from v1: Corrected a bad solution to this issue that made use of
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

