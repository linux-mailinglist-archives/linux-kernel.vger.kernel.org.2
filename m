Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1D4C3ADF9F
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 19:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhFTRnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 13:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbhFTRnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 13:43:47 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E800C061574;
        Sun, 20 Jun 2021 10:41:34 -0700 (PDT)
Received: from dslb-084-059-235-131.084.059.pools.vodafone-ip.de ([84.59.235.131] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1lv1Rn-0000xJ-K2; Sun, 20 Jun 2021 19:41:27 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v2] staging: rtl8188eu: fix usb_submit_urb error handling
Date:   Sun, 20 Jun 2021 19:40:57 +0200
Message-Id: <20210620174057.10201-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210612180019.20387-1-martin@kaiser.cx>
References: <20210612180019.20387-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

usb_read_port prepares a bulk in urb and calls usb_submit_urb to pass the
usb to the usb core. It seems wrong that usb_read_port returns success to
its caller if usb_submit_urb failed with -EPERM.

According to drivers/usb/core/urb.c, usb_submit_urb returns -EPERM when
an urb is resubmitted after being cancelled by usb_kill_urb etc.

The only caller who checks the return value of usb_read_port is
rtw_hal_inirp_init. This function submits the bulk in urbs for the first
time after the netdevice is opened. We'll not receive -EPERM from
usb_submit_urb in this case. The urbs are resubmitted by
read_port_complete, which does not check for errors from usb_read_port.

This driver may kill pending bulk in urbs when the netdevice is closed when
the driver is unloaded or the system goes to sleep. I don't think that this
will interrupt an ongoing netdev open.

Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
v2:
 - improved the commit message based on explanations from Greg and Dan

 drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c b/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
index ec07b2017fb7..0ceb05f3884f 100644
--- a/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/usb_ops_linux.c
@@ -366,7 +366,6 @@ u32 usb_read_port(struct adapter *adapter, u32 addr, struct recv_buf *precvbuf)
 	struct usb_device *pusbd = pdvobj->pusbdev;
 	int err;
 	unsigned int pipe;
-	u32 ret = _SUCCESS;
 
 	if (adapter->bDriverStopped || adapter->bSurpriseRemoved ||
 	    adapter->pwrctrlpriv.pnp_bstop_trx) {
@@ -403,10 +402,10 @@ u32 usb_read_port(struct adapter *adapter, u32 addr, struct recv_buf *precvbuf)
 			  precvbuf);/* context is precvbuf */
 
 	err = usb_submit_urb(purb, GFP_ATOMIC);
-	if ((err) && (err != (-EPERM)))
-		ret = _FAIL;
+	if (err)
+		return _FAIL;
 
-	return ret;
+	return _SUCCESS;
 }
 
 void rtw_hal_inirp_deinit(struct adapter *padapter)
-- 
2.20.1

