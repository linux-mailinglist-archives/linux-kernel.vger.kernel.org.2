Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC1DF3A1336
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239370AbhFILsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239361AbhFILsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:48:07 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67208C06178B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 04:46:00 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id l7-20020a05600c1d07b02901b0e2ebd6deso3991013wms.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 04:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nrZElwT9y3W18Lbft5uOXhWR0ueAWy9kjrpr8/SaaVM=;
        b=MGJwUTU3ouxTrRBx54L0Y6kIMPTVVjeIZYE3AWfYF0mIToRFlUq+j2r4xInXqkSulV
         0RypE2euRdG6Z5W+Q7q+gtQNZaKgW9bLj+aUuWzGZQTNUjH5ePKxxepJ6OssY/y+JHyF
         cP7QULlnNfvQNYhCcf6OYTS11mXKblu8QwbKKHHTdJlnNs8NjdG2vu5tleRoHt3WfUxd
         YhwQW5egSiEly3y8h2gObFaJsK7G7oL/ko96qLqsTYgy3hNWfWowIM+Xrc4W95HaLSeY
         cLGhxNcMLOPJYpltFnfr4CdbHmJIs3CRYnAks8qIOo56KUEybGG+ggbrkC2BDyArUL7n
         bAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=nrZElwT9y3W18Lbft5uOXhWR0ueAWy9kjrpr8/SaaVM=;
        b=O5wqcHP3+hFGn/KOrXjbofDx2O1U4Y9+B1Hq3l/1iHhWNiQ1TDW+7MUfgdtv9MmqPz
         uLbZtC/w6mdSIWf5Z+TOhhpOAT9aQ0nkErRtW55NOxLim8r8OT5SVYG+1cMH7AZbxgaP
         f2t6QWr8y16ztqAF44Q0CyXP7F2JBSu5VyLwyYS6uTxDIAUEmb7HvbwmBr2VMyP5rX54
         7waQGhQ5JTXmVSowwZtF9pMT0muNSkeZMdDkeelqgi2vRHxGekmebsk+C16CEaN5c5R2
         22ZGfVDO4ZcWx1zsR+VrIPQBrbnHXiw7ZUCe459Tw5DuK609BilTriNsQllFWcbun3jT
         knDg==
X-Gm-Message-State: AOAM532y3G+77oNda0I7vTR32d/jo5arfXg8wpCM2hUkzGkUh7N9Qn71
        /lgopF4Ari78sP0geIYEVj+xR7UsXBv+l/KU
X-Google-Smtp-Source: ABdhPJz/Klyqy8Y+luI/yuy0IgYB1SCvJlkMPYkQe0DhLcM9V6pZ1BGe43mytDAP3OWX+IGqnqrpMQ==
X-Received: by 2002:a1c:bad6:: with SMTP id k205mr9594035wmf.171.1623239158850;
        Wed, 09 Jun 2021 04:45:58 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6::45a])
        by smtp.gmail.com with ESMTPSA id l31sm6047615wms.16.2021.06.09.04.45.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jun 2021 04:45:58 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Quanyang Wang <quanyang.wang@windriver.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 22/31] arm64: zynqmp: Add note about UHS mode on some boards
Date:   Wed,  9 Jun 2021 13:44:58 +0200
Message-Id: <ac36b2b31cd32bfad09544d898c98114146af518.1623239033.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623239033.git.michal.simek@xilinx.com>
References: <cover.1623239033.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add note about UHS mode and add no-1-8-v property to zc1751-dc1 board.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts | 4 ++++
 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts      | 4 ++++
 arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts      | 3 +++
 arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts      | 5 ++++-
 4 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
index 460aba6e7990..cd406947ec34 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
@@ -370,6 +370,10 @@ &sdhci0 {
 /* SD1 with level shifter */
 &sdhci1 {
 	status = "okay";
+	/*
+	 * This property should be removed for supporting UHS mode
+	 */
+	no-1-8-v;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sdhci1_default>;
 	xlnx,mio-bank = <1>;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
index 5ddcfdf48626..3cbc51b4587d 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
@@ -956,6 +956,10 @@ &sata {
 /* SD1 with level shifter */
 &sdhci1 {
 	status = "okay";
+	/*
+	 * 1.0 revision has level shifter and this property should be
+	 * removed for supporting UHS mode
+	 */
 	no-1-8-v;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sdhci1_default>;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
index 4a0f3370bf7f..2c1c4d96fb21 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
@@ -951,6 +951,9 @@ &sata {
 /* SD1 with level shifter */
 &sdhci1 {
 	status = "okay";
+	/*
+	 * This property should be removed for supporting UHS mode
+	 */
 	no-1-8-v;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sdhci1_default>;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
index 85e9d0e2f9bd..c9d41d16c3f0 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
@@ -796,8 +796,11 @@ &sdhci1 {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sdhci1_default>;
-	no-1-8-v;
 	disable-wp;
+	/*
+	 * This property should be removed for supporting UHS mode
+	 */
+	no-1-8-v;
 	xlnx,mio-bank = <1>;
 };
 
-- 
2.31.1

