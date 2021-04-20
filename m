Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2CC4365DC6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 18:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbhDTQuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 12:50:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49827 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbhDTQug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 12:50:36 -0400
Received: from mail-ed1-f69.google.com ([209.85.208.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lYtZc-0003YU-A3
        for linux-kernel@vger.kernel.org; Tue, 20 Apr 2021 16:50:04 +0000
Received: by mail-ed1-f69.google.com with SMTP id t11-20020aa7d4cb0000b0290382e868be07so13440233edr.20
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 09:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ox2bZeNVgpS1SkdFcOmweP3XNPduD7g1GALJyeZlfYk=;
        b=ATrBSgWAIeIhtsKtLh78lVCwnTqVBj6XHdlScKl1m3tsvDTt2mpUvqdD4wQ6CfngQ8
         9g/zdf097WzKeE/j9selmd79wqpfkP6bJmW+zSC/ip9Cutbo2M9UN45zVkr271NBmNMo
         nthDgqQj3CErXZJlifdJ999b6oK0D1xzDtYiLn8EgtDw6Yu/Vb5uKDNfrGdWS/K6ebE7
         XbTyqnzPWN9PGFUnOv4cMUWjrQ6NWEsrQUyuAeSCVbRFLarRMCmZVJSs/dCu+cyeK11O
         358lc93LJ4exSFZbzBIttaaABfAJ8WX861WrfrXtXPKFDxiq1TiriN5hUXZ5CPJ6f7Gr
         rXcg==
X-Gm-Message-State: AOAM533YS1jpIGIqu39IhhffNdEZ2vpbsiIfhxeUhOORTWAiw1M/wFC4
        DfnuvlFM+Z5qEldNYZIXbqj41nv0ytXif9cGTTof2mIMVLUGOHoEMtZUMMdqv6J5RQOFtfCaJmR
        fGpKaWVAc9ctuRt+KGtER+Kv0eSfu+dfH8aeVUA6+Ow==
X-Received: by 2002:a17:906:4154:: with SMTP id l20mr28695055ejk.509.1618937404024;
        Tue, 20 Apr 2021 09:50:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy6d/waBt2sVLq9uOF/lRJOJSgWQN2YdHM4Z7ZbxFFY9PB7veMrUXGjUS9WeWx6EgSJnxtcVA==
X-Received: by 2002:a17:906:4154:: with SMTP id l20mr28695045ejk.509.1618937403896;
        Tue, 20 Apr 2021 09:50:03 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-180-75.adslplus.ch. [188.155.180.75])
        by smtp.gmail.com with ESMTPSA id c12sm18252873edx.54.2021.04.20.09.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 09:50:02 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] ARM: dts: exynos: enable PMIC wakeup from suspend on P4 Note
Date:   Tue, 20 Apr 2021 18:49:39 +0200
Message-Id: <20210420164943.11152-7-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210420164943.11152-1-krzysztof.kozlowski@canonical.com>
References: <20210420164943.11152-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RTC on Maxim max77686 PMIC can wakeup the system from suspend to
RAM.  Add a generic property for this.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/boot/dts/exynos4412-p4note.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/exynos4412-p4note.dtsi b/arch/arm/boot/dts/exynos4412-p4note.dtsi
index 9e750890edb8..22c3086e0076 100644
--- a/arch/arm/boot/dts/exynos4412-p4note.dtsi
+++ b/arch/arm/boot/dts/exynos4412-p4note.dtsi
@@ -325,6 +325,7 @@ max77686: pmic@9 {
 		interrupts = <7 IRQ_TYPE_LEVEL_LOW>;
 		pinctrl-0 = <&max77686_irq>;
 		pinctrl-names = "default";
+		wakeup-source;
 		reg = <0x09>;
 		#clock-cells = <1>;
 
-- 
2.25.1

