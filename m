Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA5C04117EA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 17:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241300AbhITPLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 11:11:32 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:40086
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241263AbhITPLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 11:11:31 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4D2854018F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 15:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632150604;
        bh=xU11jaLpUDnoKTVDhNl4Nnz5+4KkmeAKnf0UgxOYDK0=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Jf/UVPasI7eCutuWqByRpqmH4O20YHfMxJBg6B1H5xnqCwzKZbTfPreuFqPdQQJca
         C/QAQQXlcgNQgXyPNzTsLDea0w66Szg1jgPlXEsNmzUkhjmdpeLdrDGRZYuB1NKG/9
         3ky1JV3QWZAQNXKjb5s7ZmWHFZaq8Q+By603/nkJuGxctmPcp2S3mKjHELEUJZmPMJ
         dY+vboJjRukiJH3YV16HTu8hFjABERT8Ew0EpyMK9ZYunelSiliHxKUhBGjvJkiutC
         4GmhNwjHAf5odIs9Q47TBPByRR4teQe16mx6rLPo7cV1PJITD/2nvBR4n1dJlKb0Qv
         s6hagO9U4Stug==
Received: by mail-wr1-f72.google.com with SMTP id q14-20020a5d574e000000b00157b0978ddeso6349055wrw.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 08:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xU11jaLpUDnoKTVDhNl4Nnz5+4KkmeAKnf0UgxOYDK0=;
        b=LjfuGZzBN8TsATmjP5rxHN2IF9VATliv2/Sl0eei4gokMJr+5RDmxqxPAeCa4aKP/q
         +fA7OMx5b404YkENU51UOfJLL44YhA66gcZPALpfFYYYP4lxiK2TeTP9w7zsg6avsC3p
         XieHTHb38C+R2p69jJjd2XtjOao/uFhb4cW7MERXTz3nom89UpKxqv12CdRw5Y6pC6PU
         l03Ej7CS2eP/I2gRT+qf7uVL9vAoo6cfIKyEyq5jU3gUkQWoKc/15DJTi1lAdX2kItFc
         2LcXfUtFqvEyJLvKevg9ieH1HI73U6URJvg0TNYhX7Z+R+6067AloDB7uqP44dOdMnHU
         PZNw==
X-Gm-Message-State: AOAM530y2r/SXm1pzHJTog/UuFgjkp3RoqiMQQuPl8efq1bnC8d2udiB
        qShJqO4r/GbyTBNAh+44ydrC93gU9sRZCq0JLpAzChucpfJEi1rDCslNiPriCuYtgh2lpbsh2Mi
        ovyTROvZnbyHeBX4oM9aoNp2h1bjjg+uzdo61JjfoHQ==
X-Received: by 2002:adf:e44c:: with SMTP id t12mr30067258wrm.49.1632150603566;
        Mon, 20 Sep 2021 08:10:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzBBPH6zennF6+WXOjRYxYRZdYGj6tYy+clID7FjBpMnrSmFriKiZD1slG3/cFHjNMZVecHAA==
X-Received: by 2002:adf:e44c:: with SMTP id t12mr30067220wrm.49.1632150603368;
        Mon, 20 Sep 2021 08:10:03 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id i2sm15803136wrq.78.2021.09.20.08.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 08:09:54 -0700 (PDT)
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
Subject: [PATCH v3 6/6] riscv: dts: microchip: use vendor compatible for Cadence SD4HC
Date:   Mon, 20 Sep 2021 17:08:07 +0200
Message-Id: <20210920150807.164673-6-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210920150807.164673-1-krzysztof.kozlowski@canonical.com>
References: <20210920150807.164673-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Licensed IP blocks should have their own vendor compatible.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

Changes since v1:
1. New patch
---
 arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
index 55d86b078c53..7948c4249de5 100644
--- a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
@@ -263,7 +263,7 @@ serial3: serial@20104000 {
 		};
 
 		mmc: mmc@20008000 {
-			compatible = "cdns,sd4hc";
+			compatible = "microchip,mpfs-sd4hc", "cdns,sd4hc";
 			reg = <0x0 0x20008000 0x0 0x1000>;
 			interrupt-parent = <&plic>;
 			interrupts = <88>;
-- 
2.30.2

