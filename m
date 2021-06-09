Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64153A1327
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234793AbhFILrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234700AbhFILri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:47:38 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F88C061760
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 04:45:43 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id d184so3851325wmd.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 04:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dv5TZU6Wfb8j+K9/W/AYEnaVxLhCu1/evPURiwPUiMo=;
        b=Z85OLRbx3GH2ei/4xqhwY+3XR6I9n1h1s5VwXt9lvOq6dJ5i0Y7PQv9gzw83iNl3Rx
         xICN/iysMo7NlB1cSOlJROS3V2UXyBmkb1o6ntlPBTqSQ2KO/WCgGbyII+8hQPjR/2t7
         tcFuo6jBdp0JL9hlS5ckKfFUONWfpdkrNuUqdTjxtbspt2eptlxCyl+QHZKK8egaJKXT
         DsBFklGnyK7GIOHV/peFDp/MccwgOaIBEoUHTJZWR6CD7ipFEcvYE+RDrpOGcL4/18aI
         A9JNiV1CXsy1As6bxNgoRy41njUKJ82Fe4ExZNzRrayN0P08Ao52aIdYyzp9/sgj9ai2
         W/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=dv5TZU6Wfb8j+K9/W/AYEnaVxLhCu1/evPURiwPUiMo=;
        b=ERxvqzii3tNdULwbvczypn/8kzAE5ekhzf6+mnDP7q/uIHsx/URY5wEoOjE/uiRlXO
         Yhp4iGjATD1j20simA+qtyi/qcApjR9hQYWV5321RHZtAkoUHOq06earm8BGBzbozN/b
         Fd6Eu0s3Q4QcXuNpV1NogIFSQTRNzLIwpudlq+EwauZopQ4mxBc/YOCBQBv8lw2aX+B5
         2nV0FrLEfoSNHGnA8vKszHZcCm2xjCQQn/0eg09nd818LJjCw7KDtB6I0V3amn8Bt9tF
         rFUmwsG4fuXOX67o7a4HEUaUh8Mh2V5gvqT1HaK6VI0ZHiEYXWDX9rbJy/M89un+5+8Y
         husw==
X-Gm-Message-State: AOAM533OyhCFsDRfkHuVC9D4WrLpMYwM1aSFV+Do1KpRDzSXGYRJ6mva
        ZKqIV5k7O1gdF69rInTqBer/nHMTzDu3lczh
X-Google-Smtp-Source: ABdhPJxZ4rF6XjqTvg0g48EKxnPE4/hfAi3vObLFC5G1cq2/FzO1UwWMM1SbT6R2lwIc1kdlcfr/pg==
X-Received: by 2002:a7b:c20b:: with SMTP id x11mr9596495wmi.9.1623239142053;
        Wed, 09 Jun 2021 04:45:42 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6::45a])
        by smtp.gmail.com with ESMTPSA id n8sm20171026wmi.16.2021.06.09.04.45.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jun 2021 04:45:41 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 12/31] arm64: zynqmp: Add missing mio-bank properties to dc1 and dc5
Date:   Wed,  9 Jun 2021 13:44:48 +0200
Message-Id: <2b2ab31639c706651dfd319f5b6bc59e68f111b6.1623239033.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623239033.git.michal.simek@xilinx.com>
References: <cover.1623239033.git.michal.simek@xilinx.com>
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
2.31.1

