Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4DC419815
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 17:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235213AbhI0Pnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 11:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235112AbhI0Pnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 11:43:45 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288D0C061604
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 08:42:07 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id l8so23439255edw.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 08:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yixeTS4IcK7qbNDVmCuUdTLJjmWoVoD+wqJwXLkptEA=;
        b=JUGS/SuwdzthkpSr16fC4keLiCCyozxTUSlv4SnVHjAXsJpGfpRlk8tSX6kI5Dmqpr
         Bh6bU6N8M+VeA8/WSEgqSZc+yqMNg++YcBTtu7EIXmrz8T2EzjXhauj6B+U8ifgkxKsq
         ioy22b8pB2ZY31eLaewiMgnAPSk8CHUWsx2sAsw8KcghKjJtkwEGeTqVH5sKQMLBZH0r
         LDFtQBvN3WDEj77Be714jsF5ysApHaniuAm8EuL741t0UevYtC+oglli2zGzLHhNVHkJ
         izYEGoCXPE2BttIjbWMa3tnfz7PpW7TgGqg46j6/meTqyFNkXH7h6PyY/9RMV4R45vqN
         r85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yixeTS4IcK7qbNDVmCuUdTLJjmWoVoD+wqJwXLkptEA=;
        b=lcMSGC6X8TkkIG8YDe137gH//Wqr2POMcGDRNzOXJqRqhuF5j4kyU7SpMXybbISON+
         +iRe0CJRcnFOaqtu1mtldg++f/3rn/FbxnEPA6RH8rU1QRiqunM0RtMxcjGG1Rj7M9jw
         kdDsPqifpblXvazv1RrMeazIOEi0v6sDbdDqd61unXrtNjebkUJeHYNAPSUp+mCXL+ox
         WZlsMyDxWv7JwpIHcmqocZvc3fChMHdffPa7xpQ4aDThUSxbDM6u5I2qv+OiVrqdk8IE
         d8JPEzhLHi2U6IR/Guzr82b9lEHRT2168nWSU/ncUCv7oBAOCmZ+Jqh8N01nGxbyxSUl
         oRKw==
X-Gm-Message-State: AOAM531iXBvLjKCtaiVD12isoArKm7DtXndwtN4xh+owZERdLhJd7BKi
        NsvMWHKvwgE3UVXRl415KOvXTEQ58U6xgQ==
X-Google-Smtp-Source: ABdhPJyWXfQm6sHYMrxwCK2DoebLIaIwTL5p70SfDwucjWuThxcPxpwLss7p71g6/LNBDUCkjArSqg==
X-Received: by 2002:a17:906:39cd:: with SMTP id i13mr734388eje.227.1632757325745;
        Mon, 27 Sep 2021 08:42:05 -0700 (PDT)
Received: from fedora.. (dh207-96-123.xnet.hr. [88.207.96.123])
        by smtp.googlemail.com with ESMTPSA id n16sm10768025edd.10.2021.09.27.08.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 08:42:05 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 1/4] arm64: dts: marvell: espressobin-ultra: enable UART output by default
Date:   Mon, 27 Sep 2021 17:41:56 +0200
Message-Id: <20210927154159.2168500-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since Espressobin Ultra board has a microUSB port
with the onboard USB to UART connected to it to be
used as a debug UART it makes no sense to require
the bootloader to pass console args to the kernel in
order to get console working.

So, use the "stdout-path" property to enable the UART
output on the microUSB port by default.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
index c5eb3604dd5b..c1770ceff3c1 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
@@ -15,6 +15,10 @@ / {
 	compatible = "globalscale,espressobin-ultra", "marvell,armada3720",
 		     "marvell,armada3710";
 
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
 	aliases {
 		/* ethernet1 is WAN port */
 		ethernet1 = &switch0port5;
-- 
2.31.1

