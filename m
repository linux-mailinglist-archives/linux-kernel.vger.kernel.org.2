Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B3F3A134F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239625AbhFILtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:49:13 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:45741 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239481AbhFILss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:48:48 -0400
Received: by mail-wm1-f44.google.com with SMTP id v206-20020a1cded70000b02901a586d3fa23so3984766wmg.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 04:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GbQSiZBzEuGIVwuEiIag9TzTdqugGYvIJEoxnMrSSJY=;
        b=SS2cbDoIzdIU96DkZoAQxyIUC1aFdY9kqx4Q8uf/kxO4b4viV6WVw3+KrLMRZfgo3I
         u6KDYfbfnf8rMX7OCg+K3SiqcROUCrB3qnJsF0cXL7yjuXSo+jytL+zPHz0uzAHmbteB
         cY+ORis0OXizeOjQe/SskVVlHDYeiF8jg5QNj13MIb1OpQ15jDw0GiYmA/HxGR1lBlXN
         IIpbS/QLWqytR4hONpz+BfBh/u0qI221NL0LCXt3jaam8xJl+uc5k0QImmpL3yDztdEZ
         Qb/9agXFRkwbA0Bu00Z+ivR8i7i75hHy4XlTVD+Q2R6Npz4nx2TbxEdgqNnMXmALYQsa
         x5uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=GbQSiZBzEuGIVwuEiIag9TzTdqugGYvIJEoxnMrSSJY=;
        b=bsRzPanzygjJVS7peHaYeJM+M+yxG7RF+bVKdaQssSmHmLZEYr9gqYbmKLgYRDMw+D
         ZkKHmial5lv5jo+aJ6+Nm+zlmYOh8scu8hVYe/DBmnzibU70Y+xo3HjFjp+zClocqdmq
         p1ahUEvY8KYqPScPK6igd2ZTR+8PEG7YR7Je/pk8H1wb5jo53RErp61PlIpoO+S88HWU
         byCRN4RR23myhnZA9QiCsCWLEqHPKtwFgRmDCiqLXtE0hPxS6E2GiJPwzHbIb1tnUV4T
         rIhx2tgm9YYV8zXa8v4qX/B/AMMVJ1yJ1w341pEZKhEdg7XXNR4/Zjb6N6dN0biu7Cvn
         0Kbg==
X-Gm-Message-State: AOAM533VK29IYA+fi8FUau5qHDdF8GcFXexAX75R2yuZjsxw3QnDwX9q
        V5eExMCKXxbO7lSkjAN9Nwjr3SwL3Zo5igFl
X-Google-Smtp-Source: ABdhPJxMn0oxXJfBeEUS9bZ7ufRZPIikEZ+zhGDeKdgYxT4BmbfG8pxY764UIHuPlJ+II2TscdM03g==
X-Received: by 2002:a05:600c:1546:: with SMTP id f6mr9668034wmg.47.1623239152133;
        Wed, 09 Jun 2021 04:45:52 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6::45a])
        by smtp.gmail.com with ESMTPSA id b188sm7961793wmh.18.2021.06.09.04.45.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jun 2021 04:45:51 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Quanyang Wang <quanyang.wang@windriver.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 18/31] arm64: zynqmp: List reset property for ethernet phy
Date:   Wed,  9 Jun 2021 13:44:54 +0200
Message-Id: <e153f0cda37a2a6ea1c6e11fb0a4af1d400f29e2.1623239033.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623239033.git.michal.simek@xilinx.com>
References: <cover.1623239033.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add information about reset gpio for ethernet phy in case someone wants to
use it.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts | 1 +
 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
index 339a12b255c1..5ddcfdf48626 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
@@ -204,6 +204,7 @@ phy0: ethernet-phy@21 {
 		ti,tx-internal-delay = <0xa>;
 		ti,fifo-depth = <0x1>;
 		ti,dp83867-rxctrl-strap-quirk;
+		/* reset-gpios = <&tca6416_u97 6 GPIO_ACTIVE_LOW>; */
 	};
 };
 
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts
index d9ad8a4b20d3..f7d718ff116b 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dts
@@ -2,7 +2,7 @@
 /*
  * dts file for Xilinx ZynqMP ZCU102 RevB
  *
- * (C) Copyright 2016 - 2018, Xilinx, Inc.
+ * (C) Copyright 2016 - 2021, Xilinx, Inc.
  *
  * Michal Simek <michal.simek@xilinx.com>
  */
@@ -22,6 +22,7 @@ phyc: ethernet-phy@c {
 		ti,tx-internal-delay = <0xa>;
 		ti,fifo-depth = <0x1>;
 		ti,dp83867-rxctrl-strap-quirk;
+		/* reset-gpios = <&tca6416_u97 6 GPIO_ACTIVE_LOW>; */
 	};
 	/* Cleanup from RevA */
 	/delete-node/ ethernet-phy@21;
-- 
2.31.1

