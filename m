Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F20DF386B53
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 22:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242358AbhEQUXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 16:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240629AbhEQUXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 16:23:21 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AFAC061756
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 13:22:03 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id j14so6005089wrq.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 13:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z220BesNCBDXACL2kstOoMgF4dcNonJNXvdvzRxIldk=;
        b=dcsJesrjVYOJH/ZBeTAbkzGH0EaJtCj3qzMVDUxk4/s8RpLJtUBfMGkb2Sw/fZ66M6
         1LDqZ/0ovDBLYPEcHGXX6AAsQyJkmePgM3YMON5Nfg49bqp0qquUEEaMYoEkPpEnNqBi
         uijhFKTOe9VRwvj4oTBBg1jaYC4XpfxiE33kEOFm8bUFbFndrUU0l6MHChfTyLePGcw7
         yHTBckmGsEKWLreABr2KbJ/7WY2kY8C0NKU3cukrP3/JUBepxQlbU4hBUjzef4e0uUs/
         JjADlGpzkSHMpnEbKy/RjRCa8WGXBnvq0LnUvaEMgIObEbz8r3DbUtjNBiY1t1O6RXYI
         fm4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z220BesNCBDXACL2kstOoMgF4dcNonJNXvdvzRxIldk=;
        b=qglG3vj9EWmGuBm4LLm5KdTDYhR3AAogcDbQv0vh53ZZSty7Fzawb3neb9ieHxpaTm
         LXOHzZsAVxzRkEkvVHQrJ6xva7e1bLmmUqggJohbisteQjCpzibZOKVFLPu8xyaT/Gsj
         PbTQTqapTYFk/Nt+r7ZeO3sSKtxQNl3H+nXi662RcvrIDJ9FhdjSncOsWZi4+5cujpcm
         xabL7zE8NokAfMbDI4gh7GeN4HheyJgKtgm1tKXdCdrBY268PW716ETXwXo/CAD3YoWl
         44TkARYIPTd1A8wanQOW1mPq0c1Jbuu2009I712WItwFo5aIQrXhvkoHVqN9a+vEL+wr
         7OpA==
X-Gm-Message-State: AOAM532J/VBALOwXlF03HB0+DeSKrxWoEGyYeCHW5Qfc5azd5uneS++J
        eIcc75+PnR3d09qgv3cCpQ4=
X-Google-Smtp-Source: ABdhPJzeVNfSBJj8jrPvCmB6fLPbJKVTbzhHlj5S9xagPYBgolSxtx6+tSRulJyXLisr1p+0BQRxrA==
X-Received: by 2002:a5d:63c4:: with SMTP id c4mr1707262wrw.287.1621282921926;
        Mon, 17 May 2021 13:22:01 -0700 (PDT)
