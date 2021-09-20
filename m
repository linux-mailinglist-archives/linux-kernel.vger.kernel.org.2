Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BADE41152D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 15:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233861AbhITNEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 09:04:24 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:37478
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239127AbhITNEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 09:04:21 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 10AA440262
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 13:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632142974;
        bh=lrFOqJg8K+1XmVsF/GpvrcRXBvTi8X1Jdxp9tcz+qM4=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=Y7uk8W0HCjG9jgwE1f3NJhpzwGouwbathmLu1EwgpLx7m4y8x+yjNcoDZeKXOlB8t
         +dmZsCn+E+3dMFZtv9c9JusEgZ4aMoFp0ZOEiQoozAdtbyaKDyNX0U6sq1vpLMEElo
         EMcPsuNokex8MuNh2ytk/zxKeu66s3DME0YGE8wOKCCjYOxERTl/oeexmiI5FachFm
         S3STZ9bmPyjpAXZU8bNSLHh90CKU3gn1NuA11IXX2vCSDrLvUM7y8Jl6gviLLFZiuP
         RMDAQXv/aXIYZQGO2nV2t07aDR/1P1V/TjNlT6WMlAr16oGxgasWRgHXvMEMrOolxZ
         4am/21bFw/UJQ==
Received: by mail-wr1-f69.google.com with SMTP id c2-20020adfa302000000b0015e4260febdso4686150wrb.20
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 06:02:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lrFOqJg8K+1XmVsF/GpvrcRXBvTi8X1Jdxp9tcz+qM4=;
        b=hsFHhqBNuZuAmf/3x2CiVEk3Yb3okSIeJyNQxdXiy2zz/O3MYnX0mSYws+Td6HCupX
         DI/Wir6MC6RlKM9mQ4+gcbX2fuqbvZVF8QdePy+L6cctWGjcKPF2bnRu+WEkFH/slLuO
         WfaoekxFUse/Ham9hhZfP0D1b8t/QBlF7qo5F2uLmtvtrKfb2AJ4BTEwpoGZoD+zuomr
         pgwwzEmu1Q3hHUdn41cEfMfZhh4krVDhwWCmCpFduN7/xvKY/1i7+To1Dgsae1/huC+W
         RWmCl2lmgKXMsfULXkyn4L7m1+5pfY4Njm13zBSSKW8McwMfjf476NCxVAq5KU33C80D
         BQSQ==
X-Gm-Message-State: AOAM531k7uFD/maFY85dlC+NDjixHtuzFzDGDt0EsMTSQqFrKcHCOTfV
        zPh84XBO1loxaw1bpANCwBQND48xKS8vuydLQ9VvHopk2QWKBCi87hMb3M/A4sYR4Aeo1BxRCiu
        GpOLHj8J6v3cmaawxTgolm3uAIJEI3jfqGDuxeeLFBg==
X-Received: by 2002:a5d:47ad:: with SMTP id 13mr3932506wrb.77.1632142973802;
        Mon, 20 Sep 2021 06:02:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4z2ke3Qhl/DSE5AFOSSTAPUbioVfuMUlpXHmyMu5916vuc/RnrB5lx9wUQ6orRPoYBFGojg==
X-Received: by 2002:a5d:47ad:: with SMTP id 13mr3932471wrb.77.1632142973545;
        Mon, 20 Sep 2021 06:02:53 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id g22sm18015331wmp.39.2021.09.20.06.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 06:02:53 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v2 1/5] riscv: dts: sifive: use only generic JEDEC SPI NOR flash compatible
Date:   Mon, 20 Sep 2021 15:02:44 +0200
Message-Id: <20210920130248.145058-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compatible "issi,is25wp256" is undocumented and instead only a
generic jedec,spi-nor should be used (if appropriate).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

Changes since v1:
1. New patch
---
 arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts | 2 +-
 arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
index 60846e88ae4b..633b31b6e25c 100644
--- a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
@@ -63,7 +63,7 @@ &i2c0 {
 &qspi0 {
 	status = "okay";
 	flash@0 {
-		compatible = "issi,is25wp256", "jedec,spi-nor";
+		compatible = "jedec,spi-nor";
 		reg = <0>;
 		spi-max-frequency = <50000000>;
 		m25p,fast-read;
diff --git a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
index 2e4ea84f27e7..9b0b9b85040e 100644
--- a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
@@ -211,7 +211,7 @@ vdd_ldo11: ldo11 {
 &qspi0 {
 	status = "okay";
 	flash@0 {
-		compatible = "issi,is25wp256", "jedec,spi-nor";
+		compatible = "jedec,spi-nor";
 		reg = <0>;
 		spi-max-frequency = <50000000>;
 		m25p,fast-read;
-- 
2.30.2

