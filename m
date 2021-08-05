Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 911323E1EA3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 00:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240361AbhHEW2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 18:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239865AbhHEW2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 18:28:44 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDDEC0613D5;
        Thu,  5 Aug 2021 15:28:30 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id dw2-20020a17090b0942b0290177cb475142so18447092pjb.2;
        Thu, 05 Aug 2021 15:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TR1r9V+hd8xcQrbIhhyYGERXkzqKnmp/yYfpwm5Qa7o=;
        b=eDkLQqI6KBcq68piTi/kCGeXAuwS+6vgt/1vFMFS66Xz2Nj45a0U0oDjgv6/iIPZDX
         oNc8NhITVCzK4gvbUSvCa9YXmz3aA6RAOkfOb3eUNxpImk7uuwmAZbGqZV4LIPQw1Nq/
         LmPYrYcK3VA14PAgCeM3Jncbw2XrX+Bfs8N742YhyT+tN9xWavotc8WVDI0vwyoJ0+HK
         a3L9FpaZLnaTJGf9y/iPO1ZpZXe2RGyIHrPYZf1djMvFEkn+EX6vedun1CxEj+Vc24L8
         f+ye0iB6+F84BzbHmb3+ChuyoJMahHwZjWSPiUp938QSZmE3oIkEjYe47ONCiNuZY7AY
         hFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TR1r9V+hd8xcQrbIhhyYGERXkzqKnmp/yYfpwm5Qa7o=;
        b=ROqtqVBbF0KmfNucNILLSRPU8yJSXLvrqcZwODLAaeHuVr2xx3gcH59H2DBs47Tuyo
         Uof5uXoHTSLn/m5Bpz3PfOMkpZhVY5zqo0qaWoDcWw+g0oANMMOddrR41DXIT/wk42kZ
         GHbbu6al6g5sTjdiZWcRA8yA0sGWON6k4hw0v1jyy7ZYANkYIQY7Xri2ZSH7PYEaMqtL
         Mi4DSQHNlOIFfirt2nZzVvdCYXCl4DJqxzFiVZ8zWc24laxOOfXlr/Q/ZFWhUhnjTNqe
         uwTh4ZVG5S3EY+QwjFAKFA5srr7o0UNkAa2OV0T7UP35mneSuV/VtKQXoVGY6IdLHpMI
         CWGw==
X-Gm-Message-State: AOAM5327xs5QORe3xMCLmkabT3E0ska+sHwP4u+aUOtkEloaJWkGmdTt
        d/CM2Bd5T6C0KDoBfEyHyrg=
X-Google-Smtp-Source: ABdhPJyrQZG82agY7vsjAnNxKZ0mN6nB8d0Zxt4KZA9v2izYx97kafZ4Q5fVX/Tl5bgq8F+2OYoKdg==
X-Received: by 2002:aa7:9906:0:b029:3c7:a6a1:c73d with SMTP id z6-20020aa799060000b02903c7a6a1c73dmr1764963pff.1.1628202509864;
        Thu, 05 Aug 2021 15:28:29 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id b26sm8082292pfo.47.2021.08.05.15.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 15:28:29 -0700 (PDT)
From:   rentao.bupt@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH v2 1/6] ARM: dts: Add Facebook BMC 128MB flash layout
Date:   Thu,  5 Aug 2021 15:28:13 -0700
Message-Id: <20210805222818.8391-2-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210805222818.8391-1-rentao.bupt@gmail.com>
References: <20210805222818.8391-1-rentao.bupt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

This is the layout used by Facebook BMC systems. It describes the fixed
flash layout of a 128MB mtd device.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 Changes in v2:
  - None.

 .../dts/facebook-bmc-flash-layout-128.dtsi    | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 arch/arm/boot/dts/facebook-bmc-flash-layout-128.dtsi

diff --git a/arch/arm/boot/dts/facebook-bmc-flash-layout-128.dtsi b/arch/arm/boot/dts/facebook-bmc-flash-layout-128.dtsi
new file mode 100644
index 000000000000..7f3652dea550
--- /dev/null
+++ b/arch/arm/boot/dts/facebook-bmc-flash-layout-128.dtsi
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2020 Facebook Inc.
+
+partitions {
+	compatible = "fixed-partitions";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	/*
+	 * u-boot partition: 896KB.
+	 */
+	u-boot@0 {
+		reg = <0x0 0xe0000>;
+		label = "u-boot";
+	};
+
+	/*
+	 * u-boot environment variables: 64KB.
+	 */
+	u-boot-env@e0000 {
+		reg = <0xe0000 0x10000>;
+		label = "env";
+	};
+
+	/*
+	 * image metadata partition (64KB), used by Facebook internal
+	 * tools.
+	 */
+	image-meta@f0000 {
+		reg = <0xf0000 0x10000>;
+		label = "meta";
+	};
+
+	/*
+	 * FIT image: 119 MB.
+	 */
+	fit@100000 {
+		reg = <0x100000 0x7700000>;
+		label = "fit";
+	};
+
+	/*
+	 * "data0" partition (8MB) is used by Facebook BMC platforms as
+	 * persistent data store.
+	 */
+	data0@7800000 {
+		reg = <0x7800000 0x800000>;
+		label = "data0";
+	};
+
+	/*
+	 * Although the master partition can be created by enabling
+	 * MTD_PARTITIONED_MASTER option, below "flash0" partition is
+	 * explicitly created to avoid breaking legacy applications.
+	 */
+	flash0@0 {
+		reg = <0x0 0x8000000>;
+		label = "flash0";
+	};
+};
-- 
2.17.1

