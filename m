Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3CD41949D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 14:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234486AbhI0Mwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 08:52:36 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:40346
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234444AbhI0Mwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 08:52:31 -0400
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E95E74085A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 12:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632747052;
        bh=kbXZWPaqkE+qi2UkSZceVKtKOIxxsWqidwnT9f4+61Y=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=GWdLsZgzrhZ3S+Dm9xPuyEGepjLZz058w3zuCjtM9L7IG6v5NnyG5mVYAdAYqq4XU
         PFazH1K3fB36Qu18CdR765IPVzqSAy/tOkhhARhH9+ZIsjooYMwsoASZ7umP6rczss
         7VG4IGiFzc6/eqYEjAq8o8kiX0aSgCD8l2Bfuje01xOVnyqV3simJ4PM10tlIIXW8L
         4tkkwiNIZbT7iQFfmQKQnYK9ushiolXqhNLKS/IlNkq+3dbk1Mj7T4euaVn+8LOVS4
         er5oGU7QONDYOrgJiIfo6M97ep5w8EHoPUXKHdbVisFJkI2zBYr4Gu3mcuk6T3ErWS
         eODtSUHH+SBQA==
Received: by mail-lf1-f71.google.com with SMTP id g9-20020a0565123b8900b003f33a027130so15735889lfv.18
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 05:50:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kbXZWPaqkE+qi2UkSZceVKtKOIxxsWqidwnT9f4+61Y=;
        b=hlJ0IaRChwoIWPtvQELocwrjsBntep/PG8ycZVm7Jw9w0EwWAEdUxsreQF4ChsOOl6
         93tiVv2eo/4AJcBXzYbWY+g9vKGXC9uPp1BAv1EjTiPx0dzOh1zarHTi+t1KN5r+B1Er
         pSBS7scjE8gEQhZQ1ZggpXXxaXRmJ9cVz/sjuOKTGkZ5rcUCZ8uDYraCTuCh2N3d2tCT
         jFY9KPZJksLOVXOhzw3boIA0RgVOhh9OyTqH1sHQ6lzs+8DQm509Jnz93J5I8SWRzUIm
         +scOK+xl/cphJo4H8Pc5u5jrIaPUxBaVHsq+RQfLQXqH8+z49NfPHWILax/Icuhx6VAA
         XkSQ==
X-Gm-Message-State: AOAM53061vtjjalR2g4sFJa6KKkDL9bVEtIy+JV2RBRvM8gGInrAFzok
        t1Rk7+e6EQ9JZWwj7iGzVq2TMOaWxWyyVchg+mAPk19QYwV2FRiqcm4DW9ZFwkn6GKb68Nniam4
        0TFy3sE+xShad6LvgEImS8OKtVVL/xN0fsiEHnmOwAQ==
X-Received: by 2002:ac2:47ed:: with SMTP id b13mr25204257lfp.647.1632747051399;
        Mon, 27 Sep 2021 05:50:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMaM9Tc/3Sf/+ppdhry9L6l8UQ0qQ8h8nkUrM4xE3wk1hVkdcDG25FWuf57DjlukjnWtXjcQ==
X-Received: by 2002:ac2:47ed:: with SMTP id b13mr25204228lfp.647.1632747051152;
        Mon, 27 Sep 2021 05:50:51 -0700 (PDT)
Received: from localhost.localdomain (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id v28sm1592102lfi.22.2021.09.27.05.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 05:50:50 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Piotr Sroka <piotrs@cadence.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v4 3/6] riscv: dts: microchip: fix board compatible
Date:   Mon, 27 Sep 2021 14:50:41 +0200
Message-Id: <20210927125044.20046-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210927125044.20046-1-krzysztof.kozlowski@canonical.com>
References: <20210927125044.20046-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to bindings, the compatible must include microchip,mpfs.  This
fixes dtbs_check warning:

  arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dt.yaml: /: compatible: ['microchip,mpfs-icicle-kit'] is too short

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

---

Changes since v3:
1. Rename DTSI model to Polarfire SoC.
2. Add tags.

Changes since v1:
1. Use microchip,mpfs for microchip-mpfs.dtsi, suggested by Geert.
---
 arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts | 2 +-
 arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi           | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
index 3b04ef17e8da..07f1f3cab686 100644
--- a/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
+++ b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
@@ -10,7 +10,7 @@
 
 / {
 	model = "Microchip PolarFire-SoC Icicle Kit";
-	compatible = "microchip,mpfs-icicle-kit";
+	compatible = "microchip,mpfs-icicle-kit", "microchip,mpfs";
 
 	aliases {
 		ethernet0 = &emac1;
diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
index 93730afe6c58..1d04c661bccf 100644
--- a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
@@ -6,8 +6,8 @@
 / {
 	#address-cells = <2>;
 	#size-cells = <2>;
-	model = "Microchip MPFS Icicle Kit";
-	compatible = "microchip,mpfs-icicle-kit";
+	model = "Microchip PolarFire SoC";
+	compatible = "microchip,mpfs";
 
 	chosen {
 	};
-- 
2.30.2

