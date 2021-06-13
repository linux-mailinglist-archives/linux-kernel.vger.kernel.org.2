Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189933A5769
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 11:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbhFMJvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 05:51:00 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:46971 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbhFMJu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 05:50:58 -0400
Received: by mail-wr1-f45.google.com with SMTP id a11so10952182wrt.13;
        Sun, 13 Jun 2021 02:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KBrRGeB2tLy5jflZx3zulUwPWNrmiYbBd39TsmsVpuw=;
        b=gw+5NPw2bBt+nzYszknOnzycfUn4fdvONurNUi1Hn9pTftkzvQwGmEE77QBjXyviRA
         GhqurWcUTq9oujOY6dkYqVe+b4njy0TF60TUHDDZ39arB0U/8fwokWTQsiRhCOYQow/v
         eSj2RXAueGvfrl+2Axkq4lHi0r/h23kvM3uyDcs2EzzPHJvBFPd1zUHv4WAQeoj9AYQN
         FL18cm7qvJ14WXGHIG8aIC9qki+ULZjbjsZ3zsdktehqRsFyKXkO1u4ehU4Ck1aV8ije
         VCNTAcjG4YIZ+WYF6DtJ6ora46bC+VpEDAKgc1QZOguZEjjVU1pOTzMnb8Uts1845ahF
         waAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KBrRGeB2tLy5jflZx3zulUwPWNrmiYbBd39TsmsVpuw=;
        b=EK+x+NUyxwktpkgfXztk0CL69vqGGGkf8VfnvVdbzQzWsO9rTaQmtX+N3hZk4NhPPe
         nuA/W3f0b506Gbi/3BDbJCUS58N0HAhEw9OHD7p/9raFOltsPV6XkR5Q23bNG8c12/nd
         Vfny42Q1c8NW7HiZF1+TmuMDSPgVVWOYTIsilVczDLuPL2AuwcO/2YGteBRG1zjeGADZ
         kJAHzPdYf5kvEFPW2OXgGhqReMbONmrQYFN8twE7VYKch+prv+hTUfm0RN51ECY/cxHU
         yoyFnw4Iz/wC5qHY3n4cTmMNC1qByDpOo9Bl5DCQPqk6MAvZXEPtFleT4lUI2Wahv7t4
         QuBw==
X-Gm-Message-State: AOAM533/v9j9MPLJvAXmDaUWZ2hHaeTDhAwcqWvJaIrY0LgvhO4isEHx
        c2sim0Rmzf+htMoJCgPsvbqVhY0B9aI=
X-Google-Smtp-Source: ABdhPJzwtdE93FMlFu/4fNl7RSNmV/lGQ6cGe5Cy2BftilYN6LnSqlMM/a9NKHeoXAvJ9f+j5tKhEg==
X-Received: by 2002:a5d:6849:: with SMTP id o9mr12508891wrw.44.1623577665284;
        Sun, 13 Jun 2021 02:47:45 -0700 (PDT)
Received: from cluster5 ([80.76.206.81])
        by smtp.gmail.com with ESMTPSA id u15sm14548391wmq.1.2021.06.13.02.47.44
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sun, 13 Jun 2021 02:47:44 -0700 (PDT)
From:   Matthew Hagan <mnhagan88@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivek Unune <npcomplete13@gmail.com>,
        Matthew Hagan <mnhagan88@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] ARM: dts: NSP: disable sp804 ccbtimers by default
