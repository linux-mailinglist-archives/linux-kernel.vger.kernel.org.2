Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70AD0365DB1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 18:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbhDTQuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 12:50:22 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49784 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232879AbhDTQuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 12:50:21 -0400
Received: from mail-ej1-f72.google.com ([209.85.218.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lYtZM-0003Ua-Bx
        for linux-kernel@vger.kernel.org; Tue, 20 Apr 2021 16:49:48 +0000
Received: by mail-ej1-f72.google.com with SMTP id z6-20020a17090665c6b02903700252d1ccso5000192ejn.10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 09:49:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Lf3R3UlD7H86mpi6A7mTNMrbIdtgoRuo/+qKw5ATzUM=;
        b=NNLWCt7fkMg7IM5pKxnSlNHfZCzfuUktq3Iq1Ze+R3ghamHnAuHSdVC1S/naJN7/fs
         GNjqZydrQdlmURyOsds5EcpEP0u2+7matB8REHmeUHs625UUmJLd00g2sAD6weD+Rs26
         /7sUf2T58qjUkaP/0da3HSpXlNiUMT+c08Ybv5b4y0UhHARnip9ISXNhZL1XIuE/ekw8
         FaiVupoKEIw88em8scpmW1vVz0zphqjOe3vU1VyTqMrcvjAxYNQySCayiCAM1LY5b89t
         AldjGXwjsEnAAylrv4ETUVsRmX7qOnqKzazE1Keb77oxq908+px0N93iDnyxDV4GY0z7
         5tbw==
X-Gm-Message-State: AOAM5306H8QRoGAyPyE4RSYfp+eJXSsab+PtbLBWHxNB2kLKsGLybBmV
        kNLKf7IUYs3SdvHQxL2MeC0ErBXUxZFAAcNJar5fypzG8xzz1FasG0ibO/ib/Ep93bCc405qhkL
        kBLgCyu7ugGEnTIkzOiKU6Rw2klH3qGuDVf6f9D9bbw==
X-Received: by 2002:a17:907:3ac1:: with SMTP id fi1mr28609674ejc.139.1618937388089;
        Tue, 20 Apr 2021 09:49:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqnsgxDKVVF3jVQIl+y95qKX0R7WnE2ZWOWN34qb+/L0a4hZg40fBDZLGnkF70sm5SFbLapg==
X-Received: by 2002:a17:907:3ac1:: with SMTP id fi1mr28609664ejc.139.1618937387922;
        Tue, 20 Apr 2021 09:49:47 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-180-75.adslplus.ch. [188.155.180.75])
        by smtp.gmail.com with ESMTPSA id c12sm18252873edx.54.2021.04.20.09.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 09:49:47 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] ARM: dts: exynos: enable PMIC wakeup from suspend on Itop Core
Date:   Tue, 20 Apr 2021 18:49:33 +0200
Message-Id: <20210420164943.11152-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RTC on S5M8767 PMIC can wakeup the system from suspend to RAM.
Add a generic property for this.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi b/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
index 4583d342af39..b3726d4d7d93 100644
--- a/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
+++ b/arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi
@@ -163,6 +163,7 @@ s5m8767: pmic@66 {
 						 <1025000>, <950000>,
 						 <918750>, <900000>,
 						 <875000>, <831250>;
+		wakeup-source;
 
 		regulators {
 			ldo1_reg: LDO1 {
-- 
2.25.1

