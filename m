Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C3A30632E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 19:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343657AbhA0SYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 13:24:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbhA0SYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 13:24:14 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960EAC0613D6;
        Wed, 27 Jan 2021 10:23:33 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id i187so4019895lfd.4;
        Wed, 27 Jan 2021 10:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7/VIyGCkm6WYqKuSW58avCCQFZDvTdRr+WLSSIBWpSM=;
        b=TBvLEZd6eR8Jg1s6FBNMAsAVrQzkqhI0GamcHJFR7LYDoC9+HWYDPnG4cBG/0AXMmd
         PTY5bwWHS5+6Ld56/bbGo6ZSKna9l/BctnyrZELbIt3ksQ/xQvEclVg7bwgi1nIkv7na
         vAvqqVwsh5/Xte+BQIc3jG+MlayezjwET+giP4pp77SBZ7ioZLLwNxiriXNllDHaDvyJ
         oUMfs7YegcAM4U4RkKOQhNvoGQ32Hzf29gFjCr8Svt+uWT8067EJibxtDGxs04Qxo36O
         3F+jWvWxsdmKYe5dSmf1+ZuOu2a9beGROlFbyuUm7U9i4hQKtPni4rL8jzCUNVaBThIz
         UQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7/VIyGCkm6WYqKuSW58avCCQFZDvTdRr+WLSSIBWpSM=;
        b=QQhzE39l4YLvIpvd1P87pF6dyFbEGeHMcDb73fUE7s2+SUenfXZumiv3eyITS5vdWC
         oLGjCv4b55qZ8uJtLofyDSaOVrW4BLve+wtp13AW0Zf6mab4oc29m7yd5320URGdz0kZ
         5A7DrUK3Eqe65L0I1f5BY/C6kMrW0SRDq2c56Qx3Z7AAPo/PeCrX8ONEhZOM1rBT1svh
         jGBaeGX+Wy7H1CpXDZz09Gn+y6YVWcY/eAiJ9xoGIqu6pBNcSb3him5gh3uo0mvdgzI6
         TCUJMK55rpu3sAc21/IKGkJporRsI52anZ7KpJ7nlRdypizS0cx5yWXCRcgJXHU+AL6y
         KqsQ==
X-Gm-Message-State: AOAM530Jezsgay17gQFRz1sKFa5c+RQD/zkJNwha6verFXjcjsMxG6/A
        JSkO4vqm7lh78lPzGVfw6wo=
X-Google-Smtp-Source: ABdhPJxuj9qRi3BNtT+pBYV+AmDZUin5XCQxcaFgTFWsE+uJi/i7tX09ihVfB5PlDCiOkSD+r8CdDg==
X-Received: by 2002:a19:838c:: with SMTP id f134mr5518819lfd.424.1611771811861;
        Wed, 27 Jan 2021 10:23:31 -0800 (PST)
Received: from DESKTOP-GSFPEC9.localdomain (broadband-46-242-11-119.ip.moscow.rt.ru. [46.242.11.119])
        by smtp.gmail.com with ESMTPSA id q26sm667065lfd.17.2021.01.27.10.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 10:23:31 -0800 (PST)
From:   Konstantin Aladyshev <aladyshev22@gmail.com>
Cc:     supreeth.venkatesh@amd.com, aladyshev22@gmail.com,
        Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: aspeed: amd-ethanolx: Enable secondary LPC snooping address
Date:   Wed, 27 Jan 2021 21:23:26 +0300
Message-Id: <20210127182326.424-1-aladyshev22@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AMD EthanolX CRB uses 2-byte POST codes which are sent to ports 0x80/0x81.
Currently ASPEED controller snoops only 0x80 port and therefore captures
only the lower byte of each POST code.
Enable secondary LPC snooping address to capture the higher byte of POST
codes.

Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
index 96ff0aea64e5..ac2d04cfaf2f 100644
--- a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
@@ -218,7 +218,7 @@
 
 &lpc_snoop {
 	status = "okay";
-	snoop-ports = <0x80>;
+	snoop-ports = <0x80>, <0x81>;
 };
 
 &lpc_ctrl {
-- 
2.17.1

