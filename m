Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B79C941070F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 16:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238049AbhIROhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 10:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbhIROhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 10:37:13 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FF9C061574;
        Sat, 18 Sep 2021 07:35:49 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id z2so473536wmc.3;
        Sat, 18 Sep 2021 07:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U4kbLTEzstG8bqmVsjPQwQScRoxYu5fErmSJX8n+SSA=;
        b=n+AmFQhiJ0ujgKIKOLcZqYRY4IpbvsnXkrKjyAI98DO2D2J9OiOp04ktt4R6Hecqh6
         ofHXaQ43/V/Sa/fCJh6PWNRkPvb3V6GkHFtsWdIKilBCnpnp1qm0mg2gY8zZQthj9yfS
         iCNWsEQeKGdvffFKjgHFigzqrtwx8QS9ebGyz6NX/fSY7gwkV7FucmsyC922ZPAfWxaM
         84sLU8nDihEwtMjhom6TFYgp0h9+0AR7nKXSbwB656wmb5O9qZVplGExVTONxeiYMOXb
         M0KQeoGk6jmvOQ7f2MfwdF6wlYqZqlJ7FrJK19cHdVnRetH6jgrKFtbHvXcuIovsHGrG
         s0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U4kbLTEzstG8bqmVsjPQwQScRoxYu5fErmSJX8n+SSA=;
        b=I9UgOHKRCfZt0Oily0UVeALcxiyNZlfpmvpM2NOCnfStkNbFgb5Pfq/KpoRdr9GucQ
         OfN0Q/i18hnt76RliGaCnNe7rRyONnOOfQPceEsyzuZz8wY6SBaUO589RQCZtpfBMq80
         CNbtllPEBm4lYjttSlp4p1d/L7JQyZr6kV+LCZJDNKIrAmQqsT6e0tbjFOK/CCcjW6Zh
         TJVZg3L6O8XZ7AYkJcazGLWnpUlSkgGy6ABfmlSfii31Dl7lBt9PAV7FEOGPIAiAeLwZ
         csk5LyBYGrMYSjahp3+38i1syZV8gndCPjsTxQYnKWGAWxiv6ANnKfnCuBl8grZVs4ct
         WWWg==
X-Gm-Message-State: AOAM531PNm3iAlQPwu29x56bpbLTq0v1PLRU9hr1MNT2jHqY2J87ZFzb
        iOvSwdTptWyBnrxHxectVcsL760PkL8=
X-Google-Smtp-Source: ABdhPJyGciZ2Tk+zjdr9B/RlTQZ009wxlb+B9GMrZeufMBHmiwm1TkbSQzEpp09SlnXVtlOnnAOIDw==
X-Received: by 2002:a05:600c:a49:: with SMTP id c9mr20048354wmq.159.1631975748050;
        Sat, 18 Sep 2021 07:35:48 -0700 (PDT)
Received: from tom-desktop.station (net-5-94-68-9.cust.vodafonedsl.it. [5.94.68.9])
        by smtp.gmail.com with ESMTPSA id v20sm10018970wra.73.2021.09.18.07.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 07:35:47 -0700 (PDT)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     tomm.merciai@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: bcm2711-rpi-4-b: Fix pcie0, pci warning.
Date:   Sat, 18 Sep 2021 16:35:42 +0200
Message-Id: <20210918143542.146060-1-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following warning:

./scripts/dtc/include-prefixes/arm/bcm2711-rpi-4-b.dts:220.10-231.4:
Warning (pci_device_reg):
/scb/pcie@7d500000/pci@1,0: PCI unit address format error, expected "0,0"

Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
---
 arch/arm/boot/dts/bcm2711-rpi-4-b.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
index f24bdd0870a5..8a77f9e942be 100644
--- a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
+++ b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
@@ -217,7 +217,7 @@ phy1: ethernet-phy@1 {
 };
 
 &pcie0 {
-	pci@1,0 {
+	pci@0,0 {
 		#address-cells = <3>;
 		#size-cells = <2>;
 		ranges;
-- 
2.25.1

