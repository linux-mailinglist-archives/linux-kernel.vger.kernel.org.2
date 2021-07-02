Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEC4A3B9A94
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 03:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234748AbhGBBp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 21:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234501AbhGBBp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 21:45:26 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8D5C061762
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 18:42:55 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id hc16so13581457ejc.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 18:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E1Zvb/uiy3iOmHflgjq8JXx3wNW2292VBosbWV1esJ8=;
        b=STn1H9Unt+WHKEKNFfAff+AT9Dm3AcVQsswD8UTf9jF17KFYS1jV8xm67dZI0J0+GE
         CAp7MQpik05b409mi4C77C+GA+swnVNmlto/4WFi6ILwm6hP8Zw01PYwRmbObtd4Teqm
         tkmyb4cBn60oen5p1JnN9S+hMGGxXLDjUue3iYugON7o/DT5dLQpVbjVCW9AExTvJ3XB
         BW97COdMKt4Pvr0KESWdTovkdtOf2bM4iXqyl8OUYvWYWr6tojNR1q1O3UtU8Kes58AI
         ZweS2E7SnCmb6wzSLz43g0YkrbBYOUKSXqX5DprTDj8Amk11TdRvuMLvBKovvjXb12Cp
         VcRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E1Zvb/uiy3iOmHflgjq8JXx3wNW2292VBosbWV1esJ8=;
        b=gRAgqYYs+djaNVvO9K+qlHFKp1qyIbcKR7K8CAzSCGCDmB4SUd+V5Vz73G71l+sre1
         qvUE8WJcNVP1EMZIKsGmiSKYymO89rHCo5SXnEEl9HL9hFdkijEVDw7m67x1ywJgIMIE
         fYkF35bpiBUyfPKfpmoA/Z+SrUO64OiGq18xO9XIz8/enJzlybTWze2TCTa2Tsxw7kbE
         v954+VaYQFUlWTDaKbtXKPHLVp3WwomhBorG0vEDw0WLXhC/s0f6v18jK3fkFx0MMxWa
         vqi88MrIQ/9OrOouFzJOvBAoVzVm4A0wjfbTWQW+EN0z4Rt6VhRDztbalpOREh1inSFh
         wHzQ==
X-Gm-Message-State: AOAM5326qEZRgvuEZczub4G4S3CRTI4tRRSrhGJGMZ5S6veRvQ7wxI9L
        y6DKvpXA9tsRiuX/o7yo7XE=
X-Google-Smtp-Source: ABdhPJyuszK90w+8YsfWrm7VGuURTSEbrICR2T9Hqw1M2H01i04/llH03wZNXedgL9V6QmqfJTdAJA==
X-Received: by 2002:a17:907:97ca:: with SMTP id js10mr2748153ejc.393.1625190173775;
        Thu, 01 Jul 2021 18:42:53 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (ec2-44-242-66-180.us-west-2.compute.amazonaws.com. [44.242.66.180])
        by smtp.gmail.com with ESMTPSA id j19sm629580edw.43.2021.07.01.18.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 18:42:52 -0700 (PDT)
From:   Bin Meng <bmeng.cn@gmail.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Lewis Hanly <lewis.hanly@microchip.com>,
        Atish Patra <atish.patra@wdc.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Bin Meng <bin.meng@windriver.com>
Subject: [PATCH 1/2] riscv: dts: microchip: Use 'local-mac-address' for emac1
Date:   Fri,  2 Jul 2021 09:43:18 +0800
Message-Id: <20210702014319.1265766-1-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bin Meng <bin.meng@windriver.com>

Per the DT spec, 'local-mac-address' is used to specify MAC address
that was assigned to the network device, while 'mac-address' is used
to specify the MAC address that was last used by the boot program,
and shall be used only if the value differs from 'local-mac-address'
property value.

Signed-off-by: Bin Meng <bin.meng@windriver.com>
---

 arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
index 0659068b62f7..a9c558366d61 100644
--- a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
@@ -317,7 +317,7 @@ emac1: ethernet@20112000 {
 			reg = <0x0 0x20112000 0x0 0x2000>;
 			interrupt-parent = <&plic>;
 			interrupts = <70 71 72 73>;
-			mac-address = [00 00 00 00 00 00];
+			local-mac-address = [00 00 00 00 00 00];
 			clocks = <&clkcfg 5>, <&clkcfg 2>;
 			status = "disabled";
 			clock-names = "pclk", "hclk";
-- 
2.25.1

