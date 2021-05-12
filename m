Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 806D137BC74
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 14:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbhELMZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 08:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbhELMZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 08:25:13 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60ABAC06174A;
        Wed, 12 May 2021 05:24:03 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id j26so23156640edf.9;
        Wed, 12 May 2021 05:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=60Lo7xpvw9UYiOl5jHY1jyhH6Kp5rVQT5uk6x+ikYXU=;
        b=Mdu97e9gLT6Umjsqj2dU5GbMkiV4N2BUxQssVztxu3bLjVCVW/KCJZwfUFGFbEy0GR
         Cmn66TRYf5go3QSIVoXmoUIHqSn+x1P9wi4AQJ07gU6T7eShIHwQhC8x6nEJXyQ9Mq7g
         NIsvZvcq0YANcaeWtQ4iDr6h44SvQAsvrNFQT6oeb2F2Anld/75IBhQ3Aoh+4lVPyfgp
         A8P1h7xNKV55KzZ0gzPuAOJNTZaDXyV+ASDjCkGfDyWFFEjn6kzyiU5m7zuzgeA3UilP
         SvaYdEhBwUX/JeLuwFH7aOFqoaeePMJK/rP9CzU4zOF+wMG4qNUM5OOLpoxiwIlR3DgA
         kxOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=60Lo7xpvw9UYiOl5jHY1jyhH6Kp5rVQT5uk6x+ikYXU=;
        b=pY7LSg+kppvoQ23ltDT4srryUPtD7VZGFGwvvegpGKS9QTqqmGfzqZ24gi+4JnAUqC
         AGl8uvtWGSto3Uy6mN43gPsjXC44Jdq0HWt9l9/Amj0ASALZb14ca8L8Z5TGbpnNzCb6
         cLEvpuZJWEK1LUu55hMlU0rmi3esUtvmrzKiixhrOUa1PmoNg5wPB1HX33UbDTaaya/D
         IzPQRR572Du+UXJcHr+cuYQ96rP1qqWFhFGoehgzZZif2lNHJkMr8yUQQSNQReHIGoX9
         rAcmmUv0j7vz8dWH6Yn3KbFqGCGeSKCkExE2keGO86P4PfjRKVmRr9oSrIRmoUm1R+8p
         cx8Q==
X-Gm-Message-State: AOAM531Z+pE7mN4J8pge5FB4aZnIu5EdbyAIAFTDMifQ/tfp+k6beFWl
        U1Uo8STp5LNiu7ViGT4hXxI=
X-Google-Smtp-Source: ABdhPJzZj9PTMYL7qQm7sjxLMG094zoBSEv3LHs6xPHRPrYhpk7gcbrMtrpNHbJJoWmtqanqW2R5PA==
X-Received: by 2002:a05:6402:2714:: with SMTP id y20mr42631731edd.348.1620822242212;
        Wed, 12 May 2021 05:24:02 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id g17sm21459665edv.47.2021.05.12.05.24.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 May 2021 05:24:01 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, linus.walleij@linaro.org, kishon@ti.com,
        vkoul@kernel.org, jay.xu@rock-chips.com, shawn.lin@rock-chips.com,
        david.wu@rock-chips.com, zhangqing@rock-chips.com,
        huangtao@rock-chips.com, cl@rock-chips.com,
        linux-phy@lists.infradead.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/4] arm64: dts: rename grf-gpio nodename in rk3328.dtsi
Date:   Wed, 12 May 2021 14:23:46 +0200
Message-Id: <20210512122346.9463-5-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210512122346.9463-1-jbx6244@gmail.com>
References: <20210512122346.9463-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below gives this error:

/arch/arm64/boot/dts/rockchip/rk3328-a1.dt.yaml: syscon@ff100000:
grf-gpio: {'compatible': ['rockchip,rk3328-grf-gpio'],
'gpio-controller': True, '#gpio-cells': [[2]], 'phandle': [[68]]} is not
of type 'array'

Due to the regex "(?<!,nr)-gpios?$" anything that ends on
'-gpio', '-gpios' gives a match.

Rename 'grf-gpio' nodename to generic 'gpio'

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=~/.local/lib/python3.5/site-packages/dtschema/
schemas/gpio/gpio-consumer.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index 4ce49aae7..2e458fb87 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -291,7 +291,7 @@
 			status = "disabled";
 		};
 
-		grf_gpio: grf-gpio {
+		grf_gpio: gpio {
 			compatible = "rockchip,rk3328-grf-gpio";
 			gpio-controller;
 			#gpio-cells = <2>;
-- 
2.11.0

