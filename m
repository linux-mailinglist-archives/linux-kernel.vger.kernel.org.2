Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A50F3C3514
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 17:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbhGJPOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jul 2021 11:14:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbhGJPN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jul 2021 11:13:58 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C4BC0613E5;
        Sat, 10 Jul 2021 08:11:12 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id c9so5908362qte.6;
        Sat, 10 Jul 2021 08:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AlYiA4q2rsNk75Sq5fLZwlU6l6nH3Iejbu1a3VvQFdU=;
        b=mNUE3HIBHonppHVbLpIQ5LM7qgbpiKGypzWJIVvlshICuprOvlfThoGv7mYG5gDsvf
         vNeMwOvz0tvZx22WoeoYcZEiQ+wrExQnrMklo4KnidWiWMXUA/jYCXToCDTezlmVhG2W
         YETOKYlS7n/yKI1cWRBNrJbDaWhM4oetv6rz68nTtPgTE8IMZOAFLTAVTnWaMSmATUXg
         V5J9gD7MNLAWaCo1RNBRShoghrlV8EAypqW1nV0DppGADoJqY+OqGDb7mkqHGe/WTelB
         XM3t+BTjNCABpheWulMfOYxoZ6vCn0qPNBtUtXwR8qAFw94j8U+oLgKOA5JlKADjoHUb
         aq6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AlYiA4q2rsNk75Sq5fLZwlU6l6nH3Iejbu1a3VvQFdU=;
        b=M2hyGcO+JwPJ78J00SzvJltuohFclK3bu/j6bfL98WcQBzCZxIbmDJYb+6ImykOe9o
         J+u3w4gXchALSX5sRPLe8LRXm6nq7OjlSMzV/ey00Gt4NAsjau1oSOS4TfsqdMHp8eiq
         kfUob+EhG7qUu5nRGdDnG/D84BRng91WBA2fDsYYiPdjzzwhprslpnatImgglhPMQuof
         oeabTz0APTWSQRAT2nJMUvNjkZyQ4xcI4TazteV/HjIUWN+C9rAoaml3JmEVQYnK6eAY
         UU+5fzxeeZHxLuwGrMMBeIVBNMgdvD6+/DdpACjLp08MJj7lGp+mbZqVIu6dVabXa13B
         mgVQ==
X-Gm-Message-State: AOAM533wLtLHiViPt8gHLDqWor72MglwzEex+3W76P744dz9GS77c6Cj
        l9XEsALEICGgzMWHtG4l3JY=
X-Google-Smtp-Source: ABdhPJzS7x8nHbQPoBbS37Kjq6I4Ct4rXiDqSZ0yGdne625IIQ9E49UkCWY8x7v3oubC8r/zYWYgDw==
X-Received: by 2002:ac8:7d85:: with SMTP id c5mr1281370qtd.58.1625929872027;
        Sat, 10 Jul 2021 08:11:12 -0700 (PDT)
Received: from master-laptop.sparksnet ([2601:153:980:85b1:ecc6:5233:6153:7b36])
        by smtp.gmail.com with ESMTPSA id w14sm3445482qtc.55.2021.07.10.08.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 08:11:11 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Liang Chen <cl@rock-chips.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peter Geis <pgwipeout@gmail.com>
Subject: [RFC PATCH 3/4] arm64: dts: rockchip: add rk3566 dtsi
Date:   Sat, 10 Jul 2021 11:10:33 -0400
Message-Id: <20210710151034.32857-4-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210710151034.32857-1-pgwipeout@gmail.com>
References: <20210710151034.32857-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the rk3566 dtsi which includes the soc specific changes for this
chip.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3566.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3566.dtsi

diff --git a/arch/arm64/boot/dts/rockchip/rk3566.dtsi b/arch/arm64/boot/dts/rockchip/rk3566.dtsi
new file mode 100644
index 000000000000..3839eef5e4f7
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3566.dtsi
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+#include "rk356x.dtsi"
+
+/ {
+	compatible = "rockchip,rk3566";
+};
+
+&power {
+	power-domain@RK3568_PD_PIPE {
+		reg = <RK3568_PD_PIPE>;
+		clocks = <&cru PCLK_PIPE>;
+		pm_qos = <&qos_pcie2x1>,
+			 <&qos_sata1>,
+			 <&qos_sata2>,
+			 <&qos_usb3_0>,
+			 <&qos_usb3_1>;
+		#power-domain-cells = <0>;
+	};
+};
-- 
2.25.1

