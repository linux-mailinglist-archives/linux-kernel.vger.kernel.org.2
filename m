Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0AD4404A9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 23:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbhJ2VMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 17:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhJ2VME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 17:12:04 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D09C061570;
        Fri, 29 Oct 2021 14:09:35 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id y14-20020a17090a2b4e00b001a5824f4918so4708419pjc.4;
        Fri, 29 Oct 2021 14:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tbBP9vlfqwztQAwlUrA3rb3X9bknkbNPCByzkSfvM8o=;
        b=QD4+2TQnXGt2qx52hkDP3lpei9GWHyuDIUcjvpvUwmfYypY2/l4UFQkk9Ho4mZ1sRx
         x3K9FCTy8dofXQEpone5fp27e8t5a9rTS/R+YjJ/yeE1J7hgxcf9ovs+qVQMvhq9clHu
         7I3NNsBumn2RN2OCKeEd3VDKBxsHCd2NVJqEvfVADPwHJek41NXVp6r16lpHVeUac59u
         VTXm5FRv2kaqwjpQT9NiXOz/7el8jiQQsmcNccLzMpPDVkX5rinD5UuTVQ/CoWgASF9N
         F/3lP9Ym/cmYkapra5JQNoHOzPPsrFVqbqRIZnLDkl3XI3uQFMt6QdI3Q/TYgwzgWFwM
         +jvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tbBP9vlfqwztQAwlUrA3rb3X9bknkbNPCByzkSfvM8o=;
        b=X7VYVLnO7NTK1vrafpG+S1uOYhz5NIwedkfOWliGbDvw+UASXEdiJB/B83kgB0kqJ2
         NKv/IGcgri33YJFLF30euDX8rgy4fALEryBOElK+6eankmbMGzjDHAviU8xq1A8WzcLt
         OelKeL3PCqOLIPV4WqosHEEUOE7+S2VcNAO9frKjUCA7FhcXRrSvi72ytBkLcZRobX24
         d5GSGdE8Y2bXjEHSklhLD24q3jAN8eZp0GoA98owNRcNpEzYb6LksWgVdCU8JGgJma6d
         ns/XLIPWQOoKoc3i68/Zsg4b9eePJgCyhJ8OzqkgrpG1PU7kYGQRPlopEACnl9rat+A0
         QIHw==
X-Gm-Message-State: AOAM531YXjnNLSh4jRYD0gIusXUsecJnQeY09GIkHhjRDYpHKf2KaUA7
        fuuwaGbXdn9TAcJUISoxEa8=
X-Google-Smtp-Source: ABdhPJwIUGdk4jEwbcTc9PWsUkll4l5mNlE5i1uV8EBi78o4Yl0XRU0yFzupOikAV/yc/JUVEPUIdw==
X-Received: by 2002:a17:90b:1d04:: with SMTP id on4mr14076174pjb.68.1635541775461;
        Fri, 29 Oct 2021 14:09:35 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id i184sm6126210pgc.56.2021.10.29.14.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 14:09:34 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jim Quinlan <jim2101024@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        bcm-kernel-feedback-list@broadcom.com (open list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ARM: dts: bcm2711: Fix PCIe interrupts
Date:   Fri, 29 Oct 2021 14:09:26 -0700
Message-Id: <20211029210927.36800-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PCIe host bridge has two interrupt lines, one that goes towards it
PCIE_INTR2 second level interrupt controller and one for its MSI second
level interrupt controller. The first interrupt line is not currently
managed by the driver, which is why it was not a functional problem.

The interrupt-map property was also only listing the PCI_INTA interrupts
when there are also the INTB, C and D.

Reported-by: Jim Quinlan <jim2101024@gmail.com>
Fixes: d5c8dc0d4c88 ("ARM: dts: bcm2711: Enable PCIe controller")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm2711.dtsi | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm2711.dtsi b/arch/arm/boot/dts/bcm2711.dtsi
index 3b60297af7f6..9e01dbca4a01 100644
--- a/arch/arm/boot/dts/bcm2711.dtsi
+++ b/arch/arm/boot/dts/bcm2711.dtsi
@@ -506,11 +506,17 @@ pcie0: pcie@7d500000 {
 			#address-cells = <3>;
 			#interrupt-cells = <1>;
 			#size-cells = <2>;
-			interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
+			interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "pcie", "msi";
 			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
 			interrupt-map = <0 0 0 1 &gicv2 GIC_SPI 143
+							IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 2 &gicv2 GIC_SPI 144
+							IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &gicv2 GIC_SPI 145
+							IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &gicv2 GIC_SPI 146
 							IRQ_TYPE_LEVEL_HIGH>;
 			msi-controller;
 			msi-parent = <&pcie0>;
-- 
2.25.1

