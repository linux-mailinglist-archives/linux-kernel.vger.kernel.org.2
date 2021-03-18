Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0982A3408DF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 16:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbhCRP1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 11:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbhCRP1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 11:27:18 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B35C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 08:27:17 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id p19so3830594wmq.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 08:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qLUU1s8kRWxcJ8qSEAxAw8lK0hzJa5M0nSsIsfK6i4Q=;
        b=rYNAA/V3Afy04iivf60eNGzlRgIcMtegewrD7WrKf3Z6Aag3x04fraob0bxYfXXXA8
         HA+xVSPW2RE9vboeVcWxbWhba0esjgoELFi+1+LzMnjso+Z3HiOdqLYU2cJDwezxGad9
         5iDDfAIOKEGC5617ytomAKDuZcE0EvgQdO7SUtIz4jNKJI7MMTOZ4vWR/ZENvO5FrwcU
         o0K+BQFt4COovLK2QWzcLttc961ceg2UWjzGkNub5XS5j5x3HUad5YHppAXgZzwMcQ8q
         dPobLq3vx2VAxlF33Z9X2ruJ03cxMfwGxHn1uSnFcknwL8ulsj4oBfKFsK6kHCHiKNly
         j0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qLUU1s8kRWxcJ8qSEAxAw8lK0hzJa5M0nSsIsfK6i4Q=;
        b=FY6nIrtMX1LDkalhxUv35/Kw4DDVMyKgMQMAjmsYt8ijzDsH6JM/Bq0NIFVmBYQ6bd
         Tgu/Rbkm2EAxQXVLYO+Ll5Etgc+gYGElSpYe9ZiLkU/lmJsNUvoRmaXQVMaeUBOpa2fZ
         kI0/Yt5mvYbelSD+DngWPFvgyDTmPDuCB2bjXiOWJkfYISfz8W6P712/GAY2D4ZNjLDk
         Oq/hD07QLFFbBm8N0yvny0CWPK5YQSEegJxaACorCVXyqOU8YARudae5UnsFUqupXYM+
         qW/HMYnKd7h/2RGgoMirurDO2WVG1/C0Gz32jqDMNnVJjfgzJQmo8Vu7H8cSMlySB282
         g9ew==
X-Gm-Message-State: AOAM531xrLMDVe9nTA50CTXTEiAOngiyMsRaZ7eGQwuiEsFJ+XToahLQ
        mUjC0gOy93y1n0tKeSmBygk=
X-Google-Smtp-Source: ABdhPJzUu0235LltzmzUgpzF+krQtLvZN9FARDVjYF0jMCc1/9SkQUCURGIp38+xRw04HcfoH2TXUw==
X-Received: by 2002:a05:600c:4ba2:: with SMTP id e34mr4198375wmp.121.1616081236223;
        Thu, 18 Mar 2021 08:27:16 -0700 (PDT)
Received: from agape ([151.46.162.59])
        by smtp.gmail.com with ESMTPSA id i8sm2392173wmi.6.2021.03.18.08.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 08:27:15 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 13/15] staging: rtl8723bs: remove unnecessary logging in os_dep/ioctl_linux.c
Date:   Thu, 18 Mar 2021 16:26:08 +0100
Message-Id: <20210318152610.16758-14-fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210318152610.16758-1-fabioaiuto83@gmail.com>
References: <YFMb+7jjmj7Oty8B@kroah.com>
 <20210318152610.16758-1-fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following checkpatch.pl issues:

WARNING: Unnecessary ftrace-like logging - prefer using ftrace
1207: FILE: drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:1207:
+	DBG_871X("%s\n", __func__);
--
WARNING: Unnecessary ftrace-like logging - prefer using ftrace
1507: FILE: drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:1507:
+	DBG_871X("=>%s\n", __func__);
--
WARNING: Unnecessary ftrace-like logging - prefer using ftrace
3390: FILE: drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:3390:
+	DBG_871X("%s\n", __func__);
--
WARNING: Unnecessary ftrace-like logging - prefer using ftrace
3687: FILE: drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:3687:
+	DBG_871X("%s\n", __func__);
--
WARNING: Unnecessary ftrace-like logging - prefer using ftrace
4143: FILE: drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:4143:
+	/* DBG_871X("%s\n", __func__); */

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index aac1391bdbf1..590da76e9e8e 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -1204,8 +1204,6 @@ static int rtw_wx_set_mlme(struct net_device *dev,
 	if (mlme == NULL)
 		return -1;
 
-	DBG_871X("%s\n", __func__);
-
 	reason = mlme->reason_code;
 
 	DBG_871X("%s, cmd =%d, reason =%d\n", __func__, mlme->cmd, reason);
@@ -1504,7 +1502,6 @@ static int rtw_wx_set_essid(struct net_device *dev,
 	}
 
 	authmode = padapter->securitypriv.ndisauthtype;
-	DBG_871X("=>%s\n", __func__);
 	if (wrqu->essid.flags && wrqu->essid.length) {
 		len = (wrqu->essid.length < IW_ESSID_MAX_SIZE) ? wrqu->essid.length : IW_ESSID_MAX_SIZE;
 
@@ -3387,8 +3384,6 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 	struct security_priv *psecuritypriv = &(padapter->securitypriv);
 	struct sta_priv *pstapriv = &padapter->stapriv;
 
-	DBG_871X("%s\n", __func__);
-
 	param->u.crypt.err = 0;
 	param->u.crypt.alg[IEEE_CRYPT_ALG_NAME_LEN - 1] = '\0';
 
@@ -3684,8 +3679,6 @@ static void rtw_hostapd_sta_flush(struct net_device *dev)
 	struct adapter *padapter = rtw_netdev_priv(dev);
 	/* struct sta_priv *pstapriv = &padapter->stapriv; */
 
-	DBG_871X("%s\n", __func__);
-
 	flush_all_cam_entry(padapter);	/* clear CAM */
 
 	rtw_sta_flush(padapter);
@@ -4140,8 +4133,6 @@ static int rtw_hostapd_ioctl(struct net_device *dev, struct iw_point *p)
 	int ret = 0;
 	struct adapter *padapter = rtw_netdev_priv(dev);
 
-	/* DBG_871X("%s\n", __func__); */
-
 	/*
 	* this function is expect to call in master mode, which allows no power saving
 	* so, we just check hw_init_completed
-- 
2.20.1

