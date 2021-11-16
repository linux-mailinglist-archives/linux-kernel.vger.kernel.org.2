Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACD804528F1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 05:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241505AbhKPEF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 23:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241327AbhKPEFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 23:05:00 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABC4C07C914;
        Mon, 15 Nov 2021 16:53:06 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id gt5so14306757pjb.1;
        Mon, 15 Nov 2021 16:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=wt28/gXv7rd70jokBmRNQ4HFfWSUY5adpHknddEwpQM=;
        b=cmoR/uvRZCYHiW23dDQn8hsx2eu3WaFfYi1csQ/NbY3/XY0KBLwp3xh2Oc7aTe1Hdq
         iBMC293nQA5XJadNKCCVuAdTaFWwh9ibzdDZvmPT1hnm2caovByw/VXk0y+uUEw+DGYu
         ZANXmp898h/7gI+GgvhzUsFVNjzBWLIFxwRxKXILMeT2vNKGPxkZoNb1gTCk1Gm3/jb3
         TWPwIbwFTru3IDTyvBNhGEn1Fka95OXRftAZfBMEkMd78Q8JtA6SvCMfZugOuASJYrj4
         7RGqacnnY2xDWKTtmyK662m3DSDU1y5HpThhPLYn3dsLucXmFTngxDj2UXZQuNX1DPRy
         490w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wt28/gXv7rd70jokBmRNQ4HFfWSUY5adpHknddEwpQM=;
        b=b/Pa0E1jA79bgSNNvCE4P48ka6DrN/sF/AXonoEGBCoJU70tkXssiJzZ94OK7OOQeL
         2Pl0xz1x24k1Z+B7SU0JdMEwlDFL8plMfxLJi6K4vCqau730G0GQGvF3uHp1xAqIA2tv
         95NxFcy7KV9SToZH+4WWcoz4j3DEkp+we2loEQfeyUaJC2tih9HOMYWR0Jm+sL6Vd7xs
         pvbZN6yAQWuOVO/1u442N9IL8pb5gGpND/fFox5e+X+EX4ahwbZKEfD1Jadu2adIJEi1
         aCSNtGT2bh41/mcpNMmnvMArWGnKMZt5UbHbxZlQOkugRro8HLk48afUBLRX6sj58cp4
         yCcw==
X-Gm-Message-State: AOAM532g9Ra3MT2Zz+vFBtZgYyYNG0zNbmvW9V2C/Ika88XzPpzodIpx
        74TbrPY4H2AxRnNMR7vwPnY=
X-Google-Smtp-Source: ABdhPJx3oxgmqZPrNfa+Gj01j7IcRdcW1OiyaiwfxsUYOmy8BhuDeJ/HRuCz40hEir8Hs16UtzznVQ==
X-Received: by 2002:a17:90b:1b0a:: with SMTP id nu10mr69147337pjb.35.1637023985802;
        Mon, 15 Nov 2021 16:53:05 -0800 (PST)
Received: from localhost.lan (p4899162-ipngn25301marunouchi.tokyo.ocn.ne.jp. [122.18.9.162])
        by smtp.gmail.com with ESMTPSA id l21sm435129pjt.24.2021.11.15.16.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 16:53:05 -0800 (PST)
Received: from x2.lan (localhost [127.0.0.1])
        by localhost.lan (Postfix) with ESMTPSA id 6F9EE900956;
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
Subject: [PATCH] riscv: dts: sifive unmatched: Expose the board ID eeprom.
Date:   Tue, 16 Nov 2021 00:52:57 +0000
Message-Id: <eaf9679c4c93b68fd8b7a427ceb8ef59387fe925.1637023980.git.plr.vincent@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <f6512cc50dc31a086e00ed59c63ea60d8c148fc4.1637023980.git.plr.vincent@gmail.com>
References: <f6512cc50dc31a086e00ed59c63ea60d8c148fc4.1637023980.git.plr.vincent@gmail.com>
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

