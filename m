Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACE6D4117E7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 17:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241242AbhITPLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 11:11:22 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:44152
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241220AbhITPLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 11:11:20 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D396C40265
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 15:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632150592;
        bh=zUv3tXHbbUqWbaVvQkKggzK/iHQTdWabfc1NCBtXKt8=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=WUx+n0rTL1ND8eemSxyqF+F6WAqsNjGe6ANMG/wlSCu0rnm4EtFrpF4R58yJG0uMy
         ekB9bU4AIQwysB8Pg0vcjYVlJeqQSQb4M1Sn4BZhzQFZLty1ippUI+N1KUczyEngaV
         q4+Y7pwW+MamAh0PRfOyNjKNbxVIBFEBJzNjhJ8SS57jhjchB8SoagfkszTgecNpFe
         /CTH3akQBCOptJfP4enmXCRSF8hGUJiNUw6jyYoYUNNX2L6LgO4ehap8b/bNNFagnb
         H71nbO8igm4EQ3Qa2xI8Sw+F13roCsROX5YiY79N9sQiRPa/fUGjZt6Q2EIrnJY0K4
         xHmLrS3+xPe1w==
Received: by mail-wr1-f71.google.com with SMTP id f7-20020a5d50c7000000b0015e288741a4so6355755wrt.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 08:09:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zUv3tXHbbUqWbaVvQkKggzK/iHQTdWabfc1NCBtXKt8=;
        b=XxWUqsbLPrxYUPdQOY7rVTe3uVJuSmNaOL8CaIMDMzeUi8WL3YUoHHOOUYtBoYN2ju
         beH983sSvO7uJ8eheeMs2CpRkhPXMczXYkyFPXjJtwDVKR0wDQ13q4YPwLH8jLxTyIkc
         /wi6Gp4zPfTsFpC8tJ0D3fTDgX5T3ZvTe3gqd1RkKWudr3njZswO0fQVIsF/CDn3joiU
         v0dLJeihfC2/OIQJhb6QJygvSdUmXO5Ik/RnIddontTxVmOe1rTrDuIFFl9c1wj4PPP2
         qm+j3SP2xHE/KNlnO+E4PFt1Ge7TURaVJGd3NElHzqH6Ii0HtoM3cQ7Z0790OvPqmsI+
         lHQw==
X-Gm-Message-State: AOAM532tEWN6BozImAeJ7Q+5w9HkuPtN+c16cXj4qQ5nG/TsMyMLtrRw
        /2TRxnjS1nnfhWdbG/yXftkf+6tu1KIqywDy3XWvt3yPseA//cUc5g92YAB8QD9yKT9+MGwrl2C
        wbWFeHwpW6ScMGV8LxiIqIH5b79f0NjmpSEql4kpmGQ==
X-Received: by 2002:a1c:4d17:: with SMTP id o23mr23908192wmh.125.1632150592342;
        Mon, 20 Sep 2021 08:09:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx4go/KWD2wwvaGed5Gp8/j8w76ab4Sbq/2+KvZVoBShQAqdwysUAi7NfERcQWEBk3pzLlFbw==
X-Received: by 2002:a1c:4d17:: with SMTP id o23mr23908169wmh.125.1632150592140;
        Mon, 20 Sep 2021 08:09:52 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id i2sm15803136wrq.78.2021.09.20.08.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 08:09:41 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Piotr Sroka <piotrs@cadence.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v3 5/6] riscv: dts: microchip: drop unused pinctrl-names
Date:   Mon, 20 Sep 2021 17:08:06 +0200
Message-Id: <20210920150807.164673-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210920150807.164673-1-krzysztof.kozlowski@canonical.com>
References: <20210920150807.164673-1-krzysztof.kozlowski@canonical.com>
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
index 83bc14860960..55d86b078c53 100644
--- a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
@@ -267,7 +267,6 @@ mmc: mmc@20008000 {
 			reg = <0x0 0x20008000 0x0 0x1000>;
 			interrupt-parent = <&plic>;
 			interrupts = <88>;
-			pinctrl-names = "default";
 			clocks = <&clkcfg 6>;
 			max-frequency = <200000000>;
 			status = "disabled";
-- 
2.30.2

