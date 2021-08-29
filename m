Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4833FAF1E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 01:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236130AbhH2Xqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 19:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236092AbhH2Xql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 19:46:41 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E03AC061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 16:45:48 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id j14-20020a1c230e000000b002e748b9a48bso10510861wmj.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 16:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QdXktGij0krfVmBgcI/UvjythaqTzQZ5d49NfhWpr64=;
        b=oYsyrjlMGQZIfnLRtTj6TGkS5D0uy7xfmKz2dJ3uj3vpiD5g3FPPgL/e2FMrVVRWzN
         MCwsNUJCx2js+Xe81DXGfa0tS/IeT0wPq2VHt2qqnDPeoS4GcU2eKaTdUN0hxXxTtgU2
         hm6nVLSCuTLQoBaYnG5ya5JvpVPl+b9/b5YsCQazP7CCMGswVplq5GBCTrvAC3r1F7bY
         DlNKOap20UgGNlHL9BpIlQl0uQdBw0bRlYhBO6pOl7JYm9XJnhzmPt2HkSUkIRTmOpAE
         Et3U8TwKfZe1+fKtsSTWN1kEmrugrEBK2ev0y+aLbOBgKA2PKYU4t+t3tbV4FgW8cw5J
         wo8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QdXktGij0krfVmBgcI/UvjythaqTzQZ5d49NfhWpr64=;
        b=EiyaSc/QbdGxAUBN6EyhdaNcAPqH3UUiEi4J9fUW4TomUNaCnFNfTfgdf0+8uhTbaA
         sipTzQD0AorUbbCaQ20Z9EARgIdPRE/QlGyemrwbmzEGznvVilPPfJ1y4sG6TWCM6PUw
         VAuMtdv+5v1qjXPUuqI8/j9T6zIfr9Ll7/7SX+78Sxd5B5uiYvcPL489ZyFBjlxCRh6y
         xO/NFLYZpFqF4M8hg8AjDIdn6ZWEsRTQaW/ey05rUx+vFpV1/mHwZAzjRf9vwUoyx/C1
         GZok31FvNx3tocn1gsLzXeImQqxzocdS4q4QdEbls0b0CNMe0OI0og7nnItuxeOwxvdw
         aXvQ==
X-Gm-Message-State: AOAM533IxVt1P615N4BOU8GobIO5XTRc7pPr++NjRChMR9rQV96epKcy
        MauDlHf185G7ErU5Ey81JQKv+ERyqyDZVQ==
X-Google-Smtp-Source: ABdhPJz4szFLTe5DEj4HsWg0zguAIf1hsHwL43L9VrLFqJv8/+TJixA6Am4DgxvmZYFmsGTtdtGT1Q==
X-Received: by 2002:a05:600c:414f:: with SMTP id h15mr5308113wmm.124.1630280746794;
        Sun, 29 Aug 2021 16:45:46 -0700 (PDT)
Received: from localhost.localdomain (d.f.5.e.6.6.b.1.e.6.2.7.e.5.c.8.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:8c5e:726e:1b66:e5fd])
        by smtp.gmail.com with ESMTPSA id r25sm14500574wra.12.2021.08.29.16.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 16:45:46 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     straube.linux@gmail.com, fmdefrancesco@gmail.com,
        Larry.Finger@lwfinger.net, paskripkin@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] staging: r8188eu: remove rtw_hal_c2h_handler function
Date:   Mon, 30 Aug 2021 00:45:41 +0100
Message-Id: <20210829234541.946-4-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210829234541.946-1-phil@philpotter.co.uk>
References: <20210829234541.946-1-phil@philpotter.co.uk>
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

Acked-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Acked-by: Michael Straube <straube.linux@gmail.com>
Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---

V2: Same as V1, reissued as part of series for clarity.

---
 drivers/staging/r8188eu/core/rtw_cmd.c     | 2 --
 drivers/staging/r8188eu/hal/hal_intf.c     | 5 -----
 drivers/staging/r8188eu/include/hal_intf.h | 2 --
 3 files changed, 9 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 14b74f92cd0f..fee4208dacba 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -1896,8 +1896,6 @@ static void c2h_wk_callback(struct work_struct *work)
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

