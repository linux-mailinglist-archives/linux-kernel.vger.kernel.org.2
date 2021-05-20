Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D12AE38AF18
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 14:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242186AbhETMvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 08:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243146AbhETMsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 08:48:15 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA3AC05A986
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:08:30 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id a4so17443375wrr.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 05:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1WuwPehHMHFGVxccMuq44x53UaCFgIDOKkSjwdYiyjA=;
        b=bcXrIe19jnKkLpFAxnRksnHRQ67g/z51OyiXwlN9L4rHn5Aq0MUKXMj6oICo4JpSC/
         f2HclPfcahW6es+iaH8oWNrdlXmY+fZgG8U374rW5rp+24PNVzLYobeSQC4C91XijflM
         jh2SKQ9Xoxf0mplhnyWumzo7gTVPM8zL7enc4mySTs/7OKwkhHR4k4Bm39tC0bMjByu1
         KnqttfhQ6kFQTwjEmPcy1nYplwyDazRRFj25AMMlZvr3Mlz6ASR0lcEaxU1gWZacui0t
         6H2tmcnrtXqvhfyWoPYhQvAF/gj0ie30gCKfR0KZJo503KHi7vS2ThmUJwYnikhpWaYV
         ux6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1WuwPehHMHFGVxccMuq44x53UaCFgIDOKkSjwdYiyjA=;
        b=Q5UyOCO6geKxlvSAN9eVlYdfDLEOZ2l2S4h3DZoJyR284MsZL/P8V6H2vk1ouYEM5l
         Q0xPml3Sdxa6Uyr3dWwQ+B2CPt5YU8hg2/Fm2o2oENwOX9st69AuHIr2rZDuUXIF5cOE
         JN/+xxFQYKR3aT/TxOg3BO4THJDqjEx0Ru/LFjJETJ90NvhAq8ibBV9bnyeiOtsrhHb8
         7qw6zWDQO3gBzEXM5daYSvaChLRLApDWMr1lZI9bV6Cp7Uu81weWQiPia5w8o70/HXQo
         +krtMrdM8JsgZy4EKo9/od0TRqSPu8+Rizm0Kauvjp5BVrYXm/eGqrU0ROCYTwCzn4Bx
         CYwA==
X-Gm-Message-State: AOAM530jhX+pVYeVilzBGFa/9FpLjo49z1p6f3fs8PIBOqYqh7qUhZM/
        LvXSmc4mX/U/GVriI4DR5JGWHQ==
X-Google-Smtp-Source: ABdhPJzmu7S+QzeMYbZjmP7PoDrtyTy05T+KvxOsHkmdOtl0XjoSfJN/6TvHaX7e8g3T5WzwcvPcYg==
X-Received: by 2002:a5d:6b52:: with SMTP id x18mr3839406wrw.11.1621512508827;
        Thu, 20 May 2021 05:08:28 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id r7sm2237170wmq.18.2021.05.20.05.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 05:08:28 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH 6/7] mfd: si476x-cmd: Fix a bunch of incorrectly documented function names
