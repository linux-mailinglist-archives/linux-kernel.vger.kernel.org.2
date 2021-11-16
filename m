Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 913D64528F6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 05:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241622AbhKPEF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 23:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241336AbhKPEFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 23:05:01 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED16C07C917;
        Mon, 15 Nov 2021 16:53:06 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id gt5so14306764pjb.1;
        Mon, 15 Nov 2021 16:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jO8DHdz6ka/B1BYuotJwYwQ7xtBreOe1PucIcCXxUqM=;
        b=PCFfee0RLp2Y4um38Yr1zP4bxQnSYMojtp5EfSe1uMHuMo98S/96Ms6hC/yYD1Ey3j
         STl7g8a8j+pZfZFllwz/39ckoH0mQ8SBSFnG7Rt4Iij+GPYpuDf97da8pDiPhJT2+Kyo
         f5DyF81zQRd4HGW55J3X7yPwWiXbiXHpO/EEypOWkDbSEqgF4lG0ApLS/JPLXhC2wX91
         /cxO+YDqm0uBSNqSAjSFZNSbPvc0CCzvKpTBZtEQmeOejx61rampIVRDKPU8RuXRpQK7
         ye1yrx4A9zmantWqU6L9UWN+uLJlU0EYkP/xVvHcVYU20tDAVuLIBVG4cjgys24PEjg1
         1r4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jO8DHdz6ka/B1BYuotJwYwQ7xtBreOe1PucIcCXxUqM=;
        b=ro3xrUUTlh09d9hyFjyEPXuTcVbpI2ts54lXjlLwjAPoVZbcLqUgcT2nS1I7cWssXd
         1GcV/bAUpAvmgLuBSFpJjUTM/yK3X3CYFI0mDApY8vtR/fJaCI5x0cfP+24dh0v1SAS2
         o2bAShOcR1q5d5iRfv1R25fijZIhnSv3YwEpl/K8E0s9d9BcjBPEfDnhKrugEA46LY2N
         Gpxg1fsR3WyN01uazicO6SkDoZOnwS9sMYZvlQVH3w9wnVmddeqd8AN4TKPhfK4OXCYM
         ggQ9RHKIJ28ZF1F4NieRDQ4CLMWZOrjdJ/MLin3nA8+o7xkdv+BNnn3Z57pF8DrdpiAF
         R+8A==
X-Gm-Message-State: AOAM533t0nwOTN1e48/WiG79b345E2Tsx0K/ljzarDzrO3CL768NojMY
        W+JYX14r5OGEha7h4r9wbdpom1IvaxfOC0eL
X-Google-Smtp-Source: ABdhPJzNtsiLSYI0RPWPUWoD8tW+Hs4I+0ls35cXKOz5IZL2XwzBwwUsAtJUbVxmer1D+IiCFBWHww==
X-Received: by 2002:a17:90b:128d:: with SMTP id fw13mr3682017pjb.50.1637023986152;
        Mon, 15 Nov 2021 16:53:06 -0800 (PST)
Received: from localhost.lan (p4899162-ipngn25301marunouchi.tokyo.ocn.ne.jp. [122.18.9.162])
        by smtp.gmail.com with ESMTPSA id k1sm16912060pfu.31.2021.11.15.16.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 16:53:05 -0800 (PST)
Received: from x2.lan (localhost [127.0.0.1])
        by localhost.lan (Postfix) with ESMTPSA id 632C2900949;
        Tue, 16 Nov 2021 00:53:03 +0000 (GMT)
From:   Vincent Pelletier <plr.vincent@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Qiu Wenbo <qiuwenbo@kylinos.com.cn>,
        Yash Shah <yash.shah@sifive.com>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Abdurachmanov <david.abdurachmanov@sifive.com>
Subject: [PATCH] riscv: dts: sifive unmatched: Name gpio lines.
Date:   Tue, 16 Nov 2021 00:52:56 +0000
Message-Id: <f6512cc50dc31a086e00ed59c63ea60d8c148fc4.1637023980.git.plr.vincent@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow the pin descriptions given in the version 3 of the board schematics.

Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
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