Date:   Sun, 13 Jun 2021 10:46:35 +0100
Message-Id: <20210613094639.3242151-2-mnhagan88@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210613094639.3242151-1-mnhagan88@gmail.com>
References: <20210613094639.3242151-1-mnhagan88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sp804 ccbtimers are enabled by default, however they may or may not
be present on the board. This patch disables them by default, requiring
them to be enabled only where applicable.

Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi     | 2 ++
 arch/arm/boot/dts/bcm958522er.dts  | 8 ++++++++
 arch/arm/boot/dts/bcm958525er.dts  | 8 ++++++++
 arch/arm/boot/dts/bcm958525xmc.dts | 8 ++++++++
 arch/arm/boot/dts/bcm958622hr.dts  | 8 ++++++++
 arch/arm/boot/dts/bcm958623hr.dts  | 8 ++++++++
 arch/arm/boot/dts/bcm958625hr.dts  | 8 ++++++++
 arch/arm/boot/dts/bcm958625k.dts   | 8 ++++++++
 arch/arm/boot/dts/bcm988312hr.dts  | 8 ++++++++
 9 files changed, 66 insertions(+)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index c0427d985438..043d3bfaf1cc 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -375,6 +375,7 @@ ccbtimer0: timer@34000 {
 				     <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&iprocslow>;
 			clock-names = "apb_pclk";
+			status = "disabled";
 		};
 
 		ccbtimer1: timer@35000 {
@@ -384,6 +385,7 @@ ccbtimer1: timer@35000 {
 				     <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&iprocslow>;
 			clock-names = "apb_pclk";
+			status = "disabled";
 		};
 
 		srab: ethernet-switch@36000 {
diff --git a/arch/arm/boot/dts/bcm958522er.dts b/arch/arm/boot/dts/bcm958522er.dts
index e5ed67b3c35f..bc7a28cd1017 100644
--- a/arch/arm/boot/dts/bcm958522er.dts
+++ b/arch/arm/boot/dts/bcm958522er.dts
@@ -70,6 +70,14 @@ &amac1 {
 	status = "okay";
 };
 
+&ccbtimer0 {
+	status = "okay";
+};
+
+&ccbtimer1 {
+	status = "okay";
+};
+
 &ehci0 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/bcm958525er.dts b/arch/arm/boot/dts/bcm958525er.dts
index 017fc46cdf0b..cd9b24bf2ee6 100644
--- a/arch/arm/boot/dts/bcm958525er.dts
+++ b/arch/arm/boot/dts/bcm958525er.dts
@@ -70,6 +70,14 @@ &amac1 {
 	status = "okay";
 };
 
+&ccbtimer0 {
+	status = "okay";
+};
+
+&ccbtimer1 {
+	status = "okay";
+};
+
 &ehci0 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/bcm958525xmc.dts b/arch/arm/boot/dts/bcm958525xmc.dts
index 5364f98ae1b8..b7c76a7d4a40 100644
--- a/arch/arm/boot/dts/bcm958525xmc.dts
+++ b/arch/arm/boot/dts/bcm958525xmc.dts
@@ -66,6 +66,14 @@ &amac0 {
 	status = "okay";
 };
 
+&ccbtimer0 {
+	status = "okay";
+};
+
+&ccbtimer1 {
+	status = "okay";
+};
+
 &ehci0 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/bcm958622hr.dts b/arch/arm/boot/dts/bcm958622hr.dts
index 4763eb5d68a6..fe5ac3495223 100644
--- a/arch/arm/boot/dts/bcm958622hr.dts
+++ b/arch/arm/boot/dts/bcm958622hr.dts
@@ -74,6 +74,14 @@ &amac2 {
 	status = "okay";
 };
 
+&ccbtimer0 {
+	status = "okay";
+};
+
+&ccbtimer1 {
+	status = "okay";
+};
+
 &ehci0 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/bcm958623hr.dts b/arch/arm/boot/dts/bcm958623hr.dts
index f2468bed2808..4c8563fdd635 100644
--- a/arch/arm/boot/dts/bcm958623hr.dts
+++ b/arch/arm/boot/dts/bcm958623hr.dts
@@ -74,6 +74,14 @@ &amac2 {
 	status = "okay";
 };
 
+&ccbtimer0 {
+	status = "okay";
+};
+
+&ccbtimer1 {
+	status = "okay";
+};
+
 &ehci0 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/bcm958625hr.dts b/arch/arm/boot/dts/bcm958625hr.dts
index c26849304bc7..dc0fccf57dfe 100644
--- a/arch/arm/boot/dts/bcm958625hr.dts
+++ b/arch/arm/boot/dts/bcm958625hr.dts
@@ -85,6 +85,14 @@ &amac2 {
 	status = "okay";
 };
 
+&ccbtimer0 {
+	status = "okay";
+};
+
+&ccbtimer1 {
+	status = "okay";
+};
+
 &ehci0 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/bcm958625k.dts b/arch/arm/boot/dts/bcm958625k.dts
index b7b136c862a8..f23e97df2fc1 100644
--- a/arch/arm/boot/dts/bcm958625k.dts
+++ b/arch/arm/boot/dts/bcm958625k.dts
@@ -64,6 +64,14 @@ &amac2 {
 	status = "okay";
 };
 
+&ccbtimer0 {
+	status = "okay";
+};
+
+&ccbtimer1 {
+	status = "okay";
+};
+
 &ehci0 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/bcm988312hr.dts b/arch/arm/boot/dts/bcm988312hr.dts
index 6b57530a3964..a2c8a22e8381 100644
--- a/arch/arm/boot/dts/bcm988312hr.dts
+++ b/arch/arm/boot/dts/bcm988312hr.dts
@@ -74,6 +74,14 @@ &amac2 {
 	status = "okay";
 };
 
+&ccbtimer0 {
+	status = "okay";
+};
+
+&ccbtimer1 {
+	status = "okay";
+};
+
 &ehci0 {
 	status = "okay";
 };
-- 
2.26.3

