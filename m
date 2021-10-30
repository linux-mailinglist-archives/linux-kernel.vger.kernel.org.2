Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA0C44097C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 16:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbhJ3OWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Oct 2021 10:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbhJ3OWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 10:22:44 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA1BC061570;
        Sat, 30 Oct 2021 07:20:14 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id o14so21129898wra.12;
        Sat, 30 Oct 2021 07:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OJp/wZiERGVBUU7HIuspGPpojRpXm2e3BfdSR6ZgDTc=;
        b=JEUQHEz7bQf2OP6y0/Ta376kQgRSsPMSL15aqYo0Z0p5RG85Z7g+/dIDirWzrAnUfl
         DLW09vDWRWfRHCE9mv9E8t92lSwRPEIudUygoA8GiaFa2iNLeSkZkAyHZMxV0K8RFg1g
         rbmAPkTiqbuXuH/zf9DbxaS97uW9UTIJbJD1Jb+fD0NkhMWHsgkrTRJld7h0cj9dU4Fn
         +aSWb7HUKsh8LLWR1zk+3j2DDdW/xuVhAKhRcwS+gVHyClNW6w4IkRMcuhzCfYkqcths
         YyaEN4z4f0vHpU4zd0W0u0rLzTB9eQ6pV4ZPV+9NNnZtDXP/1r+vaUefUOFmggI517uX
         lslQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OJp/wZiERGVBUU7HIuspGPpojRpXm2e3BfdSR6ZgDTc=;
        b=RGrCC/5/LNWo7vAM8gLuiEsph3OvDeSj10SICSGqvuewboJTWNBS7GfCuMpoOKJTNZ
         ylILroyymEenv2j5wYcNs5H7Rrq3Bnw6Ha0MtOAbZcKsCS1Gg6VRabRSS84bnHGr0JXp
         RIdSX4UjIb9lbSbQHqxKziZvYJMLYwFOyyyuC7oxmfEnj6iqqstnT9z6U9Hb4RX9EPXQ
         VLYD+u8+gTbhyVjxsIUbvoEQ8VOgp3cunPOTTep5bfbtWh2k+ySDESjVadScpfw70lcK
         mCqJyRFqmWtFTbVNBlcHFoXvu3977XC+ENIHwBlwyfLMDMWR5VmkLr9c1CpIKgT1+Ee3
         /E9A==
X-Gm-Message-State: AOAM532Z5SuuN/cebYwdBl1GprK5nZhcojJQM0qs51DKTBpPUgoFN92T
        mglfcktdrNMfAWBHmmgg7R/4IEu4LSvfiQ==
X-Google-Smtp-Source: ABdhPJz7QSlwLY1YRbetjzWjw7/3EjxA/mbkzu0Xnm2Awq8L+ztW9XbXGuoUMg4NgTlWGt7KD+Qi/Q==
X-Received: by 2002:a5d:59a7:: with SMTP id p7mr22897326wrr.141.1635603612739;
        Sat, 30 Oct 2021 07:20:12 -0700 (PDT)
Received: from localhost.localdomain (252.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.252])
        by smtp.gmail.com with ESMTPSA id m12sm8208521wrq.69.2021.10.30.07.20.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Oct 2021 07:20:12 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, sboyd@kernel.org, john@phrozen.org,
        linux-staging@lists.linux.dev, gregkh@linuxfoundation.org,
        neil@brown.name, Rob Herring <robh@kernel.org>
Subject: [PATCH v3 2/4] dt-bindings: clock: mediatek,mt7621-sysc: add '#reset-cells' property
Date:   Sat, 30 Oct 2021 16:20:05 +0200
Message-Id: <20211030142007.27085-3-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211030142007.27085-1-sergio.paracuellos@gmail.com>
References: <20211030142007.27085-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make system controller a reset provider for all the peripherals in the
MT7621 SoC adding '#reset-cells' property.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 .../bindings/clock/mediatek,mt7621-sysc.yaml         | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt7621-sysc.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt7621-sysc.yaml
index 915f84efd763..0c0b0ae5e2ac 100644
--- a/Documentation/devicetree/bindings/clock/mediatek,mt7621-sysc.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt7621-sysc.yaml
@@ -22,6 +22,11 @@ description: |
 
   The clocks are provided inside a system controller node.
 
+  This node is also a reset provider for all the peripherals.
+
+  Reset related bits are defined in:
+  [2]: <include/dt-bindings/reset/mt7621-reset.h>.
+
 properties:
   compatible:
     items:
@@ -37,6 +42,12 @@ properties:
       clocks.
     const: 1
 
+  "#reset-cells":
+    description:
+      The first cell indicates the reset bit within the register, see
+      [2] for available resets.
+    const: 1
+
   ralink,memctl:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:
@@ -61,6 +72,7 @@ examples:
       compatible = "mediatek,mt7621-sysc", "syscon";
       reg = <0x0 0x100>;
       #clock-cells = <1>;
+      #reset-cells = <1>;
       ralink,memctl = <&memc>;
       clock-output-names = "xtal", "cpu", "bus",
                            "50m", "125m", "150m",
-- 
2.33.0

