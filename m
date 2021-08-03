Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB3E13DF63F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 22:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbhHCUPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 16:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240427AbhHCUPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 16:15:39 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF4BC061757
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 13:15:28 -0700 (PDT)
Received: from dslb-188-104-062-095.188.104.pools.vodafone-ip.de ([188.104.62.95] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mB0ou-0007wl-6C; Tue, 03 Aug 2021 22:15:24 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 3/6] staging: r8188eu: remove RT_TRACE and DBG_88E prints from osdep_service.c
Date:   Tue,  3 Aug 2021 22:15:08 +0200
Message-Id: <20210803201511.29000-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210803201511.29000-1-martin@kaiser.cx>
References: <20210803201511.29000-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should use the standard mechanism for debug prints. Remove the prints
that use driver-specific macros.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/os_dep/osdep_service.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/osdep_service.c b/drivers/staging/r8188eu/os_dep/osdep_service.c
index 99ddc535e5ea..e00775730bad 100644
--- a/drivers/staging/r8188eu/os_dep/osdep_service.c
+++ b/drivers/staging/r8188eu/os_dep/osdep_service.c
@@ -366,11 +366,9 @@ int rtw_change_ifname(struct adapter *padapter, const char *ifname)
 		ret = register_netdev(pnetdev);
 	else
 		ret = register_netdevice(pnetdev);
-	if (ret != 0) {
-		RT_TRACE(_module_hci_intfs_c_, _drv_err_,
-			 ("register_netdev() failed\n"));
+	if (ret != 0)
 		goto error;
-	}
+
 	rtw_proc_init_one(pnetdev);
 	return 0;
 error:
@@ -455,8 +453,6 @@ bool rtw_cbuf_push(struct rtw_cbuf *cbuf, void *buf)
 	if (rtw_cbuf_full(cbuf))
 		return _FAIL;
 
-	if (0)
-		DBG_88E("%s on %u\n", __func__, cbuf->write);
 	cbuf->bufs[cbuf->write] = buf;
 	cbuf->write = (cbuf->write+1)%cbuf->size;
 
@@ -476,8 +472,6 @@ void *rtw_cbuf_pop(struct rtw_cbuf *cbuf)
 	if (rtw_cbuf_empty(cbuf))
 		return NULL;
 
-	if (0)
-		DBG_88E("%s on %u\n", __func__, cbuf->read);
 	buf = cbuf->bufs[cbuf->read];
 	cbuf->read = (cbuf->read+1)%cbuf->size;
 
-- 
2.20.1

