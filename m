Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04BA137175E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 17:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbhECPBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 11:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbhECPBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 11:01:39 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12A5C06174A;
        Mon,  3 May 2021 08:00:44 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id y1so2962196plg.11;
        Mon, 03 May 2021 08:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Me0/8wMFfbBiWllaQC8QNsKSdHVtD76NnW7CR+YniVo=;
        b=VGdvX2Weop7QRB/TM9J7p48OMZbgZdlrwDC27bf+srOMUSE4I/Rt1DMgj1wuVHFKnM
         u0PkGoxIuFs/NpnF7IPGniu5QD5nLbPe/mdLy1f4Skr4I82gy7jcM89/SkCCNCL3Ocxt
         DfUowqM0RfFlc2D0U0YE6HgViejRPoyLSGg0A95zgCWhHqENUAcfnb32F/1yqSH6tzKQ
         1kN8YsornF4InndpeZ2VL6w0sKz0miu2pS6AkQ9HcQ3VaktrqodvQTJi30vxF44roGle
         IFtVBTX8t1nYw2+RlxgeNI7DVRCV+khsMFmYGpB/FXeTJAzgobny4dfrgrYYeTog5Gpp
         pO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Me0/8wMFfbBiWllaQC8QNsKSdHVtD76NnW7CR+YniVo=;
        b=D4Ef6vGNkQxGQ/AtjwxWHjd/5X+V8IEtkgkDh0K0JWe2ZAzAHttUDnPtErfrHktQx5
         4TfUnP1Hsv0lc+yVgaiJskqAenCP0JcBfxBXCrpFHsnuzMINmakQVJV36i3XitZUMzN+
         A47pUgZKiQtkYoDhrlGlZ9OX5kdsxG7dIob0EeWQEHzAQM3y0v+0YsC1SS+hTTyfmKK5
         UXt0E62BqpRIwnP4ddLJ59vMWQq47XGUkG4vi1xzRU04/FaWJ2Y61YQ79yW4kJBYt9Qf
         4qOg6o5xkI3GncgPuHfid41/JyN3XUbDunV2QOpiwc/t/Xa6bCAEaMQumiFEfGgCHemN
         OitQ==
X-Gm-Message-State: AOAM5304mIwGenN/taZuSh6NDZzqtRY3FZEpeJMpK98er/7rEpKCA8YB
        N8LCdcvS5Ni+00XwyzmtddN/Qe6LV7A=
X-Google-Smtp-Source: ABdhPJwyjIoeQq8BCEUBxiuksyZ7uSber5kmEZBqOvk8KpjIdFU6rrjD5629sb9k++p1tUZigcwv+w==
X-Received: by 2002:a17:902:7444:b029:ed:5334:40b6 with SMTP id e4-20020a1709027444b02900ed533440b6mr20583031plt.35.1620054044230;
        Mon, 03 May 2021 08:00:44 -0700 (PDT)
Received: from archl-on2.. ([103.51.75.154])
        by smtp.gmail.com with ESMTPSA id k38sm3593983pgi.73.2021.05.03.08.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 08:00:43 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Anand Moon <linux.amoon@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCHv1 8/9] soc: amlogic: meson-ee-pwrc: Add hdmi power domain Meson gxbb and gxl SoCs
Date:   Mon,  3 May 2021 14:54:41 +0000
Message-Id: <20210503145503.1477-9-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210503145503.1477-1-linux.amoon@gmail.com>
References: <20210503145503.1477-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the S905X datasheet add hdmi power domain
controller for Meson gxbb and gxl SoCs.

Cc: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/soc/amlogic/meson-ee-pwrc.c          | 1 +
 include/dt-bindings/power/meson-gxbb-power.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/soc/amlogic/meson-ee-pwrc.c b/drivers/soc/amlogic/meson-ee-pwrc.c
index 062b2488f932..23a748ee9e68 100644
--- a/drivers/soc/amlogic/meson-ee-pwrc.c
+++ b/drivers/soc/amlogic/meson-ee-pwrc.c
@@ -268,6 +268,7 @@ static struct meson_ee_pwrc_domain_desc g12a_pwrc_domains[] = {
 static struct meson_ee_pwrc_domain_desc gxbb_pwrc_domains[] = {
 	[PWRC_GXBB_VPU_ID]  = VPU_PD("VPU", &gx_pwrc_vpu, gxbb_pwrc_mem_vpu,
 				     pwrc_ee_get_power, 12, 2),
+	[PWRC_GXBB_HDMI_ID] = MEM_PD("HDMI", meson_pwrc_mem_hdmi),
 	[PWRC_GXBB_ETHERNET_MEM_ID] = MEM_PD("ETH", meson_pwrc_mem_eth),
 };
 
diff --git a/include/dt-bindings/power/meson-gxbb-power.h b/include/dt-bindings/power/meson-gxbb-power.h
index 1262dac696c0..eafa92eb836e 100644
--- a/include/dt-bindings/power/meson-gxbb-power.h
+++ b/include/dt-bindings/power/meson-gxbb-power.h
@@ -9,5 +9,6 @@
 
 #define PWRC_GXBB_VPU_ID		0
 #define PWRC_GXBB_ETHERNET_MEM_ID	1
+#define PWRC_GXBB_HDMI_ID		2
 
 #endif
-- 
2.31.1

