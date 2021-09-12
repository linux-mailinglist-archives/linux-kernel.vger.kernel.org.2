Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1057F407EE4
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 19:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234916AbhILRRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 13:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbhILRRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 13:17:33 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91691C061574
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 10:16:19 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id f11-20020a17090aa78b00b0018e98a7cddaso4842643pjq.4
        for <linux-kernel@vger.kernel.org>; Sun, 12 Sep 2021 10:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=lGLbYa4J/EZXe/PrXpmfquP6UQajacndX8DduSJkb9I=;
        b=YKgvivWauINumj3NILs+WLOWbIwfwmfzzsGXuXDnJPQqYcnSxtH4EOfNB/Lk2lXbe7
         MfsY+o63JXNAugUbkqfy4CpTFV/TuJz9A59QUfUqJ9MANUKEDj48UIYCUZRIec1sqA0J
         KOYXmeHxJIc/GPa1oW2K/Crsn5yR0N8N9c8GOsAJyWqWGDK0YenCCLSW4j9Tp1QZD1n6
         NWpCr+1z145CftO0/VHxTxJlb6vknLt+gCIjvklTWqhsnBKalWIE15sJaWjgVTbvWRW6
         wBbylM7CEU9azHaU7HVIG3KWwtPVJ/DtLEz/IajS+8IaZp07nKWsraFIeNjxA8Mz0w00
         Xx1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=lGLbYa4J/EZXe/PrXpmfquP6UQajacndX8DduSJkb9I=;
        b=X1hK8M96lwNiX6Zf2HXY07scpfh/Vr0u3WBlp0UODwVoC6zLN4/D/Omd1zUTRjlPrZ
         yAmgmXV9iU2DIt3a9jBhx0Q3OPXTthxRE+xdSAyGgJuqPQnfyiTM5M4dnRECIyTMOR/u
         jEiwqppAY/LQxV/lHDKlEJ6bpYeahaLYTWdBoBQCCVxtIX61y+GopEqeKij/5bWFQ50D
         8D6WduvUgs7ijJSczhjyHMhXGRp5XEsD6/pnH9RpRHsbWk9oXiLBBbcihCRUdls8JnxD
         I0MdhfkAEtEA51wcK+++Wg9sC44uueE6//RbyPu4gSqmHkQL0IWy+mbzKwFl39TM8QCo
         xFug==
X-Gm-Message-State: AOAM533uZGJ0R3n+c/9q/D7Zo4Hb4q+j3xqvWW+6mbhdf/nCY3iqQ4un
        v2LRG7nxQ/+n7HIxIoSiitPhJlBiNZ7AHQ==
X-Google-Smtp-Source: ABdhPJylQoKi0ZxmxC2e0StkTbXR+jRJ+5OR03VmEzNksdJmKqx5Vc7/15HSo7BWhZPgjFpIGkvhHA==
X-Received: by 2002:a17:902:b909:b0:13a:2d8e:12bc with SMTP id bf9-20020a170902b90900b0013a2d8e12bcmr6839890plb.6.1631466979027;
        Sun, 12 Sep 2021 10:16:19 -0700 (PDT)
Received: from user ([117.98.200.228])
        by smtp.gmail.com with ESMTPSA id d3sm4395494pjc.49.2021.09.12.10.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 10:16:18 -0700 (PDT)
Date:   Sun, 12 Sep 2021 22:46:12 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, martin@kaiser.cx,
        saurav.girepunje@gmail.com, straube.linux@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] staging: r8188eu: os_dep: remove unused function
 rtw_android_priv_cmd
Message-ID: <YT413EaBXqIqMttS@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused function rtw_android_priv_cmd.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/staging/r8188eu/include/rtw_android.h |   1 -
 drivers/staging/r8188eu/os_dep/rtw_android.c  | 138 ------------------
 2 files changed, 139 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtw_android.h b/drivers/staging/r8188eu/include/rtw_android.h
index f60cf1c82984..86e3ac5f7955 100644
--- a/drivers/staging/r8188eu/include/rtw_android.h
+++ b/drivers/staging/r8188eu/include/rtw_android.h
@@ -42,6 +42,5 @@ enum ANDROID_WIFI_CMD {
 };

 int rtw_android_cmdstr_to_num(char *cmdstr);
-int rtw_android_priv_cmd(struct net_device *net, struct ifreq *ifr, int cmd);

 #endif /* __RTW_ANDROID_H__ */
diff --git a/drivers/staging/r8188eu/os_dep/rtw_android.c b/drivers/staging/r8188eu/os_dep/rtw_android.c
index 010d529c8982..bd76177d60f9 100644
--- a/drivers/staging/r8188eu/os_dep/rtw_android.c
+++ b/drivers/staging/r8188eu/os_dep/rtw_android.c
@@ -133,141 +133,3 @@ static int rtw_android_set_block(struct net_device *net, char *command,
 	return 0;
 }

