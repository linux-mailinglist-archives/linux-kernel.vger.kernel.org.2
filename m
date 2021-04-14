Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B34DB35FA7C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 20:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352573AbhDNSNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 14:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234332AbhDNSMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 14:12:15 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A71C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:11:53 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id mh2so11252885ejb.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WsTnlZ0JLtuPnbO60j2rczl2/gLE7x7tVgm20+EM1Dc=;
        b=v7SNGemTBhWQrAoIapsNidlHLFQnZx+bRnGVs+M17pVLVxst/gNZb3SmwiskAjL8lg
         ygF1ZxYy+vpP/GQgmtBbIe/A8oz4faap+35tlxfg6yhC2EsaoLFn2bw3qc2sKJs5uO4W
         HNT3QE++OG9CbZCcW9Wo4ljeZmkpJobpEhaq1Cz7flYijDpgGUl+nYEiuX8zFX0thYOt
         iOt/aKuDWC/6WtGfEzIsI6KbEtXv2sXF0oB5s4lKuZcBAr+MeH9C9dpWGvCVhyo/x3LV
         iECHTLWDZakB/vTl7nfioZOhPE98eoXt1dSaXLaYSmliBFmEt5nSm0OXycJB74HD/drA
         wVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WsTnlZ0JLtuPnbO60j2rczl2/gLE7x7tVgm20+EM1Dc=;
        b=P35WS2rN8IvbMzyU4oPgqRQshxV76m3QJfrrEnPwA6zB739cHM/ry7vlQCTR5Ii+LI
         oyB0UYZA1mToluThiI17eGVzqqTlhbwrWmjJSUD00ttgZkSHvQ8GqihANBuGuay6Uig6
         0rYO78X/miyKpXhWiPB6BMU1XWtX3QzxCGLgbk4HHNtxMOeahf9M1bHQygYpiQmXzG/c
         s9ukNbopct9y5AJ+Its0MqHAV/3OEGrASEc27e2Tq6gpuHN7wjHWD8Ajpvp6OWZgMPn5
         btzQhl0pDQ5D23hlqXgvpg86woa2Q+P1xWXEBQKKkXwxNtd1/IylkMlEm96i2/HsEOn4
         EJdA==
X-Gm-Message-State: AOAM5323feSiQXrC6cKK75o8KSo4+Dw4uXxG33CYGi7ndxEVygAgftHu
        yNrvhULZzOieGXDoWP7zIY1QPA==
X-Google-Smtp-Source: ABdhPJyQJ/Sxa/NX2STNIxTSUi4KKDzaHuSnMl08NYq4KrdAtMi3M+xDBFVTkst+RtqDwC4ChkPzzA==
X-Received: by 2002:a17:906:430f:: with SMTP id j15mr115016ejm.543.1618423912323;
        Wed, 14 Apr 2021 11:11:52 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id v1sm279493eds.17.2021.04.14.11.11.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 11:11:51 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ross Schmidt <ross.schm.dev@gmail.com>,
        linux-staging@lists.linux.dev
Subject: [PATCH 17/57] staging: rtl8723bs: core: rtw_sta_mgt: Return error value directly
Date:   Wed, 14 Apr 2021 19:10:49 +0100
Message-Id: <20210414181129.1628598-18-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210414181129.1628598-1-lee.jones@linaro.org>
References: <20210414181129.1628598-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/staging/rtl8723bs/core/rtw_sta_mgt.c: In function ‘rtw_init_bcmc_stainfo’:
 drivers/staging/rtl8723bs/core/rtw_sta_mgt.c:512:6: warning: variable ‘res’ set but not used [-Wunused-but-set-variable]

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ross Schmidt <ross.schm.dev@gmail.com>
Cc: linux-staging@lists.linux.dev
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/staging/rtl8723bs/core/rtw_sta_mgt.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
index 7b631a6b258a1..233febc145983 100644
--- a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
+++ b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
@@ -497,7 +497,6 @@ struct sta_info *rtw_get_stainfo(struct sta_priv *pstapriv, u8 *hwaddr)
 u32 rtw_init_bcmc_stainfo(struct adapter *padapter)
 {
 	struct sta_info *psta;
-	u32 res = _SUCCESS;
 	NDIS_802_11_MAC_ADDRESS	bcast_addr = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 
 	struct	sta_priv *pstapriv = &padapter->stapriv;
@@ -505,15 +504,12 @@ u32 rtw_init_bcmc_stainfo(struct adapter *padapter)
 
 	psta = rtw_alloc_stainfo(pstapriv, bcast_addr);
 
-	if (!psta) {
-		res = _FAIL;
-		goto exit;
-	}
+	if (!psta)
+		return _FAIL;
 
 	/*  default broadcast & multicast use macid 1 */
 	psta->mac_id = 1;
 
-exit:
 	return _SUCCESS;
 }
 
-- 
2.27.0

