Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20BDA4194A1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 14:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234512AbhI0Mwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 08:52:41 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:40420
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234468AbhI0Mwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 08:52:34 -0400
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3BF174082B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 12:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632747056;
        bh=gL2n73HFUZMgICxi9XxH4YAlloJV26Mt1lAxrRgunho=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=lNx+trnLPezcfVob9zFV9tc2LMYLcLEhotK8CYHYYBenPKGfwZNiDD3dsh9VLU6Un
         6RDZo9JrnfuuQ6ARvY7Rfkw3nQ1HfZGYoCHeJDCJbZA59WCit3Om4hrQzdpjkytb1Z
         8i7j7EhMv144Cez575suNq6qQFFKBa0lebnmpBWCB/848ELlhTzv6bGo8FzUrvG0kY
         Nn9M4gLR1JC7Pn0sWYynahOBs98nWTif7dErssYCpwIo5hRhiKeWUUC2QHw8epvKTN
         O55Hz527rOlSz3t/+MNEzZeNXHUAABjlKGKTAGM1hdF5oKwyJvNBlJTQ8fmKVleXXW
         jmdSf+4+RIyag==
Received: by mail-lf1-f70.google.com with SMTP id c24-20020ac25318000000b003f257832dfdso15652048lfh.20
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 05:50:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gL2n73HFUZMgICxi9XxH4YAlloJV26Mt1lAxrRgunho=;
        b=YFCLQxaXoGPTEF9GxdvUKKHDuT/sdaTpDMhGQC17Z1cPG8G5uwD+zmKwKIsxOk2emY
         KkJHho97KpZ/bhZVejj4SFuYoDWfIuLw0uimxAuQd5cMpG6P8x3jhJvDFP74bRIOKEnD
         qXnYvEL6RT5/fdfAFdbzIRW8QfN7qbFF9E1gYWt/MqsYkb1u+CtIfjUuFeG2aaq5lkJ0
         bWhrnyci67n8cjDUujjLAS6vxQYc3XGXLnEyrpNNfSF28qNmWYcrWt3EqLAeS5xxm83X
         ov2vZnOeDMnnsgME1ZSql1isOuLPZCIUJ42fNudaevR0cvh4zpnCFlKbYSNqHZ/TxHH9
         SbTw==
X-Gm-Message-State: AOAM533BNxGatJg4mtVmeR6VFLALEm+N76nAA4zOf5wvfbKplC2GhTtA
        buFM+mR8MGVnye5CaZRugjlXUnRpC8DCkXGqJUuuG6v+KYKD3Sz2ybh8np9PWd3RV/kmsrVQIuP
        dg1qDJJKRndrcct8wbgIHeNBw0UFcqNpp6fhK4jpvAw==
X-Received: by 2002:ac2:4d22:: with SMTP id h2mr24000847lfk.429.1632747054382;
        Mon, 27 Sep 2021 05:50:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyyk4pwmdGw/4Ofbnvsd28i4hCYWPZtzP5PsR1gIz62OdaiPMEFoxgoIwLu67WJig5byBmk5g==
X-Received: by 2002:ac2:4d22:: with SMTP id h2mr24000825lfk.429.1632747054225;
        Mon, 27 Sep 2021 05:50:54 -0700 (PDT)
Received: from localhost.localdomain (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id v28sm1592102lfi.22.2021.09.27.05.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 05:50:53 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Piotr Sroka <piotrs@cadence.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v4 5/6] riscv: dts: microchip: drop unused pinctrl-names
Date:   Mon, 27 Sep 2021 14:50:43 +0200
Message-Id: <20210927125044.20046-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210927125044.20046-1-krzysztof.kozlowski@canonical.com>
References: <20210927125044.20046-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pinctrl-names without pinctrl-0 does not have any sense:

  arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dt.yaml: sdhc@20008000: 'pinctrl-0' is a dependency of 'pinctrl-names'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

---

Changes since v2:
1. Drop some patch garbage from rebase, pointed by Geert.

Changes since v1:
1. Add review.
---
 arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
index b15e93d1702b..63984e53c0b3 100644
--- a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
@@ -268,7 +268,6 @@ mmc: mmc@20008000 {
 			reg = <0x0 0x20008000 0x0 0x1000>;
 			interrupt-parent = <&plic>;
 			interrupts = <88 89>;
-			pinctrl-names = "default";
 			clocks = <&clkcfg 6>;
 			max-frequency = <200000000>;
 			status = "disabled";
-- 
2.30.2

