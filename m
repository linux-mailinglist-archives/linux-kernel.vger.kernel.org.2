Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37F51374968
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 22:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235724AbhEEU2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 16:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235562AbhEEU1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 16:27:43 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6C7C06138C;
        Wed,  5 May 2021 13:26:44 -0700 (PDT)
Received: from dslb-188-104-057-152.188.104.pools.vodafone-ip.de ([188.104.57.152] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1leO6J-0003aS-1u; Wed, 05 May 2021 22:26:31 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 1/6] staging: rtl8188eu: make rtw_android_cmdstr_to_num static
Date:   Wed,  5 May 2021 22:26:17 +0200
Message-Id: <20210505202622.11087-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is used only in rtw_android.c.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/staging/rtl8188eu/include/rtw_android.h | 1 -
 drivers/staging/rtl8188eu/os_dep/rtw_android.c  | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/include/rtw_android.h b/drivers/staging/rtl8188eu/include/rtw_android.h
index d7ca7c2fb118..2c26993b8205 100644
--- a/drivers/staging/rtl8188eu/include/rtw_android.h
+++ b/drivers/staging/rtl8188eu/include/rtw_android.h
@@ -45,7 +45,6 @@ enum ANDROID_WIFI_CMD {
 	ANDROID_WIFI_CMD_MAX
 };
 
-int rtw_android_cmdstr_to_num(char *cmdstr);
 int rtw_android_priv_cmd(struct net_device *net, struct ifreq *ifr, int cmd);
 
 #endif /* __RTW_ANDROID_H__ */
diff --git a/drivers/staging/rtl8188eu/os_dep/rtw_android.c b/drivers/staging/rtl8188eu/os_dep/rtw_android.c
index f1470ac56874..99475be30702 100644
--- a/drivers/staging/rtl8188eu/os_dep/rtw_android.c
+++ b/drivers/staging/rtl8188eu/os_dep/rtw_android.c
@@ -52,7 +52,7 @@ struct android_wifi_priv_cmd {
 	int total_len;
 };
 
-int rtw_android_cmdstr_to_num(char *cmdstr)
+static int rtw_android_cmdstr_to_num(char *cmdstr)
 {
 	int cmd_num;
 
-- 
2.20.1

