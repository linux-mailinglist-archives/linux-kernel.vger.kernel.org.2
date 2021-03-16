Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F8E33D5B5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 15:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236302AbhCPO2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 10:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236318AbhCPO13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 10:27:29 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134BFC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 07:27:28 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id v4so7541362wrp.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 07:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Z3y9Zt05eK/x4XAYQw9778IfbN4rttihbJa5pQKUfZI=;
        b=JBZIpUDC9/kFh5/1HRjgB889/7vKTDhSvIKCclKU5oCICW69+zvL1PT2xKU93fKoSa
         HDKHiY1UPz+mNG+r0MmH56e/4f7oO7OtxrrpxgELE2TMrxV4rx9jjAA9/OgjKK0EdiZ3
         VwUexPeDo0o0jJ0J5gOYUYCaZBAHannVvHEs0JkayCjGU+IGu8xiIG1wP8AweDdepC+m
         M3txz113EypgWxVPCjs9N0kqqKDZqZBcUW2c3rsoioU+k5Xpyh/PPNESRMhdhY0KCAiY
         CJxHfE/5tum7Lzu9GVRXJ9CKVb0IN9i7HtCj8z/6uSxKMxT1/65mAzH1lHb8359xta3F
         lgkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Z3y9Zt05eK/x4XAYQw9778IfbN4rttihbJa5pQKUfZI=;
        b=Vr8ADp+k4ScnpBVMd8Qse9HFSwmv2lLve9G8z7z6c+v0MLjQlM3Kkg5ZHzOKQDKxij
         Q1cN73SDiVeWa8UXsPhNIZjd+fN9GayXobtcawefZYks+K2O4gJnWLIE22q03UVK13MZ
         ttMhlXVS3NMGFSXi2Y25j3RX1/HxQqMCaSG3zJKclfyQ5RJoncWLVofLlKGzreUvrqba
         ItERC2dnxXyqyDc8kOWKkr2jWw6uGBKoHo2t06jB0cS6I/qMZkElEZq3JRQZ+cN6OYjl
         x6xCek127qyR2AYWcNOoyMvu6lpMBKOlH/+eDyyRqNWeM3/i6eyMaxwwiiHuRaPxO9k9
         2PYA==
X-Gm-Message-State: AOAM531pAythl8NbBWduQTBrstMfYWCf54kiJH2ZuzJzSDY08cPtTXXl
        FE4i4yAIdNIFKE65TrSNWIDpsmAiKhA=
X-Google-Smtp-Source: ABdhPJwHBIO7CEuDjFLjWSCgnqNMLfgEgBrnOGyZx6f2iVhdMifs08VIip1HwV/KxvFhajo0P4YjRg==
X-Received: by 2002:a5d:4688:: with SMTP id u8mr5229343wrq.39.1615904846803;
        Tue, 16 Mar 2021 07:27:26 -0700 (PDT)
Received: from agape.jhs ([5.171.72.71])
        by smtp.gmail.com with ESMTPSA id b17sm22396143wrt.17.2021.03.16.07.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 07:27:26 -0700 (PDT)
Date:   Tue, 16 Mar 2021 15:27:21 +0100
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: rtl8723bs: remove unused code blocks conditioned
 by never set CONFIG_GPIO_API
Message-ID: <20210316142714.GA3368@agape.jhs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove conditional code blocks checked by unused
CONFIG_GPIO_API

cleaning required in TODO file:

find and remove code blocks guarded by never set CONFIG_FOO defines

Changes in v2:
	rebase of conflicting code in public staging-testing

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 .../staging/rtl8723bs/core/rtw_wlan_util.c    | 95 -------------------
 drivers/staging/rtl8723bs/include/drv_types.h |  6 --
 .../staging/rtl8723bs/os_dep/ioctl_linux.c    | 40 --------
 3 files changed, 141 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index d04514d36b49..3e211780cde4 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -2014,98 +2014,3 @@ struct adapter *dvobj_get_port0_adapter(struct dvobj_priv *dvobj)
 
 	return dvobj->padapters;
 }
