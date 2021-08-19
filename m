Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC5303F1E8A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 18:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbhHSRAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 13:00:03 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:57058
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231180AbhHSRAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 13:00:00 -0400
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 07859411C9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 16:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629392363;
        bh=NMKQ8HC+F1mFEutTPt5SprtiqsXf0Joxpmn/FGyaQRA=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Wmn3xILc5jroBfGJ1XJhpDEwpJzxbOwCXDVtXsNoR6rQUX/G7T/OaABI9uADaKOk7
         EbjZAJM58Bi7AjSejozn4RqvCTHeTxaXFsr0IxLv4JZE2ttlhSu3S6qsVDFMqk81Zm
         eS/XiYZ/0FQlfL7qVaIUEFfi28Hl3HUQPZuSlTEoNRslT1zeJI+Ner0K1cRmd7rEpe
         2n66+oaz1IGevGf8gPLzEoqSyvbS2v3vNNiZRFRDfHC23vEhXBC9NKtJV9czhmrfZD
         Gd3fRBpNIVkdhTXZTUmeYefwjnBW8hzgAltaKXPT5svaCuq+jgOF3q38CgmWoaILAL
         l3XmGCIMapE8A==
Received: by mail-ej1-f71.google.com with SMTP id v19-20020a170906b013b02905b2f1bbf8f3so2489402ejy.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 09:59:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NMKQ8HC+F1mFEutTPt5SprtiqsXf0Joxpmn/FGyaQRA=;
        b=k/Ip+afm6IWPetzf/xJGYGchs0XQ6riWJLGLrQ/Ad6X+zpSoMHW8cPOBrlWDfw2UNI
         /JUfFsXT5JFBEzTYPZ+nIqCHronh0brCWIknsyBjVTBv04Lx1cw+iJZpl/vxcwkiNzwW
         KtUdKLb+AQ154qbhxLc/vEmvUPk6yD1F22liw0dDvToZgJHtanpEhSbIQnZmCEmEIvSb
         Goyuska81GuxnOmJSKUxPXprNxqElfTTsC4LNWYBPnz/oYY5JfUMoeS8vcD+CskP8WZ5
         pQOj2eTDq+MnPNogIxqrIUzjnCRavIK1HIn5Y+ys9PKgOfzyO4pVVZWGzEeE2X48q/lB
         dPOQ==
X-Gm-Message-State: AOAM530x4R9KInDI0Dml+vaxdOK+6LgVNrwAxHe4VEThpgflk+3YfFcj
        0/l1WfNMYW+wJSEDkQYBv4MztRGPoNBoupJ8/kEWstJwbt7GStkl5twrfK1Szue2qE/O2XUj6vQ
        /PlDW725KIlymyrrBtC4S9WwboS1SWajkQRc+0FtElA==
X-Received: by 2002:a17:906:6ad4:: with SMTP id q20mr17321649ejs.433.1629392362663;
        Thu, 19 Aug 2021 09:59:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTiHUoNITAHW6eENhh9K7MzzNuKTjMUdplkoqS0IOpq6oP+UAyQaSufFwMawL/9lYJf9kFuA==
X-Received: by 2002:a17:906:6ad4:: with SMTP id q20mr17321630ejs.433.1629392362524;
        Thu, 19 Aug 2021 09:59:22 -0700 (PDT)
Received: from localhost.localdomain ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id h8sm2023418edv.30.2021.08.19.09.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 09:59:21 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Sagar Shrikant Kadam <sagar.kadam@sifive.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 4/5] riscv: dts: microchip: add missing compatibles for clint and plic
Date:   Thu, 19 Aug 2021 18:59:07 +0200
Message-Id: <20210819165908.135591-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210819165908.135591-1-krzysztof.kozlowski@canonical.com>
References: <20210819165908.135591-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Microchip Icicle kit uses SiFive E51 and U54 cores, so it looks that
also Core Local Interruptor and Platform-Level Interrupt Controller are
coming from SiFive.  Add proper compatibles to silence dtbs_check
warnings:

  clint@2000000: compatible:0: 'sifive,clint0' is not one of ['sifive,fu540-c000-clint', 'canaan,k210-clint']
  interrupt-controller@c000000: compatible:0: 'sifive,plic-1.0.0' is not one of ['sifive,fu540-c000-plic', 'canaan,k210-plic']

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
index d9f7ee747d0d..6f843afacfad 100644
--- a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
@@ -161,7 +161,7 @@ cache-controller@2010000 {
 		};
 
 		clint@2000000 {
-			compatible = "sifive,clint0";
+			compatible = "sifive,fu540-c000-clint", "sifive,clint0";
 			reg = <0x0 0x2000000 0x0 0xC000>;
 			interrupts-extended = <&cpu0_intc 3 &cpu0_intc 7
 						&cpu1_intc 3 &cpu1_intc 7
@@ -172,7 +172,7 @@ &cpu3_intc 3 &cpu3_intc 7
 
 		plic: interrupt-controller@c000000 {
 			#interrupt-cells = <1>;
-			compatible = "sifive,plic-1.0.0";
+			compatible = "sifive,fu540-c000-plic", "sifive,plic-1.0.0";
 			reg = <0x0 0xc000000 0x0 0x4000000>;
 			riscv,ndev = <186>;
 			interrupt-controller;
-- 
2.30.2

