Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3E2427B61
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 17:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234462AbhJIPlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 11:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234106AbhJIPlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 11:41:16 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C253C061570
        for <linux-kernel@vger.kernel.org>; Sat,  9 Oct 2021 08:39:19 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id 187so10729520pfc.10
        for <linux-kernel@vger.kernel.org>; Sat, 09 Oct 2021 08:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=xn3cZFmsRkEBphig5j0Fjp/Shbu/DV7lATpJ+tppRws=;
        b=I65/gN9VXJyrTgtS9X2dyUj2il1coHyZyab1Wy4IojdCqRUWrytic7fYUURUp2ljaV
         g3DkawOXbe2ClE2ta1jdpPKZX239GAq1dP5OJ9xPumNmP9xcJkkv/oChtWNbUeBb5S3w
         OY86igjXcsIixfzDakmLK/8ShFAyu5zLw4K1rIZs7jvEzVM35fnwtWBY4kLcO/rPEyUc
         HZaTgiPk1m+Mc8SKZO3IX1xA2xM8S0c1Y+1B8uwbdYGkhWZF2FSwac0Rra9ZeusEWcPi
         aADR758y7cT4Mg47QuPR21cNe5oMzl3ud9sCf+jbUIaNqWB8x8vG9JWvK8A97sZxIvYV
         3xSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=xn3cZFmsRkEBphig5j0Fjp/Shbu/DV7lATpJ+tppRws=;
        b=0wzHrlMl3+qEwmof7rnYVbgfOxr52hySmXPlGzb0oQoSz0k4HGiC04lJRM1HTo85mG
         kAbr4bje0VkSIQWkjmDflPzfy6akp3yacDZ6D68hgDZ5wmViECJSBpiF1AG+eJAdReLs
         2e0wt9eoHiOjZbyadE7AeJW3j0ReG8zjBA+izID3XbdgT9fn02QKSiCjnFLT9aP94Ufa
         UPNKY2JV4PMLVNFZeQQdP7oOH/RCIhOGQGllTgPs5BfKyT0/GGvr3ccSduZHc3xqeQDV
         OOxngUvUybWyGcQIioEA0i5pwVik4mROGXifD9IEC/PJZG5aIIl5ehvf531z0KP14yUs
         +Fmg==
X-Gm-Message-State: AOAM530Ew1f3a2b92dQBgpnWw4QyZ3vO1BR2+SGHNggapD4jlOAmffwf
        XLGJ239t5auXiavXUPLTwsErYSlw74s=
X-Google-Smtp-Source: ABdhPJy37wMBE/ZvwJCG4r4p1qVkUAyHu1kF4A5stn8oRkLvqOd3NOPV7yICAlD+ybVTepC9IIdFAw==
X-Received: by 2002:a63:b04c:: with SMTP id z12mr9923338pgo.371.1633793958266;
        Sat, 09 Oct 2021 08:39:18 -0700 (PDT)
Received: from user ([223.230.43.197])
        by smtp.gmail.com with ESMTPSA id a17sm2730058pfd.54.2021.10.09.08.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Oct 2021 08:39:17 -0700 (PDT)
Date:   Sat, 9 Oct 2021 21:09:12 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, marcocesati@gmail.com,
        insafonov@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] staging: rtl8723bs: os_dep: simplify the return statement.
Message-ID: <YWG3oIchovDZnPl8@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unneeded and redundant check of variable on goto out.
Simplify the return using multiple goto label to avoid
unneeded check.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 29 ++++++++++---------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 0868f56e2979..574fdb6adce7 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -2282,18 +2282,18 @@ static int rtw_cfg80211_add_monitor_if(struct adapter *padapter, char *name, str

 	if (!name) {
 		ret = -EINVAL;
-		goto out;
+		goto err_out;
 	}

 	if (pwdev_priv->pmon_ndev) {
 		ret = -EBUSY;
-		goto out;
+		goto err_out;
 	}

 	mon_ndev = alloc_etherdev(sizeof(struct rtw_netdev_priv_indicator));
 	if (!mon_ndev) {
 		ret = -ENOMEM;
-		goto out;
+		goto err_out;
 	}

 	mon_ndev->type = ARPHRD_IEEE80211_RADIOTAP;
@@ -2312,7 +2312,7 @@ static int rtw_cfg80211_add_monitor_if(struct adapter *padapter, char *name, str
 	mon_wdev = rtw_zmalloc(sizeof(struct wireless_dev));
 	if (!mon_wdev) {
 		ret = -ENOMEM;
-		goto out;
+		goto err_zmalloc;
 	}

 	mon_wdev->wiphy = padapter->rtw_wdev->wiphy;
@@ -2322,22 +2322,23 @@ static int rtw_cfg80211_add_monitor_if(struct adapter *padapter, char *name, str

 	ret = cfg80211_register_netdevice(mon_ndev);
 	if (ret) {
-		goto out;
+		goto err_register;
 	}

 	*ndev = pwdev_priv->pmon_ndev = mon_ndev;
 	memcpy(pwdev_priv->ifname_mon, name, IFNAMSIZ+1);

-out:
-	if (ret && mon_wdev) {
-		kfree(mon_wdev);
-		mon_wdev = NULL;
-	}
+err_register:

-	if (ret && mon_ndev) {
-		free_netdev(mon_ndev);
-		*ndev = mon_ndev = NULL;
-	}
+	kfree(mon_wdev);
+	mon_wdev = NULL;
+
+err_zmalloc:
+
+	free_netdev(mon_ndev);
+	*ndev = mon_ndev = NULL;
+
+err_out:

 	return ret;
 }
--
2.32.0

