Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 741743F1E85
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 18:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbhHSQ75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 12:59:57 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:56980
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230416AbhHSQ74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 12:59:56 -0400
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id 0E48A411CC
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 16:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629392359;
        bh=eulTWffz2zcY1QHzF3VctUTdQdyWBbuhcOokJb1Arrg=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=rhtOTdmthNu2ThG+hY3/LzKIqTR9Droed/Mx6QU+buHVClI6aO8E1z/DNARz7IaN2
         jVfYLBpBMy3r69LYb2H2O/n06OrkCLcnR9O3eVho/70XSv94RNGDA8ahrQrLCzOsPX
         5/W3xF8adtdheZeSDKMdlMrYGdmSKjxuOpsdfi6XFTjI0kRpjd9O75ZEIwNj2ceaTC
         WJdzp6wfpCoeGsp/hXs1PsKcsTixkSQMSdhy/TorPrd9wO8QaJAgD2aBHJD3U3tSdF
         gzTis6ckblOOf8X/Ux1GyYrbTgE6X8u2hZ6XOH3gxP5lUFWvOK/V0kZR9OWHeCAtob
         gE2zoJYQL+bYg==
Received: by mail-ej1-f72.google.com with SMTP id m24-20020a17090607d800b005c18a22567fso1313563ejc.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 09:59:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eulTWffz2zcY1QHzF3VctUTdQdyWBbuhcOokJb1Arrg=;
        b=RpvRAAVgMLEA32/KnROc+p0+qWey2e3UeKswC1imnnTB5nxkj6bb3u7Gp3boD2lRip
         NXmxzgehQxGT+BMka7VoxW3YPbTQ69YYSsdadUiAdchN6IooEwunIaBR2PcJxcWfyw3p
         C38JDzc/DSIp2ct7be7siKzezzz2zDHL7np0mke430CCYJT5mEph16TPtd20JU6VFqG7
         XcNK3N+eGkHxRVTcZ75NRh8dY0+gavdBh7XS47i1/2H7i1WcqN9rGwti/NZ7QjDnXkPG
         UN1lS+mVpxXIeEqmLArPBtrFUQ5SRwlYwl/0fNVGzHcXN9SRdCZpThuPpQxV71Q6Kffp
         8HcQ==
X-Gm-Message-State: AOAM533p4wrlxnCHkaKVHp6yrBuRYhWIksAFmSr3MuSFm8Ua/5qDJOdE
        I0gV5mOStS9bIJ2Jk3UmPHVZQsNrpIw7pUPjVSkCQrrTCgPXIv2Bw5RpiaUuilbaVRcDTDBj7UT
        cOcwa9cJKI6x3cOtQNfkomwwurTRjbNSxq+n9B9T/dA==
X-Received: by 2002:a05:6402:781:: with SMTP id d1mr17839058edy.32.1629392358804;
        Thu, 19 Aug 2021 09:59:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJww4UtUY6h9OU4l9uS3kIuoYiIOm0VucV6SoXDn0iXyU7Cxho1WRMomPQZIfagqOlV+lXh0nw==
X-Received: by 2002:a05:6402:781:: with SMTP id d1mr17839040edy.32.1629392358686;
        Thu, 19 Aug 2021 09:59:18 -0700 (PDT)
Received: from localhost.localdomain ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id h8sm2023418edv.30.2021.08.19.09.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 09:59:18 -0700 (PDT)
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
Subject: [PATCH 2/5] riscv: dts: sifive: fix Unleashed board compatible
Date:   Thu, 19 Aug 2021 18:59:05 +0200
Message-Id: <20210819165908.135591-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210819165908.135591-1-krzysztof.kozlowski@canonical.com>
References: <20210819165908.135591-1-krzysztof.kozlowski@canonical.com>
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
 arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
index 60846e88ae4b..c960e19cfa70 100644
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

