Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A79A45792F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 23:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234847AbhKSW7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 17:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233493AbhKSW67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 17:58:59 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5CFC061574;
        Fri, 19 Nov 2021 14:55:57 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id g19so10540953pfb.8;
        Fri, 19 Nov 2021 14:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1TdlIUtILM24Fc2UXh8s4SrJCWxmjGMPvwtQIlJ5JvA=;
        b=k2ZKvdwo7VNV+6taHj2fBaQjreLV5crFPY+WVis2Pge4ac9Mzc5G3ZwcQ2XI/toKiz
         xam+oXmu1ckuI1WGKNF52sYPFOef+cFtDEKM64+A07/pj7L0kVuLGq0fxswUolb3I+uQ
         63K2txyOMIhP4wl0SSck86zX9pkqMArenANzIYG2NlHiORlmes/+5wFuI7i023zMWRfb
         ysvBVueVKaeO/PAwCIX79vc0EvIhEvRVrKP4kX4oMm8J6Sxx8pIWqpxZV/zZsHCdW2IN
         btGSnFt2tNg3lWvXuzUMoFkk1BG5YuwYXyvW0eKWf/lKAjlgq1f1yyD/C/01PmBK/Ub3
         33ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1TdlIUtILM24Fc2UXh8s4SrJCWxmjGMPvwtQIlJ5JvA=;
        b=3qlLk9/A+OodoWl4CzlYA7tDnwJPRBxBa506ays87KiLVasoHzW+0L1NqvOgrH8J8k
         o+88LZ2yqPJi2hNSdyxzOVQHBAsjhhsEEiE6ETIv8AgLo+opyoId4uMYGzRbzpkU9spg
         CCKA6P+1RDmmZLox8PFt1tLadPuGEh9Zuv88OUqCTEvmjqn8YqdtHvbMVfD5I7jdjPvK
         GByfAggYCdrnzzCNTQuuwEjfNisuSDx2yMFRmU+EbT+eVS5k2gnvNBroKu4uo9l6gdwu
         HeD3J9YgfVLiJcS5Y1eZwVukIeaDNRcLhKN6/8+dGhu3OVyvNYYqSDfEEqXzZESYiC7Q
         7M2Q==
X-Gm-Message-State: AOAM532EuAsV/nk7A4zcyz4kaP5/sMdXoVVc+bIbvFv4sE209MIJV/jI
        eosaok1WVAbIUMa5bHnE7c8=
X-Google-Smtp-Source: ABdhPJzxs/PXuLiHQU2pcYAU1NtTrlRYL9Jvb4fvqk3t4JTK6e+qbvibiIGhHAjqqEhI2g7tePcFdg==
X-Received: by 2002:a63:844a:: with SMTP id k71mr9951068pgd.101.1637362557132;
        Fri, 19 Nov 2021 14:55:57 -0800 (PST)
Received: from localhost.lan ([2400:4070:175b:7500::7a7])
        by smtp.gmail.com with ESMTPSA id x18sm618413pfh.210.2021.11.19.14.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 14:55:56 -0800 (PST)
Received: from x2.lan (localhost [127.0.0.1])
        by localhost.lan (Postfix) with ESMTPSA id 2AAD7900956;
        Fri, 19 Nov 2021 22:55:55 +0000 (GMT)
From:   Vincent Pelletier <plr.vincent@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Qiu Wenbo <qiuwenbo@kylinos.com.cn>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        David Abdurachmanov <david.abdurachmanov@sifive.com>
Subject: [PATCH v3 2/6] riscv: dts: sifive unmatched: Expose the board ID eeprom
Date:   Fri, 19 Nov 2021 22:55:38 +0000
Message-Id: <589539cd08e35c35b269a769caeac40b85ffd01c.1637362542.git.plr.vincent@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <378c64fb868b595430b0068a9af10fdbeceb8e12.1637362542.git.plr.vincent@gmail.com>
References: <378c64fb868b595430b0068a9af10fdbeceb8e12.1637362542.git.plr.vincent@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark it as read-only as it is factory-programmed with identifying
information, and no executable nor configuration:
- eth MAC address
- board model (PCB version, BoM version)
- board serial number
Accidental modification would cause misidentification which could brick
the board, so marking read-only seem like both a safe and non-constraining
choice.

Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>

---
Changes since v2:
- Fix end-of-commit-message separator so change lists do not end up in them.
Changes since v1:
- Remove trailing "." on subject line.
---
 arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
index 305a086e5207..cf8937708829 100644
--- a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
@@ -58,6 +58,16 @@ temperature-sensor@4c {
 		interrupts = <6 IRQ_TYPE_LEVEL_LOW>;
 	};
 
+	eeprom@54 {
+		compatible = "microchip,24c02", "atmel,24c02";
+		reg = <0x54>;
+		vcc-supply = <&vdd_bpro>;
+		label = "board-id";
+		pagesize = <16>;
+		read-only;
+		size = <256>;
+	};
+
 	pmic@58 {
 		compatible = "dlg,da9063";
 		reg = <0x58>;
-- 
2.33.1

