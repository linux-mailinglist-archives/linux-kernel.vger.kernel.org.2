Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE30A457931
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 23:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234989AbhKSW7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 17:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234188AbhKSW7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 17:59:00 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C9AC061574;
        Fri, 19 Nov 2021 14:55:57 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id gt5so8995643pjb.1;
        Fri, 19 Nov 2021 14:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jZmwgkqEaqsNB6eacHx7jGF/Uov9dTZSX+ljfrl1HKM=;
        b=V/IOvaCPhLruyYv/u2Pwu2NAOOo24zKaeNHGVUHXALOkFK9Pwu8No8GbinVvdCrgTP
         ug4Vi0nd4UzDVYnYLpI4WJmWOrNw/nkJrXv1T82n5t3XfkPIP2jTpRAXSZjDliM+5Bbc
         QuOYAJ5EVj+AOyTmdF18djuKSKaC3+NTMOq+2WFMXWZd+Ej4bSlyuobr5YZtKY1Sojcp
         nE7sjHSQ362M9iksil66vUXNXsosL2nd53i4/KQfJD6MEcWdQYjUlrnt1xFCfl91dRfA
         /lkRUxljcAmAr9f2sKAuShrXFsKGgglbIrG7lSPdhgx1cgWbEf6huX/7mDzt7FN0ontm
         TuAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jZmwgkqEaqsNB6eacHx7jGF/Uov9dTZSX+ljfrl1HKM=;
        b=tM1JHGUIzhcyzOV/gtFdOlYZcsdWW4yK9SqGT6ZbffR9d8EoL3WUHAbKkBRr02KNLK
         ZT2novdtOwA5xACn27UPMkLmqjdIOAZRL/luzGmY5a4i8rf3/mAfLMHMq2jPZ8zM/XvA
         B3QdicbwPZaKTVBiktMt7I0iudbk0J5LfuXULdTJDnt324qxFgdsUCjg5aU3TQEb2X8k
         RCvWnFvXBa/3RGF/OqPr5/OC+lwHqop2e85vRqiHXVAsH/eVtmSQeKpdPWbps8eNuZ/y
         iqCcfYV9pyQDnqcAudcUQU12GHzzwoylCTxu+XICi14U70LAwpPefEYtnVCOw/HxzqVy
         W6Mg==
X-Gm-Message-State: AOAM531DxnNIaQajJbqPIJsaQHkoorAT5hQmsEqgS7CiOxLRRcMCNJVa
        bqdL6HPmefip6KofvcI2Knw=
X-Google-Smtp-Source: ABdhPJz95l/urJMhGxpdaJPNfeHFnuLnqGtNyiFrtqE2iDlD9RvfTthWn9SEdWafPaD5FVqbnhABhg==
X-Received: by 2002:a17:90a:7004:: with SMTP id f4mr4103477pjk.156.1637362557584;
        Fri, 19 Nov 2021 14:55:57 -0800 (PST)
Received: from localhost.lan (p4857108-ipngn27301marunouchi.tokyo.ocn.ne.jp. [114.164.215.108])
        by smtp.gmail.com with ESMTPSA id f21sm658610pfc.191.2021.11.19.14.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 14:55:57 -0800 (PST)
Received: from x2.lan (localhost [127.0.0.1])
        by localhost.lan (Postfix) with ESMTPSA id 1B297900921;
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
Subject: [PATCH v3 1/6] riscv: dts: sifive unmatched: Name gpio lines
Date:   Fri, 19 Nov 2021 22:55:37 +0000
Message-Id: <378c64fb868b595430b0068a9af10fdbeceb8e12.1637362542.git.plr.vincent@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow the pin descriptions given in the version 3 of the board schematics.

Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>

---
Changes since v2:
- Fix end-of-commit-message separator so change lists do not end up in them.
Changes since v1:
- Remove trailing "." on subject line.
---
 arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
index 4f66919215f6..305a086e5207 100644
--- a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
@@ -245,4 +245,8 @@ &pwm1 {
 
 &gpio {
 	status = "okay";
+	gpio-line-names = "J29.1", "PMICNTB", "PMICSHDN", "J8.1", "J8.3",
+		"PCIe_PWREN", "THERM", "UBRDG_RSTN", "PCIe_PERSTN",
+		"ULPI_RSTN", "J8.2", "UHUB_RSTN", "GEMGXL_RST", "J8.4",
+		"EN_VDD_SD", "SD_CD";
 };
-- 
2.33.1

