Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA2323572B3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 19:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354592AbhDGRG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 13:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354566AbhDGRGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 13:06:15 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A7FC06175F;
        Wed,  7 Apr 2021 10:06:03 -0700 (PDT)
Received: from ipservice-092-217-079-185.092.217.pools.vodafone-ip.de ([92.217.79.185] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1lUBcs-0001Q6-Hj; Wed, 07 Apr 2021 19:05:58 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 06/10] staging: rtl8188eu: clean up rtw_recv_entry
Date:   Wed,  7 Apr 2021 19:05:27 +0200
Message-Id: <20210407170531.29356-6-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407170531.29356-1-martin@kaiser.cx>
References: <20210407170531.29356-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the return type to int, the function returns 0 or 1.
Remove the goto statement, we're not doing any cleanup on exit.
Summarize variable declarations and assignments.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/rtl8188eu/core/rtw_recv.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_recv.c b/drivers/staging/rtl8188eu/core/rtw_recv.c
index b9b4bc435037..b2fe448d999d 100644
--- a/drivers/staging/rtl8188eu/core/rtw_recv.c
+++ b/drivers/staging/rtl8188eu/core/rtw_recv.c
@@ -1962,27 +1962,18 @@ static int recv_func(struct adapter *padapter, struct recv_frame *rframe)
 	return ret;
 }
 
-s32 rtw_recv_entry(struct recv_frame *precvframe)
+int rtw_recv_entry(struct recv_frame *precvframe)
 {
-	struct adapter *padapter;
-	struct recv_priv *precvpriv;
-	s32 ret = _SUCCESS;
-
-	padapter = precvframe->adapter;
-
-	precvpriv = &padapter->recvpriv;
+	struct adapter *padapter = precvframe->adapter;
+	struct recv_priv *precvpriv = &padapter->recvpriv;
+	int ret;
 
 	ret = recv_func(padapter, precvframe);
-	if (ret == _FAIL) {
+	if (ret == _SUCCESS)
+		precvpriv->rx_pkts++;
+	else
 		RT_TRACE(_module_rtl871x_recv_c_, _drv_info_, ("%s: recv_func return fail!!!\n", __func__));
-		goto _recv_entry_drop;
-	}
-
-	precvpriv->rx_pkts++;
-
-	return ret;
 
-_recv_entry_drop:
 	return ret;
 }
 
-- 
2.20.1