-int rtw_android_priv_cmd(struct net_device *net, struct ifreq *ifr, int cmd)
-{
-	int ret = 0;
-	char *command = NULL;
-	int cmd_num;
-	int bytes_written = 0;
-	struct android_wifi_priv_cmd priv_cmd;
-
-	if (!ifr->ifr_data) {
-		ret = -EINVAL;
-		goto exit;
-	}
-	if (copy_from_user(&priv_cmd, ifr->ifr_data,
-			   sizeof(struct android_wifi_priv_cmd))) {
-		ret = -EFAULT;
-		goto exit;
-	}
-	command = kmalloc(priv_cmd.total_len, GFP_KERNEL);
-	if (!command) {
-		DBG_88E("%s: failed to allocate memory\n", __func__);
-		ret = -ENOMEM;
-		goto exit;
-	}
-	if (!access_ok(priv_cmd.buf, priv_cmd.total_len)) {
-		DBG_88E("%s: failed to access memory\n", __func__);
-		ret = -EFAULT;
-		goto exit;
-	}
-	if (copy_from_user(command, (char __user *)priv_cmd.buf,
-			   priv_cmd.total_len)) {
-		ret = -EFAULT;
-		goto exit;
-	}
-	DBG_88E("%s: Android private cmd \"%s\" on %s\n",
-		__func__, command, ifr->ifr_name);
-	cmd_num = rtw_android_cmdstr_to_num(command);
-	switch (cmd_num) {
-	case ANDROID_WIFI_CMD_START:
-		goto response;
-	case ANDROID_WIFI_CMD_SETFWPATH:
-		goto response;
-	}
-	if (!g_wifi_on) {
-		DBG_88E("%s: Ignore private cmd \"%s\" - iface %s is down\n",
-			__func__, command, ifr->ifr_name);
-		ret = 0;
-		goto exit;
-	}
-	switch (cmd_num) {
-	case ANDROID_WIFI_CMD_STOP:
-		break;
-	case ANDROID_WIFI_CMD_SCAN_ACTIVE:
-		break;
-	case ANDROID_WIFI_CMD_SCAN_PASSIVE:
-		break;
-	case ANDROID_WIFI_CMD_RSSI:
-		bytes_written = rtw_android_get_rssi(net, command,
-						     priv_cmd.total_len);
-		break;
-	case ANDROID_WIFI_CMD_LINKSPEED:
-		bytes_written = rtw_android_get_link_speed(net, command,
-							   priv_cmd.total_len);
-		break;
-	case ANDROID_WIFI_CMD_MACADDR:
-		bytes_written = rtw_android_get_macaddr(net, command,
-							priv_cmd.total_len);
-		break;
-	case ANDROID_WIFI_CMD_BLOCK:
-		bytes_written = rtw_android_set_block(net, command,
-						      priv_cmd.total_len);
-		break;
-	case ANDROID_WIFI_CMD_RXFILTER_START:
-		break;
-	case ANDROID_WIFI_CMD_RXFILTER_STOP:
-		break;
-	case ANDROID_WIFI_CMD_RXFILTER_ADD:
-		break;
-	case ANDROID_WIFI_CMD_RXFILTER_REMOVE:
-		break;
-	case ANDROID_WIFI_CMD_BTCOEXSCAN_START:
-		/* TBD: BTCOEXSCAN-START */
-		break;
-	case ANDROID_WIFI_CMD_BTCOEXSCAN_STOP:
-		/* TBD: BTCOEXSCAN-STOP */
-		break;
-	case ANDROID_WIFI_CMD_BTCOEXMODE:
-		break;
-	case ANDROID_WIFI_CMD_SETSUSPENDOPT:
-		break;
-	case ANDROID_WIFI_CMD_SETBAND:
-		break;
-	case ANDROID_WIFI_CMD_GETBAND:
-		break;
-	case ANDROID_WIFI_CMD_COUNTRY:
-		bytes_written = android_set_cntry(net, command,
-						  priv_cmd.total_len);
-		break;
-	case ANDROID_WIFI_CMD_P2P_DEV_ADDR:
-		bytes_written = android_get_p2p_addr(net, command,
-						     priv_cmd.total_len);
-		break;
-	case ANDROID_WIFI_CMD_P2P_SET_NOA:
-		break;
-	case ANDROID_WIFI_CMD_P2P_GET_NOA:
-		break;
-	case ANDROID_WIFI_CMD_P2P_SET_PS:
-		break;
-	default:
-		DBG_88E("Unknown PRIVATE command %s - ignored\n", command);
-		snprintf(command, 3, "OK");
-		bytes_written = strlen("OK");
-	}
-
-response:
-	if (bytes_written >= 0) {
-		if ((bytes_written == 0) && (priv_cmd.total_len > 0))
-			command[0] = '\0';
-		if (bytes_written >= priv_cmd.total_len) {
-			DBG_88E("%s: bytes_written = %d\n", __func__,
-				bytes_written);
-			bytes_written = priv_cmd.total_len;
-		} else {
-			bytes_written++;
-		}
-		priv_cmd.used_len = bytes_written;
-		if (copy_to_user((char __user *)priv_cmd.buf, command,
-				 bytes_written)) {
-			DBG_88E("%s: failed to copy data to user buffer\n",
-				__func__);
-			ret = -EFAULT;
-		}
-	} else {
-		ret = bytes_written;
-	}
-exit:
-	kfree(command);
-	return ret;
-}
--
2.32.0

