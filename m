Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 794DC3F868F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 13:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242215AbhHZLcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 07:32:25 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:35446
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242190AbhHZLcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 07:32:23 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B9B994075F
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 11:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629977495;
        bh=/4+f3V6mfjl/IwRAcPyaEIpUuWCzLFO2MSov0Okxjyw=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=O+TjvHPnDMdCPFMFU1wYD0TjYem9XXCwidXEnhFymQJUhBp+NLekS1HDLfRzteOWt
         OiClj4BiNSkWicftJtzYm+nUgvknKgEDYz2bIHT6pX6MmY8m5uLR4Swje/72I4OKj2
         lI1tfkkBA6mNEDo/ZBK2e3eiKT4lAShsHnJSuIeTPcjUzihGQ5s32wgpWn5eKNcxir
         erhscVnbo3MC4ELC4SkEuya0uv1Vx2eXmOR5QNuk+qQN9GzRMEy/u913fbqj6ufJ8U
         imnYtQpWhher4D0vCuOFSRWBBc+oKhIVZWn9SKH0aopRcGhJIM9bgtGQt3v7dCE35b
         +hOrGnmBDnneQ==
Received: by mail-wr1-f72.google.com with SMTP id v6-20020adfe4c6000000b001574f9d8336so729515wrm.15
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 04:31:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/4+f3V6mfjl/IwRAcPyaEIpUuWCzLFO2MSov0Okxjyw=;
        b=hGpNcqFzPhyG/1wTwBy94ES8D2lmGWm9Edgc7doJqsO028UGH0IHwuvpjLNMBA3Rx4
         m4I+6NaJeki9mH83eASD0ooqKar/Ur741bLm9v25ukwmk6V0fbEBQMV2VOpnqs0786Jh
         /SZuBg8vakI6PoDLUPGk72aIjd/lG/zoIviuodZvMnn6onK/FwoV2DpFYTqXe8/7aOT9
         XTBfVFVN5OhkvdwoWJr4LnLMsGtx39mxlpmJ7q4MerhpaUQ6XaBPwydFFL/Bzrdvk1Wy
         XZwzxTvlA2IF4NLbvBSurf9puCdRccwQpcCdpmxR6JwBiq85fGB83cDYc/v2FEuPs+I6
         DuTw==
X-Gm-Message-State: AOAM532ajNrF4AtMlYDOMMtZWQSFYaBNLhXS0M02QnprP7XMlkUWlR2d
        fFe+J/xsQi431fUzO9jPlU65E3R9dk2MRpngrzQwAPFjGrPuyMMx8Tifxv26+8AnI47Gpf/6ED/
        zb/c89vaLLHR1RdN8k42M7gLyam+nQVGYA3f12PdF3A==
X-Received: by 2002:a05:6000:10:: with SMTP id h16mr3378312wrx.24.1629977492394;
        Thu, 26 Aug 2021 04:31:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRIGILxCoA8dBlrp1p/psmbDQi+gHYZunmUGz5IxhIucSwKL/01jAubKNSedu2x99rwlJGJg==
X-Received: by 2002:a05:6000:10:: with SMTP id h16mr3378293wrx.24.1629977492257;
        Thu, 26 Aug 2021 04:31:32 -0700 (PDT)
Received: from localhost.localdomain ([79.98.113.63])
        by smtp.gmail.com with ESMTPSA id k25sm3082494wrd.42.2021.08.26.04.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 04:31:31 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Borislav Petkov <bp@alien8.de>, York Sun <york.sun@nxp.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/3] ARM: dts: ls1021a: drop unused big-endian property from DDR controller
Date:   Thu, 26 Aug 2021 13:30:48 +0200
Message-Id: <20210826113049.92962-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210826113049.92962-1-krzysztof.kozlowski@canonical.com>
References: <20210826113049.92962-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The big-endian is default setting for DDR controller as expressed in
bindings and such property was never documented for Freescale DDR memory
controller.  The driver also does not parse this property at all.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/boot/dts/ls1021a.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 4fce81422943..0f759bc81239 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -136,7 +136,6 @@ ddr: memory-controller@1080000 {
 			compatible = "fsl,qoriq-memory-controller";
 			reg = <0x0 0x1080000 0x0 0x1000>;
 			interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
-			big-endian;
 		};
 
 		gic: interrupt-controller@1400000 {
-- 
2.30.2

