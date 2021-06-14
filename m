Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1BE3A6A24
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 17:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233633AbhFNP2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 11:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbhFNP2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 11:28:16 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6B3C0613A3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 08:26:13 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id ci15so17363156ejc.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 08:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nm9qn1QbSihHVUPv//yaqJU+HrAYckEVtZ9B21qTXrI=;
        b=jJ6sATRUdBVFcYYPylcLs/v7Aei8uAfnQJwgkue+Lghb2tEoigmVTVRU2TsNRVHKLO
         jdGTbnj1XBPcT9CnE49RelbZ543aJ2ieb49ZKMmJI2AOGNpvQVBbaH2ueygXkGRbWfQY
         5gBSalNM5M43l416bt6IYRXXSbPhErgSeGxJZIo2MtBgwF6+paP7E6w9vholxgfCc58N
         nxcAmPBfipuG+fFxWSJ312BLxzbMYN0IunKmAlngjQyW8X8CZSAeKVhckuMETvkjfN/9
         r+QLIpQrL0ZoNdtj4a+MbLN4wk0GRCI5fh6b0hp/E4tPIprxmQBovw/x6swfRscipqvn
         oAKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=nm9qn1QbSihHVUPv//yaqJU+HrAYckEVtZ9B21qTXrI=;
        b=ojZHFxOXA2zBU0yVddbnJ3q7DOJ4ebyTAXB+w3VkW2UCTvFlS81Di7xzbli8tWe49z
         sLWvSb7/sHcvsWk4snHae9loU+mJd+AwIQHVln0bIBGkgqUwKSi+I8lMq3iS6yWJhbXb
         8HxevWAOkUNZWKbtiM/8RT/GrJF6utbguW700F5MQJW/XBJWCkP1HPuXqRfvjdz7/Mnk
         7t9Qf5SK+sPCJDMUoLMHJuNOsM7DiZy5YQC1YDqQSZRAln1oIlqnPC+QItsQNeF1rehs
         FXq4iE0t69FZFuPCWnAuguCuib8dCt/IduWjxVslBQWHJ9poYQyFoCVIIUXQmnq4TNfA
         bjFA==
X-Gm-Message-State: AOAM530+7cA0OFAtD8s5QOXyANNjngkiIt5Zf1WAgo8mF5IA/kfY69VS
        wAEzWJVWyagLFugUpNCf8ZKL63hDNCU0Zhh9
X-Google-Smtp-Source: ABdhPJwdfZPNqiUr0DYnkyAiU26gMo0l4LAgX5ie3j31dfHeeBU2o2iYOVwcbw8F4SPHbpq+ajfceQ==
X-Received: by 2002:a17:907:9617:: with SMTP id gb23mr15762024ejc.483.1623684371770;
        Mon, 14 Jun 2021 08:26:11 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6:f666:9af6:3fed:e53b])
        by smtp.gmail.com with ESMTPSA id jo13sm7534746ejb.91.2021.06.14.08.26.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jun 2021 08:26:11 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Mounika Grace Akula <mounika.grace.akula@xilinx.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 19/33] arm64: zynqmp: Add reset-on-timeout to all boards and modify default timeout value
Date:   Mon, 14 Jun 2021 17:25:27 +0200
Message-Id: <5848a81447921240fddfe2f5749ae0746fcbbdbd.1623684253.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623684253.git.michal.simek@xilinx.com>
References: <cover.1623684253.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mounika Grace Akula <mounika.grace.akula@xilinx.com>

This patch adds reset-on-timeout to FPD WDT which will trigger an
interrupt to PMU when watchdog expiry happens and PMU takes the
necessary action. If this property is not enabled, reason will not be
known when watchdog expiry happens.
This patch also modifies the default timeout to 60 seconds. Reason is
that if u-boot enables WDT, it will set the timeout to 10 seconds and
this is not enough to boot till Linux and start the WDT application in
Linux. 60 seconds is the maximum safest value to boot till Linux and
start the WDT application.

Users need to change this timeout value to fit their needs.

Signed-off-by: Mounika Grace Akula <mounika.grace.akula@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2: None

 arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
index bd3f0d456ca4..80332e3b4d6a 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
+++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
@@ -830,7 +830,8 @@ watchdog0: watchdog@fd4d0000 {
 			interrupt-parent = <&gic>;
 			interrupts = <0 113 1>;
 			reg = <0x0 0xfd4d0000 0x0 0x1000>;
-			timeout-sec = <10>;
+			timeout-sec = <60>;
+			reset-on-timeout;
 		};
 
 		lpd_watchdog: watchdog@ff150000 {
-- 
2.32.0

