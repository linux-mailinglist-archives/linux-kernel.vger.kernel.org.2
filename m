Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE6AE3DF641
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 22:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240482AbhHCUP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 16:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240441AbhHCUPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 16:15:42 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D3AC061757
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 13:15:31 -0700 (PDT)
Received: from dslb-188-104-062-095.188.104.pools.vodafone-ip.de ([188.104.62.95] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1mB0ox-0007wl-7G; Tue, 03 Aug 2021 22:15:27 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 5/6] staging: r8188eu: remove DBG_88E prints from rtw_android.c
Date:   Tue,  3 Aug 2021 22:15:10 +0200
Message-Id: <20210803201511.29000-5-martin@kaiser.cx>
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
 drivers/staging/r8188eu/os_dep/rtw_android.c | 21 ++++----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/rtw_android.c b/drivers/staging/r8188eu/os_dep/rtw_android.c
index 2b9e719e2a51..c5cd621eebd9 100644
--- a/drivers/staging/r8188eu/os_dep/rtw_android.c
+++ b/drivers/staging/r8188eu/os_dep/rtw_android.c
@@ -159,7 +159,6 @@ int rtw_android_priv_cmd(struct net_device *net, struct ifreq *ifr, int cmd)
 	}
 	command = kmalloc(priv_cmd.total_len, GFP_KERNEL);
 	if (!command) {
-		DBG_88E("%s: failed to allocate memory\n", __func__);
 		ret = -ENOMEM;
 		goto exit;
 	}
@@ -168,7 +167,6 @@ int rtw_android_priv_cmd(struct net_device *net, struct ifreq *ifr, int cmd)
 #else
 	if (!access_ok(VERIFY_READ, priv_cmd.buf, priv_cmd.total_len)) {
 #endif
-		DBG_88E("%s: failed to access memory\n", __func__);
 		ret = -EFAULT;
 		goto exit;
 	}
@@ -177,8 +175,6 @@ int rtw_android_priv_cmd(struct net_device *net, struct ifreq *ifr, int cmd)
 		ret = -EFAULT;
 		goto exit;
 	}
-	DBG_88E("%s: Android private cmd \"%s\" on %s\n",
-		__func__, command, ifr->ifr_name);
 	cmd_num = rtw_android_cmdstr_to_num(command);
 	switch (cmd_num) {
 	case ANDROID_WIFI_CMD_START:
@@ -187,8 +183,6 @@ int rtw_android_priv_cmd(struct net_device *net, struct ifreq *ifr, int cmd)
 		goto response;
 	}
 	if (!g_wifi_on) {
-		DBG_88E("%s: Ignore private cmd \"%s\" - iface %s is down\n",
-			__func__, command, ifr->ifr_name);
 		ret = 0;
 		goto exit;
 	}
@@ -252,7 +246,6 @@ int rtw_android_priv_cmd(struct net_device *net, struct ifreq *ifr, int cmd)
 	case ANDROID_WIFI_CMD_P2P_SET_PS:
 		break;
 	default:
-		DBG_88E("Unknown PRIVATE command %s - ignored\n", command);
 		snprintf(command, 3, "OK");
 		bytes_written = strlen("OK");
 	}
@@ -261,20 +254,14 @@ int rtw_android_priv_cmd(struct net_device *net, struct ifreq *ifr, int cmd)
 	if (bytes_written >= 0) {
 		if ((bytes_written == 0) && (priv_cmd.total_len > 0))
 			command[0] = '\0';
-		if (bytes_written >= priv_cmd.total_len) {
-			DBG_88E("%s: bytes_written = %d\n", __func__,
-				bytes_written);
+		if (bytes_written >= priv_cmd.total_len)
 			bytes_written = priv_cmd.total_len;
-		} else {
+		else
 			bytes_written++;
-		}
+
 		priv_cmd.used_len = bytes_written;
-		if (copy_to_user((char __user *)priv_cmd.buf, command,
-				 bytes_written)) {
-			DBG_88E("%s: failed to copy data to user buffer\n",
-				__func__);
+		if (copy_to_user((char __user *)priv_cmd.buf, command, bytes_written))
 			ret = -EFAULT;
-		}
 	} else {
 		ret = bytes_written;
 	}
-- 
2.20.1