Received: from localhost.localdomain (p200300f1371adf00428d5cfffeb99db8.dip0.t-ipconnect.de. [2003:f1:371a:df00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id f4sm19190387wrz.33.2021.05.17.13.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 13:22:01 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     narmstrong@baylibre.com, khilman@baylibre.com,
        linux-amlogic@lists.infradead.org
Cc:     jbrunet@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH] soc: amlogic: meson-ee-pwrc: Rename "get_power" to "is_powered_off"
Date:   Mon, 17 May 2021 22:21:15 +0200
Message-Id: <20210517202115.1004065-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The name "get_power" is used within the Meson EE power controller driver
to indicate whether a power domain is turned on or off. With the
original "get_power" naming the result was:
- true = powered off
- false = powered on

Rename "get_power" to "is_powered_off" to make the naming consistent
with the third argument to pm_genpd_init. Also this naming is easier to
understand when reading the code without looking at the implementation
of "get_power".

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/soc/amlogic/meson-ee-pwrc.c | 46 ++++++++++++++---------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/soc/amlogic/meson-ee-pwrc.c b/drivers/soc/amlogic/meson-ee-pwrc.c
index 50bf5d2b828b..2be3afe6c2e3 100644
--- a/drivers/soc/amlogic/meson-ee-pwrc.c
+++ b/drivers/soc/amlogic/meson-ee-pwrc.c
@@ -68,7 +68,7 @@ struct meson_ee_pwrc_domain_desc {
 	struct meson_ee_pwrc_top_domain *top_pd;
 	unsigned int mem_pd_count;
 	struct meson_ee_pwrc_mem_domain *mem_pd;
-	bool (*get_power)(struct meson_ee_pwrc_domain *pwrc_domain);
+	bool (*is_powered_off)(struct meson_ee_pwrc_domain *pwrc_domain);
 };
 
 struct meson_ee_pwrc_domain_data {
@@ -217,7 +217,7 @@ static struct meson_ee_pwrc_mem_domain sm1_pwrc_mem_audio[] = {
 	{ HHI_AUDIO_MEM_PD_REG0, GENMASK(27, 26) },
 };
 
-#define VPU_PD(__name, __top_pd, __mem, __get_power, __resets, __clks)	\
+#define VPU_PD(__name, __top_pd, __mem, __is_pwr_off, __resets, __clks)	\
 	{								\
 		.name = __name,						\
 		.reset_names_count = __resets,				\
@@ -225,46 +225,46 @@ static struct meson_ee_pwrc_mem_domain sm1_pwrc_mem_audio[] = {
 		.top_pd = __top_pd,					\
 		.mem_pd_count = ARRAY_SIZE(__mem),			\
 		.mem_pd = __mem,					\
-		.get_power = __get_power,				\
+		.is_powered_off = __is_pwr_off,				\
 	}
 
-#define TOP_PD(__name, __top_pd, __mem, __get_power)			\
+#define TOP_PD(__name, __top_pd, __mem, __is_pwr_off)			\
 	{								\
 		.name = __name,						\
 		.top_pd = __top_pd,					\
 		.mem_pd_count = ARRAY_SIZE(__mem),			\
 		.mem_pd = __mem,					\
-		.get_power = __get_power,				\
+		.is_powered_off = __is_pwr_off,				\
 	}
 
 #define MEM_PD(__name, __mem)						\
 	TOP_PD(__name, NULL, __mem, NULL)
 
-static bool pwrc_ee_get_power(struct meson_ee_pwrc_domain *pwrc_domain);
+static bool pwrc_ee_is_powered_off(struct meson_ee_pwrc_domain *pwrc_domain);
 
 static struct meson_ee_pwrc_domain_desc axg_pwrc_domains[] = {
 	[PWRC_AXG_VPU_ID]  = VPU_PD("VPU", &gx_pwrc_vpu, axg_pwrc_mem_vpu,
-				     pwrc_ee_get_power, 5, 2),
+				     pwrc_ee_is_powered_off, 5, 2),
 	[PWRC_AXG_ETHERNET_MEM_ID] = MEM_PD("ETH", meson_pwrc_mem_eth),
 	[PWRC_AXG_AUDIO_ID] = MEM_PD("AUDIO", axg_pwrc_mem_audio),
 };
 
 static struct meson_ee_pwrc_domain_desc g12a_pwrc_domains[] = {
 	[PWRC_G12A_VPU_ID]  = VPU_PD("VPU", &gx_pwrc_vpu, g12a_pwrc_mem_vpu,
-				     pwrc_ee_get_power, 11, 2),
+				     pwrc_ee_is_powered_off, 11, 2),
 	[PWRC_G12A_ETH_ID] = MEM_PD("ETH", meson_pwrc_mem_eth),
 };
 
 static struct meson_ee_pwrc_domain_desc gxbb_pwrc_domains[] = {
 	[PWRC_GXBB_VPU_ID]  = VPU_PD("VPU", &gx_pwrc_vpu, gxbb_pwrc_mem_vpu,
-				     pwrc_ee_get_power, 12, 2),
+				     pwrc_ee_is_powered_off, 12, 2),
 	[PWRC_GXBB_ETHERNET_MEM_ID] = MEM_PD("ETH", meson_pwrc_mem_eth),
 };
 
 static struct meson_ee_pwrc_domain_desc meson8_pwrc_domains[] = {
 	[PWRC_MESON8_VPU_ID]  = VPU_PD("VPU", &meson8_pwrc_vpu,
-				       meson8_pwrc_mem_vpu, pwrc_ee_get_power,
-				       0, 1),
+				       meson8_pwrc_mem_vpu,
+				       pwrc_ee_is_powered_off, 0, 1),
 	[PWRC_MESON8_ETHERNET_MEM_ID] = MEM_PD("ETHERNET_MEM",
 					       meson_pwrc_mem_eth),
 	[PWRC_MESON8_AUDIO_DSP_MEM_ID] = MEM_PD("AUDIO_DSP_MEM",
@@ -273,8 +273,8 @@ static struct meson_ee_pwrc_domain_desc meson8_pwrc_domains[] = {
 
 static struct meson_ee_pwrc_domain_desc meson8b_pwrc_domains[] = {
 	[PWRC_MESON8_VPU_ID]  = VPU_PD("VPU", &meson8_pwrc_vpu,
-				       meson8_pwrc_mem_vpu, pwrc_ee_get_power,
-				       11, 1),
+				       meson8_pwrc_mem_vpu,
+				       pwrc_ee_is_powered_off, 11, 1),
 	[PWRC_MESON8_ETHERNET_MEM_ID] = MEM_PD("ETHERNET_MEM",
 					       meson_pwrc_mem_eth),
 	[PWRC_MESON8_AUDIO_DSP_MEM_ID] = MEM_PD("AUDIO_DSP_MEM",
@@ -283,15 +283,15 @@ static struct meson_ee_pwrc_domain_desc meson8b_pwrc_domains[] = {
 
 static struct meson_ee_pwrc_domain_desc sm1_pwrc_domains[] = {
 	[PWRC_SM1_VPU_ID]  = VPU_PD("VPU", &sm1_pwrc_vpu, sm1_pwrc_mem_vpu,
-				    pwrc_ee_get_power, 11, 2),
+				    pwrc_ee_is_powered_off, 11, 2),
 	[PWRC_SM1_NNA_ID]  = TOP_PD("NNA", &sm1_pwrc_nna, sm1_pwrc_mem_nna,
-				    pwrc_ee_get_power),
+				    pwrc_ee_is_powered_off),
 	[PWRC_SM1_USB_ID]  = TOP_PD("USB", &sm1_pwrc_usb, sm1_pwrc_mem_usb,
-				    pwrc_ee_get_power),
+				    pwrc_ee_is_powered_off),
 	[PWRC_SM1_PCIE_ID] = TOP_PD("PCI", &sm1_pwrc_pci, sm1_pwrc_mem_pcie,
-				    pwrc_ee_get_power),
+				    pwrc_ee_is_powered_off),
 	[PWRC_SM1_GE2D_ID] = TOP_PD("GE2D", &sm1_pwrc_ge2d, sm1_pwrc_mem_ge2d,
-				    pwrc_ee_get_power),
+				    pwrc_ee_is_powered_off),
 	[PWRC_SM1_AUDIO_ID] = MEM_PD("AUDIO", sm1_pwrc_mem_audio),
 	[PWRC_SM1_ETH_ID] = MEM_PD("ETH", meson_pwrc_mem_eth),
 };
