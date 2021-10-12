Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3C7342ED85
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 11:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237279AbhJOJ0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 05:26:46 -0400
Received: from ixit.cz ([94.230.151.217]:58764 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236767AbhJOJ0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 05:26:44 -0400
Received: from newone.brmlab.cz (unknown [91.146.121.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id ED93B20064;
        Tue, 12 Oct 2021 20:16:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1634062607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=SPc2IVyrD8PWJ0VNqHMWOp4R+CLAD6uPKyK1HWCBuvM=;
        b=NxoDur6Bo0a/HM/iP9MVw4/SB26HAHb85m3Wjb7NR/90kDgKUiaEe4UrSbLj6sHudfwzGL
        m/5Ll4ToquA6xv2C/tECOo/540dunlpJobgsiLPrB2jRwTt5q+LysokRXlDDZNCwEYQXUe
        Oba0YvMQWYQLTW8oPHPE6hh+/GhrcjI=
From:   David Heidelberg <david@ixit.cz>
To:     Rob Herring <robh+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: [PATCH v2 1/4] arm64: dts: qcom: SMxxxx: drop msg-size property from ramoops
Date:   Tue, 12 Oct 2021 20:14:57 +0200
Message-Id: <20211012181500.5309-1-david@ixit.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Invalid property, not supported by ramoops node.

Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts | 1 -
 arch/arm64/boot/dts/qcom/sm6350.dtsi                         | 1 -
 arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi      | 1 -
 arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi         | 1 -
 4 files changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
index 58b6b2742d3f..64f1eab99d5e 100644
--- a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
+++ b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
@@ -74,7 +74,6 @@ pstore_mem: ramoops@ffc00000 {
 			reg = <0x0 0xffc40000 0x0 0xc0000>;
 			record-size = <0x1000>;
 			console-size = <0x40000>;
-			msg-size = <0x20000 0x20000>;
 		};
 
 		cmdline_mem: memory@ffd00000 {
diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 926d30c57add..513c27895dd5 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -344,7 +344,6 @@ ramoops: ramoops@ffc00000 {
 			record-size = <0x1000>;
 			console-size = <0x40000>;
 			ftrace-size = <0x0>;
-			msg-size = <0x20000 0x20000>;
 			cc-size = <0x0>;
 			no-map;
 		};
diff --git a/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi b/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi
index 014fe3a31548..a7eb084932ab 100644
--- a/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi
@@ -126,7 +126,6 @@ ramoops@ffc00000 {
 			reg = <0x0 0xffc00000 0x0 0x100000>;
 			record-size = <0x1000>;
 			console-size = <0x40000>;
-			msg-size = <0x20000 0x20000>;
 			ecc-size = <16>;
 			no-map;
 		};
diff --git a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
index d63f7a9bc4e9..34cfb8d8d1ad 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
@@ -111,7 +111,6 @@ ramoops@ffc00000 {
 			reg = <0x0 0xffc00000 0x0 0x100000>;
 			record-size = <0x1000>;
 			console-size = <0x40000>;
-			msg-size = <0x20000 0x20000>;
 			ecc-size = <16>;
 			no-map;
 		};
-- 
2.33.0

