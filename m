Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B290B4528F5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 05:03:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241566AbhKPEFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 23:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241334AbhKPEFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 23:05:00 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53862C07C915;
        Mon, 15 Nov 2021 16:53:06 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id q12so4367299pgh.5;
        Mon, 15 Nov 2021 16:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=mQ4zBzdLNeEoEE74Qz4XRg/VBkFxechuDPINXlbW2qc=;
        b=VEU1Q9m+nafMaezjJbss0mGeK7ymabadCo5+aoUS/F2b7H4K5CZ731E2duImYM77uE
         M/jd5rLQt1f0y6D4OVNm+8Je8kFmLkE8OKO5Cab71ISBGPrOCrMTxCGC6WH+HtQogF+9
         lTEd0lDibWcJ9OXrkHxNyMPltK3hbFVzWfggQBw3oswWf3BwalmhG9r1ULbyVl0DPDN9
         t+TLg76Hp2hSst0XRDn67WmiV3Jtma3LMRgnHyF4g00ycZt4DHBuTUS6HHZYEBI9G72G
         PDjb1Nv3MiOVDqxk09bfedjwOgylWanBJHTXSr0eVJY0P/5ORf7UuN+fg/bd/nMaxNtp
         sI2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mQ4zBzdLNeEoEE74Qz4XRg/VBkFxechuDPINXlbW2qc=;
        b=gdDxaGmu6A4E8qrvzQrpkKaG+/Zr5BEyN3rtQOc+w6ceAYStuUw3k0YvBOkuTpBVom
         MbcYQFyibrc2auoqYAfAgsNYLobIVO3TC/A/PpU+jWusmWtaUKmUVZx5sFkpj91j0ex2
         xMb1xt5ka9VQtAJjGHeSYzvVrYZrtCrTtcg4v8Iwet53Iu7UhmMNE7fQtn3qg0wIJUmW
         s1fO1qQLynh7cGRlpRapE8UvFoj1jz7Vx2X8GRZq0mRWgwsJX3dEJUt4qmFHY5WK3kfu
         Ord5/n3e3foA0gDU/hc3Ql8LurlDD6GHRa9c5y2m78AtMuquXK1JDJMQf+STYNwrzyBt
         h3GQ==
X-Gm-Message-State: AOAM533/phbMmNMr7LUXkAtuVglIAwxgSMezJM96eyHG87SqaB/Srx5g
        uBR3uVA0pbwW2zOzut5wrRA=
X-Google-Smtp-Source: ABdhPJwWHpML+YUDcHJCudx7sqn0Ep4LzQiuRZB9kU2ct73HsNkMskXqdNdDQtw32VZtOAqRbi0FoQ==
X-Received: by 2002:a63:8c5c:: with SMTP id q28mr2247255pgn.244.1637023985989;
        Mon, 15 Nov 2021 16:53:05 -0800 (PST)
Received: from localhost.lan ([2400:4070:175b:7500::7a7])
        by smtp.gmail.com with ESMTPSA id 14sm4819960pge.35.2021.11.15.16.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 16:53:05 -0800 (PST)
Received: from x2.lan (localhost [127.0.0.1])
        by localhost.lan (Postfix) with ESMTPSA id 71755900957;
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
Subject: [PATCH] riscv: dts: sifive unmatched: Expose the PMIC sub-functions.
Date:   Tue, 16 Nov 2021 00:52:58 +0000
Message-Id: <0f5e86c3658817874f158b06f78cf2d4e8e1a9e5.1637023980.git.plr.vincent@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <f6512cc50dc31a086e00ed59c63ea60d8c148fc4.1637023980.git.plr.vincent@gmail.com>
References: <f6512cc50dc31a086e00ed59c63ea60d8c148fc4.1637023980.git.plr.vincent@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These sub-functions are available in the chip revision on this board, so
expose them.

Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>
---
 arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
index cf8937708829..270360b258b7 100644
--- a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
@@ -75,6 +75,18 @@ pmic@58 {
 		interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
 
+		onkey {
+			compatible = "dlg,da9063-onkey";
+		};
+
+		rtc {
+			compatible = "dlg,da9063-rtc";
+		};
+
+		wdt {
+			compatible = "dlg,da9063-watchdog";
+		};
+
 		regulators {
 			vdd_bcore1: bcore1 {
 				regulator-min-microvolt = <900000>;
-- 
2.33.1