-
-#ifdef CONFIG_GPIO_API
-int rtw_get_gpio(struct net_device *netdev, int gpio_num)
-{
-	u8 value;
-	u8 direction;
-	struct adapter *adapter = rtw_netdev_priv(netdev);
-	struct pwrctrl_priv *pwrpriv = adapter_to_pwrctl(adapter);
-
-	rtw_ps_deny(adapter, PS_DENY_IOCTL);
-
-	DBG_871X("rf_pwrstate = 0x%02x\n", pwrpriv->rf_pwrstate);
-	LeaveAllPowerSaveModeDirect(adapter);
-
-	/* Read GPIO Direction */
-	direction = (rtw_read8(adapter, REG_GPIO_PIN_CTRL + 2) & BIT(gpio_num)) >> gpio_num;
-
-	/* According the direction to read register value */
-	if (direction)
-		value = (rtw_read8(adapter, REG_GPIO_PIN_CTRL + 1) & BIT(gpio_num)) >> gpio_num;
-	else
-		value = (rtw_read8(adapter, REG_GPIO_PIN_CTRL) & BIT(gpio_num)) >> gpio_num;
-
-	rtw_ps_deny_cancel(adapter, PS_DENY_IOCTL);
-	DBG_871X("%s direction =%d value =%d\n", __func__, direction, value);
-
-	return value;
-}
-EXPORT_SYMBOL(rtw_get_gpio);
-
-int  rtw_set_gpio_output_value(struct net_device *netdev, int gpio_num, bool isHigh)
-{
-	u8 direction = 0;
-	u8 res = -1;
-	struct adapter *adapter = rtw_netdev_priv(netdev);
-
-	/* Check GPIO is 4~7 */
-	if (gpio_num > 7 || gpio_num < 4) {
-		DBG_871X("%s The gpio number does not included 4~7.\n", __func__);
-		return -1;
-	}
-
-	rtw_ps_deny(adapter, PS_DENY_IOCTL);
-
-	LeaveAllPowerSaveModeDirect(adapter);
-
-	/* Read GPIO direction */
-	direction = (rtw_read8(adapter, REG_GPIO_PIN_CTRL + 2) & BIT(gpio_num)) >> gpio_num;
-
-	/* If GPIO is output direction, setting value. */
-	if (direction) {
-		if (isHigh)
-			rtw_write8(adapter, REG_GPIO_PIN_CTRL + 1, rtw_read8(adapter, REG_GPIO_PIN_CTRL + 1) | BIT(gpio_num));
-		else
-			rtw_write8(adapter, REG_GPIO_PIN_CTRL + 1, rtw_read8(adapter, REG_GPIO_PIN_CTRL + 1) & ~BIT(gpio_num));
-
-		DBG_871X("%s Set gpio %x[%d]=%d\n", __func__, REG_GPIO_PIN_CTRL+1, gpio_num, isHigh);
-		res = 0;
-	} else {
-		DBG_871X("%s The gpio is input, not be set!\n", __func__);
-		res = -1;
-	}
-
-	rtw_ps_deny_cancel(adapter, PS_DENY_IOCTL);
-	return res;
-}
-EXPORT_SYMBOL(rtw_set_gpio_output_value);
-
-int rtw_config_gpio(struct net_device *netdev, int gpio_num, bool isOutput)
-{
-	struct adapter *adapter = rtw_netdev_priv(netdev);
-
-	if (gpio_num > 7 || gpio_num < 4) {
-		DBG_871X("%s The gpio number does not included 4~7.\n", __func__);
-		return -1;
-	}
-
-	DBG_871X("%s gpio_num =%d direction =%d\n", __func__, gpio_num, isOutput);
-
-	rtw_ps_deny(adapter, PS_DENY_IOCTL);
-
-	LeaveAllPowerSaveModeDirect(adapter);
-
-	if (isOutput)
-		rtw_write8(adapter, REG_GPIO_PIN_CTRL + 2, rtw_read8(adapter, REG_GPIO_PIN_CTRL + 2) | BIT(gpio_num));
-	else
-		rtw_write8(adapter, REG_GPIO_PIN_CTRL + 2, rtw_read8(adapter, REG_GPIO_PIN_CTRL + 2) & ~BIT(gpio_num));
-
-	rtw_ps_deny_cancel(adapter, PS_DENY_IOCTL);
-
-	return 0;
-}
-EXPORT_SYMBOL(rtw_config_gpio);
-#endif
-
diff --git a/drivers/staging/rtl8723bs/include/drv_types.h b/drivers/staging/rtl8723bs/include/drv_types.h
index 9d482a6115ab..9c0e7b6946f8 100644
--- a/drivers/staging/rtl8723bs/include/drv_types.h
+++ b/drivers/staging/rtl8723bs/include/drv_types.h
@@ -528,12 +528,6 @@ static inline void RTW_ENABLE_FUNC(struct adapter *padapter, int func_bit)
 			 (padapter)->bSurpriseRemoved || \
 			 RTW_IS_FUNC_DISABLED((padapter), DF_TX_BIT))
 
