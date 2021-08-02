Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1A273DCE7E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 03:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbhHBBKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 21:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbhHBBKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 21:10:40 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F403C06175F
        for <linux-kernel@vger.kernel.org>; Sun,  1 Aug 2021 18:10:30 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id oz16so28122051ejc.7
        for <linux-kernel@vger.kernel.org>; Sun, 01 Aug 2021 18:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vDTryV5o7j71henWHWGJv2jh6rOM9nJJodKObYrp408=;
        b=ZPzHyckjh+mwv45V9CfAkXP5Nf99S+p9tfk+GZmsyuiaZiXInmUR9e8GsjVYabdRN4
         gV/UdbdyrM9y9xDOlT3B2iGpggxPKWhwwSLaapKxrtrcirRWgF51HcHeKWOeQgNPgoha
         ho9r+IMIVFugH7V9IhovKQ1wiUlHB06cPiLrAslZLAyYASrgWbe7/EywHq3BNYxrT0H6
         TjFNGUxeRDZk0HkzDt0o2triJtrmcCThFdugS4xfetK491XIfnY5UEvRh8jQUI0ZP/dg
         6Jw8ZvGgDPkGSoSdjWDMqa+MTC9MAYcL4rnUKAYAbfCn8RjdCN5PXZl8MRY03O8hJauz
         X7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vDTryV5o7j71henWHWGJv2jh6rOM9nJJodKObYrp408=;
        b=bPqMlCW81BNs7wml+WnDybuBOG5UR5QhQ1WNk2RBNafAUhFBJ5pnyFfokb74HoIVLL
         9uxdSz+vHK9yUlKqHaU+Et3a4ofGvtZhZzvR7Il1zz2eiGGygIZeaAdjFU5RLvQv02Jh
         zjs6DiWSQGv5JS5+/dukknzZjCeNVsVHYfhJoRCeZ1M1Mb9C3kJttxsvIBthaBipBLbZ
         zNxEbJg24FJ1CqnvS2MloUL5xrVD8JC+r+2x2AW82QGHxHWesPnC3SDRqH6me3ibNhaF
         PB6xgw2vEQWqP16R/j1CYu2Zxp5Of1G0w+GbXZ+IS6Ac+bENQLAl5v/Yns9m54mxOtWf
         h1Cw==
X-Gm-Message-State: AOAM530o2UQE8YXIA0icm2R4VrDFbdmvAlaFrzCKiZCsFBK6GeAyINxb
        tmwOWw512lo81H9AkB6hv3o=
X-Google-Smtp-Source: ABdhPJyil2Jutor3HP/tZQdS2Z42bmbaPUmamDLNv/9bhtbFZ2ycw1fL5V4tO0LPnViBS8kmRVsQOQ==
X-Received: by 2002:a17:906:5509:: with SMTP id r9mr13491435ejp.74.1627866628911;
        Sun, 01 Aug 2021 18:10:28 -0700 (PDT)
Received: from localhost.localdomain (host-82-51-42-96.retail.telecomitalia.it. [82.51.42.96])
        by smtp.gmail.com with ESMTPSA id dg20sm4865691edb.13.2021.08.01.18.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 18:10:28 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] staging: r8188eu: include: Remove unused const definitions
Date:   Mon,  2 Aug 2021 03:10:25 +0200
Message-Id: <20210802011025.23887-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused const definitions. Issues detected by sparse. Remove the
'#ifdef' and '#endif' preprocessor directives that surround them.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 .../staging/r8188eu/include/rtw_mp_ioctl.h    | 77 -------------------
 1 file changed, 77 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtw_mp_ioctl.h b/drivers/staging/r8188eu/include/rtw_mp_ioctl.h
