Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC3AE3DA371
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 14:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237353AbhG2Myx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 08:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237242AbhG2Myc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 08:54:32 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBA2C061798
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 05:54:20 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r2so6858528wrl.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 05:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sojLm/OhjX4jzl+CwB8PAyfGWgokmWWvVfhI8e4IKfE=;
        b=h5hUX2zAHlgXlLgtDuzcJWrGe1s4S8nTN4bHSXzO4YxkCoa/ssdI7ZUt0npehg+fV4
         r+4JWhJyqR1N78lG2Ct8zaPMe9hM4tCofg1aCKWHRKFDuSPQNfHNaJNgEm/8CdZBu3mI
         zPl7OWqDTjmZ7CH0IFckEM+XS9faiZeNUFk4Ilm5mx6oc5dvpm2F5Xt4KyQakjZMNGpI
         JVMqJ0vRBrW6Z0MoQdkqxsYAyH6yJ8wqlD9lJXg+Pb9wvdxiVtCK3CRDjvIe/uFCDlRy
         YI5X76WrLvTyXbUj+gv37uMmMjiVGnLTm9LtzzBc89SCYPTz7LyjQIq11TV7xM4ebu3r
         kTLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sojLm/OhjX4jzl+CwB8PAyfGWgokmWWvVfhI8e4IKfE=;
        b=rRhvc4SW8AvS2pkyeqyzfwXiO3nXCFDaQi2NzkXeT0Pcxsg4Dw70mWnEUsJ35UyYEC
         /GjDc+f/h/0+SsWjYhBy2MISu0Lu+a4KbSKbdAUZVV0ZElgUCK1nSjPwJg/cmNSSpE4L
         rtD2uTKOWEWPXDzkVS21Mj+AD4tXpr/KmetFbm2Z0hQQCuSebjV+QNpY71MNyK5p7aQ1
         I3TtwI6NHznH3apkmZYTTFOr0+njz2gco5D+JsrDCWGNhI4H/IORtwIQFFbZZiHXA115
         0hoiCvEFJXQQUXWDsqcH+XRU79zAmyuN+ROwYGeDtmU+nxVnmYxiNGmLE2Cu5hMT2IQR
         CRGg==
X-Gm-Message-State: AOAM530uRvIqQt8A90RdbzWOwsm30rxuvIJwMfs1MrIk9GKYvH300Irx
        44dJdg3UdY/0S86fXMTMy84Yjjn3xzU=
X-Google-Smtp-Source: ABdhPJz0akrNVSl7x+MyGwUD3d8Ebq3UGQsTid5gKG7puHLNuj1uMJDcbPJSxWlyENV/o29X/2gAhA==
X-Received: by 2002:adf:ea41:: with SMTP id j1mr4687602wrn.147.1627563259338;
        Thu, 29 Jul 2021 05:54:19 -0700 (PDT)
Received: from agape ([5.171.73.68])
        by smtp.gmail.com with ESMTPSA id h15sm3191183wrq.88.2021.07.29.05.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 05:54:19 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: remove unused BT static variables
Date:   Thu, 29 Jul 2021 14:54:17 +0200
Message-Id: <20210729125417.4380-1-fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove some unused static variables. One of them
is used to toggle on the BT coexistence mechanism,
but it is always enabled and it's not conditioned
to the value of the related parameter.

Remove unused field of the registry_priv struct as
well, they were intended for hosting the parameters
this patch rids.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/drv_types.h |  4 ----
 drivers/staging/rtl8723bs/os_dep/os_intfs.c   | 10 ----------
 2 files changed, 14 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/drv_types.h b/drivers/staging/rtl8723bs/include/drv_types.h
index 895c41526164..d49009c75d2e 100644
--- a/drivers/staging/rtl8723bs/include/drv_types.h
+++ b/drivers/staging/rtl8723bs/include/drv_types.h
@@ -139,10 +139,6 @@ struct registry_priv {
 
 	u8 channel_plan;
 
-	u8 btcoex;
-	u8 bt_iso;
-	u8 bt_sco;
-	u8 bt_ampdu;
 	s8	ant_num;
 
 	/* false:Reject AP's Add BA req, true:accept AP's Add BA req */
diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index b042df319c98..7359f0861cce 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -95,12 +95,6 @@ static int rtw_low_power;
 static int rtw_wifi_spec;
 static int rtw_channel_plan = RT_CHANNEL_DOMAIN_MAX;
 
-static int rtw_btcoex_enable = 1;
-module_param(rtw_btcoex_enable, int, 0644);
-MODULE_PARM_DESC(rtw_btcoex_enable, "Enable BT co-existence mechanism");
-static int rtw_bt_iso = 2;/*  0:Low, 1:High, 2:From Efuse */
-static int rtw_bt_sco = 3;/*  0:Idle, 1:None-SCO, 2:SCO, 3:From Counter, 4.Busy, 5.OtherBusy */
-static int rtw_bt_ampdu = 1 ;/*  0:Disable BT control A-MPDU, 1:Enable BT control A-MPDU. */
 static int rtw_ant_num = -1; /*  <0: undefined, >0: Antenna number */
 module_param(rtw_ant_num, int, 0644);
 MODULE_PARM_DESC(rtw_ant_num, "Antenna number setting");
@@ -263,10 +257,6 @@ static void loadparam(struct adapter *padapter, struct net_device *pnetdev)
 
 	registry_par->channel_plan = (u8)rtw_channel_plan;
 
-	registry_par->btcoex = (u8)rtw_btcoex_enable;
-	registry_par->bt_iso = (u8)rtw_bt_iso;
-	registry_par->bt_sco = (u8)rtw_bt_sco;
-	registry_par->bt_ampdu = (u8)rtw_bt_ampdu;
 	registry_par->ant_num = (s8)rtw_ant_num;
 
 	registry_par->accept_addba_req = true;
-- 
2.20.1