-#ifdef CONFIG_GPIO_API
-int rtw_get_gpio(struct net_device *netdev, int gpio_num);
-int rtw_set_gpio_output_value(struct net_device *netdev, int gpio_num, bool isHigh);
-int rtw_config_gpio(struct net_device *netdev, int gpio_num, bool isOutput);
-#endif
-
 static inline u8 *myid(struct eeprom_priv *peepriv)
 {
 	return peepriv->mac_addr;
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index d0e77465ad9a..f5cd3639f571 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -3063,46 +3063,6 @@ static int rtw_dbg_port(struct net_device *dev,
 					{
 						break;
 					}
-#ifdef CONFIG_GPIO_API
-		            case 0x25: /* Get GPIO register */
-		                    {
-			                    /*
-			                    * dbg 0x7f250000 [gpio_num], Get gpio value, gpio_num:0~7
-			                    */
-
-			                    int value;
-			                    DBG_871X("Read GPIO Value  extra_arg = %d\n", extra_arg);
-			                    value = rtw_get_gpio(dev, extra_arg);
-			                    DBG_871X("Read GPIO Value = %d\n", value);
-			                    break;
-		                    }
-		            case 0x26: /* Set GPIO direction */
-		                    {
-
-			                    /* dbg 0x7f26000x [y], Set gpio direction,
-			                    * x: gpio_num, 4~7  y: indicate direction, 0~1
-			                    */
-
-			                    int value;
-			                    DBG_871X("Set GPIO Direction! arg = %d , extra_arg =%d\n", arg, extra_arg);
-			                    value = rtw_config_gpio(dev, arg, extra_arg);
-			                    DBG_871X("Set GPIO Direction %s\n", (value == -1) ? "Fail!!!" : "Success");
-			                    break;
-					}
-				case 0x27: /* Set GPIO output direction value */
-					{
-						/*
-						* dbg 0x7f27000x [y], Set gpio output direction value,
-						* x: gpio_num, 4~7  y: indicate direction, 0~1
-						*/
-
-						int value;
-						DBG_871X("Set GPIO Value! arg = %d , extra_arg =%d\n", arg, extra_arg);
-						value = rtw_set_gpio_output_value(dev, arg, extra_arg);
-						DBG_871X("Set GPIO Value %s\n", (value == -1) ? "Fail!!!" : "Success");
-						break;
-					}
-#endif
 				case 0xaa:
 					{
 						if ((extra_arg & 0x7F) > 0x3F)
-- 
2.20.1

