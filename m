Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F0942FE5E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 00:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243399AbhJOWxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 18:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243388AbhJOWxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 18:53:13 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D8CC061570;
        Fri, 15 Oct 2021 15:51:05 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r18so28881187wrg.6;
        Fri, 15 Oct 2021 15:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ViyBfgrlTDHAPuYDXUpgKxN93vpgYhGWRnJ+NxkNW10=;
        b=QveWERmc92+G0T+1qYxwqc36ANWAR4avspuAYLUnhTlPWAPiL1yaQDgisIUlw71zze
         qoLKzQKfU+gNowZpdHabyNW7pRTgYT6MWzKd3y8H0O5yi0H3aHvnofZfvw7hoOfzRY3+
         Y+U9oNwlrocJqgAmQSMEVMMazQAymnjU6v07p+FSP+qTHw69gr+uJgoCusp4FErTYugg
         P0dvsMML8hBeE33p2DlDYST1U5bhOBnqQ++w189qj6zp1LzSpoeKi3ivUoZDHimAO4iW
         2gkCE4YnL64ILwKpdhFMitih8LfhI7lB1BLLIsyR2f2iD6VmyQB3fcoThqIfCyXbyD/T
         y7Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ViyBfgrlTDHAPuYDXUpgKxN93vpgYhGWRnJ+NxkNW10=;
        b=0Oe3xp3MBxxJM8MC+2Q4SbWm4PJhw9UWhBo8uH6WIeDLIySDVZPTfsBtKTB92PLELm
         6S7jc5icK1UnJ23aKxv5W28VCoqwNeJt0NlYzacNADgPNowVPqlgkd3hJh0o9+saMAEP
         /j5lo4tUJe7KWBOgVYCwyi32Ij0OZh6CNCcP5GYPlErOHXpsCsemQ7EyQvNLGznHMnUI
         9znKX0416G8Ul4DAADAeZixlZWxM9tv/5o8XnaMHCJV2D/0qGIrHRtx1lBiT2PN1HX3A
         ioyTpFCBdhWaBnLnjnLhK9vAyY/GiAGzO5Xd/1HOZLnlAWOvr4oDwW/t5lEO4GN8IK7J
         sIRw==
X-Gm-Message-State: AOAM530ImhmJ/NoAwPX7e+g4HGbh9yv28GXPCLi0E+lRXqhK5vcJbM2G
        JLghhLB3mvw/pwPrtA0UlsM=
X-Google-Smtp-Source: ABdhPJzKIoCyg8oyLXXUS8sOvfK/90PTAWpLgURFuRPV3Fwso6F9jUV9O1RZ48XQIjgwaOR/20DbYQ==
X-Received: by 2002:adf:a152:: with SMTP id r18mr18268655wrr.317.1634338264405;
        Fri, 15 Oct 2021 15:51:04 -0700 (PDT)
Received: from oci-gb-a1.vcn08061408.oraclevcn.com ([2603:c020:c001:7eff:7c7:9b76:193f:d476])
        by smtp.googlemail.com with ESMTPSA id q18sm11601017wmc.7.2021.10.15.15.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 15:51:03 -0700 (PDT)
From:   Matthew Hagan <mnhagan88@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Matthew Hagan <mnhagan88@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: NSP: MX65: add qca8k falling-edge, PLL properties
Date:   Fri, 15 Oct 2021 23:50:22 +0100
Message-Id: <20211015225022.3828860-1-mnhagan88@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables two properties for the QCA8337 switches on the MX65.

Set the SGMII transmit clock to falling edge
"qca,sgmii-txclk-falling-edge" to conform to the OEM configuration [1].

The new explicit PLL enable option "qca,sgmii-enable-pll" is required
[2].

[1] https://git.kernel.org/netdev/net-next/c/6c43809bf1be
[2] https://git.kernel.org/netdev/net-next/c/bbc4799e8bb6

Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
---
 arch/arm/boot/dts/bcm958625-meraki-alamo.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/bcm958625-meraki-alamo.dtsi b/arch/arm/boot/dts/bcm958625-meraki-alamo.dtsi
index 102acd85fab2..ba01054a76cf 100644
--- a/arch/arm/boot/dts/bcm958625-meraki-alamo.dtsi
+++ b/arch/arm/boot/dts/bcm958625-meraki-alamo.dtsi
@@ -118,6 +118,8 @@ port@0 {
 						reg = <0>;
 						ethernet = <&sgmii1>;
 						phy-mode = "sgmii";
+						qca,sgmii-enable-pll;
+						qca,sgmii-txclk-falling-edge;
 						fixed-link {
 							speed = <1000>;
 							full-duplex;
@@ -194,6 +196,8 @@ port@0 {
 						reg = <0>;
 						ethernet = <&sgmii0>;
 						phy-mode = "sgmii";
+						qca,sgmii-enable-pll;
+						qca,sgmii-txclk-falling-edge;
 						fixed-link {
 							speed = <1000>;
 							full-duplex;
-- 
2.27.0

