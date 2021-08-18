Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711673F0EBD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 01:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235195AbhHRXne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 19:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235148AbhHRXnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 19:43:32 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D8AC0613D9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 16:42:56 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id x10so6032162wrt.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 16:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b/gpO+AdZjDxLFL9pl6PQ8PT9YMajy0ZJusmrr2xHJE=;
        b=CiJzIl5iTqHZfVq1SOiChKp2Y4bVYoE0Z+67nk+YypbitzQyuieFkzd+OEVKfM17+u
         RvHhg+4jzupQzzOukOrxXWtWuFhDbLuCqL4QELvtwxE4pTx2Qat+2g83D5XQ1qhzBaUl
         O/4ZYKse0PSM6gKp0jSr3zS2o1gYIljDd8mkpiC3PRIiOr6egZpLb3UCPn6fjPv8fQD8
         Z+RqJE0Brz0lBMW0UCmXhDKPsSuQdwzKQi5+mKLZeuSDEvhEiTwoYeezJ31zPgarln/X
         cBEDUyXGo5hVqsfFdDdKjW+0ji5d4QYNc/34Ra32SJ8ZpQdzkcBOBJCoHTk1ICbWHaxG
         JMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b/gpO+AdZjDxLFL9pl6PQ8PT9YMajy0ZJusmrr2xHJE=;
        b=gDVq9VwIMfutfOkLdCvTC3TwDXEW3G7okAnelT+LEZEyXFdEVRZdqVtP9DeL70Wdai
         GSZtHzYvKUossUxnwPQsMikOd+lY2F11/m+zDwvXmBXLFlDARrJgA4z4jI/fazUtmzTY
         hKybVTlQv+SCiXRCNgSzSScAv3emrwQzMnRVIyw1UGk+LlVYTaXVfy9NSIgjHOkALihO
         ckfKCNC6FIpOH3zOqXo06a2841G/gAtaMoR3GfESAA4eoLgQIpIydRvBLNvuSXAN9G15
         TnXBfdsRcLYszTXZgLMGIwx+GorpIgLmNlEaLSqEoO5uATCejicbMMwMZNr/R8N8Hmpk
         bKag==
X-Gm-Message-State: AOAM530bEY2usiL0Rc+swkpPl3DdhBjBeurWPcEq4g28QfPr7hSgWBCX
        yuRE7SAVgacho9IaJanPo7RKVqd1sOkV1HkE
X-Google-Smtp-Source: ABdhPJzkKt8KYCOjZCWOHKsOkrBYsXM+C4ychf0pY1QgalTLJdo5E2zLHBpx2QdBlpwBAKIjOyghJg==
X-Received: by 2002:adf:feca:: with SMTP id q10mr54134wrs.420.1629330175389;
        Wed, 18 Aug 2021 16:42:55 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id z8sm1194926wrt.77.2021.08.18.16.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 16:42:55 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        martin@kaiser.cx, straube.linux@gmail.com,
        Larry.Finger@lwfinger.net
Subject: [PATCH 1/6] staging: r8188eu: remove _dbg_dump_tx_info function
Date:   Thu, 19 Aug 2021 00:42:48 +0100
Message-Id: <20210818234253.208271-2-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210818234253.208271-1-phil@philpotter.co.uk>
References: <20210818234253.208271-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove _dbg_dump_tx_info from hal/rtl8188e_xmit.c as it is just a
dumping function that contains a lot of unclear DBG_88E calls, and has
no other external effect, other than calling a function that ultimately
determines whether or not to dump/trigger the DBG_88E calls. Also remove
its declaration and single call site.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/hal/rtl8188e_xmit.c   | 31 -------------------
 drivers/staging/r8188eu/hal/rtl8188eu_xmit.c  |  1 -
 .../staging/r8188eu/include/rtl8188e_xmit.h   |  3 --
 3 files changed, 35 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_xmit.c b/drivers/staging/r8188eu/hal/rtl8188e_xmit.c
index 164ec6650dec..d2b55d581f95 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_xmit.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_xmit.c
@@ -42,34 +42,3 @@ void handle_txrpt_ccx_88e(struct adapter *adapter, u8 *buf)
 					RTW_SCTX_DONE_CCX_PKT_FAIL);
 	}
 }
-
-void _dbg_dump_tx_info(struct adapter *padapter, int frame_tag,
-		       struct tx_desc *ptxdesc)
-{
-	u8 dmp_txpkt;
-	bool dump_txdesc = false;
-	rtw_hal_get_def_var(padapter, HAL_DEF_DBG_DUMP_TXPKT, &(dmp_txpkt));
-
-	if (dmp_txpkt == 1) {/* dump txdesc for data frame */
-		DBG_88E("dump tx_desc for data frame\n");
-		if ((frame_tag & 0x0f) == DATA_FRAMETAG)
-			dump_txdesc = true;
-	} else if (dmp_txpkt == 2) {/* dump txdesc for mgnt frame */
-		DBG_88E("dump tx_desc for mgnt frame\n");
-		if ((frame_tag & 0x0f) == MGNT_FRAMETAG)
-			dump_txdesc = true;
-	}
-
-	if (dump_txdesc) {
-		DBG_88E("=====================================\n");
-		DBG_88E("txdw0(0x%08x)\n", ptxdesc->txdw0);
-		DBG_88E("txdw1(0x%08x)\n", ptxdesc->txdw1);
-		DBG_88E("txdw2(0x%08x)\n", ptxdesc->txdw2);
-		DBG_88E("txdw3(0x%08x)\n", ptxdesc->txdw3);
-		DBG_88E("txdw4(0x%08x)\n", ptxdesc->txdw4);
-		DBG_88E("txdw5(0x%08x)\n", ptxdesc->txdw5);
-		DBG_88E("txdw6(0x%08x)\n", ptxdesc->txdw6);
-		DBG_88E("txdw7(0x%08x)\n", ptxdesc->txdw7);
-		DBG_88E("=====================================\n");
-	}
-}
diff --git a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
index 50c4b9382761..b279309405a2 100644
--- a/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
+++ b/drivers/staging/r8188eu/hal/rtl8188eu_xmit.c
@@ -330,7 +330,6 @@ static s32 update_txdesc(struct xmit_frame *pxmitframe, u8 *pmem, s32 sz, u8 bag
 	ODM_SetTxAntByTxInfo_88E(&haldata->odmpriv, pmem, pattrib->mac_id);
 
 	rtl8188eu_cal_txdesc_chksum(ptxdesc);
-	_dbg_dump_tx_info(adapt, pxmitframe->frame_tag, ptxdesc);
 	return pull;
 }
 
diff --git a/drivers/staging/r8188eu/include/rtl8188e_xmit.h b/drivers/staging/r8188eu/include/rtl8188e_xmit.h
index ff8b73441c52..d2099da1a41a 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_xmit.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_xmit.h
@@ -153,7 +153,4 @@ s32 rtl8188eu_xmitframe_complete(struct adapter *padapter,
 void dump_txrpt_ccx_88e(void *buf);
 void handle_txrpt_ccx_88e(struct adapter *adapter, u8 *buf);
 
-void _dbg_dump_tx_info(struct adapter *padapter, int frame_tag,
-		       struct tx_desc *ptxdesc);
-
 #endif /* __RTL8188E_XMIT_H__ */
-- 
2.31.1

