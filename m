Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0F93F758C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 15:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241047AbhHYNGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 09:06:25 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:34304
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238919AbhHYNGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 09:06:19 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A2321406F6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 13:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629896733;
        bh=j2CmHETEfQosnB82At+fI6P+jueRuH10iqGIAMLDsaM=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=pE2rOQxgnhKQaMM1oYgkR9xpm0Wsknqh3p9i5dsxPD1WMIikCINpjqn/N2BkUW/WE
         6monqQx/dtdIXMBe2/eVoOWIm00u5PEFLWGwTB9fEmdMRhU99WbcwTJ/Fu7rKHczi2
         nDuSC4/EE6g9ATWyXbuEAs9o6DrHeLBt2i6AnxN4PYC/5A0Q1ycTxZDJjvVIa5J1xH
         MC8KsGMi2l6Buc4wBVPrJWir6X9R29F+qrrf8WV5vEWgRrfpVanYnp6zGBiPuVa0KE
         iY8ZNjiIiLjj3uGRatGcSJPGd+JRULyixkCzEAaeNaIV3AtNMM7B6WCCgbOjQpTEtw
         3Th2wKfdC+zyw==
Received: by mail-wr1-f72.google.com with SMTP id b8-20020a5d5508000000b001574e8e9237so2688364wrv.16
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 06:05:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j2CmHETEfQosnB82At+fI6P+jueRuH10iqGIAMLDsaM=;
        b=cl4i/gOkoaVj7MrQqnHLam+Am6qdP378RzmBmTWwudWJaCb3RTEPFcRohktM2jpROc
         ipZfKm947AYmn6ta9nxQJo4htaLuL38N9kH60KvvEkdBx5Ml2+kTsnHP9X/0me2Vk17e
         o5khqfRZXlVP4ER+xEFBqfkt36Ki10NX6T8H4Jzm4TBKVM1FcD3gTBfaQUlJVcKEEK30
         wul1tXHkOn97c53qGlzXslRLyPN1KCb6wkLawem719qLxng1WR7ajBlMZzbLtU/oYKde
         Niqyr3KrProyxxJRtOceNYQTYQYqbGAtaIDBH79PkQ2LHRl59LkkZULq16dsG20G7I/w
         k8ow==
X-Gm-Message-State: AOAM530Mbyhhl27ukrmptsM9scDD36/pV9EyLT7Qy+l+Lqv42s2QGO2W
        e9panzoVvjJH04QXjmqppsaabUUfJTPbBXX4aApGg5+zG9QLri7Qd5NS8cGk1Oboo0jhx3oO8Pg
        UMKAVUxlmwhpNYPbdtmJZTzGo8p8GX0p7Qf6vnJydqA==
X-Received: by 2002:adf:ef90:: with SMTP id d16mr24968965wro.75.1629896733411;
        Wed, 25 Aug 2021 06:05:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzSrseSsm6RkTsqZky/uo4GWu/U5U79W/FAF0KF5t1wAuV+iuMi36FtNc38uo3ZgcvIxS0KqA==
X-Received: by 2002:adf:ef90:: with SMTP id d16mr24968941wro.75.1629896733265;
        Wed, 25 Aug 2021 06:05:33 -0700 (PDT)
Received: from localhost.localdomain ([79.98.113.233])
        by smtp.gmail.com with ESMTPSA id 11sm5338828wmi.15.2021.08.25.06.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 06:05:32 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Atish Patra <atish.patra@wdc.com>,
        Sagar Shrikant Kadam <sagar.kadam@sifive.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] riscv: dts: sifive: fix Unleashed board compatible
Date:   Wed, 25 Aug 2021 15:04:49 +0200
Message-Id: <20210825130452.203407-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210825130452.203407-1-krzysztof.kozlowski@canonical.com>
References: <20210825130452.203407-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing sifive,fu540 compatible to fix dtbs_check warnings:

  arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dt.yaml: /: compatible: 'oneOf' conditional failed, one must be fixed:
  ['sifive,hifive-unleashed-a00', 'sifive,fu540-c000'] is too short
  'sifive,hifive-unleashed-a00' is not one of ['sifive,hifive-unmatched-a00']
  'sifive,fu740-c000' was expected

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

Changes since v1:
1. None
---
 arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
index 633b31b6e25c..2b4af7b4cc2f 100644
--- a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
@@ -11,7 +11,8 @@ / {
 	#address-cells = <2>;
 	#size-cells = <2>;
 	model = "SiFive HiFive Unleashed A00";
-	compatible = "sifive,hifive-unleashed-a00", "sifive,fu540-c000";
+	compatible = "sifive,hifive-unleashed-a00", "sifive,fu540-c000",
+		     "sifive,fu540";
 
 	chosen {
 		stdout-path = "serial0";
-- 
2.30.2

