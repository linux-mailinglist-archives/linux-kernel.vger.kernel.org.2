Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E35C3FAF00
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 00:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236134AbhH2WjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 18:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236089AbhH2WjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 18:39:13 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D571C061575;
        Sun, 29 Aug 2021 15:38:20 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id o39-20020a05600c512700b002e74638b567so8187236wms.2;
        Sun, 29 Aug 2021 15:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+EcoqQrjH+X3WH9ltlbLmxW1lqGbR5DG6LpDcnY7UDY=;
        b=nIaf2PZZOnYOo3ftrezk1GDHR794g0SHml537B/jrr6SeD/KvBJ5gsMp+/SQMUiXk6
         Up4dZWidPQzQ0qkyMjhKv+Y27zELXyMKSuppI8modTbnJeC6MvAvbecbuXn7ce274Iis
         znDCwG2xMJCsnQ1+N4xqn6sTfHIEeUBXE5Q1om60eA0XiKlKZj/MO80T9Rhcn1JwLtZX
         wYMqa0VkHs/w02iIl4/7gAuxcwfi9fGmwkLcgY8vuxUd7AtcYlbj+Tzq3D3Mbqnuj6ST
         1oZ7IDknTOqQhj838ge0lW+DTxDTc8oUyRUWcbA+3D9OTmijYge6w2uhC37YNF09V3da
         9IuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+EcoqQrjH+X3WH9ltlbLmxW1lqGbR5DG6LpDcnY7UDY=;
        b=Rxa7QSeOkoMgPZ2vddf490XkfCiWmW5yElx+k74jTN+lXFLdxmjtZwvMJRmB1z3gCp
         1mVW8L7zNcM6c+BWFaQEY58jVNJtdSxWDsCrQXkelggcGjhBNtEDoadXhvhzmHUuCVIW
         heRB8hnYAc/1WGAOT10Bv7hzsS9tIcee3HDu9h3mb4uQhyUtiL2J3N7prZE7w45wq7jj
         lbmgIG9Y6/eD1IjpezO9WmBSMyfHn30Ms0EyJsLSYXjlt9aN9dmcIhpeD6JqtVFjNYMT
         ipziF2uSbL4+I2jFhUibKe3Ac9KAsc7+Ur2TauEX+4+SPjqnMkmyeWyEqyGzDmisgxs8
         9ajA==
X-Gm-Message-State: AOAM532G5v67UCSn0uRAUd4AkkMm7i8IhFqaYGjVBR9lCyeNVxITgP32
        fY47Dvn4C2pZ22k/wp5Cg0E=
X-Google-Smtp-Source: ABdhPJxylKgFqODswN/SRmP/Ql0l6ZMSgZislcRGn+ymy6qeEfOLSlVWZwJjLnbSX24Cml4b+KxD5A==
X-Received: by 2002:a05:600c:a05:: with SMTP id z5mr19736675wmp.73.1630276698899;
        Sun, 29 Aug 2021 15:38:18 -0700 (PDT)
Received: from oci-gb-a1.vcn08061408.oraclevcn.com ([2603:c020:c001:7eff:7c7:9b76:193f:d476])
        by smtp.googlemail.com with ESMTPSA id s7sm13603878wra.75.2021.08.29.15.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 15:38:18 -0700 (PDT)
From:   Matthew Hagan <mnhagan88@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Matthew Hagan <mnhagan88@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] ARM: dts: NSP: Fix MX64/MX65 eeprom node name
Date:   Sun, 29 Aug 2021 22:37:50 +0000
Message-Id: <20210829223752.2748091-4-mnhagan88@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210829223752.2748091-1-mnhagan88@gmail.com>
References: <20210829223752.2748091-1-mnhagan88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running dtbs_check yields the following message when checking the
MX64/MX65 devicetree:
at24@50: $nodename:0: 'at24@50' does not match '^eeprom@[0-9a-f]{1,2}$'

This patch fixes the issue by renaming the at24 node appropriately.

Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
---
 arch/arm/boot/dts/bcm958625-meraki-mx6x-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm958625-meraki-mx6x-common.dtsi b/arch/arm/boot/dts/bcm958625-meraki-mx6x-common.dtsi
index bcdd38954f1d..6519b7c61af1 100644
--- a/arch/arm/boot/dts/bcm958625-meraki-mx6x-common.dtsi
+++ b/arch/arm/boot/dts/bcm958625-meraki-mx6x-common.dtsi
@@ -48,7 +48,7 @@ &ehci0 {
 &i2c0 {
 	status = "okay";
 
-	at24@50 {
+	eeprom@50 {
 		compatible = "atmel,24c64";
 		reg = <0x50>;
 		pagesize = <32>;
-- 
2.27.0

