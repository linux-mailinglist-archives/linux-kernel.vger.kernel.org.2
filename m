Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847D839D14F
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 22:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhFFUUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 16:20:11 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:40723 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbhFFUUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 16:20:04 -0400
Received: by mail-ed1-f46.google.com with SMTP id t3so17634332edc.7
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 13:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snejp.pl; s=gmail;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=qqv/zIOjF7NIyGSn6gjOvY+easTFG+SbModa0mydre0=;
        b=ngi3GO87bf82JBszh9x1WrlJpUMr6tKYc5Xpyf18N0WQ1Qp8qC8vgwBtn/bCmUA6Gw
         cti4hDldWE9EH+zn1CNBeo1amj+evmleTIlWX7UUW1wEA3i9xpl+Oo0qGMhWgBXyvBuH
         DveCYykijKUCf/7xbNgK9QThElkjeyoxyhIY9FVcs+0diw0jpi5Wi+7qP464idM0QGx7
         j/ROBJGdaP7ejmz8ie25IGLSRBdWsVzsgJFf4EaGGJ11pAp/maPO9lKp7pmZwWXSrZmX
         CP7bOkTgYn8trQ5FnN6+OTBbt9R4qXhINwU9bQeAq5QZQFv81RlNASLsY55WZMWRLzev
         bNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qqv/zIOjF7NIyGSn6gjOvY+easTFG+SbModa0mydre0=;
        b=CsdGWF3zccV2nz60Pc1sXDg8tCxarF93reF1CJ7AhvsDviW6etcRJIyNR+a+A4P57U
         MYd1QfIk3qVYCoWm3rBW99FHDwR30jcPI98nCeISme0k2aDsfDs1ACFx8vhYmZ7GzsD6
         MBEmd/Yc8Zb24HvFK/M83C7YSD9fxxAY6qASEUlb0ijFOPFCyP4Lha9ZcTJvWG5r2GVE
         4Pj3roK9IfLi+O66nkwoGtZomE43ihqGVsLdhdmzJM0T9Qr0P++y1Y9QlB2y25PxQjH1
         8Sh6CmlGd0QeVLXai32U2kqdA6D27q+s3PSKwcb82BOuKOwgQ3atOddKDpkob9fEaAu1
         VLRQ==
X-Gm-Message-State: AOAM533CpcN+qnjN7pDa6kdiV9C76k6F1+Sg+IYG8yF9JeIlRKMVtQ01
        Oj4a7fQqVOt4xhEn+SPVLLj+0g==
X-Google-Smtp-Source: ABdhPJyC8Za9uHMXOdmHWNxp1ZB/q/0EUA8vonNdpV64QvjM9o48iCAQzT/b02iu7HThSlhwOoNWzw==
X-Received: by 2002:aa7:d590:: with SMTP id r16mr16850650edq.355.1623010619108;
        Sun, 06 Jun 2021 13:16:59 -0700 (PDT)
Received: from PackardBell (192038129059.mbb.telenor.dk. [192.38.129.59])
        by smtp.googlemail.com with ESMTPSA id v8sm2211623edc.59.2021.06.06.13.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 13:16:58 -0700 (PDT)
Received: from localhost (PackardBell [local])
        by PackardBell (OpenSMTPD) with ESMTPA id 49482cf5;
        Sun, 6 Jun 2021 20:16:53 +0000 (UTC)
From:   Bartosz Dudziak <bartosz.dudziak@snejp.pl>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        David Sterba <dsterba@suse.com>, Jens Axboe <axboe@kernel.dk>,
        Bartosz Dudziak <bartosz.dudziak@snejp.pl>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/2] arm: qcom: Add SMP support for MSM8226
Date:   Sun,  6 Jun 2021 22:16:12 +0200
Message-Id: <20210606201612.100752-3-bartosz.dudziak@snejp.pl>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210606201612.100752-1-bartosz.dudziak@snejp.pl>
References: <20210606201612.100752-1-bartosz.dudziak@snejp.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement support for Cortex-A7 CPU release sequence in MSM8226 SoC.

Signed-off-by: Bartosz Dudziak <bartosz.dudziak@snejp.pl>
---
 arch/arm/mach-qcom/platsmp.c | 71 ++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/arch/arm/mach-qcom/platsmp.c b/arch/arm/mach-qcom/platsmp.c
