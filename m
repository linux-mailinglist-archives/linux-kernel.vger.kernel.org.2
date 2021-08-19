Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B18BB3F1D26
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 17:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240364AbhHSPpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 11:45:54 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:42236
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240272AbhHSPpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 11:45:53 -0400
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id 358EB411F5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 15:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629387916;
        bh=oQMiOvmPhv/1z2rOKVbJqGE7XkhSX2/8Th51kVa/d5I=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=p2KEGHXlBgGTDKU4PKDKi6NhJ/wVB8pY3Ft1ez3BIS/8NaktOpD77S8vxPmJBqx3T
         TCMSF9W+lAfT/JbrDntPQmyoki/0c65AwDJcVIfVgjcuG+X6GSOmjpgDC7cCyRC+4P
         0UnjcaV/MqHK3rtFHcqx5mbDD3xsFku3L9Q9+5BZv+OcxGF4pth6Y7EjRCx78ii6Hw
         12vvwgqllkf15cL6AmsIIy6+dUbIYggAl9icpUZeJKK1XWSBAJyHXjBaS7Q2rvFCd5
         +c6GqRUZPFxkwjnWqtokOtks/Sn3jkEawRRx9y5D6acL+LN6F4p5od07C4VtwFGSuH
         M0ngp65Qa4cjg==
Received: by mail-ej1-f69.google.com with SMTP id k12-20020a170906680cb02905aeccdbd1efso2413660ejr.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 08:45:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oQMiOvmPhv/1z2rOKVbJqGE7XkhSX2/8Th51kVa/d5I=;
        b=rISbZlt07hjgBHEHE7WCFvx7LipKja01iEfqVFWCzJcoRrvffzNvOUmqDOl+AcuexT
         ZleNjKi7DDfT7prRqiaqhh8Vr1SMMG4zu9qbPWGZY8rYJqY1lW/LQkFZFZuaX+YZdMYR
         Sccy8UFfPSCjhbAPSgWv0JRych/nRxm/fX/GjGBgOzZhvFtUhAjfNurVfcJzeCXCHS09
         LEoOmhgf25FEG6fEKDkKGnhdQSmoYjrUNAGXicaHbBzpQJOATBhhGp020NLOy6XX8NUP
         G8Lf4l5kDYOQoM38aVzA0VJ8fpzxKr0eA2GP2DNEekBdVolfi2nmtBS8TsNqGPr6uCoH
         fH5g==
X-Gm-Message-State: AOAM532ved2hSmD+J5ZNLay0fUg91dvGvCQYnR1VdPwHxZkSEz5o0hmW
        niHPjFh5xG1jueInHvYNwSMiJCTk/v0d/SK/Efm+KQmY2YDEDwY6nLnC+2h8topkPhYe6JvkwhC
        XAFhUboCm7HoZ3vje9WGn4iIBpfpEZ0vz8Mnq43ZaUA==
X-Received: by 2002:a05:6402:22ab:: with SMTP id cx11mr16901485edb.240.1629387915596;
        Thu, 19 Aug 2021 08:45:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwAEWiZz1c1r34QEyTMCWKIodNsdb2JaUuRv2nhyWDs0CmReup5t8cL3kDjjf8lf3M4RXzjlw==
X-Received: by 2002:a05:6402:22ab:: with SMTP id cx11mr16901463edb.240.1629387915485;
        Thu, 19 Aug 2021 08:45:15 -0700 (PDT)
Received: from localhost.localdomain ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id f16sm1925373edw.79.2021.08.19.08.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 08:45:15 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Atish Patra <atish.patra@wdc.com>,
        Yash Shah <yash.shah@sifive.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Piotr Sroka <piotrs@cadence.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH 1/6] dt-bindings: riscv: correct e51 and u54-mc CPU bindings
Date:   Thu, 19 Aug 2021 17:44:31 +0200
Message-Id: <20210819154436.117798-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All existing boards with sifive,e51 and sifive,u54-mc use it on top of
sifive,rocket0 compatible:

  arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dt.yaml: cpu@0: compatible: 'oneOf' conditional failed, one must be fixed:
    ['sifive,e51', 'sifive,rocket0', 'riscv'] is too long
    Additional items are not allowed ('riscv' was unexpected)
    Additional items are not allowed ('sifive,rocket0', 'riscv' were unexpected)
    'riscv' was expected

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index e534f6a7cfa1..aa5fb64d57eb 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -31,9 +31,7 @@ properties:
               - sifive,bullet0
               - sifive,e5
               - sifive,e7
-              - sifive,e51
               - sifive,e71
-              - sifive,u54-mc
               - sifive,u74-mc
               - sifive,u54
               - sifive,u74
@@ -41,6 +39,12 @@ properties:
               - sifive,u7
               - canaan,k210
           - const: riscv
+      - items:
+          - enum:
+              - sifive,e51
+              - sifive,u54-mc
+          - const: sifive,rocket0
+          - const: riscv
       - const: riscv    # Simulator only
     description:
       Identifies that the hart uses the RISC-V instruction set
-- 
2.30.2