@@ -314,7 +314,7 @@ struct meson_ee_pwrc {
 	struct genpd_onecell_data xlate;
 };
 
-static bool pwrc_ee_get_power(struct meson_ee_pwrc_domain *pwrc_domain)
+static bool pwrc_ee_is_powered_off(struct meson_ee_pwrc_domain *pwrc_domain)
 {
 	u32 reg;
 
@@ -445,7 +445,7 @@ static int meson_ee_pwrc_init_domain(struct platform_device *pdev,
          * we need to power the domain off, otherwise the internal clocks
          * prepare/enable counters won't be in sync.
          */
-	if (dom->num_clks && dom->desc.get_power && !dom->desc.get_power(dom)) {
+	if (dom->num_clks && dom->desc.is_powered_off && !dom->desc.is_powered_off(dom)) {
 		ret = clk_bulk_prepare_enable(dom->num_clks, dom->clks);
 		if (ret)
 			return ret;
@@ -456,8 +456,8 @@ static int meson_ee_pwrc_init_domain(struct platform_device *pdev,
 			return ret;
 	} else {
 		ret = pm_genpd_init(&dom->base, NULL,
-				    (dom->desc.get_power ?
-				     dom->desc.get_power(dom) : true));
+				    (dom->desc.is_powered_off ?
+				     dom->desc.is_powered_off(dom) : true));
 		if (ret)
 			return ret;
 	}
@@ -536,7 +536,7 @@ static void meson_ee_pwrc_shutdown(struct platform_device *pdev)
 	for (i = 0 ; i < pwrc->xlate.num_domains ; ++i) {
 		struct meson_ee_pwrc_domain *dom = &pwrc->domains[i];
 
-		if (dom->desc.get_power && !dom->desc.get_power(dom))
+		if (dom->desc.is_powered_off && !dom->desc.is_powered_off(dom))
 			meson_ee_pwrc_off(&dom->base);
 	}
 }
-- 
2.31.1

