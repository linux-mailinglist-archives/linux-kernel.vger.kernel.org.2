Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACC74358DD5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 21:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbhDHT5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 15:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbhDHT5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 15:57:08 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B793CC061760;
        Thu,  8 Apr 2021 12:56:56 -0700 (PDT)
Received: from ipservice-092-217-074-086.092.217.pools.vodafone-ip.de ([92.217.74.86] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1lUalp-0005PV-0C; Thu, 08 Apr 2021 21:56:53 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 05/12] staging: rtl8188eu: remove unused function parameter
Date:   Thu,  8 Apr 2021 21:55:54 +0200
Message-Id: <20210408195601.4762-5-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210408195601.4762-1-martin@kaiser.cx>
References: <20210408195601.4762-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The struct adapter parameter of rtw_os_recvbuf_resource_alloc is not used.
Remove it.

While at it, use the same parameter name in the prototype and the function
definition.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/rtl8188eu/hal/rtl8188eu_recv.c | 2 +-
 drivers/staging/rtl8188eu/include/recv_osdep.h | 2 +-
 drivers/staging/rtl8188eu/os_dep/recv_linux.c  | 3 +--
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/rtl8188eu_recv.c b/drivers/staging/rtl8188eu/hal/rtl8188eu_recv.c
index 25f46b2f4920..09bc915994db 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188eu_recv.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188eu_recv.c
@@ -38,7 +38,7 @@ int rtw_hal_init_recv_priv(struct adapter *padapter)
 	precvbuf = precvpriv->precv_buf;
 
 	for (i = 0; i < NR_RECVBUFF; i++) {
-		res = rtw_os_recvbuf_resource_alloc(padapter, precvbuf);
+		res = rtw_os_recvbuf_resource_alloc(precvbuf);
 		if (res == _FAIL)
 			break;
 		precvbuf->adapter = padapter;
diff --git a/drivers/staging/rtl8188eu/include/recv_osdep.h b/drivers/staging/rtl8188eu/include/recv_osdep.h
index 3b771702810d..614245d4b179 100644
--- a/drivers/staging/rtl8188eu/include/recv_osdep.h
+++ b/drivers/staging/rtl8188eu/include/recv_osdep.h
@@ -19,7 +19,7 @@ int rtw_recv_indicatepkt(struct adapter *adapter,
 
 void rtw_handle_tkip_mic_err(struct adapter *padapter, u8 bgroup);
 
-int rtw_os_recvbuf_resource_alloc(struct adapter *adapt, struct recv_buf *buf);
+int rtw_os_recvbuf_resource_alloc(struct recv_buf *precvbuf);
 
 void rtw_init_recv_timer(struct recv_reorder_ctrl *preorder_ctrl);
 
diff --git a/drivers/staging/rtl8188eu/os_dep/recv_linux.c b/drivers/staging/rtl8188eu/os_dep/recv_linux.c
index 9c9339863a4a..a647cdc330e4 100644
--- a/drivers/staging/rtl8188eu/os_dep/recv_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/recv_linux.c
@@ -14,8 +14,7 @@
 #include <usb_ops_linux.h>
 
 /* alloc os related resource in struct recv_buf */
-int rtw_os_recvbuf_resource_alloc(struct adapter *padapter,
-				  struct recv_buf *precvbuf)
+int rtw_os_recvbuf_resource_alloc(struct recv_buf *precvbuf)
 {
 	precvbuf->pskb = NULL;
 	precvbuf->reuse = false;
-- 
2.20.1

