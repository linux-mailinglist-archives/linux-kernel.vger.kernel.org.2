Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB423E0132
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 14:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238120AbhHDMar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 08:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238087AbhHDMaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 08:30:46 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B080C0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 05:30:33 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id o5so3465757ejy.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 05:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OLftcCiR2oyNljE54bb27thfQzh14DolSH3s1/1P/+w=;
        b=m45M4wRFC7Zc0J8Gwu3B4lPC/LXioJnqS9oEvr8DV3PmhE8fuVLvxh2rsNNgG4v0Cm
         xYXf9abkKtsKsE81rL/F36DrUNI8wfirBIIb1vhYV4GMbweNlS1fRdoA//UOJo08J+UN
         4n/fhk04AuQMYX0JaAYM58M/sqO/GTx94iIHhMa3Zv4OtVVJ2n4qKDnmkFdL24mz4niS
         BOXXBAOse1NH0nopBEkHzcnWRainTbLcj8CVaJs1XzpG2vnDlDm3x3A1YWYPJQvhFBR0
         uNBaOm8lE7xm1I+njc8XdoXuu7NqGcZih78DLF98n5d9OhkUT58ZmwLy+Z9XmMr8F3ZR
         N6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OLftcCiR2oyNljE54bb27thfQzh14DolSH3s1/1P/+w=;
        b=H1qJnCzWnLQRNWoHzuS33QdmwaNZf5+jovsGRfucvA2UJgIVMbrSHzg/uD70CO/KZz
         KIsjnHdCZAwyqG0JhUAa3XfLpb1FXnIFkfpxopB0gPz9pgcGh/l23j7+l0Hp4OWDwpUG
         eMqoJCExU2FKRz5ogtG9v/X2Trk0QhpkB4bu7FFtYFPZ6qJA2FCVOVubXwBDRwYZveFC
         F9BOPs1cyEjPnGOncUK6TyCtQQ8Ieg8MxO/S4P5DTGV8BT/5FLa0yfpjCpipLh5+1wvq
         CoeAW6jMOA3j5DRvZNRseROMzNc+SoU1NqUMml0BYu+7tpK38dVCMh9v27N1AZ3vlIsF
         aI1g==
X-Gm-Message-State: AOAM532ggcwkuMvoeeMz7/YOz8K0C7WRuUq0CK0O+JcWCrAdwx5PatIl
        mHlJ5orU2LB1/9CNHuXp6c0=
X-Google-Smtp-Source: ABdhPJxP6xt6XhnuBtGwOrh2MyWhOJiuzzj9Ab5gP5VWwMnYmfC9koqioV/vQw1tMV0IM1YDaR4mWQ==
X-Received: by 2002:a17:906:c252:: with SMTP id bl18mr25700532ejb.519.1628080232108;
        Wed, 04 Aug 2021 05:30:32 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (ec2-44-242-66-180.us-west-2.compute.amazonaws.com. [44.242.66.180])
        by smtp.gmail.com with ESMTPSA id f5sm627590ejj.45.2021.08.04.05.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 05:30:31 -0700 (PDT)
From:   Bin Meng <bmeng.cn@gmail.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <Conor.Dooley@microchip.com>,
        Atish Patra <atish.patra@wdc.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Bin Meng <bin.meng@windriver.com>
Subject: [PATCH v2 2/2] riscv: dts: microchip: Add ethernet0 to the aliases node
Date:   Wed,  4 Aug 2021 20:30:15 +0800
Message-Id: <20210804123015.807929-2-bmeng.cn@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210804123015.807929-1-bmeng.cn@gmail.com>
References: <20210804123015.807929-1-bmeng.cn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bin Meng <bin.meng@windriver.com>

U-Boot expects this alias to be in place in order to fix up the mac
address of the ethernet node.

Note on the Icicle Kit board, currently only emac1 is enabled so it
becomes the 'ethernet0'.

Signed-off-by: Bin Meng <bin.meng@windriver.com>

---

Changes in v2:
- move the aliases node to board dts

 arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
index ec79944065c9..baea7d204639 100644
--- a/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
+++ b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
@@ -14,6 +14,10 @@ / {
 	model = "Microchip PolarFire-SoC Icicle Kit";
 	compatible = "microchip,mpfs-icicle-kit";
 
+	aliases {
+		ethernet0 = &emac1;
+	};
+
 	chosen {
 		stdout-path = &serial0;
 	};
-- 
2.25.1

