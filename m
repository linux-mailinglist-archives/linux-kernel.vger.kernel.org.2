Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDF33A6A55
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 17:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbhFNPav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 11:30:51 -0400
Received: from mail-ej1-f53.google.com ([209.85.218.53]:40647 "EHLO
        mail-ej1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234046AbhFNP3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 11:29:31 -0400
Received: by mail-ej1-f53.google.com with SMTP id my49so17365593ejc.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 08:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mY4VUHxyljfbMro9AuDww6rqSqYJxJhuPj8A+uZVAc4=;
        b=v8s974ILdWNnF2/apJTK7PCsNuxsBBZ6mlCwv4IM5lHdhhGfieTN+UxddU18UDF66h
         MSh8grqc/aeLHzMnXupFcbU7fPn99iGVsBoweAPp8kztQdjlwNYJwRFxDNLb71MeMeaE
         R/Cb3vUiV+NKBP63Hf9ZxhC6ENyZuBO84ISP8OIh4IAbOWvao35m7OW7L9RZuimaQiKI
         9+ONnhZ2ZJ/mN4RvCB/2XATB6ehfrxrGq112AR4fWMTY3plctGnTy5UdyAjy6HnfTePc
         E9uRNp3OywOOfBeA0+l9iRmFkqzXKp1M9U/zLAGQJ4m5FOaGU69zcHVhJuCGSpl3rQVT
         7gXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=mY4VUHxyljfbMro9AuDww6rqSqYJxJhuPj8A+uZVAc4=;
        b=mRnidPGhrgbOaoLWj5nPIk1tVqHQyRcdlzK3nu8HQVUnZRlPamgfFAUXht7M9eCq88
         mrAbnsehvjF7wj/v/UE4dFdtPyjmUkS8Ge3sIRQELUY83mXiWqS3muJWfZDWsjIj3y68
         COsPbQ/IiXl/VpNZ4MhJzhlnuQz1Gh9rQmIYRxNMeePuOTv0nq9EMCV3SNajgPaAmKjy
         8ZD8rqBWX3Mz10uCj/87ELeb238ws1YdB/fpv8dK0/dfnquFEyyeR1IMdh4o1DByLnyU
         ISsSGnx21Vkvhe93v4nfHmikwFTzoKg53v40PUE+HbhhTIrjyPe8jGsofEdqjHsZrIXN
         GAeQ==
X-Gm-Message-State: AOAM530hNVLaasWFcQH4oXOQvACdrCCNILaAVk7CDFMidz7kH6tMzU39
        hDjq46I/Qa/tLChK+95cD+/ksOMa4fKJWzxp
X-Google-Smtp-Source: ABdhPJz7WOGXgdnytHoufYdCp2r4+LSURDFXlw0e/cBseLLMhQNDfXZcfxY6iKWPjLa580czuSJrZw==
X-Received: by 2002:a17:907:2cef:: with SMTP id hz15mr15659186ejc.253.1623684374555;
        Mon, 14 Jun 2021 08:26:14 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6:f666:9af6:3fed:e53b])
        by smtp.gmail.com with ESMTPSA id x13sm7773593ejj.21.2021.06.14.08.26.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jun 2021 08:26:14 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Quanyang Wang <quanyang.wang@windriver.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 21/33] arm64: zynqmp: Move DP nodes to the end of file on zcu106
Date:   Mon, 14 Jun 2021 17:25:29 +0200
Message-Id: <d14404afd846f975a421023e9e9b6ad18585719f.1623684253.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623684253.git.michal.simek@xilinx.com>
References: <cover.1623684253.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This location is used by others DTs files that's why this move.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

---

Changes in v2:
- Add reviewed-by from Laurent

 .../boot/dts/xilinx/zynqmp-zcu106-revA.dts    | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
index dbb8bfbb5c7f..4a0f3370bf7f 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
@@ -160,17 +160,6 @@ &dcc {
 	status = "okay";
 };
 
-&zynqmp_dpdma {
-	status = "okay";
-};
-
-&zynqmp_dpsub {
-	status = "okay";
-	phy-names = "dp-phy0", "dp-phy1";
-	phys = <&psgtr 1 PHY_TYPE_DP 0 3>,
-	       <&psgtr 0 PHY_TYPE_DP 1 3>;
-};
-
 /* fpd_dma clk 667MHz, lpd_dma 500MHz */
 &fpd_dma_chan1 {
 	status = "okay";
@@ -994,3 +983,14 @@ &usb0 {
 &watchdog0 {
 	status = "okay";
 };
+
+&zynqmp_dpdma {
+	status = "okay";
+};
+
+&zynqmp_dpsub {
+	status = "okay";
+	phy-names = "dp-phy0", "dp-phy1";
+	phys = <&psgtr 1 PHY_TYPE_DP 0 3>,
+	       <&psgtr 0 PHY_TYPE_DP 1 3>;
+};
-- 
2.32.0

