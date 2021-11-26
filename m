Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26F2945F33C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 18:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236795AbhKZSAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 13:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbhKZR6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 12:58:01 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2638FC061395
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 09:32:33 -0800 (PST)
Received: from dslb-084-059-234-221.084.059.pools.vodafone-ip.de ([84.59.234.221] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mqf5K-00083N-ST; Fri, 26 Nov 2021 18:32:30 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 7/8] staging: r8188eu: don't store nr_endpoint in a global struct
Date:   Fri, 26 Nov 2021 18:32:04 +0100
Message-Id: <20211126173205.21352-8-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211126173205.21352-1-martin@kaiser.cx>
References: <20211126173205.21352-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need to store the number of endpoints in a global struct.
We only need it at startup when we iterate over the endpoints.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/r8188eu/include/drv_types.h | 1 -
 drivers/staging/r8188eu/os_dep/usb_intf.c   | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/include/drv_types.h b/drivers/staging/r8188eu/include/drv_types.h
index a3fb509f3f90..1eb6b5f29425 100644
--- a/drivers/staging/r8188eu/include/drv_types.h
+++ b/drivers/staging/r8188eu/include/drv_types.h
@@ -145,7 +145,6 @@ struct dvobj_priv {
 
 /*-------- below is for USB INTERFACE --------*/
 
-	u8	nr_endpoint;
 	u8	ishighspeed;
 	u8	RtNumInPipes;
 	u8	RtNumOutPipes;
diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index 8aa22c2f56cd..04454237a477 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -97,9 +97,8 @@ static struct dvobj_priv *usb_dvobj_init(struct usb_interface *usb_intf)
 
 	pdvobjpriv->NumInterfaces = pconf_desc->bNumInterfaces;
 	pdvobjpriv->InterfaceNumber = piface_desc->bInterfaceNumber;
-	pdvobjpriv->nr_endpoint = piface_desc->bNumEndpoints;
 
-	for (i = 0; i < pdvobjpriv->nr_endpoint; i++) {
+	for (i = 0; i < piface_desc->bNumEndpoints; i++) {
 		int ep_num;
 		pendp_desc = &phost_iface->endpoint[i].desc;
 
-- 
2.20.1

