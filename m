Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44EC730A9C0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 15:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbhBAO2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 09:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbhBAO2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 09:28:20 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1C2C061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 06:27:39 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id i8so8209272ejc.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 06:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Km1nRi/E0hQQHdsUs4PTtzZ/2EK/cinSobxTg4K908c=;
        b=A7yOMagAv0HXn8vIiK9NiBuG7aVrrHzmN1hZ6P6puZVaVw7dFJ862pyWLFFC6CtYiq
         sSrCeU/yn2wqbTp25SibVy+hQCJbat2NWjcaVsgkWQVziN4oKvy/i317VR8yb3+g9bJu
         2xm31hu9kNsDyfrlMwAyGhHNBKStgrMkfz4I8W5OwsUOwvGrmsQCkwY/9pYVk7rP8bGx
         jKTifuTqfvZ3V3yK7zysl/C4yfAbzXn4vUgNa3r6PSZTQeaLClVNGe3iRejZk6lAv2+9
         ZlRzZCgFArM2A0RK1fmgE7e1eLAfOaiYJIYRFKaGCYSohr/vk4bgNET5mqZgVnt/bCTO
         A6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Km1nRi/E0hQQHdsUs4PTtzZ/2EK/cinSobxTg4K908c=;
        b=J3xz0dY/AtfNgqQJXhVhmWlrV08AJQQhtEpVK83PYwqZGB0W1A9rDgGR+ixn/SWB25
         PiXyV3e5+2srJi7gBZemo1vjFh2b01Bzr0Fkiej6by+BfdWhX0s0elqpB5KUzFK0MHK2
         xkntcsahRygMythYMCJvbS2oXXXkxvTD3iNg4P4IeCIujZbRVtSNjf/5S5naLy11RXVN
         rhnBruvDfWfZeQ+WAQxKVZlYvzQta3xM82Lzx7THGY4ppG6DqaIhoApeSGuMksrZSsmL
         8mcUyNrhf8V9gJJbmAoSgRu2PAeq0hEp1lLirW3pC8vJCihUsCgSEnw8VP2q2rdzQNmg
         3Xbg==
X-Gm-Message-State: AOAM532gH91691cvpD5xLKIQP56XzVrmujuXgBi1hYz2eZ2rl8mzHQ0b
        sFT6peVV6ICSddlkK9YM0XPEIHs1riZMNm3M
X-Google-Smtp-Source: ABdhPJz3KuUqLFWHn7q6n9pykrrupcKFT2ebxoU9dhBXhBWp5jwXBja/fCx2vpz6lzl2qLuqPKUe6g==
X-Received: by 2002:a17:906:854f:: with SMTP id h15mr6171090ejy.2.1612189657776;
        Mon, 01 Feb 2021 06:27:37 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id q26sm8041340ejr.97.2021.02.01.06.27.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Feb 2021 06:27:36 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: dts: zynq: Add address-cells property to interrupt controllers
Date:   Mon,  1 Feb 2021 15:27:35 +0100
Message-Id: <91e3405245c89f134676449cf3822285798d2ed2.1612189652.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 3eb619b2f7d8 ("scripts/dtc: Update to upstream version
v1.6.0-11-g9d7888cbf19c") updated dtc version which also contained DTC
commit
"81e0919a3e21 checks: Add interrupt provider test"
where reasons for this checking are mentioned as
"A missing #address-cells property is less critical, but creates
ambiguities when used in interrupt-map properties, so warn about this as
well now."

Add address-cells property to gic and gpio nodes to get rid of this warning.
The similar change has been done for ZynqMP too.

CC: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm/boot/dts/zynq-7000.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index df9ad831cf05..c4810d58540b 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -133,6 +133,7 @@ can1: can@e0009000 {
 
 		gpio0: gpio@e000a000 {
 			compatible = "xlnx,zynq-gpio-1.0";
+			#address-cells = <0>;
 			#gpio-cells = <2>;
 			clocks = <&clkc 42>;
 			gpio-controller;
@@ -168,6 +169,7 @@ i2c1: i2c@e0005000 {
 		intc: interrupt-controller@f8f01000 {
 			compatible = "arm,cortex-a9-gic";
 			#interrupt-cells = <3>;
+			#address-cells = <0>;
 			interrupt-controller;
 			reg = <0xF8F01000 0x1000>,
 			      <0xF8F00100 0x100>;
-- 
2.30.0

