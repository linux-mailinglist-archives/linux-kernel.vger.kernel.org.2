Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3DF357F1A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 11:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhDHJ1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 05:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbhDHJ1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 05:27:43 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F22CC061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 02:27:32 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id a6so1342052wrw.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 02:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=48C+aUCAw/5HBSrI0DJTgDCws6FWqJvlhCmFPj8c4MI=;
        b=fd8IaLe41wlZZv9dP+GV7sa9CXRatY01hhpcOKJlIQo/og1CChBl4MUMKjGO3xHfFX
         nQG0eNCsJEYkfSXJRMQx1eyGV1kka7zBfTmwUNgPIFb7YwKq8PfVgWtFLuGX82kcB1fk
         mj+UmRtvVEAUyUNTPvbp+0g1VsKHVqIsXma15bayJkUWwpLcb9tYcYj5uqbdlFtBmedK
         Y5hbovH3J+xov4/NyJOzkl3PAKP44ifvm6vRv4LVOxhgEY8hCavE78eCCt2IDkgUWF5L
         4NdDw5P7qEAhM/RG0UFFxtnH9J0pEHv0v/sNszp7q1EV/ZVEvz6s60S0CGpkqNpYVJtQ
         t6IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=48C+aUCAw/5HBSrI0DJTgDCws6FWqJvlhCmFPj8c4MI=;
        b=n1CBDkEVxhtE83+gHU/gTnTsIyrsp+DTIiaUlDNTW/EMS333ryvfoDGTULbDk1J9Mg
         hfS7lHxLtunqdXPaZhYg8KO727I5DM00x/UABBK6mzIGoHp2b+TatDU297ufaR/GekU1
         2o9LZuetls9J0phWSFxD9yfuZMXQdW0uiFqZoN4sld7NfW8j1mf/j6deo7sxtrZhB7jN
         6s6hD2hcNe+ETHZmCWObN1dRiV1EVW26zPI7EAFs/SRHQQSjjC35s8zMeYnLyNAUdZbS
         b73wIFoBmupmNY7cJgMM/njz8QcT4N4IT9Hu+tEJNDpbZChE4g4FX8sE8HiPqqUxsUpj
         NVBA==
X-Gm-Message-State: AOAM5335KV9Pvit4Qdlm/npE3OMHujwCqa0uzMEZc0g19YTNJuNc2rKN
        844ql6F7iFzuWcjAS0mBYA0=
X-Google-Smtp-Source: ABdhPJwQ4GG0zxk/uzYthI9jgEc+Iub3ZyFz4cvX6uH9x/wIDCFMld9ZPIZhqTJJH0H0fLt/AFnwqA==
X-Received: by 2002:adf:d082:: with SMTP id y2mr9256160wrh.176.1617874051185;
        Thu, 08 Apr 2021 02:27:31 -0700 (PDT)
Received: from agape ([5.171.81.167])
        by smtp.gmail.com with ESMTPSA id n3sm12787844wmi.7.2021.04.08.02.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 02:27:30 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] staging: rtl8723bs: remove unused variables
Date:   Thu,  8 Apr 2021 11:27:02 +0200
Message-Id: <20210408092702.25863-1-fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove declared and assigned unused variables

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_cmd.c      |  3 ---
 .../staging/rtl8723bs/include/rtw_security.h  | 18 -------------
 .../staging/rtl8723bs/os_dep/ioctl_linux.c    | 26 +++----------------
 3 files changed, 3 insertions(+), 44 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index baf8b1e0f43c..e94eb1138cf1 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -387,7 +387,6 @@ int rtw_cmd_thread(void *context)
 	u8 ret;
 	struct cmd_obj *pcmd;
 	u8 *pcmdbuf;
-	unsigned long cmd_start_time;
 	u8 (*cmd_hdl)(struct adapter *padapter, u8 *pbuf);
 	void (*pcmd_callback)(struct adapter *dev, struct cmd_obj *pcmd);
 	struct adapter *padapter = context;
@@ -438,8 +437,6 @@ int rtw_cmd_thread(void *context)
 			continue;
 		}
 
