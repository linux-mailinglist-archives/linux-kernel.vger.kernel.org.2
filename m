Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA1CC3F0EBE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 01:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235211AbhHRXnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 19:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235154AbhHRXnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 19:43:33 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830EEC061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 16:42:57 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id c129-20020a1c35870000b02902e6b6135279so2920035wma.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 16:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fS87NzQwLT8g66B7fskAIWcIr5+nFxmzUVQe97BcNMA=;
        b=2LLT+ZN1EAetJhx8/FJo9T8oYwnVl3/ZAag7ZCfKAylDCaoQUXDJuyrbsP0oYO30xJ
         q7n39aIn28mrkea0MZ60YVEuvGon9pyRg+WIhTUlqL0NwqgGyz+xa7guV94zrs3UECx4
         kMyo7vZejteDT41CG3H0nwDYGQtD7XIdpUMkbRMYZpLd8lNuxY46DfXLq3uV2eivwcPz
         8cqYuztRcpWshNeYLuD79aQWM9M2HQidZ2aH6RpfuKXkPCW89/E902w7D1qc9XgWci9Z
         TMuPXjAUrLPfuk6DjPdKF1r+9Lvs31FKjoMpGh52vC65n3WKjxYz3oIjyHUCeapPCuwK
         v0AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fS87NzQwLT8g66B7fskAIWcIr5+nFxmzUVQe97BcNMA=;
        b=U0wR/KnwoKek3uZHqQUFsWKTT9gnDAO/SJG+CeMHy6y7fb2bkU3V3YJ8AgghgWwj5I
         pL35ozv8XvPf+IaNk5C7PXvbKf/g51cB9CuApnavHTjs/UMEZrgCLZefyw1wUC3GiNWR
         xLumAMXfTUE6WXRHLGkXnr0t/H5Zid2Ubi6mT5KhjHFIJFSQeqm3rOS6IbZenPm8OkfY
         dXwoq70eNdZdj2HHxGgWh+bieA2sQlhK3qXd6A7Jm9BCxIps6ecsqsZ5/KFIcWfHFonw
         StIrmphhCp0O0nqjxMC5Co5FflNTkSe2kjE+SfkARggge6pn8e3ju83Gg+L6OM9zHZEF
         6v9g==
X-Gm-Message-State: AOAM533CmyfQnlDS53cqUWoMYtHQV4ZnmUrfN502oiRiZnZdcNttuqTI
        KAL7RO7eiT7tEVSdnKXYj1NuvQ==
X-Google-Smtp-Source: ABdhPJy87p+QaMAhA3A9d7t6/3wJ21c0PEe/UwXDw1z5nhan2j7WVLu5bh/Kemv/Bjz/pJx+epFpTQ==
X-Received: by 2002:a7b:ca45:: with SMTP id m5mr10750096wml.158.1629330176181;
        Wed, 18 Aug 2021 16:42:56 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id z8sm1194926wrt.77.2021.08.18.16.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 16:42:55 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        martin@kaiser.cx, straube.linux@gmail.com,
        Larry.Finger@lwfinger.net
Subject: [PATCH 2/6] staging: r8188eu: remove unused function dump_txrpt_ccx_88e
Date:   Thu, 19 Aug 2021 00:42:49 +0100
Message-Id: <20210818234253.208271-3-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210818234253.208271-1-phil@philpotter.co.uk>
References: <20210818234253.208271-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused function dump_txrpt_ccx_88e from hal/rtl8188e_xmit.c and
remove its declaration in include/rtl8188e_xmit.h, as this function is
not called from anywhere, and is thus dead code.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/hal/rtl8188e_xmit.c   | 22 -------------------
 .../staging/r8188eu/include/rtl8188e_xmit.h   |  1 -
 2 files changed, 23 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_xmit.c b/drivers/staging/r8188eu/hal/rtl8188e_xmit.c
index d2b55d581f95..46b871f3f631 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_xmit.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_xmit.c
@@ -7,28 +7,6 @@
 #include "../include/drv_types.h"
 #include "../include/rtl8188e_hal.h"
 
-void dump_txrpt_ccx_88e(void *buf)
-{
-	struct txrpt_ccx_88e *txrpt_ccx = (struct txrpt_ccx_88e *)buf;
-
-	DBG_88E("%s:\n"
-		"tag1:%u, pkt_num:%u, txdma_underflow:%u, int_bt:%u, int_tri:%u, int_ccx:%u\n"
-		"mac_id:%u, pkt_ok:%u, bmc:%u\n"
-		"retry_cnt:%u, lifetime_over:%u, retry_over:%u\n"
-		"ccx_qtime:%u\n"
-		"final_data_rate:0x%02x\n"
-		"qsel:%u, sw:0x%03x\n",
-		__func__, txrpt_ccx->tag1, txrpt_ccx->pkt_num,
-		txrpt_ccx->txdma_underflow, txrpt_ccx->int_bt,
-		txrpt_ccx->int_tri, txrpt_ccx->int_ccx,
-		txrpt_ccx->mac_id, txrpt_ccx->pkt_ok, txrpt_ccx->bmc,
-		txrpt_ccx->retry_cnt, txrpt_ccx->lifetime_over,
-		txrpt_ccx->retry_over, txrpt_ccx_qtime_88e(txrpt_ccx),
-		txrpt_ccx->final_data_rate, txrpt_ccx->qsel,
-		txrpt_ccx_sw_88e(txrpt_ccx)
-	);
-}
-
 void handle_txrpt_ccx_88e(struct adapter *adapter, u8 *buf)
 {
 	struct txrpt_ccx_88e *txrpt_ccx = (struct txrpt_ccx_88e *)buf;
diff --git a/drivers/staging/r8188eu/include/rtl8188e_xmit.h b/drivers/staging/r8188eu/include/rtl8188e_xmit.h
index d2099da1a41a..20b55e3850ba 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_xmit.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_xmit.h
@@ -150,7 +150,6 @@ s32 rtl8188eu_xmitframe_complete(struct adapter *padapter,
 				 struct xmit_priv *pxmitpriv,
 				 struct xmit_buf *pxmitbuf);
 
-void dump_txrpt_ccx_88e(void *buf);
 void handle_txrpt_ccx_88e(struct adapter *adapter, u8 *buf);
 
 #endif /* __RTL8188E_XMIT_H__ */
-- 
2.31.1

