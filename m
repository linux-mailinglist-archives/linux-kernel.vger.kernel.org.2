Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC5FC4194A2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 14:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbhI0Mwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 08:52:43 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:40434
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234471AbhI0Mwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 08:52:34 -0400
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4B8044085A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 12:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632747056;
        bh=HyJUjHjlK3mirIZ1mWbxEOM/yJgRijm4GthGtGsI3+o=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=sTaluSXJlk/YFnoSrKgHjFenPfTHMyatRl1VIaMgceJas6GzTFkJAty97NuE03G7b
         q6wkrHkUATYOs/awOSEWY/Q5rXuCY7exEplpcYBhtesvKgiUES25XJYtgiN5385f7F
         +8a10ACBxqR4vIhPJW/LCZHF1CMqPNo9a4Nfv4coPBGCTSkPUuan0w5PsltEP9uOBN
         /FQYkwzl7wEciAHfRd16PiPSw06CwLhKopZj7RbdnreF7MEdXqY3NwReEU/SiXGvbb
         4RLRCaZa4Lb4eAgVIE82jgkYLIBMb/9Fj0+FRKjnWID5zoc4fA2w/h2KWlwa3AciUu
         gj7loYYpE3ZGw==
Received: by mail-lf1-f72.google.com with SMTP id z9-20020a0565120c0900b003fce36c1f74so3733034lfu.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 05:50:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HyJUjHjlK3mirIZ1mWbxEOM/yJgRijm4GthGtGsI3+o=;
        b=5T0/nEPIwVrSKSWPF21Jpe+kx9+QKh/G0aJXyi7fEnJfl5sE0/8L120H+fAYDm0Fwj
         /IumstzsTQgyTnoNK+T4REaCLk9rwDhQPTdXQKSxU2JWaZqWRw8ZiF9KGxDy95aWrP7M
         9VHdzbOB4xox/GRdIwK8EfaTjAlIgmAu8teUYnu9CnsD9h8KZcW+weA4UqXQ7zQV9KMS
         pMgHpSbN5HK552em75oqKDoiDMy0WJGDSZypTBDbXZAm1pNHUlRKATiIhnK1EqLfDODO
         B5h7BdzBA9qEyQSd27wWDU7lxYRgdA2tBmdmWrJBcQsMqYZ9vVRZxfJEws11T908mQxw
         8NLg==
X-Gm-Message-State: AOAM532g24wq9GFNW2qpoD5S+EDqa266nXccAwUnUFE60IsiKmknH6Tk
        Splu1rxlIRQ3nnG/iCFQ2tqh4Tly99cvT9RMqqqkqkNbJbQ0rEQ79JsnSO44KhWr4tTDT1Y+9Vb
        00zyj61yqqomA523EACAz/ZemW4bNp/KSFkxCTY/Iuw==
X-Received: by 2002:a05:6512:150b:: with SMTP id bq11mr24378579lfb.495.1632747055578;
        Mon, 27 Sep 2021 05:50:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxub5gxPd0btgj0850I+iTNBnTY40Um3nPH4TVM4BxueRLq1HcvaTKOdlAvhZ1R1kGJjV++gQ==
X-Received: by 2002:a05:6512:150b:: with SMTP id bq11mr24378555lfb.495.1632747055433;
        Mon, 27 Sep 2021 05:50:55 -0700 (PDT)
Received: from localhost.localdomain (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id v28sm1592102lfi.22.2021.09.27.05.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 05:50:55 -0700 (PDT)
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
Subject: [PATCH v4 6/6] riscv: dts: microchip: use vendor compatible for Cadence SD4HC
Date:   Mon, 27 Sep 2021 14:50:44 +0200
Message-Id: <20210927125044.20046-6-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210927125044.20046-1-krzysztof.kozlowski@canonical.com>
References: <20210927125044.20046-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Licensed IP blocks should have their own vendor compatible.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

---

Changes since v3:
1. Add tags.

Changes since v1:
1. New patch.
---
 arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
index 63984e53c0b3..c9f6d205d2ba 100644
--- a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
@@ -264,7 +264,7 @@ serial3: serial@20104000 {
 
 		/* Common node entry for emmc/sd */
 		mmc: mmc@20008000 {
-			compatible = "cdns,sd4hc";
+			compatible = "microchip,mpfs-sd4hc", "cdns,sd4hc";
 			reg = <0x0 0x20008000 0x0 0x1000>;
 			interrupt-parent = <&plic>;
 			interrupts = <88 89>;
-- 
2.30.2

