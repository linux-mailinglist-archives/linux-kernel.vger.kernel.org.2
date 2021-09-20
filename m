Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3E684117E1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 17:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241228AbhITPKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 11:10:51 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:39942
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241200AbhITPKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 11:10:50 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9A92F3F338
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 15:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632150562;
        bh=2AzFw7QWiJnpc3+D+qC2D6oogvLnCMo5bvL1ARpYSXo=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=GzisCl0VFyuetRRa2ZKFMqFNQd0wVpmc6HjhyxEGWjnRJcmN7kxEV6LZ5viCQqISD
         3/GUXGGIaUCzWKpZ2vgzXds/61Zm9C8e+ZKzYamsv8/mCPk6pC/sR2bND77mFmHRa5
         1SBnyRWIJi7kChZWuNM5fFj5081ws1aOfqedtZ7D7vpXMicZ8HEkgitRBkD62rj/PG
         W6vElJofhpo/ZJ5Liaq60wNYAQgAbPDW5G1Hpmwx3KpsJ/D+HClNs/URSJDWSw57Gf
         4yjaIPR9qLWDkpyXDnS824n0Og1aAlooO3/pLePvAKDUmd0CFQqs4ngN7BLzOalNIt
         3LKNX5tfLqicg==
Received: by mail-wr1-f69.google.com with SMTP id m1-20020a056000180100b0015e1ec30ac3so6348976wrh.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 08:09:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2AzFw7QWiJnpc3+D+qC2D6oogvLnCMo5bvL1ARpYSXo=;
        b=IyYKYAOFkqa8hbgiLMf1Lo6vFQyUyXIrtuOt94Y/CpvMs/gKNsS0y/WK2fWWYGiZ/p
         SS8MplgOBehpsG1RiMKj8+8HWoViHQZsmLfuaYt/j/HHCeMWVyOvRViRdwaHOP+E7asB
         hkmwTr6ErpHHDpkPuHsB2lCokm52WoiIH2gNUjnbWAB/oc1FQmhIFFFOwzmE1uQpZBY9
         jmdThiQvX69wvumwGz+T+tuoBA3LdEitFqsZQWdV+bXGqtT6YdvGF7s9SGtCUTZKNTxT
         Z0Kvsa/GtncC0vCzQIM6xgEetxHFdTEnFj2PK3GTg4H8bQOebV8EOounXxQi8yWZPZfr
         pFWQ==
X-Gm-Message-State: AOAM530Engd/l4dfNJ8GxzGBGgUGpJN54gdv9EreigyKV+1h3KdOGbxW
        qdVBJw4aUu6UshUObusZvd97+yjtWDpwnJqf42Ke9hhrp6e7p+dLTaN0FvC7xa730a7qcujpKAA
        RbsSigfKldt+NWC7KmccNXOn6C1xnBKjjwfkuFL7spQ==
X-Received: by 2002:a05:600c:21c8:: with SMTP id x8mr24829317wmj.163.1632150562323;
        Mon, 20 Sep 2021 08:09:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyh9HwY7qtDiYuXsvesg74JozhNdGgdehheDKBXdv1dZ+7W5s7qvmts4pXM0X21xET38Gx3ZQ==
X-Received: by 2002:a05:600c:21c8:: with SMTP id x8mr24829283wmj.163.1632150562129;
        Mon, 20 Sep 2021 08:09:22 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id i2sm15803136wrq.78.2021.09.20.08.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 08:09:13 -0700 (PDT)
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
Subject: [PATCH v3 3/6] riscv: dts: microchip: fix board compatible
Date:   Mon, 20 Sep 2021 17:08:04 +0200
Message-Id: <20210920150807.164673-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210920150807.164673-1-krzysztof.kozlowski@canonical.com>
References: <20210920150807.164673-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to bindings, the compatible must include microchip,mpfs.  This
fixes dtbs_check warning:

  arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dt.yaml: /: compatible: ['microchip,mpfs-icicle-kit'] is too short

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

Changes since v1:
1. Use microchip,mpfs for microchip-mpfs.dtsi, suggested by Geert.
---
 arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts | 2 +-
 arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
index 3b04ef17e8da..07f1f3cab686 100644
--- a/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
+++ b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
@@ -10,7 +10,7 @@
 
 / {
 	model = "Microchip PolarFire-SoC Icicle Kit";
-	compatible = "microchip,mpfs-icicle-kit";
+	compatible = "microchip,mpfs-icicle-kit", "microchip,mpfs";
 
 	aliases {
 		ethernet0 = &emac1;
diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
index 93730afe6c58..5084b93188f0 100644
--- a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
@@ -7,7 +7,7 @@ / {
 	#address-cells = <2>;
 	#size-cells = <2>;
 	model = "Microchip MPFS Icicle Kit";
-	compatible = "microchip,mpfs-icicle-kit";
+	compatible = "microchip,mpfs";
 
 	chosen {
 	};
-- 
2.30.2

