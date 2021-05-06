Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B548A375672
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 17:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235149AbhEFPVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 11:21:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41499 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234993AbhEFPVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 11:21:48 -0400
Received: from mail-qk1-f197.google.com ([209.85.222.197])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lefo1-00037s-ET
        for linux-kernel@vger.kernel.org; Thu, 06 May 2021 15:20:49 +0000
Received: by mail-qk1-f197.google.com with SMTP id b19-20020a05620a0893b02902e956b29f5dso3668872qka.16
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 08:20:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cQf4MjiqPeV3cfZrYpEWKZORZH0m9Y7Wed5/vpwhH/8=;
        b=N3hMPnuNj6HTnxpQ+RhQACw4wBNDyOveNNbUKNt9q4DM+LLPco7jhFnACN4L5QifBR
         DCl59wGkZIagoNEW7OmMjOJfzBa6EcHH1Q1wTKa3tDDKJoJ8tx0BsNkih3dn1u4YwtJq
         mgLe9FS7y2Hevet8WE/RTu6yd68Jy0e8dI24EW3rfIZh+g8OLuvmqG6PAPFFAS7VkSR8
         SbW8tNUS/cMMnuMuxDh6lGsbDBQgvqaeAB0wDU5lxCuZgHwQMVOfHNjU6KzxOtfxCLib
         mmJJFuEJIvjA4cnw0FPi7fasIo9vgcTBvm4dbh/obHqBbg2fBBk5Yq4kimwMyU6kqXN/
         KmFQ==
X-Gm-Message-State: AOAM532Yz4gj7RywgAsUQCf7yKE0UHz9ChTzfnFCI32vpwXzz0B5SVPK
        jg7JWguzouwGFy+Kd3izUQS90MfJkuqZCVV+ABHpgeRk1WtZqJMrM/8A7ZEu90G6uASMeiznu/h
        B1FFcFU+xzeVdpNJ6mvmL9XN8ulUhDrIQkNgFg4X9Qw==
X-Received: by 2002:a37:6850:: with SMTP id d77mr4605623qkc.57.1620314448558;
        Thu, 06 May 2021 08:20:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwiaCcE9k/KLZzFM/F0Z3mcERK+7wGrNRw+WINMCIvWA+NLoEI5nNx/djusvRAdAwLVIH/T7g==
X-Received: by 2002:a37:6850:: with SMTP id d77mr4605603qkc.57.1620314448407;
        Thu, 06 May 2021 08:20:48 -0700 (PDT)
Received: from localhost.localdomain ([45.237.49.3])
        by smtp.gmail.com with ESMTPSA id 19sm2115882qkn.111.2021.05.06.08.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 08:20:47 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: s5pv210: remove unused Atmel touchscreen properties in Goni
Date:   Thu,  6 May 2021 11:20:44 -0400
Message-Id: <20210506152044.37579-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Atmel bindings and driver do not use custom properties like
x/y-size, burst length, threshold and so on.  The driver gets necessary
data from the device directly.  Remove unused properties to fix
dtbs_check warning:

  arch/arm/boot/dts/s5pv210-goni.dt.yaml: touchscreen@4a:
    'atmel,burst-length', 'atmel,orientation', 'atmel,threshold', 'atmel,x-line', 'atmel,x-size',
    'atmel,y-line', 'atmel,y-size' do not match any of the regexes

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/boot/dts/s5pv210-goni.dts | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/boot/dts/s5pv210-goni.dts b/arch/arm/boot/dts/s5pv210-goni.dts
index 5c1e12d39747..c6f39147cb96 100644
--- a/arch/arm/boot/dts/s5pv210-goni.dts
+++ b/arch/arm/boot/dts/s5pv210-goni.dts
@@ -358,15 +358,6 @@ touchscreen@4a {
 		reg = <0x4a>;
 		interrupt-parent = <&gpj0>;
 		interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
-
-		atmel,x-line = <17>;
-		atmel,y-line = <11>;
-		atmel,x-size = <800>;
-		atmel,y-size = <480>;
-		atmel,burst-length = <0x21>;
-		atmel,threshold = <0x28>;
-		atmel,orientation = <1>;
-
 		vdd-supply = <&tsp_reg>;
 	};
 };
-- 
2.25.1

