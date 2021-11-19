Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2FB9457930
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 23:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234949AbhKSW7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 17:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234177AbhKSW7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 17:59:00 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA726C061748;
        Fri, 19 Nov 2021 14:55:57 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id p18so9194689plf.13;
        Fri, 19 Nov 2021 14:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3C4LuMh2VIE+wfKLtAY46glakCgCNvxeiTkI8GKqos4=;
        b=R+ZIw1XKRLZ9ySesQABrbTWa4gMlZwrFq+FIouSxHvqdXBsAwtrFP+20qRmNwSFRvc
         DASSwnuV+c32ig0DWg0QuxGajbinT4SwAe6f8klUqA4v4AURwQHOi40D1/L+8HVnMUrH
         0FVznStLfU4IUALgW01U346ZlgwER3uex4ce43vmToFZBFIr9qE4L2+QNwShn/lcCPf/
         R10lNKpqsqe5QPjR8fdIgq+5KDcEVR6c9GSbBX0CP30YVyBpuJjdXf2LN2ruIhLO+UzE
         ZjtUCWmEU3SDnJs0YztmLQd868/zlWs0x82wvtShX9ZP4x8ZqmIdtyuRdkCc8PTtGmny
         lljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3C4LuMh2VIE+wfKLtAY46glakCgCNvxeiTkI8GKqos4=;
        b=rNKUWwZxsTJ8go6N9y7VRVF3liM6+le76vyXk60dzNKN44HA6VZJc2AMmQdXa9ZyFE
         i0l01dEWV0L/0RJvLP9iJUh7Nd7/teTCg2HrQ9X9nTdvglsjHMq3zoSsknqXMhtzCSaC
         GKGyZ+umwVfSKwBxLg9Y47NBeMXx4V1KjqnfQoW5G9TkkJvp0bIqt0t9whVRPW5N8SIw
         3PSyoUUQovvH6YIdErACKz1IK9vRenP4/ykEk+dWWumiRMWIQT94WGxbEwr1aZHcdFuD
         buwOdilFZLO8wOVLvgCssSTeXQr1nLKh64259Ho+uAr8SiyEGkh0ax8rU0kRanzIcDqL
         bpKg==
X-Gm-Message-State: AOAM533frL8ABABABpwbHV70GEsoEzRdy1zvIIwXsMsgfOMJQmi95ISK
        LmKAzMQA21AJtwg4CFPkBpg=
X-Google-Smtp-Source: ABdhPJwY8Ho1qj5lw0Ln31TtjBdyghc07ysy3t1VPuYmJWU2d5GkuGWEIMcZg5LZFL6DFOjcVGO/Dg==
X-Received: by 2002:a17:903:1247:b0:143:b9b9:52a2 with SMTP id u7-20020a170903124700b00143b9b952a2mr65752312plh.35.1637362557406;
        Fri, 19 Nov 2021 14:55:57 -0800 (PST)
Received: from localhost.lan (p4857108-ipngn27301marunouchi.tokyo.ocn.ne.jp. [114.164.215.108])
        by smtp.gmail.com with ESMTPSA id me7sm13446042pjb.9.2021.11.19.14.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 14:55:56 -0800 (PST)
Received: from x2.lan (localhost [127.0.0.1])
        by localhost.lan (Postfix) with ESMTPSA id 38B68900957;
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
Subject: [PATCH v3 3/6] riscv: dts: sifive unmatched: Expose the PMIC sub-functions
Date:   Fri, 19 Nov 2021 22:55:39 +0000
Message-Id: <d309ed6c649eb6b8b0e5e06b016a3eacbe845159.1637362542.git.plr.vincent@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <378c64fb868b595430b0068a9af10fdbeceb8e12.1637362542.git.plr.vincent@gmail.com>
References: <378c64fb868b595430b0068a9af10fdbeceb8e12.1637362542.git.plr.vincent@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These sub-functions are available in the chip revision on this board, so
expose them.

Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>

---
Changes since v2:
- Fix end-of-commit-message separator so change lists do not end up in them.
Changes since v1:
- Remove trailing "." on subject line.
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

