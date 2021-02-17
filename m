Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80DAB31DC51
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 16:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbhBQPfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 10:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233688AbhBQPcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 10:32:00 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36753C061788;
        Wed, 17 Feb 2021 07:30:46 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id 81so13084362qkf.4;
        Wed, 17 Feb 2021 07:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jvz/+Sbpy7Q7uN5Kdj0arf6yo889JF2jVVQnFz4hh0Y=;
        b=dSviZFgeTOkS2y8DyLtSVtgcMhFXOmSv/Gcv9BaJU2XiDMqgIMwOm5jt/AiVgRSmnf
         m829GSjCXMqP5LKg+Sg/X4m8slLJIGOig2q4LXS4LXcgEpWWoUZCUijLG9C2O6FDI+s8
         VPDmYwxfDjjAgibvDlYvNSdE52qy3fMfjjCmaiQTjPHQGg+US8thctLaXIV8nzrjIzsY
         zoeLaGGvQ0CK4FzDu9xjrGwVXlSpNZiz8helZ90O+HtTtddJHDH3zpRJ8keDEI/KgVNU
         xQrsZWhte3gTERhX5ozOTwbsL2Xq+cWIKJkqizvuAc4PgofCSEQKvmseVZURv00/iqSw
         aNsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jvz/+Sbpy7Q7uN5Kdj0arf6yo889JF2jVVQnFz4hh0Y=;
        b=aDIXAChKFGGbGfXDdppX869BwkYdPtE6Zsn3KRVu84UZvGBtS+TZ3aeXtNCyexAFMi
         7g/lIjDeHQcsIAD4SDoxcMEnBktQfeWcj2u2eDT3t71eMh0JkMcjmVmAiTQrKK4ID+62
         /MR7LjV8PIYEfJ8sYVzpcvIpJdjOVkELNojCb4rVpVmhjogXfNUQksTN3mP0Y+CNxngq
         QFlrQ7Pd4QncHmWUhh70K2wCQrBKjy49Id0Fa/ZPPpI9GPKRNnj0qPQOnfpme3Q41B53
         a1UbVbRFSap5JL1ao0IRnwbBOPB7krauE2MFvhoQlE/BKMlpqn6gNMTJfno5vgt0DSDp
         rtHA==
X-Gm-Message-State: AOAM533yK+DRhaybgSvm39hNhTW/6nk22ssoYDU0cUePstA0Iv0DZJHc
        DR8bMey1Hg2xrNTI8+LFBA==
X-Google-Smtp-Source: ABdhPJwqkZZBXh40P+gy12WBcoPO8gcc3SFTRYSvguI9LrlWfYANJ1Mip+60CkBP7Fx0EWGmAIw4xA==
X-Received: by 2002:a05:620a:1285:: with SMTP id w5mr23591421qki.420.1613575845422;
        Wed, 17 Feb 2021 07:30:45 -0800 (PST)
Received: from presler.lan (a109-49-10-113.cpe.netcabo.pt. [109.49.10.113])
        by smtp.gmail.com with ESMTPSA id z37sm286313qth.87.2021.02.17.07.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 07:30:44 -0800 (PST)
From:   Rui Salvaterra <rsalvaterra@gmail.com>
To:     andrew@lunn.ch, gregory.clement@bootlin.com, kabel@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rui Salvaterra <rsalvaterra@gmail.com>
Subject: [PATCH] ARM: dts: turris-omnia: fix hardware buffer management
Date:   Wed, 17 Feb 2021 15:30:38 +0000
Message-Id: <20210217153038.1068170-1-rsalvaterra@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hardware buffer management has never worked on the Turris Omnia, as the
required MBus window hadn't been reserved. Fix thusly.

Fixes: 018b88eee1a2 ("ARM: dts: turris-omnia: enable HW buffer management")

Signed-off-by: Rui Salvaterra <rsalvaterra@gmail.com>
---
 arch/arm/boot/dts/armada-385-turris-omnia.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-385-turris-omnia.dts b/arch/arm/boot/dts/armada-385-turris-omnia.dts
index 646a06420c77..dc80a909ea88 100644
--- a/arch/arm/boot/dts/armada-385-turris-omnia.dts
+++ b/arch/arm/boot/dts/armada-385-turris-omnia.dts
@@ -32,7 +32,8 @@ soc {
 		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
 			  MBUS_ID(0x01, 0x1d) 0 0xfff00000 0x100000
 			  MBUS_ID(0x09, 0x19) 0 0xf1100000 0x10000
-			  MBUS_ID(0x09, 0x15) 0 0xf1110000 0x10000>;
+			  MBUS_ID(0x09, 0x15) 0 0xf1110000 0x10000
+			  MBUS_ID(0x0c, 0x04) 0 0xf1200000 0x100000>;
 
 		internal-regs {
 
-- 
2.30.1