-		cmd_start_time = jiffies;
-
 		if (rtw_cmd_filter(pcmdpriv, pcmd) == _FAIL) {
 			pcmd->res = H2C_DROPPED;
 			goto post_process;
diff --git a/drivers/staging/rtl8723bs/include/rtw_security.h b/drivers/staging/rtl8723bs/include/rtw_security.h
index b71f0959108b..5c787e999aab 100644
--- a/drivers/staging/rtl8723bs/include/rtw_security.h
+++ b/drivers/staging/rtl8723bs/include/rtw_security.h
@@ -332,24 +332,6 @@ static inline u32 rotr(u32 val, int bits)
 /* This is based on SHA256 implementation in LibTomCrypt that was released into
  * public domain by Tom St Denis. */
 
-/* the K array */
-static const unsigned long K[64] = {
-	0x428a2f98UL, 0x71374491UL, 0xb5c0fbcfUL, 0xe9b5dba5UL, 0x3956c25bUL,
-	0x59f111f1UL, 0x923f82a4UL, 0xab1c5ed5UL, 0xd807aa98UL, 0x12835b01UL,
-	0x243185beUL, 0x550c7dc3UL, 0x72be5d74UL, 0x80deb1feUL, 0x9bdc06a7UL,
-	0xc19bf174UL, 0xe49b69c1UL, 0xefbe4786UL, 0x0fc19dc6UL, 0x240ca1ccUL,
-	0x2de92c6fUL, 0x4a7484aaUL, 0x5cb0a9dcUL, 0x76f988daUL, 0x983e5152UL,
-	0xa831c66dUL, 0xb00327c8UL, 0xbf597fc7UL, 0xc6e00bf3UL, 0xd5a79147UL,
-	0x06ca6351UL, 0x14292967UL, 0x27b70a85UL, 0x2e1b2138UL, 0x4d2c6dfcUL,
-	0x53380d13UL, 0x650a7354UL, 0x766a0abbUL, 0x81c2c92eUL, 0x92722c85UL,
-	0xa2bfe8a1UL, 0xa81a664bUL, 0xc24b8b70UL, 0xc76c51a3UL, 0xd192e819UL,
-	0xd6990624UL, 0xf40e3585UL, 0x106aa070UL, 0x19a4c116UL, 0x1e376c08UL,
-	0x2748774cUL, 0x34b0bcb5UL, 0x391c0cb3UL, 0x4ed8aa4aUL, 0x5b9cca4fUL,
-	0x682e6ff3UL, 0x748f82eeUL, 0x78a5636fUL, 0x84c87814UL, 0x8cc70208UL,
-	0x90befffaUL, 0xa4506cebUL, 0xbef9a3f7UL, 0xc67178f2UL
-};
-
-
 /* Various logical functions */
 #define RORc(x, y) \
 (((((unsigned long) (x) & 0xFFFFFFFFUL) >> (unsigned long) ((y) & 31)) | \
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index a9820d813d8b..8d29ca9ba67f 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -33,10 +33,6 @@
 static u32 rtw_rates[] = {1000000, 2000000, 5500000, 11000000,
 	6000000, 9000000, 12000000, 18000000, 24000000, 36000000, 48000000, 54000000};
 
-static const char * const iw_operation_mode[] = {
-	"Auto", "Ad-Hoc", "Managed",  "Master", "Repeater", "Secondary", "Monitor"
-};
-
 void indicate_wx_scan_complete_event(struct adapter *padapter)
 {
 	union iwreq_data wrqu;
@@ -1125,7 +1121,6 @@ static int rtw_wx_set_mlme(struct net_device *dev,
 			     union iwreq_data *wrqu, char *extra)
 {
 	int ret = 0;
-	u16 reason;
 	struct adapter *padapter = rtw_netdev_priv(dev);
 	struct iw_mlme *mlme = (struct iw_mlme *)extra;
 
@@ -1133,8 +1128,6 @@ static int rtw_wx_set_mlme(struct net_device *dev,
 	if (mlme == NULL)
 		return -1;
 
-	reason = mlme->reason_code;
-
 	switch (mlme->cmd) {
 	case IW_MLME_DEAUTH:
 		if (!rtw_set_802_11_disassociate(padapter))
@@ -2440,7 +2433,6 @@ static int rtw_dbg_port(struct net_device *dev,
 	u8 major_cmd, minor_cmd;
 	u16 arg;
 	u32 extra_arg, *pdata, val32;
-	struct sta_info *psta;
 	struct adapter *padapter = rtw_netdev_priv(dev);
 	struct mlme_priv *pmlmepriv = &(padapter->mlmepriv);
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
@@ -2542,15 +2534,7 @@ static int rtw_dbg_port(struct net_device *dev,
 
 					break;
 				case 0x05:
-					psta = rtw_get_stainfo(pstapriv, cur_network->network.MacAddress);
-					if (psta) {
-						int i;
-						struct recv_reorder_ctrl *preorder_ctrl;
-
-						for (i = 0; i < 16; i++)
-							preorder_ctrl = &psta->recvreorder_ctrl[i];
-
-					}
+					rtw_get_stainfo(pstapriv, cur_network->network.MacAddress);
 					break;
 				case 0x06:
 					{
@@ -2568,9 +2552,8 @@ static int rtw_dbg_port(struct net_device *dev,
 					break;
 				case 0x09:
 					{
-						int i, j;
+						int i;
 						struct list_head	*plist, *phead;
-						struct recv_reorder_ctrl *preorder_ctrl;
 
 						spin_lock_bh(&pstapriv->sta_hash_lock);
 
@@ -2579,13 +2562,10 @@ static int rtw_dbg_port(struct net_device *dev,
 							plist = get_next(phead);
 
 							while (phead != plist) {
-								psta = container_of(plist, struct sta_info, hash_list);
+								container_of(plist, struct sta_info, hash_list);
 
 								plist = get_next(plist);
 
-								if (extra_arg == psta->aid)
-									for (j = 0; j < 16; j++)
-										preorder_ctrl = &psta->recvreorder_ctrl[j];
 							}
 						}
 
-- 
2.20.1

