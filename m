Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071CD3A132A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238631AbhFILrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235021AbhFILro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:47:44 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89927C061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 04:45:36 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id a11so23259892wrt.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 04:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0qKaD7pcb5H9dx5KCUiqNVK5FGDD0UzlMgn+aThmPRQ=;
        b=LwLmDRa7HlVj5TeRIpJRW31k1q2q0LlumVmgD3rCRkL/qSlQOVL+r4huHkECdp2mbF
         HdBA57KgpDnUjbp2HP7pKTAXOr+h+qpBcIcDdcjoFIvsyK7Ln6GzYLuB6akf75Y0GA5J
         kS29z5bcGJT7RmfeSZVOyHi0HAR/EL6D0/v+fQmN+GCPThEbtduA4E9F4w40Tz1r17Q/
         Nzq76MpTE+uI70pDb2xJsAoWvTMAJrQ4OHk1qY1wBTbPqVcI9BMBk0MohsRMVs/nNu1q
         WXwSWYzGkIPejvUlQWWWNEGiqy6lvJwMXshXvw6sLfML9fEOKDvtDUqRQI2OZHtP6QU5
         ofug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=0qKaD7pcb5H9dx5KCUiqNVK5FGDD0UzlMgn+aThmPRQ=;
        b=PxtTbpPnnkLh1S0KTCQgFFUXJZvg65T1MNWl2DYEklrXSXXoLIoCK7EV06rDJ+iwpo
         ATA5FA3g/vkJMndiy43ptT9++cxq04Y+UbWvcXGzhUrw1zl/ssYr+vhb1wxdaZlVa4TS
         TiSpY+0VJlsV9KYr/md54tPPmQUn1cmE6sXzLJAi6NqXHPfFiZHUkVpSsfF0xvbe+9RQ
         SOVIMVkDtLA0ueoWRlgM2qhdsaqxWhRKec2jbsZrWiFDVBdIBP7i/iDMyUP22VeCnjSQ
         G4/pcB7F8EUOfPrz4UmMp5YgV84yQ4tigFMkpeNHMIo4XMIj4CXFvybjjAy0sLxd4ieu
         8hqA==
X-Gm-Message-State: AOAM5333a8fk0TtfCODkGK40jjFsBns7QgeJFUGITMs1HSBbg9flWUJF
        o7zETHYFkSNOG5Df+OUFC+xnlwkpQIOBgpm0
X-Google-Smtp-Source: ABdhPJzYholqo05PJOkGyVewkjTdKbLoCbFtuO511CPRSN8GIDXNlAS3YvCL76RCDzWo0v7BLIhDEA==
X-Received: by 2002:adf:f211:: with SMTP id p17mr27593378wro.173.1623239135005;
        Wed, 09 Jun 2021 04:45:35 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6::45a])
        by smtp.gmail.com with ESMTPSA id v15sm1836422wrw.24.2021.06.09.04.45.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jun 2021 04:45:34 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 08/31] arm64: zynqmp: Correct psgtr description for zcu100-revC
Date:   Wed,  9 Jun 2021 13:44:44 +0200
Message-Id: <bd35fdaac08208578b2bb5059ba2c59bb4e66dac.1623239033.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623239033.git.michal.simek@xilinx.com>
References: <cover.1623239033.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable psgtr node and also fix clock names to be aligned with other zynqmp
boards.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
index 9c40c6552c32..4622e173d262 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
@@ -111,13 +111,13 @@ ina226 {
 		io-channels = <&u35 0>, <&u35 1>, <&u35 2>, <&u35 3>;
 	};
 
-	si5335a_0: clk26 {
+	si5335_0: si5335_0 { /* clk0_usb - u23 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <26000000>;
 	};
 
-	si5335a_1: clk27 {
+	si5335_1: si5335_1 { /* clk1_dp - u23 */
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <27000000>;
@@ -459,8 +459,9 @@ conf-tx {
 };
 
 &psgtr {
-	/* usb3, dps */
-	clocks = <&si5335a_0>, <&si5335a_1>;
+	status = "okay";
+	/* usb3, dp */
+	clocks = <&si5335_0>, <&si5335_1>;
 	clock-names = "ref0", "ref1";
 };
 
-- 
2.31.1

