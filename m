Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0733FA79A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 23:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbhH1VZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 17:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232684AbhH1VZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 17:25:51 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427DBC061756
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 14:25:00 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id d26so16271274wrc.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 14:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q1h4DF8vwdgzDXv0WetE7P68kDtfdB8RpBQW3/t1r50=;
        b=f22pL4vTEsQRaJBRfxGB+OThWRmIS5S88NRYIbsIjOS2srvrc7wT3AhfanOIcxXmiM
         ZC+MTM5vR8PdHHPrLBNG3UIIahHBeqORSq9jACTsNSGbggbfnSP0vhDSY0Jk5FHeNs92
         1IPjDOyRdX1r8LhfncOPJbr9n2RpFLtCRJQisF53Cgv4mX2yPwMkY5rIM9pt5Q3uqa6c
         2OQ2EDyojO2JfrP+/dI0r8WZZElKRPciYK6SNQJJ62YQXGebH7lkKLIq6p1RYey+OnIb
         +Kq7/Q1p4WlGSivar32Hf8cuLUnWHScag5O0xfcrzCt+tBO4VmeLLFTps1xRKDpf/YHW
         rs1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q1h4DF8vwdgzDXv0WetE7P68kDtfdB8RpBQW3/t1r50=;
        b=E3KWywHS+dtMW3HdaEp9pv7JJzcrIq9k1mg3qRZWJWEkRl01blocc3Ad0/6xJwrDj3
         EqMoL7f3kVD07TqLnwTb1o+7f57yBBjvCvVpp6VNb6OzHuLK+uuSpH0fmmQN2Y2dTvVs
         G36GZb0K5Vg0xCF8HxuavRLvX4IlCm7tH4aZ9K+UxJLCF53DErI0MTwYG3rEuBB290l0
         LBwenP3siqgxlHgaAO+rJ83fYSmhu3JJtckUWNF8OKf7pb5quCmnwCvAv2Zd14WTCyIi
         twXSjVB7EIM1CapnP6N9gNSR9MqiHkgxwpELLf9YHuBUiTEWQPenYFYXT0202SUDwHr3
         gLXg==
X-Gm-Message-State: AOAM530q8i0ZPzfZnITdxcS20vc/DRcWgYwBTUYAeiXR9RVATxYIsFXu
        IXjEhCOQBilIWmQveSSdRca5sg==
X-Google-Smtp-Source: ABdhPJw6iV3AMIFjF3F2nlzYwQSNyaVDYOFJAMCCpzN0XOEtnC8nZPHPTMPEXPHFQV+jgNSJFWKGJw==
X-Received: by 2002:a5d:4647:: with SMTP id j7mr17894768wrs.149.1630185897349;
        Sat, 28 Aug 2021 14:24:57 -0700 (PDT)
Received: from localhost.localdomain (d.f.5.e.6.6.b.1.e.6.2.7.e.5.c.8.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:8c5e:726e:1b66:e5fd])
        by smtp.gmail.com with ESMTPSA id u26sm8645847wrd.32.2021.08.28.14.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 14:24:57 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     straube.linux@gmail.com, fmdefrancesco@gmail.com,
        Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] staging: r8188eu: remove rtw_hal_c2h_handler function
Date:   Sat, 28 Aug 2021 22:24:53 +0100
Message-Id: <20210828212453.898-4-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210828212453.898-1-phil@philpotter.co.uk>
References: <20210828212453.898-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove rtw_hal_c2h_handler function from hal/hal_intf.c, as well as its
declaration in include/hal_intf.h, and remove its one remaining caller
within core/rtw_cmd.c.

This function was a wrapper function, then simplified to always return
_FAIL. Since it has no further use, remove it, as part of ongoing
efforts to simplify and remove the HAL layer of the driver.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_cmd.c     | 2 --
 drivers/staging/r8188eu/hal/hal_intf.c     | 5 -----
 drivers/staging/r8188eu/include/hal_intf.h | 2 --
 3 files changed, 9 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index b520c6b43c03..5222863f8d66 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -1898,8 +1898,6 @@ static void c2h_wk_callback(struct work_struct *work)
 		}
 
 		if (ccx_id_filter(c2h_evt->id)) {
-			/* Handle CCX report here */
-			rtw_hal_c2h_handler(adapter, c2h_evt);
 			kfree(c2h_evt);
 		} else {
 #ifdef CONFIG_88EU_P2P
diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index 0c835f9cd181..bcc77da06c08 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -426,11 +426,6 @@ void rtw_hal_reset_security_engine(struct adapter *adapter)
 		adapter->HalFunc.hal_reset_security_engine(adapter);
 }
 
-s32 rtw_hal_c2h_handler(struct adapter *adapter, struct c2h_evt_hdr *c2h_evt)
-{
-	return _FAIL;
-}
-
 c2h_id_filter rtw_hal_c2h_id_filter_ccx(struct adapter *adapter)
 {
 	return adapter->HalFunc.c2h_id_filter_ccx;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 4603f9212030..954de3ab2613 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -400,8 +400,6 @@ int rtw_hal_iol_cmd(struct adapter  *adapter, struct xmit_frame *xmit_frame,
 void rtw_hal_notch_filter(struct adapter *adapter, bool enable);
 void rtw_hal_reset_security_engine(struct adapter *adapter);
 
-s32 rtw_hal_c2h_handler(struct adapter *adapter,
-			struct c2h_evt_hdr *c2h_evt);
 c2h_id_filter rtw_hal_c2h_id_filter_ccx(struct adapter *adapter);
 void indicate_wx_scan_complete_event(struct adapter *padapter);
 u8 rtw_do_join(struct adapter *padapter);
-- 
2.31.1

