Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9F734070D8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 20:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhIJSVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 14:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhIJSVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 14:21:43 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DCAC061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 11:20:32 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id 5so1677058plo.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 11:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=MQBLIvat0Yi5uc02p/sMmL47y+EqK3jI7MnOBAhKSpo=;
        b=CSLBs1ZYIhN2ZflZu+StwA+/osv2USf5nrilccKrwZRW8TLBnnTCBgdN/SivALTq29
         bZZUKmhMsH/C4I4oMTMmhGTGWiLX0kfgy8X+Ppy2zjlgMxXvXeCiJNW1hF7WRK6ucGqU
         SJ3Q/PAnOMSiJsFnMPH8vhq4nlg31/EsOnzffpYWEDDQdXBLHFkAvHByGkqNhx/Wp/rn
         yDJxVip0x8NperS+nyyf+un6v73GjbEdZ1dS4qwHMCWcQrFkez1Hoi/1xXhj4JBRRY5a
         /G7y248LuiHaCylhfPp5fTHrltU84TAF+uFCHVzexhwl6sKlmyYi0dHRHP2m5LKQB+1+
         FZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=MQBLIvat0Yi5uc02p/sMmL47y+EqK3jI7MnOBAhKSpo=;
        b=tMqArvqoQVKpSlwD5w7dHj/Cl077IV3O+69Y6+xFiaDoeARjDsMfis9QY8ZFeeGrTe
         /ypj+DYxbKenw7LmVUInfJ1cBaEE9ZkDivHDILss8rY8v88HSFUZ6qmOytgEDAIO1A0T
         Ct8YMi+5P2OCYPlucGOR5idb1rE7HfXkl2USAWZuF9Frqyof0I9Jj58ICFNHTTxgwX13
         i8SmaJG3f+eu9cNIAggMDfUXJpFcflMWLV7NIqsaY7g2kKcHTNIOjbClRzNXXMaK+hP7
         9Yf4Zrray8wFmZ1gQ8oMDibvDyzpsLLmISCqp7JezQOGgdbsom+I/EoLK4J93TM6W/cN
         S1tQ==
X-Gm-Message-State: AOAM530922xrxilHaDqWTyHYu1PAuGiVS+/vd5PtsG+4lfCvTjig9XHy
        OutNXk6xlyxl5AEvRm5W7Lk=
X-Google-Smtp-Source: ABdhPJx3EZioYxal1RHBatlP+Lu41k4JXAZ/f5FVmhry4zywyIXVDdzr4tnbMf0cDUYrlpCFykvecg==
X-Received: by 2002:a17:90b:1509:: with SMTP id le9mr4370489pjb.171.1631298031785;
        Fri, 10 Sep 2021 11:20:31 -0700 (PDT)
Received: from user ([117.98.200.228])
        by smtp.gmail.com with ESMTPSA id m21sm5950077pfa.216.2021.09.10.11.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 11:20:31 -0700 (PDT)
Date:   Fri, 10 Sep 2021 23:50:26 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        saurav.girepunje@gmail.com, martin@kaiser.cx,
        linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] staging: r8188eu: core: remove unused variable Adapter
Message-ID: <YTuh6iDyPMUC3wha@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused variable Adapter from rtw_IOL_cmd_buf_dump function.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_iol.c          | 2 +-
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 2 +-
 drivers/staging/r8188eu/include/rtw_iol.h       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_iol.c b/drivers/staging/r8188eu/core/rtw_iol.c
index 5c1b19679cad..abaddfb1a1a5 100644
--- a/drivers/staging/r8188eu/core/rtw_iol.c
+++ b/drivers/staging/r8188eu/core/rtw_iol.c
@@ -174,7 +174,7 @@ u8 rtw_IOL_cmd_boundary_handle(struct xmit_frame *pxmit_frame)
 	return is_cmd_bndy;
 }

-void rtw_IOL_cmd_buf_dump(struct adapter  *Adapter, int buf_len, u8 *pbuf)
+void rtw_IOL_cmd_buf_dump(int buf_len, u8 *pbuf)
 {
 	int i;
 	int j = 1;
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 14758361960c..f3fb1a2f4cb6 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -362,7 +362,7 @@ void rtw_IOL_cmd_tx_pkt_buf_dump(struct adapter *Adapter, int data_len)
 				rtw_usleep_os(2);
 			} while (!rstatus && (loop++ < 10));
 		}
-		rtw_IOL_cmd_buf_dump(Adapter, data_len, pbuf);
+		rtw_IOL_cmd_buf_dump(data_len, pbuf);
 		vfree(pbuf);
 	}
 	DBG_88E("###### %s ######\n", __func__);
diff --git a/drivers/staging/r8188eu/include/rtw_iol.h b/drivers/staging/r8188eu/include/rtw_iol.h
index 471f9ca092a8..7979cbcf8e00 100644
--- a/drivers/staging/r8188eu/include/rtw_iol.h
+++ b/drivers/staging/r8188eu/include/rtw_iol.h
@@ -63,6 +63,6 @@ int _rtw_IOL_append_WRF_cmd(struct xmit_frame *xmit_frame, u8 rf_path,
 	_rtw_IOL_append_WRF_cmd((xmit_frame),(rf_path), (addr), (value), (mask))

 u8 rtw_IOL_cmd_boundary_handle(struct xmit_frame *pxmit_frame);
-void  rtw_IOL_cmd_buf_dump(struct adapter  *Adapter,int buf_len,u8 *pbuf);
+void  rtw_IOL_cmd_buf_dump(int buf_len, u8 *pbuf);

 #endif /* __RTW_IOL_H_ */
--
2.32.0

