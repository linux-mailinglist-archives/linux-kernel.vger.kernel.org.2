Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1318371747
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 16:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbhECO6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 10:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbhECO6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 10:58:41 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52224C06138B;
        Mon,  3 May 2021 07:57:47 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id i14so3813002pgk.5;
        Mon, 03 May 2021 07:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a1fdsn/UqipHakxIGXIN7yVeQcOHlVqXqVo8GiLuBOY=;
        b=sK9V6pUTJjDj8PitUOzz8v0oR3NrpgGdQSiWY+mIZkQHOd4JDGv2mlbSzWzfQEGXkv
         NvX0haqQB11zldQr1PH+nnlWGCQ1hWVPe3zWNq3SVmAX75l7pZNAQnt/zCRnNqcGCBvx
         SKMC2ny41vH1kHP7dAQGKLoc8uSGmrP8Vb8pRDazdxi4yhPNMOQSA6S/rw7J1kGdiJdk
         UKeYNGcr3mQBdqPqqmc1SGPK0Jri12G3eWjJ/0wSdSbd7BXCDLRjQfNXRzqNhAQoX1BM
         9xfqY7Ygn5luvURPcajJqOs5QeZg3SAIz6Py+RKtSujJmOLyecA8y9Sjqsb2oburd9W5
         133w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a1fdsn/UqipHakxIGXIN7yVeQcOHlVqXqVo8GiLuBOY=;
        b=KlN1AeoSnkuu7/Afej4r8F32bWX8f0/drBT59bdxlY/999Na0Abjnuc5dAZEmN4aY2
         89sGAt8lRgdw3s8y1w0BjrxrWdhg9SokcbnaV50yS+VwwXaODXDyffJeuCLoW1phYnRZ
         nELn+dzAlQ7S++njXeA0oHYGTX6SC3Tpa9Wu5cNWHVI3v24eLra55Cybfngyc1YSPvF8
         BzmxD2CACagPmvFBL+r9s9nk6Uaw89TYiBBrNAAzciEsWEdvrbP/xZ+E/NavBYQW/0Mm
         Wr8puraOvKca7YeCK9/EEFJ5Rs4k0lLCQNqqIDAJ/MnuvM8BaP6Jk7BDxKO26xag2QTh
         LXEg==
X-Gm-Message-State: AOAM531QMEdXC0ndCB83lov1u2OUOVD//exNf+Dp2RN6BisaxLVOPnKb
        rTChkXZb+9ANdMcJ0JQBl1i02O0AC98=
X-Google-Smtp-Source: ABdhPJxWCYkbaDXB7lShNp5YSQak8Y4u1zB4HvVTJzzZ533GuVksci3JwIe/BUdFxMrUyDuTb51u0A==
X-Received: by 2002:a65:4c89:: with SMTP id m9mr18333911pgt.330.1620053866701;
        Mon, 03 May 2021 07:57:46 -0700 (PDT)
Received: from archl-on2.. ([103.51.75.154])
        by smtp.gmail.com with ESMTPSA id k38sm3593983pgi.73.2021.05.03.07.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 07:57:46 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Anand Moon <linux.amoon@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCHv1 1/9] soc: amlogic: meson-ee-pwrc: Add audio power domain Meson g12a and g12b SoCs
Date:   Mon,  3 May 2021 14:54:34 +0000
Message-Id: <20210503145503.1477-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210503145503.1477-1-linux.amoon@gmail.com>
References: <20210503145503.1477-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the S922X datasheet add audio power domain controller for
Meson g12a and g12b SoCs.

Cc: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/soc/amlogic/meson-ee-pwrc.c          | 5 +++++
 include/dt-bindings/power/meson-g12a-power.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/soc/amlogic/meson-ee-pwrc.c b/drivers/soc/amlogic/meson-ee-pwrc.c
index 50bf5d2b828b..2e07ddf2d6a6 100644
--- a/drivers/soc/amlogic/meson-ee-pwrc.c
+++ b/drivers/soc/amlogic/meson-ee-pwrc.c
@@ -154,6 +154,10 @@ static struct meson_ee_pwrc_mem_domain gxbb_pwrc_mem_vpu[] = {
 	VPU_HHI_MEMPD(HHI_MEM_PD_REG0),
 };
 
+static struct meson_ee_pwrc_mem_domain meson_pwrc_mem_audio[] = {
+	{ HHI_MEM_PD_REG0, GENMASK(5, 4) },
+};
+
 static struct meson_ee_pwrc_mem_domain meson_pwrc_mem_eth[] = {
 	{ HHI_MEM_PD_REG0, GENMASK(3, 2) },
 };
@@ -252,6 +256,7 @@ static struct meson_ee_pwrc_domain_desc axg_pwrc_domains[] = {
 static struct meson_ee_pwrc_domain_desc g12a_pwrc_domains[] = {
 	[PWRC_G12A_VPU_ID]  = VPU_PD("VPU", &gx_pwrc_vpu, g12a_pwrc_mem_vpu,
 				     pwrc_ee_get_power, 11, 2),
+	[PWRC_G12A_AUDIO_ID] = MEM_PD("AUDIO", meson_pwrc_mem_audio),
 	[PWRC_G12A_ETH_ID] = MEM_PD("ETH", meson_pwrc_mem_eth),
 };
 
diff --git a/include/dt-bindings/power/meson-g12a-power.h b/include/dt-bindings/power/meson-g12a-power.h
index bb5e67a842de..1cf20e4e412e 100644
--- a/include/dt-bindings/power/meson-g12a-power.h
+++ b/include/dt-bindings/power/meson-g12a-power.h
@@ -9,5 +9,6 @@
 
 #define PWRC_G12A_VPU_ID		0
 #define PWRC_G12A_ETH_ID		1
+#define PWRC_G12A_AUDIO_ID		2
 
 #endif
-- 
2.31.1

