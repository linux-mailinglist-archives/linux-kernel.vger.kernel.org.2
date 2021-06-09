Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0037C3A1365
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239603AbhFILui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:50:38 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:38413 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239590AbhFILtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:49:08 -0400
Received: by mail-wm1-f46.google.com with SMTP id t4-20020a1c77040000b029019d22d84ebdso4069199wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 04:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ygLx5mqyQd2h1hI8hvNSPIoVDk3VcyF8wNEveFu8IIc=;
        b=X4SxR6sTMrh3dDCmjjhSuDAVAmHQMNNkEcOwEkrs6RMVywtWJN9mwPJPH2M610k0xW
         PME8zUtPDBQ+0qdpDBd5VivS6+eNu2+moDzbYH16aajVnoHbFEOiywed0b5re+kuU9lX
         56JSnqMN/AZWFK+aCPsc1Lzm5c4AqnfNEH2oxRw4ybwezNxcmU0RBmSLc5nCoz2nYz7a
         l7ij4U20VQQSMNYH5rLEdRvJwlnW9jhwGiADBEzkYomksdsU835o5dfI/GeC4uimFzsy
         NlnVPWwMXCFIV3aYLFcEknoHvsFar15WXnqUpejhjY7H3mRkuxatKa/de3Lmpw9aUDkD
         oetw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ygLx5mqyQd2h1hI8hvNSPIoVDk3VcyF8wNEveFu8IIc=;
        b=sqQxRyErfAUkP2WAGYzIZdLcvgPqXekIKKmX456YzPpdgAmQgwLcy1Arn93JdxeHJB
         MXladmBINbAYYi9Vs20Gy3WoAFdlQW/JeckHwGr2+rGXHXc0nMg1E+zrOIroMxxSKZ4n
         6gaET6sXQzsZB5g4DzyW/YfWdZB47qUM/eJGzShSKfObgh06LSz4+d4jsvyJvYJh3E4D
         m18KGk88OcmsLed/OVBXkPIorpS7fp6fsDQ2vJ+ueQ+Jph6UZ0Nfn2p6x8M4u5WFQtN2
         a+vKNIN4DYt7SnElCTpEvsjsma3PZCM27isoKbL/t5a+GZQJyUBq9zoj06tscp32CnMs
         BncA==
X-Gm-Message-State: AOAM532aTbRTP6wZrel+uxIJ+rGTB8yQ97VauSipzqIiGH67v0s09M2N
        lAuY8DLKlm5j8rTMekSgBNSYfK6e33v0f4WD
X-Google-Smtp-Source: ABdhPJz7Q5mq9N+0Smnm0si/xySA3RKY9uF/7ud5QpTTpMnRh4RQgeMW/FpScpBMeR9SnN8y+2p9QA==
X-Received: by 2002:a7b:c5cd:: with SMTP id n13mr27401786wmk.97.1623239160459;
        Wed, 09 Jun 2021 04:46:00 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6::45a])
        by smtp.gmail.com with ESMTPSA id e17sm26458205wre.79.2021.06.09.04.46.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jun 2021 04:46:00 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Srinivas Neeli <srinivas.neeli@xilinx.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 23/31] arm64: zynqmp: Update rtc calibration value
Date:   Wed,  9 Jun 2021 13:44:59 +0200
Message-Id: <d21c59bea71b9605006c12ee053a13320daeca8f.1623239033.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623239033.git.michal.simek@xilinx.com>
References: <cover.1623239033.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Neeli <srinivas.neeli@xilinx.com>

As per the design specification
"The 16-bit Seconds Calibration Value represents the number of
 Oscillator Ticks that are required to measure the largest time
 period that is less than or equal to 1 second.
 For an oscillator that is 32.768 KHz, this value will be 0x7FFF."

Signed-off-by: Srinivas Neeli <srinivas.neeli@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index 80332e3b4d6a..da54a2d35552 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -663,7 +663,7 @@ rtc: rtc@ffa60000 {
 			interrupt-parent = <&gic>;
 			interrupts = <0 26 4>, <0 27 4>;
 			interrupt-names = "alarm", "sec";
-			calibration = <0x8000>;
+			calibration = <0x7FFF>;
 		};
 
 		sata: ahci@fd0c0000 {
-- 
2.31.1