index 630a038f45..60496554c6 100644
--- a/arch/arm/mach-qcom/platsmp.c
+++ b/arch/arm/mach-qcom/platsmp.c
@@ -29,6 +29,7 @@
 #define COREPOR_RST		BIT(5)
 #define CORE_RST		BIT(4)
 #define L2DT_SLP		BIT(3)
+#define CORE_MEM_CLAMP		BIT(1)
 #define CLAMP			BIT(0)
 
 #define APC_PWR_GATE_CTL	0x14
@@ -75,6 +76,62 @@ static int scss_release_secondary(unsigned int cpu)
 	return 0;
 }
 
+static int cortex_a7_release_secondary(unsigned int cpu)
+{
+	int ret = 0;
+	void __iomem *reg;
+	struct device_node *cpu_node, *acc_node;
+	u32 reg_val;
+
+	cpu_node = of_get_cpu_node(cpu, NULL);
+	if (!cpu_node)
+		return -ENODEV;
+
+	acc_node = of_parse_phandle(cpu_node, "qcom,acc", 0);
+	if (!acc_node) {
+		ret = -ENODEV;
+		goto out_acc;
+	}
+
+	reg = of_iomap(acc_node, 0);
+	if (!reg) {
+		ret = -ENOMEM;
+		goto out_acc_map;
+	}
+
+	/* Put the CPU into reset. */
+	reg_val = CORE_RST | COREPOR_RST | CLAMP | CORE_MEM_CLAMP;
+	writel(reg_val, reg + APCS_CPU_PWR_CTL);
+
+	/* Turn on the BHS and set the BHS_CNT to 16 XO clock cycles */
+	writel(BHS_EN | (0x10 << BHS_CNT_SHIFT), reg + APC_PWR_GATE_CTL);
+	/* Wait for the BHS to settle */
+	udelay(2);
+
+	reg_val &= ~CORE_MEM_CLAMP;
+	writel(reg_val, reg + APCS_CPU_PWR_CTL);
+	reg_val |= L2DT_SLP;
+	writel(reg_val, reg + APCS_CPU_PWR_CTL);
+	udelay(2);
+
+	reg_val = (reg_val | BIT(17)) & ~CLAMP;
+	writel(reg_val, reg + APCS_CPU_PWR_CTL);
+	udelay(2);
+
+	/* Release CPU out of reset and bring it to life. */
+	reg_val &= ~(CORE_RST | COREPOR_RST);
+	writel(reg_val, reg + APCS_CPU_PWR_CTL);
+	reg_val |= CORE_PWRD_UP;
+	writel(reg_val, reg + APCS_CPU_PWR_CTL);
+
+	iounmap(reg);
+out_acc_map:
+	of_node_put(acc_node);
+out_acc:
+	of_node_put(cpu_node);
+	return ret;
+}
+
 static int kpssv1_release_secondary(unsigned int cpu)
 {
 	int ret = 0;
@@ -281,6 +338,11 @@ static int msm8660_boot_secondary(unsigned int cpu, struct task_struct *idle)
 	return qcom_boot_secondary(cpu, scss_release_secondary);
 }
 
+static int cortex_a7_boot_secondary(unsigned int cpu, struct task_struct *idle)
+{
+	return qcom_boot_secondary(cpu, cortex_a7_release_secondary);
+}
+
 static int kpssv1_boot_secondary(unsigned int cpu, struct task_struct *idle)
 {
 	return qcom_boot_secondary(cpu, kpssv1_release_secondary);
@@ -315,6 +377,15 @@ static const struct smp_operations smp_msm8660_ops __initconst = {
 };
 CPU_METHOD_OF_DECLARE(qcom_smp, "qcom,gcc-msm8660", &smp_msm8660_ops);
 
+static const struct smp_operations qcom_smp_cortex_a7_ops __initconst = {
+	.smp_prepare_cpus	= qcom_smp_prepare_cpus,
+	.smp_boot_secondary	= cortex_a7_boot_secondary,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_die		= qcom_cpu_die,
+#endif
+};
+CPU_METHOD_OF_DECLARE(qcom_smp_msm8226, "qcom,msm8226-smp", &qcom_smp_cortex_a7_ops);
+
 static const struct smp_operations qcom_smp_kpssv1_ops __initconst = {
 	.smp_prepare_cpus	= qcom_smp_prepare_cpus,
 	.smp_boot_secondary	= kpssv1_boot_secondary,
-- 
2.25.1

