Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D45D43F1D35
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 17:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240726AbhHSPqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 11:46:09 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:42418
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240667AbhHSPqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 11:46:03 -0400
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id 3449A411F5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 15:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629387926;
        bh=8A01Ti4iWFCly0K7Cu7pOp84vfobY1MUZZvBkKJ35Ik=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=miB6jSpx1z6XeXlLQYemeFLQyRj8Xc4r5DJWKyx/DXlDoYPv2GMnQ/zl/CY4GVvE2
         o44EXz02dIOL6RMbOK8MN498n4VFYKvV+4w5F2Da/wxybU5mq6wGgHpevx7u66pg1S
         ry8WfC8b05mjb+7H4mXF26AvafNjrPKGZN6CEPRVNtSnxdziBD7K2jE3Q/XxcbCuEJ
         KrXwAJg1JEtErMJ4Z0lGLuT9AS1lgDn33zIxmOIhiFxJwZ2Cjsxh0FDKEUC7Djf5BU
         Ezn3SVaWNS33kRPRx1p1JuINv6jOi0blGae8cpVy5rU36jeuQaktgp2AyLkD+P4Pd2
         g3pWnQQbRfNwQ==
Received: by mail-ej1-f69.google.com with SMTP id h7-20020a17090619c700b005bc3c7dead9so2418751ejd.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 08:45:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8A01Ti4iWFCly0K7Cu7pOp84vfobY1MUZZvBkKJ35Ik=;
        b=t+6XRHxsMi6r0KgUS20I2VuXmmI83Jl13lNBbnA4YhdIFJO7P/8gUTdNea3e7yxj7t
         MHSOFlJPifc7Z1fCiM3shn1OWZrerS+6EL5219Ha9dOmlixN9dUrmaDSsXwFFoG8PPUQ
         pxYwlaFrwqgD07tiq0wkIBDfj7V+FEjtpjZ63szCj2d9KEpCW3Z2FeU77ZEn6H++HGDK
         H6pIaxtVYHIgM/nLXX6N7F0cO/Osdvpk3FggDuM4Jll11XM6RtOx3jPIEPhBHf+byOCB
         gCpmRV1+4Si3uj26nhvusb67QCh1TexLoUO0gOIItrdPswrTlRS2huMWJxeNs815jCt1
         LH/A==
X-Gm-Message-State: AOAM533HVhxrfdIo5MieSJ5r4QF2UMY3K76VqPjwrS/5ul9vLz6/E4Hh
        XJ/28Xgi+zSYpf2AUTKDRC2b/AWNfSETgtFtBIf8lSWN8BCE6xQ3CV8D7/rFWx8bui3VbEhzOxO
        A5xj+ZyeyuAdtWqYVfRGj+Ibqt2mSJx3JDpQXe0jRBg==
X-Received: by 2002:a17:906:7b53:: with SMTP id n19mr16394834ejo.14.1629387925474;
        Thu, 19 Aug 2021 08:45:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzop3xk9uOpzYONSS6eh+yJG5Jh6O2SpXAk8eo8bL4yAUYTFJUcq4vRwvvEVjARPWSfETkepw==
X-Received: by 2002:a17:906:7b53:: with SMTP id n19mr16394819ejo.14.1629387925347;
        Thu, 19 Aug 2021 08:45:25 -0700 (PDT)
Received: from localhost.localdomain ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id f16sm1925373edw.79.2021.08.19.08.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 08:45:24 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Atish Patra <atish.patra@wdc.com>,
        Yash Shah <yash.shah@sifive.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Piotr Sroka <piotrs@cadence.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH 6/6] riscv: microchip: mpfs: drop unused pinctrl-names
Date:   Thu, 19 Aug 2021 17:44:36 +0200
Message-Id: <20210819154436.117798-6-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210819154436.117798-1-krzysztof.kozlowski@canonical.com>
References: <20210819154436.117798-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pinctrl-names without pinctrl-0 does not have any sense:

  arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dt.yaml: sdhc@20008000: 'pinctrl-0' is a dependency of 'pinctrl-names'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
index c4ccd7e4d3eb..d9f7ee747d0d 100644
--- a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
@@ -267,7 +267,6 @@ mmc: mmc@20008000 {
 			reg = <0x0 0x20008000 0x0 0x1000>;
 			interrupt-parent = <&plic>;
 			interrupts = <88>;
-			pinctrl-names = "default";
 			clocks = <&clkcfg 6>;
 			bus-width = <4>;
 			max-frequency = <200000000>;
-- 
2.30.2

