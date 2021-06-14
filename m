Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB053A6A29
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 17:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbhFNP2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 11:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbhFNP2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 11:28:19 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2787C061787
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 08:26:02 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id g8so17364208ejx.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 08:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y086/3Vb8l/j6MijbS9GRLbZljtg5wwxE96eR+fUbxY=;
        b=v69WUXvWTGhZ5AAFUMPyL0zcf/t3WyZzaZHhwB9jyxOjwCkXw9qeNMeh0tERU4bsT2
         QCycoaZPVO8z2Y6/m5Bzq+gGnp/hky5yS6kTlQCYWcKrjmPV/AdP9L+raedXyWIL3MxP
         ocuNHKKiKThmCTOhTzDydo7/l78xmq+ttA0qEYsf92HPRP7OgZCARHNFdV/uKcXf349C
         6YoQJf3Eaj+lg7yqwlWDLzOP6QiMXOg1EEWZkNhIs+nNqycLu4KGJgcVGj0IESIeQRyV
         ZcwynvF7kRuwlTk1O9y165YhFLqwrtbJTYld4+/mVIzyHkVnkun7duSD7Q2wVVGdLe5S
         q9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=y086/3Vb8l/j6MijbS9GRLbZljtg5wwxE96eR+fUbxY=;
        b=M0C7/x4mzRYruXoPhuYpnfhRJCJQi/gKkE68wtvllnZAAI+EnatA4CM9zBlmNs+EVi
         IkbxsvuNQY2WwMKQhY0Co7SaB3CFYHtHLcLOR2RNzf6FmcuTSEX1doKrZQcrNy2wuR5T
         KGJ5LU8GjODbseUhPUEAvK54tehCqfHN0nbTdK5CfK4Pr/koFGVhnvlG3R9x9XjnAb7w
         LSvqA7zgM1zjragU+gdoPfH8dGUmSVD6g9sw/MqkVe0+3DnjqCBM7ecpDt2POj5LLl4L
         6Etrp51sPnCA5mpgLYerts0u3syISdTHecnEfYqScg5iqsri5mdgYAxJTs6hWzY4ZHN/
         /hZw==
X-Gm-Message-State: AOAM533ePTb39noHjKcjAJ6wm35aZ4K4886t7i3hKQBZoOvWdPP5zMWR
        VPsZVpYRxZhAytN2kAPKmHHaB926O+CZj4UV
X-Google-Smtp-Source: ABdhPJxt9YZsUJHl3F6lcV2jTPN/+KSjz6rdUToRPkBhvFBUe82kAIulrMvMh+8g2zZlXXtH2jsmBw==
X-Received: by 2002:a17:906:71d2:: with SMTP id i18mr16548883ejk.373.1623684361115;
        Mon, 14 Jun 2021 08:26:01 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6:f666:9af6:3fed:e53b])
        by smtp.gmail.com with ESMTPSA id k21sm9240943edo.41.2021.06.14.08.26.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jun 2021 08:26:00 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 12/33] arm64: zynqmp: Add missing mio-bank properties to dc1 and dc5
Date:   Mon, 14 Jun 2021 17:25:20 +0200
Message-Id: <2b2ab31639c706651dfd319f5b6bc59e68f111b6.1623684253.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623684253.git.michal.simek@xilinx.com>
References: <cover.1623684253.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing mio-bank properties to zc1751 dc1 and dc5 boards.
The same change was done by commit 63481699d6e3 ("arm64: dts: zynqmp: Add
missing mio-bank properties to sdhcis").

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2: None

 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts | 2 ++
 arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts | 1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
index f57cb5356cef..dd129347174a 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dts
@@ -364,6 +364,7 @@ &sdhci0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sdhci0_default>;
 	bus-width = <8>;
+	xlnx,mio-bank = <0>;
 };
 
 /* SD1 with level shifter */
@@ -371,6 +372,7 @@ &sdhci1 {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sdhci1_default>;
+	xlnx,mio-bank = <1>;
 };
 
 &uart0 {
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts
index 6c9460a0707c..ae2d03d98322 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dts
@@ -407,6 +407,7 @@ &sdhci0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_sdhci0_default>;
 	no-1-8-v;
+	xlnx,mio-bank = <0>;
 };
 
 &ttc0 {
-- 
2.32.0

