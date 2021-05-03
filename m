Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E2E371750
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 16:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbhECO7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 10:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbhECO7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 10:59:32 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B27C06174A;
        Mon,  3 May 2021 07:58:38 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id v13so2960774ple.9;
        Mon, 03 May 2021 07:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8e82Fw8ZdhiWxmWRJT09dHY82V2CPKcFuKG3LSkUO+s=;
        b=o/s/ipX6lhIS0rkr1BNOrxZHkysLFiZsXMj2JKwLYw5n1HbW5DuV1LytOawGwV7FXC
         TLHg7gI83DM87ny6EZnlxTIfGPogEIgj/0sE98YtARI0s0zD/NjJo4QyonIxN132LVH/
         Sw37NW0HGqPKs93MBoO9ZzE12qujiTSe3S9JtAsAC7GHgH/M2pfypBUEK7zlZUranjW0
         9WBLE4a9vjVx/VGvpgpNLe7ewI6wesroGWal1slHu8ZNPqfYz2u+vjhDZVjizw5SrcBI
         CPrNWzbHVpcvrC1Hk9vWkE99Q3Iblf5yIC2Ulth7wdisqjr5yOFdg9xh6RKqMQyIPgAn
         3OXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8e82Fw8ZdhiWxmWRJT09dHY82V2CPKcFuKG3LSkUO+s=;
        b=scauVghiMQiBQUWTRGP2NSqj/sJQC4QMjfhmZgcMGsC3zd717llSo6xulp42lojxjY
         P+H/77yyBUKga6YFsMaF82EvgZJfl1HDkHt6UzrkVuEJpz9Md9GSUF1KLCWjRq2SQNlH
         UMzO2znexXGmudyoYTHrUTTULNC7qNb1Sv+aX137/hc6Tc0WByayq7cCQ35n7mJUzfNm
         QdJ831IwVyGeUYWInP6EYwIqBlFBPuqPlOl1Jsy3Uu+WGR2VCEf8INmGZxInsaMqVv9L
         6hlX5ge3C+fvz5dPnRY/qw//DBaj/uYgDFAHfqu4bSrcJPaTiPmAbeDKVTm5BIglin1X
         LCBA==
X-Gm-Message-State: AOAM533Dax1dKBHl/+Mn5zhAlMIWklgIUy9vFjDKWyUOCguM94vTfix3
        ayOmS/4GdVFEyvBrSRd57YTT6AF9ne4=
X-Google-Smtp-Source: ABdhPJwYew63gOdTQpo4q/72kTglfh0y15sgwTWm2nNlWUMZpJk2lj3OWE7N/OxC8HCNU3f2lggysg==
X-Received: by 2002:a17:90a:a2e:: with SMTP id o43mr30532107pjo.163.1620053917551;
        Mon, 03 May 2021 07:58:37 -0700 (PDT)
Received: from archl-on2.. ([103.51.75.154])
        by smtp.gmail.com with ESMTPSA id k38sm3593983pgi.73.2021.05.03.07.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 07:58:37 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Anand Moon <linux.amoon@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCHv1 3/9] soc: amlogic: meson-ee-pwrc: Add hdmi power domain Meson g12a SoCs
Date:   Mon,  3 May 2021 14:54:36 +0000
Message-Id: <20210503145503.1477-4-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210503145503.1477-1-linux.amoon@gmail.com>
References: <20210503145503.1477-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the S922X datasheet add hdmi power domain
controller for Meson g12a and g12b SoCs.

Cc: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/soc/amlogic/meson-ee-pwrc.c          | 5 +++++
 include/dt-bindings/power/meson-g12a-power.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/soc/amlogic/meson-ee-pwrc.c b/drivers/soc/amlogic/meson-ee-pwrc.c
index 2e07ddf2d6a6..ec402c4ab931 100644
--- a/drivers/soc/amlogic/meson-ee-pwrc.c
+++ b/drivers/soc/amlogic/meson-ee-pwrc.c
@@ -154,6 +154,10 @@ static struct meson_ee_pwrc_mem_domain gxbb_pwrc_mem_vpu[] = {
 	VPU_HHI_MEMPD(HHI_MEM_PD_REG0),
 };
 
+static struct meson_ee_pwrc_mem_domain meson_pwrc_mem_hdmi[] = {
+	{ HHI_MEM_PD_REG0, GENMASK(15, 8) },
+};
+
 static struct meson_ee_pwrc_mem_domain meson_pwrc_mem_audio[] = {
 	{ HHI_MEM_PD_REG0, GENMASK(5, 4) },
 };
@@ -256,6 +260,7 @@ static struct meson_ee_pwrc_domain_desc axg_pwrc_domains[] = {
 static struct meson_ee_pwrc_domain_desc g12a_pwrc_domains[] = {
 	[PWRC_G12A_VPU_ID]  = VPU_PD("VPU", &gx_pwrc_vpu, g12a_pwrc_mem_vpu,
 				     pwrc_ee_get_power, 11, 2),
+	[PWRC_G12A_HDMI_ID] = MEM_PD("HDMI", meson_pwrc_mem_hdmi),
 	[PWRC_G12A_AUDIO_ID] = MEM_PD("AUDIO", meson_pwrc_mem_audio),
 	[PWRC_G12A_ETH_ID] = MEM_PD("ETH", meson_pwrc_mem_eth),
 };
diff --git a/include/dt-bindings/power/meson-g12a-power.h b/include/dt-bindings/power/meson-g12a-power.h
index 1cf20e4e412e..900924d17798 100644
--- a/include/dt-bindings/power/meson-g12a-power.h
+++ b/include/dt-bindings/power/meson-g12a-power.h
@@ -10,5 +10,6 @@
 #define PWRC_G12A_VPU_ID		0
 #define PWRC_G12A_ETH_ID		1
 #define PWRC_G12A_AUDIO_ID		2
+#define PWRC_G12A_HDMI_ID		3
 
 #endif
-- 
2.31.1