Date:   Thu, 20 May 2021 13:08:19 +0100
Message-Id: <20210520120820.3465562-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210520120820.3465562-1-lee.jones@linaro.org>
References: <20210520120820.3465562-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/mfd/si476x-cmd.c:406: warning: expecting prototype for si476x_cmd_func_info(). Prototype was for si476x_core_cmd_func_info() instead
 drivers/mfd/si476x-cmd.c:437: warning: expecting prototype for si476x_cmd_set_property(). Prototype was for si476x_core_cmd_set_property() instead
 drivers/mfd/si476x-cmd.c:463: warning: expecting prototype for si476x_cmd_get_property(). Prototype was for si476x_core_cmd_get_property() instead
 drivers/mfd/si476x-cmd.c:525: warning: expecting prototype for si476x_cmd_dig_audio_pin_cfg(). Prototype was for si476x_core_cmd_dig_audio_pin_cfg() instead
 drivers/mfd/si476x-cmd.c:574: warning: expecting prototype for si476x_cmd_zif_pin_cfg(). Prototype was for si476x_core_cmd_zif_pin_cfg() instead
 drivers/mfd/si476x-cmd.c:631: warning: expecting prototype for si476x_cmd_ic_link_gpo_ctl_pin_cfg(). Prototype was for si476x_core_cmd_ic_link_gpo_ctl_pin_cfg() instead
 drivers/mfd/si476x-cmd.c:662: warning: expecting prototype for si476x_cmd_ana_audio_pin_cfg(). Prototype was for si476x_core_cmd_ana_audio_pin_cfg() instead
 drivers/mfd/si476x-cmd.c:697: warning: expecting prototype for si476x_cmd_intb_pin_cfg(). Prototype was for si476x_core_cmd_intb_pin_cfg_a10() instead
 drivers/mfd/si476x-cmd.c:742: warning: expecting prototype for si476x_cmd_am_rsq_status(). Prototype was for si476x_core_cmd_am_rsq_status() instead
 drivers/mfd/si476x-cmd.c:874: warning: expecting prototype for si476x_cmd_fm_seek_start(). Prototype was for si476x_core_cmd_fm_seek_start() instead
 drivers/mfd/si476x-cmd.c:905: warning: expecting prototype for si476x_cmd_fm_rds_status(). Prototype was for si476x_core_cmd_fm_rds_status() instead
 drivers/mfd/si476x-cmd.c:1050: warning: expecting prototype for si476x_cmd_am_seek_start(). Prototype was for si476x_core_cmd_am_seek_start() instead

