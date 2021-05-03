Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84BBF371754
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 16:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbhECPAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 11:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbhECPAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 11:00:21 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A5FC06174A;
        Mon,  3 May 2021 07:59:28 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id v191so4328472pfc.8;
        Mon, 03 May 2021 07:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GXN6lwbGsWsgi+duQg1bgSlBiOoKXOf+TIMtVpvr234=;
        b=KS3qHNvfG/cWG8uFRIxuiHEWIeE7kALsIqz4peGUHvFBuO+5wahFZSSOUEY6ZOn9Oo
         o40pws3KfivqBbk9Q/RiQfxxqX4INWGyauv8/zWEyo0MVVmhNcOqGsN6bbHvSPyLxXq0
         VTyhRHYP0hjwt5n32DqK7eNFR4qqVl7sNrj8OL/c7P1b5GNTMjnkYkl9Z3zlzsUXkS6j
         Zd48PqKw9ddtCfD4MuYMV6Ly3gN1kRhxqb+8csb2/lAAYM9ihQ+jnLR/ET3itk9C22CX
         2KNIKN4ggQKdSuiEfnsyWE5tMJqGJ6Dm9dxqhswTunPX38HRmGhE/WXDnwPz8X2z95d2
         25hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GXN6lwbGsWsgi+duQg1bgSlBiOoKXOf+TIMtVpvr234=;
        b=JJ4B2DD/m3WrrsbP/q20C/FfzB+uWKgE4unMfhHa32wQXgmEVdZXpv9IjmFbpgZwqM
         y1tucBycCIz7NapAhOkvdMcFFLkhGALqr+zEhtHAF+UBS1rAHu3gCVjomSF6rx7WTMI3
         /eCMToj+G2uc0sN9oNFUCCixku3/A9tyKssTPV4+VIb/HiNqKFVTfit5nkZ6QGHBGwC+
         ftBqCWNjsu/1Fo6C+lhw5FiWMloohl4gRpTW7xGsRmsQLqGbuIZXba9tuwHm24oARB49
         LQAe59vfH+dyEwU6AvgRETaP3GHv8LjacSPKiddLzKOPn2DuBTZZFanPD8Z/LwFmWDOJ
         zj4A==
X-Gm-Message-State: AOAM533/rVya6UslHeN/k5k1HbHh4xjRStZ7vEHaKN3LCtffyWzLQBOd
        m611xZ0/T8kIGMXe6btCzeNtVjHnHL4=
X-Google-Smtp-Source: ABdhPJwZ4qfpVTQbY6D9dayHKNh07G1hp3UyhjWAsOmTskW9/coCHxrWS/68gTBlAdIoTYbvGTIlqw==
X-Received: by 2002:a05:6a00:78e:b029:28e:62a4:5f3 with SMTP id g14-20020a056a00078eb029028e62a405f3mr10642223pfu.19.1620053967572;
        Mon, 03 May 2021 07:59:27 -0700 (PDT)
Received: from archl-on2.. ([103.51.75.154])
        by smtp.gmail.com with ESMTPSA id k38sm3593983pgi.73.2021.05.03.07.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 07:59:27 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Anand Moon <linux.amoon@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCHv1 5/9] soc: amlogic: meson-ee-pwrc: Add hdmi power domain Meson sm1 SoCs
Date:   Mon,  3 May 2021 14:54:38 +0000
Message-Id: <20210503145503.1477-6-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210503145503.1477-1-linux.amoon@gmail.com>
References: <20210503145503.1477-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the S905X3 datasheet add hdmi power domain
controller for Meson sm1 SoCs.

Cc: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/soc/amlogic/meson-ee-pwrc.c         | 1 +
 include/dt-bindings/power/meson-sm1-power.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/soc/amlogic/meson-ee-pwrc.c b/drivers/soc/amlogic/meson-ee-pwrc.c
index ec402c4ab931..062b2488f932 100644
--- a/drivers/soc/amlogic/meson-ee-pwrc.c
+++ b/drivers/soc/amlogic/meson-ee-pwrc.c
@@ -302,6 +302,7 @@ static struct meson_ee_pwrc_domain_desc sm1_pwrc_domains[] = {
 				    pwrc_ee_get_power),
 	[PWRC_SM1_GE2D_ID] = TOP_PD("GE2D", &sm1_pwrc_ge2d, sm1_pwrc_mem_ge2d,
 				    pwrc_ee_get_power),
+	[PWRC_SM1_HDMI_ID] = MEM_PD("HDMI", meson_pwrc_mem_hdmi),
 	[PWRC_SM1_AUDIO_ID] = MEM_PD("AUDIO", sm1_pwrc_mem_audio),
 	[PWRC_SM1_ETH_ID] = MEM_PD("ETH", meson_pwrc_mem_eth),
 };
diff --git a/include/dt-bindings/power/meson-sm1-power.h b/include/dt-bindings/power/meson-sm1-power.h
index a020ab00c134..094a6a44ab96 100644
--- a/include/dt-bindings/power/meson-sm1-power.h
+++ b/include/dt-bindings/power/meson-sm1-power.h
@@ -14,5 +14,6 @@
 #define PWRC_SM1_GE2D_ID	4
 #define PWRC_SM1_AUDIO_ID	5
 #define PWRC_SM1_ETH_ID		6
+#define PWRC_SM1_HDMI_ID	7
 
 #endif
-- 
2.31.1

