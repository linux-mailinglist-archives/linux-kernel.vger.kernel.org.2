Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 506CC415104
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237558AbhIVUHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237528AbhIVUHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:07:20 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BD4C061756
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:05:46 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id t8so10455008wrq.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zh1EhUp+ycwtcdOHHKSBFQNu3WOK1cxrbNQKyf+vALE=;
        b=buyLhCHcC5TiizRXCFyi8m4UgO8p5y/cWv3Ej7Kfsg0te5iEMVh8U5MtFyF+xKmKaF
         YCD9o6tNdpEJIPUUyFPjpaSpz957me08apgEJhTXi89Id9a420xeQ+5uscJO78dUk/PR
         hOef2ZM/ryQoof3LBf8E43Nze4JQclN0x0DyX3hwAp3FGRZp9NIFVmD0cQ0k9Ji/lxRJ
         HgCN2aXSHkV23/KKRqQw2yYoT98897lLPl7ONHFlODdvgb46OhrDx+zia7U1lZMqWed+
         ChHPqk5AejgibBhSNbga62Kyr/yQkHbpOpiIgQuVSXSLQpBl1ty7un+3JMJepZQO2Xt/
         lQOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zh1EhUp+ycwtcdOHHKSBFQNu3WOK1cxrbNQKyf+vALE=;
        b=u9fGEAvdoDDRmpfrnxyszBFjDke+p7QvUt5N5emG+ZmvHLdPqxI0o8j4hpO+pwOwl5
         Fh3PIXl9g0v9H3HTDTLPoE+BSuDwNsN81DLFpEc7VSHzstSHwYWyfS/BhL+t8ShNhF6R
         i91fxDhObS8OkNYZzBZVY7gTDOmuOZhV1FQ6SFIKPUZBH/gy7MXgMYlRnFTpdFRuuEJG
         ztsTO+GYPoK21NhP1sip1c5JgweRuTqKhxi6dANys3Wluzo9VmbC/H95Fn/XYdEGV09a
         f7Z3PQWwKKYhGY3/dcUXzWXNIT9lPft6MhLwcDmZtS+gO8plnsP8jcKPA5OtwdKEOtQN
         JyiA==
X-Gm-Message-State: AOAM531oslx/Dg+Ef45c7h8AHdAeioIvd+O06YDVRFlPMYV5EjXBH07W
        Y0jYRyR5MGx+UTThJMjl1ehmsmwsMlNprQ==
X-Google-Smtp-Source: ABdhPJy1/ABTBMiMCcSz98DxMbx61Ero9ZfOVemg6521R4LaOCkgqkRjtuxNB/Q2bhufqEQETA8oCA==
X-Received: by 2002:a7b:ce16:: with SMTP id m22mr874456wmc.172.1632341144831;
        Wed, 22 Sep 2021 13:05:44 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id e2sm3219761wra.40.2021.09.22.13.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 13:05:44 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 20/47] staging: r8188eu: remove rtw_set_802_11_remove_wep()
Date:   Wed, 22 Sep 2021 22:03:53 +0200
Message-Id: <20210922200420.9693-21-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210922200420.9693-1-straube.linux@gmail.com>
References: <20210922200420.9693-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rtw_set_802_11_remove_wep() is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ioctl_set.c  | 25 -------------------
 .../staging/r8188eu/include/rtw_ioctl_set.h   |  1 -
 2 files changed, 26 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ioctl_set.c b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
index 219d579a853f..9b083829fffa 100644
--- a/drivers/staging/r8188eu/core/rtw_ioctl_set.c
+++ b/drivers/staging/r8188eu/core/rtw_ioctl_set.c
@@ -467,31 +467,6 @@ u8 rtw_set_802_11_add_wep(struct adapter *padapter, struct ndis_802_11_wep *wep)
 	return ret;
 }
 
-u8 rtw_set_802_11_remove_wep(struct adapter *padapter, u32 keyindex)
-{
-	u8 ret = _SUCCESS;
-
-	if (keyindex >= 0x80000000 || !padapter) {
-		ret = false;
-		goto exit;
-	} else {
-		int res;
-		struct security_priv *psecuritypriv = &padapter->securitypriv;
-		if (keyindex < 4) {
-			memset(&psecuritypriv->dot11DefKey[keyindex], 0, 16);
-			res = rtw_set_key(padapter, psecuritypriv, keyindex, 0);
-			psecuritypriv->dot11DefKeylen[keyindex] = 0;
-			if (res == _FAIL)
-				ret = _FAIL;
-		} else {
-			ret = _FAIL;
-		}
-	}
-exit:
-
-	return ret;
-}
-
 /*
 * rtw_get_cur_max_rate -
 * @adapter: pointer to struct adapter structure
diff --git a/drivers/staging/r8188eu/include/rtw_ioctl_set.h b/drivers/staging/r8188eu/include/rtw_ioctl_set.h
index 6203f49f8bf7..5114d217a3d9 100644
--- a/drivers/staging/r8188eu/include/rtw_ioctl_set.h
+++ b/drivers/staging/r8188eu/include/rtw_ioctl_set.h
@@ -18,7 +18,6 @@ u8 rtw_set_802_11_bssid_list_scan(struct adapter*adapter,
 				  int ssid_max_num);
 u8 rtw_set_802_11_infrastructure_mode(struct adapter *adapter,
 				      enum ndis_802_11_network_infra type);
-u8 rtw_set_802_11_remove_wep(struct adapter *adapter, u32 keyindex);
 u8 rtw_set_802_11_ssid(struct adapter *adapt, struct ndis_802_11_ssid *ssid);
 u8 rtw_validate_ssid(struct ndis_802_11_ssid *ssid);
 u16 rtw_get_cur_max_rate(struct adapter *adapter);
-- 
2.33.0