Cc: Lee Jones <lee.jones@linaro.org>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/si476x-cmd.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/mfd/si476x-cmd.c b/drivers/mfd/si476x-cmd.c
index d15b3e7833692..0e4b89a967ed6 100644
--- a/drivers/mfd/si476x-cmd.c
+++ b/drivers/mfd/si476x-cmd.c
@@ -390,7 +390,7 @@ static int si476x_cmd_tune_seek_freq(struct si476x_core *core,
 }
 
 /**
- * si476x_cmd_func_info() - send 'FUNC_INFO' command to the device
+ * si476x_core_cmd_func_info() - send 'FUNC_INFO' command to the device
  * @core: device to send the command to
  * @info:  struct si476x_func_info to fill all the information
  *         returned by the command
@@ -424,7 +424,7 @@ int si476x_core_cmd_func_info(struct si476x_core *core,
 EXPORT_SYMBOL_GPL(si476x_core_cmd_func_info);
 
 /**
- * si476x_cmd_set_property() - send 'SET_PROPERTY' command to the device
+ * si476x_core_cmd_set_property() - send 'SET_PROPERTY' command to the device
  * @core:    device to send the command to
  * @property: property address
  * @value:    property value
@@ -452,7 +452,7 @@ int si476x_core_cmd_set_property(struct si476x_core *core,
 EXPORT_SYMBOL_GPL(si476x_core_cmd_set_property);
 
 /**
- * si476x_cmd_get_property() - send 'GET_PROPERTY' command to the device
+ * si476x_core_cmd_get_property() - send 'GET_PROPERTY' command to the device
  * @core:    device to send the command to
  * @property: property address
  *
@@ -481,7 +481,7 @@ int si476x_core_cmd_get_property(struct si476x_core *core, u16 property)
 EXPORT_SYMBOL_GPL(si476x_core_cmd_get_property);
 
 /**
- * si476x_cmd_dig_audio_pin_cfg() - send 'DIG_AUDIO_PIN_CFG' command to
+ * si476x_core_cmd_dig_audio_pin_cfg() - send 'DIG_AUDIO_PIN_CFG' command to
  * the device
  * @core: device to send the command to
  * @dclk:  DCLK pin function configuration:
@@ -539,7 +539,7 @@ int si476x_core_cmd_dig_audio_pin_cfg(struct  si476x_core *core,
 EXPORT_SYMBOL_GPL(si476x_core_cmd_dig_audio_pin_cfg);
 
 /**
- * si476x_cmd_zif_pin_cfg - send 'ZIF_PIN_CFG_COMMAND'
+ * si476x_core_cmd_zif_pin_cfg - send 'ZIF_PIN_CFG_COMMAND'
  * @core: - device to send the command to
  * @iqclk: - IQCL pin function configuration:
  *       SI476X_IQCLK_NOOP     - do not modify the behaviour
@@ -588,7 +588,7 @@ int si476x_core_cmd_zif_pin_cfg(struct si476x_core *core,
 EXPORT_SYMBOL_GPL(si476x_core_cmd_zif_pin_cfg);
 
 /**
- * si476x_cmd_ic_link_gpo_ctl_pin_cfg - send
+ * si476x_core_cmd_ic_link_gpo_ctl_pin_cfg - send
  * 'IC_LINK_GPIO_CTL_PIN_CFG' comand to the device
  * @core: - device to send the command to
  * @icin: - ICIN pin function configuration:
@@ -645,7 +645,7 @@ int si476x_core_cmd_ic_link_gpo_ctl_pin_cfg(struct si476x_core *core,
 EXPORT_SYMBOL_GPL(si476x_core_cmd_ic_link_gpo_ctl_pin_cfg);
 
 /**
- * si476x_cmd_ana_audio_pin_cfg - send 'ANA_AUDIO_PIN_CFG' to the
+ * si476x_core_cmd_ana_audio_pin_cfg - send 'ANA_AUDIO_PIN_CFG' to the
  * device
  * @core: - device to send the command to
  * @lrout: - LROUT pin function configuration:
@@ -674,7 +674,7 @@ EXPORT_SYMBOL_GPL(si476x_core_cmd_ana_audio_pin_cfg);
 
 
 /**
- * si476x_cmd_intb_pin_cfg - send 'INTB_PIN_CFG' command to the device
+ * si476x_core_cmd_intb_pin_cfg_a10 - send 'INTB_PIN_CFG' command to the device
  * @core: - device to send the command to
  * @intb: - INTB pin function configuration:
  *      SI476X_INTB_NOOP     - do not modify the behaviour
@@ -726,7 +726,7 @@ static int si476x_core_cmd_intb_pin_cfg_a20(struct si476x_core *core,
 
 
 /**
- * si476x_cmd_am_rsq_status - send 'AM_RSQ_STATUS' command to the
+ * si476x_core_cmd_am_rsq_status - send 'AM_RSQ_STATUS' command to the
  * device
  * @core:  - device to send the command to
  * @rsqargs: - pointer to a structure containing a group of sub-args
@@ -856,7 +856,7 @@ EXPORT_SYMBOL_GPL(si476x_core_cmd_am_acf_status);
 
 
 /**
- * si476x_cmd_fm_seek_start - send 'FM_SEEK_START' command to the
+ * si476x_core_cmd_fm_seek_start - send 'FM_SEEK_START' command to the
  * device
  * @core:  - device to send the command to
  * @seekup: - if set the direction of the search is 'up'
@@ -884,7 +884,7 @@ int si476x_core_cmd_fm_seek_start(struct si476x_core *core,
 EXPORT_SYMBOL_GPL(si476x_core_cmd_fm_seek_start);
 
 /**
- * si476x_cmd_fm_rds_status - send 'FM_RDS_STATUS' command to the
+ * si476x_core_cmd_fm_rds_status - send 'FM_RDS_STATUS' command to the
  * device
  * @core: - device to send the command to
  * @status_only: - if set the data is not removed from RDSFIFO,
@@ -1032,7 +1032,7 @@ EXPORT_SYMBOL_GPL(si476x_core_cmd_fm_phase_div_status);
 
 
 /**
- * si476x_cmd_am_seek_start - send 'FM_SEEK_START' command to the
+ * si476x_core_cmd_am_seek_start - send 'FM_SEEK_START' command to the
  * device
  * @core:  - device to send the command to
  * @seekup: - if set the direction of the search is 'up'
-- 
2.31.1

