Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F353E0131
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 14:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238085AbhHDMan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 08:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237429AbhHDMal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 08:30:41 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4E1C0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 05:30:28 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id ec13so3331707edb.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 05:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gcr8BhuUlRn9dO5oYZlFn/1npo+Wb2aMp3w+r/9MRMk=;
        b=WHKHoCpXVz/+eBeqLg7X8OOd0zw5SbQ8V8eTxq9QbYyNdg/1UfJBh6/CJxfwEyZ672
         UQ72/RmfGI6i5A2WGOuU23KrfpW2v4J82hxlSZ0STUvMPUMQIuvn7M6aI4VbaBFf8qVV
         LgifWWKRKWB3+iTsuVwNAxZaUY81YATnGteYy/X/9MkyTt0F3yRVSdxeS/4NlTBQcUfv
         RJB+V8LIg7OFihL6w8uUTAMNsLHVv40sj8Hr8RFNqEANKycf6HvGNsOX7NLqKHNpPRQT
         IbgucPZG243C2IEqwZEBCh5kwONLZqMWbNtFHAjeZL6hy8kBIobOAcN7VLMSPzn+7OE3
         qICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gcr8BhuUlRn9dO5oYZlFn/1npo+Wb2aMp3w+r/9MRMk=;
        b=balpJ56Uoxf1lzkbeUC09NbYHiWJi+OKKCePk8QwGB9+zXRLAp+A1bPMn9Qtk9LCiG
         ZSXmh5Lha5PQ0VAzu8JgQS5/MAPKz76lYuxaOgR2e7qjsZs3YMKqmrIrOMW84iy7yN1q
         Qpqfdf0YqZkzESV6457r7sgu6xHSRfuTfEPDrfvk+WemSnhNA48Z+FD0qzXUehh29xD8
         aW550357pRaYLcX+nNekbCKr1uuyr3DaLOgxWpIoZXIx6heQ6BBd+LrK3zhIWUxNq4ce
         18Ow9JMi8dsn1nsVLUx5o/r6jDrxE3zHSG0NhNNF677c+oKI3HonPrKsRJrwHMu0eYW6
         zxlg==
X-Gm-Message-State: AOAM533ibKeSyW9nIotCF8H8y1vBB2ittSN6kHdmcFNlk6n4P307ACCQ
        qdwOrrTA85msbTJ+4michOY=
X-Google-Smtp-Source: ABdhPJwWCUzOdpguggzhTnudkKa+0jV8mVhsPd0pRn7Jd/RgWXtGu4TEEiyhKU8ZPYkIP/U38Qolog==
X-Received: by 2002:a50:9503:: with SMTP id u3mr31376325eda.135.1628080227448;
        Wed, 04 Aug 2021 05:30:27 -0700 (PDT)
Received: from pek-vx-bsp2.wrs.com (ec2-44-242-66-180.us-west-2.compute.amazonaws.com. [44.242.66.180])
        by smtp.gmail.com with ESMTPSA id f5sm627590ejj.45.2021.08.04.05.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 05:30:27 -0700 (PDT)
From:   Bin Meng <bmeng.cn@gmail.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <Conor.Dooley@microchip.com>,
        Atish Patra <atish.patra@wdc.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Bin Meng <bin.meng@windriver.com>,
        conor dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 1/2] riscv: dts: microchip: Use 'local-mac-address' for emac1
Date:   Wed,  4 Aug 2021 20:30:14 +0800
Message-Id: <20210804123015.807929-1-bmeng.cn@gmail.com>
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
Reviewed-by: conor dooley <conor.dooley@microchip.com>
---

(no changes since v1)

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

