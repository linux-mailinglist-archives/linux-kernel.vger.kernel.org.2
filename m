Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A538D379860
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 22:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbhEJU3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 16:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232360AbhEJU3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 16:29:15 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFF0C06175F;
        Mon, 10 May 2021 13:28:09 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id j10so25266507lfb.12;
        Mon, 10 May 2021 13:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LjHfzBtzxjrf6ANvtSTjdzJ2Mz0ZhF/wkhq61KghsA0=;
        b=vNRkzbn/LQz89RWeVfxPfLmH4TOXwjFmkRzfstTGH7rgfxz7Ba5G8ZNGzfMRPzSp7d
         QMBggnSkfwa7Pk2YXow5OG0S+ZZX8X7cW0ytkAOxHTc4y5rdXzOumNWDWjQZdxICJpPi
         HuZnKmna2jqujs6BAcgHSPowanofqcxmEShEn0JvQTN1vPUPiWCHJ2hxAAZPknXS2FSl
         yH1USUJekDww08tqBx0WZJPcj9AuRBSQEG0pTJh1FqsymHLUL+Om5ujNDBV6ELABLu6i
         AAGO/Y3dJ8yF/a8iZO5lO79jq3ZyPFwZxFhMQSblPlnJgR27plCkXmb422Q4rE4RHPYA
         IMpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LjHfzBtzxjrf6ANvtSTjdzJ2Mz0ZhF/wkhq61KghsA0=;
        b=G0tpjK7rQPPtryG0Cgm0k3qrjaDKgvHs/37KeyBNNQ7sqbP7dGiC7BFGaVUWYnghQj
         mFuXk5YJLEmsunVn4hzbYXeQYmu+M6aarjeaG1g8Fmx+cka7AaBfrxFRIw6LYa0e7wk9
         /ITx0rllBViGTxivWqLgB9iPd5YqHqgWpJ+OhLIpjFeHuZ0MLCoIFMraimQUorSLxkEz
         LDJt/r5xWMaSJ9xhFTj9rLV116o9X8C1kcL4J7eI+EGeoxbrNve7PkPvchTGSLnitAKJ
         WRJugq7ofG5r7sJQsvV9ICQirb7a67qXv3U5DxDiWey2CEYukdoITGlMNITgCpUcI7pu
         0mjA==
X-Gm-Message-State: AOAM5313nSgNb2hRKsK8EsnmTnQO//KtBhUsdZAuTk8yNPeSy2rDwSuW
        bwYWSga7lYODQjMjz3eThU0=
X-Google-Smtp-Source: ABdhPJxO3nFuMml5R4G+4fGztoX7er10cHW4039qV6NXidT1lLC8voca7FrtJq5hKPtcthEA8izCrA==
X-Received: by 2002:a19:c317:: with SMTP id t23mr18654719lff.5.1620678488548;
        Mon, 10 May 2021 13:28:08 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-91.dynamic.spd-mgts.ru. [109.252.193.91])
        by smtp.gmail.com with ESMTPSA id z23sm2360662lfq.241.2021.05.10.13.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 13:28:08 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Agneli <poczt@protonmail.ch>, Paul Fertser <fercerpav@gmail.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 07/10] ARM: tegra: nexus7: Add i2c-thermtrip node
Date:   Mon, 10 May 2021 23:25:57 +0300
Message-Id: <20210510202600.12156-8-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210510202600.12156-1-digetx@gmail.com>
References: <20210510202600.12156-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i2c-thermtrip node which enables emergency shutdown by PMC on
SoC die overheat detected by TSENSOR.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../boot/dts/tegra30-asus-nexus7-grouper-maxim-pmic.dtsi | 9 +++++++++
 .../boot/dts/tegra30-asus-nexus7-grouper-ti-pmic.dtsi    | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-maxim-pmic.dtsi b/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-maxim-pmic.dtsi
index 17b6682ffce8..53966fa4eef2 100644
--- a/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-maxim-pmic.dtsi
+++ b/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-maxim-pmic.dtsi
@@ -182,4 +182,13 @@ regulator@4 {
 		enable-active-high;
 		vin-supply = <&vdd_3v3_sys>;
 	};
+
+	pmc@7000e400 {
+		i2c-thermtrip {
+			nvidia,i2c-controller-id = <4>;
+			nvidia,bus-addr = <0x3c>;
+			nvidia,reg-addr = <0x41>;
+			nvidia,reg-data = <0xe0>;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-ti-pmic.dtsi b/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-ti-pmic.dtsi
index b97da45ebdb4..06b5e8a5ce5d 100644
--- a/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-ti-pmic.dtsi
+++ b/arch/arm/boot/dts/tegra30-asus-nexus7-grouper-ti-pmic.dtsi
@@ -147,4 +147,13 @@ vdd_3v3_sys: regulator@1 {
 		gpio = <&pmic 7 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
+
+	pmc@7000e400 {
+		i2c-thermtrip {
+			nvidia,i2c-controller-id = <4>;
+			nvidia,bus-addr = <0x2d>;
+			nvidia,reg-addr = <0x3f>;
+			nvidia,reg-data = <0x80>;
+		};
+	};
 };
-- 
2.30.2

