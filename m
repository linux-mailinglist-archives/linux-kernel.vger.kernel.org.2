Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58E173F285D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 10:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbhHTI0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 04:26:24 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:52576
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232622AbhHTI0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 04:26:18 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C40F8407A8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 08:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629447461;
        bh=uL2b34fb4mR31Q+H29bjRYsDCLvbqA4faR8YCZqFpKo=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=E96/o2hV0C0Obj5P4HDTsFt9mNM4H2gcUNQUhLraRdBhHMRLenen0pI5xVPZP91Ss
         KO5XJcIDhSHKtzthMOjDXOcQkIwUvJL7vFaQgT0Ki206pGPjFHGt4rY7XP+mcwj3u+
         r0eEcORK1wPlNRx2bbFM8cjDKYptuNrIcPvc0rDTBOjsDH2R675hHNm+luKwIcNwga
         NGtOJ5sAdYHY91nQoyNyC9TFwIout1BDcAfzTdEBOiBiyf/tPqyg80E11fkBwp7K96
         RHH6FtLAgot+2kVGL7lnVRE2RHBWqc+5MxL31Z1KARIr4Q6fsVYw+WSzFzPIEnsaWr
         IjiUjU93w//Fw==
Received: by mail-ed1-f72.google.com with SMTP id b25-20020a05640202d9b02903be7281a80cso4173451edx.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 01:17:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uL2b34fb4mR31Q+H29bjRYsDCLvbqA4faR8YCZqFpKo=;
        b=azfqcGeumGdrDkAJLQ36ULHodpzWTkB71DDTFwo+RjS1VTydrkfUQsgkXCQdlPBLBz
         E0vkKUCclve22QtTfr+lFJSh7GlZE1UKJJGB/BQOmarXCuKs90Gta1wuU31mpS+D7ixQ
         5DXqllJcRG8u6nHhXr/hSs7WOIKk2HWid0ueE088Cx55kdRGN6DSo06zhREKViLvLf1s
         8lZ+xlAIzMGx9oHQMiGcBLR/XMW/cVMbSl1PUlHtbKRLt7iyyUqu3WiR8jXW7aoJN1Eb
         NARg20DtEf1u3tCDx7ArbstPZi4tu/L4i/XlJ1sMxejSZHzOVaNC+78VMwfWXAAYI1LZ
         BVKw==
X-Gm-Message-State: AOAM5319oxYQX8D2lWWQzPlFW7eRYGOTNIbEIgfEpvMkto76XqODnrjl
        j3qzJWJchZOmxOsK5Lofn9kD6m8s+ciYsOPBc/v5+4reOQdq6H2dnEhpQFsEr4Dc4NNxAnJMQZx
        qCNdurXEZnREX3h1BiyOt0cOHgUSuvd7pkMpnUOqEuQ==
X-Received: by 2002:aa7:d787:: with SMTP id s7mr21130836edq.336.1629447461486;
        Fri, 20 Aug 2021 01:17:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBxfCR35X39RHE3yqRRLWn03RefoOBmdkIZc7zBhsu7mUJCwhaiyE5PCxCjrAHUOLUZasgwA==
X-Received: by 2002:aa7:d787:: with SMTP id s7mr21130827edq.336.1629447461384;
        Fri, 20 Aug 2021 01:17:41 -0700 (PDT)
Received: from localhost.localdomain ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id d22sm2488041ejk.5.2021.08.20.01.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 01:17:41 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 3/3] arm64: dts: arm: drop unused interrupt-names in MHU
Date:   Fri, 20 Aug 2021 10:17:33 +0200
Message-Id: <20210820081733.83976-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210820081733.83976-1-krzysztof.kozlowski@canonical.com>
References: <20210820081733.83976-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arm,mhu bindings and driver do not define interrupt-names, so drop
the property to fix warnings:

  arch/arm64/boot/dts/arm/juno-r2.dt.yaml: mhu@2b1f0000: 'interrupt-names' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm64/boot/dts/arm/juno-base.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
index 8e7a66943b01..e4fea639731e 100644
--- a/arch/arm64/boot/dts/arm/juno-base.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
@@ -27,8 +27,6 @@ mailbox: mhu@2b1f0000 {
 		reg = <0x0 0x2b1f0000 0x0 0x1000>;
 		interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "mhu_lpri_rx",
-				  "mhu_hpri_rx";
 		#mbox-cells = <1>;
 		clocks = <&soc_refclk100mhz>;
 		clock-names = "apb_pclk";
-- 
2.30.2