index e856fd0ad036..0376ddbf6011 100644
--- a/drivers/staging/r8188eu/include/rtw_mp_ioctl.h
+++ b/drivers/staging/r8188eu/include/rtw_mp_ioctl.h
@@ -135,83 +135,6 @@ int rtl8188eu_oid_rt_set_power_down_hdl(struct oid_par_priv *poid_par_priv);
 int rtl8188eu_oid_rt_get_power_mode_hdl(struct oid_par_priv *poid_par_priv);
 int rtl8188eu_oid_rt_pro_trigger_gpio_hdl(struct oid_par_priv *poid_par_priv);
 
-#ifdef _RTW_MP_IOCTL_C_
-
-static const struct oid_obj_priv rtl8188eu_oid_rtl_seg_81_80_00[] = {
-	{1, &oid_null_function},		/* 0x00	OID_RT_PRO_RESET_DUT */
-	{1, &rtl8188eu_oid_rt_pro_set_data_rate_hdl},	/* 0x01 */
-	{1, &rtl8188eu_oid_rt_pro_start_test_hdl},	/* 0x02 */
-	{1, &rtl8188eu_oid_rt_pro_stop_test_hdl},		/* 0x03 */
-	{1, &oid_null_function},	/* 0x04	OID_RT_PRO_SET_PREAMBLE */
-	{1, &oid_null_function},	/* 0x05	OID_RT_PRO_SET_SCRAMBLER */
-	{1, &oid_null_function},	/* 0x06	OID_RT_PRO_SET_FILTER_BB */
-	{1, &oid_null_function},/* 0x07	OID_RT_PRO_SET_MANUAL_DIVERSITY_BB */
-	{1, &rtl8188eu_oid_rt_pro_set_channel_direct_call_hdl},	/* 0x08 */
-	{1, &oid_null_function},/* 0x09	OID_RT_PRO_SET_SLEEP_MODE_DIRECT_CALL */
-	{1, &oid_null_function},/* 0x0A	OID_RT_PRO_SET_WAKE_MODE_DIRECT_CALL */
-	{1, &rtl8188eu_oid_rt_pro_set_continuous_tx_hdl},	/* 0x0B	OID_RT_PRO_SET_TX_CONTINUOUS_DIRECT_CALL */
-	{1, &rtl8188eu_oid_rt_pro_set_single_carrier_tx_hdl},/* 0x0C	OID_RT_PRO_SET_SINGLE_CARRIER_TX_CONTINUOUS */
-	{1, &oid_null_function},	/* 0x0D	OID_RT_PRO_SET_TX_ANTENNA_BB */
-	{1, &rtl8188eu_oid_rt_pro_set_antenna_bb_hdl},	/* 0x0E */
-	{1, &oid_null_function},		/* 0x0F	OID_RT_PRO_SET_CR_SCRAMBLER */
-	{1, &oid_null_function},		/* 0x10	OID_RT_PRO_SET_CR_NEW_FILTER */
-	{1, &rtl8188eu_oid_rt_pro_set_tx_power_control_hdl},/* 0x11 OID_RT_PRO_SET_TX_POWER_CONTROL */
-	{1, &oid_null_function},	/* 0x12	OID_RT_PRO_SET_CR_TX_CONFIG */
-	{1, &oid_null_function},	/* 0x13	OID_RT_PRO_GET_TX_POWER_CONTROL */
-	{1, &oid_null_function},	/* 0x14	OID_RT_PRO_GET_CR_SIGNAL_QUALITY */
-	{1, &oid_null_function},	/* 0x15	OID_RT_PRO_SET_CR_SETPOINT */
-	{1, &oid_null_function},	/* 0x16	OID_RT_PRO_SET_INTEGRATOR */
-	{1, &oid_null_function},	/* 0x17	OID_RT_PRO_SET_SIGNAL_QUALITY */
-	{1, &oid_null_function},	/* 0x18	OID_RT_PRO_GET_INTEGRATOR */
-	{1, &oid_null_function},	/* 0x19	OID_RT_PRO_GET_SIGNAL_QUALITY */
-	{1, &oid_null_function},	/* 0x1A	OID_RT_PRO_QUERY_EEPROM_TYPE */
-	{1, &oid_null_function},	/* 0x1B	OID_RT_PRO_WRITE_MAC_ADDRESS */
-	{1, &oid_null_function},	/* 0x1C	OID_RT_PRO_READ_MAC_ADDRESS */
-	{1, &oid_null_function},	/* 0x1D	OID_RT_PRO_WRITE_CIS_DATA */
-	{1, &oid_null_function},	/* 0x1E	OID_RT_PRO_READ_CIS_DATA */
-	{1, &oid_null_function}		/* 0x1F	OID_RT_PRO_WRITE_POWER_CONTROL */
-};
-
-static const struct oid_obj_priv rtl8188eu_oid_rtl_seg_81_80_20[] = {
-	{1, &oid_null_function},	/* 0x20	OID_RT_PRO_READ_POWER_CONTROL */
-	{1, &oid_null_function},	/* 0x21	OID_RT_PRO_WRITE_EEPROM */
-	{1, &oid_null_function},	/* 0x22	OID_RT_PRO_READ_EEPROM */
-	{1, &rtl8188eu_oid_rt_pro_reset_tx_packet_sent_hdl},	/* 0x23 */
-	{1, &rtl8188eu_oid_rt_pro_query_tx_packet_sent_hdl},	/* 0x24 */
-	{1, &rtl8188eu_oid_rt_pro_reset_rx_packet_received_hdl},	/* 0x25 */
-	{1, &rtl8188eu_oid_rt_pro_query_rx_packet_received_hdl},	/* 0x26 */
-	{1, &rtl8188eu_oid_rt_pro_query_rx_packet_crc32_error_hdl},	/* 0x27 */
-	{1, &oid_null_function},	/* 0x28	OID_RT_PRO_QUERY_CURRENT_ADDRESS */
-	{1, &oid_null_function},	/* 0x29	OID_RT_PRO_QUERY_PERMANENT_ADDRESS */
-	{1, &oid_null_function},	/* 0x2A	OID_RT_PRO_SET_PHILIPS_RF_PARAMETERS */
-	{1, &rtl8188eu_oid_rt_pro_set_carrier_suppression_tx_hdl},/* 0x2B	OID_RT_PRO_SET_CARRIER_SUPPRESSION_TX */
-	{1, &oid_null_function},	/* 0x2C	OID_RT_PRO_RECEIVE_PACKET */
-	{1, &oid_null_function},	/* 0x2D	OID_RT_PRO_WRITE_EEPROM_BYTE */
-	{1, &oid_null_function},	/* 0x2E	OID_RT_PRO_READ_EEPROM_BYTE */
-	{1, &rtl8188eu_oid_rt_pro_set_modulation_hdl}		/* 0x2F */
-};
-
-static const struct oid_obj_priv rtl8188eu_oid_rtl_seg_81_80_40[] = {
-	{1, &oid_null_function},			/* 0x40 */
-	{1, &oid_null_function},			/* 0x41 */
-	{1, &oid_null_function},			/* 0x42 */
-	{1, &rtl8188eu_oid_rt_pro_set_single_tone_tx_hdl},	/* 0x43 */
-	{1, &oid_null_function},			/* 0x44 */
-	{1, &oid_null_function}				/* 0x45 */
-};
-
-static const struct oid_obj_priv rtl8188eu_oid_rtl_seg_81_80_80[] = {
-	{1, &oid_null_function},		/* 0x80	OID_RT_DRIVER_OPTION */
-	{1, &oid_null_function},		/* 0x81	OID_RT_RF_OFF */
-	{1, &oid_null_function}			/* 0x82	OID_RT_AUTH_STATUS */
-};
-
-static const struct oid_obj_priv rtl8188eu_oid_rtl_seg_81_85[] = {
-	{1, &rtl8188eu_oid_rt_wireless_mode_hdl}		/* 0x00	OID_RT_WIRELESS_MODE */
-};
-
-#endif /* _RTL871X_MP_IOCTL_C_ */
-
 struct rwreg_param {
 	u32 offset;
 	u32 width;
-- 
2.32.0

