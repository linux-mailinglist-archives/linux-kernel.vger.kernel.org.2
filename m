Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9313E364B00
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 22:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238850AbhDSUN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 16:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbhDSUN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 16:13:26 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5A4C06174A;
        Mon, 19 Apr 2021 13:12:54 -0700 (PDT)
Received: from dslb-188-097-210-083.188.097.pools.vodafone-ip.de ([188.97.210.83] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1lYaGI-0006ik-7y; Mon, 19 Apr 2021 22:12:50 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2 2/4] staging: rtl8188eu: remove constant variable and dead code
Date:   Mon, 19 Apr 2021 22:11:24 +0200
Message-Id: <20210419201126.25633-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210419201126.25633-1-martin@kaiser.cx>
References: <20210417180037.17806-1-martin@kaiser.cx>
 <20210419201126.25633-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

g_wifi_on is always true. Remove the variable and the code that would
be run only if g_wifi_on was false.

While at it, remove a pointlesss comment that starts with /** and is
misinterpreted as a kernel-doc comment.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
Reported-by: kernel test robot <lkp@intel.com>
---
v2:
 - fix compiler warning, remove a comment that looks like kernel-doc

 drivers/staging/rtl8188eu/os_dep/rtw_android.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/rtw_android.c b/drivers/staging/rtl8188eu/os_dep/rtw_android.c
index f5763a9d70c5..f1470ac56874 100644
--- a/drivers/staging/rtl8188eu/os_dep/rtw_android.c
+++ b/drivers/staging/rtl8188eu/os_dep/rtw_android.c
@@ -52,16 +52,6 @@ struct android_wifi_priv_cmd {
 	int total_len;
 };
 
-/**
- * Local (static) functions and variables
- */
-
-/* Initialize g_wifi_on to 1 so dhd_bus_start will be called for the first
- * time (only) in dhd_open, subsequential wifi on will be handled by
- * wl_android_wifi_on
- */
-static int g_wifi_on = true;
-
 int rtw_android_cmdstr_to_num(char *cmdstr)
 {
 	int cmd_num;
@@ -154,12 +144,6 @@ int rtw_android_priv_cmd(struct net_device *net, struct ifreq *ifr, int cmd)
 	case ANDROID_WIFI_CMD_SETFWPATH:
 		goto response;
 	}
-	if (!g_wifi_on) {
-		DBG_88E("%s: Ignore private cmd \"%s\" - iface %s is down\n",
-			__func__, command, ifr->ifr_name);
-		ret = 0;
-		goto free;
-	}
 	switch (cmd_num) {
 	case ANDROID_WIFI_CMD_STOP:
 		break;
@@ -244,7 +228,6 @@ int rtw_android_priv_cmd(struct net_device *net, struct ifreq *ifr, int cmd)
 	} else {
 		ret = bytes_written;
 	}
-free:
 	kfree(command);
 	return ret;
 }
-- 
2.20.1

