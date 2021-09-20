Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609744115B0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 15:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239960AbhITN2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 09:28:42 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:34624
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240062AbhITN1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 09:27:30 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9E8A73F320
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 13:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632144362;
        bh=vJToJAd3e7XitzB+9QvxgrvOdQZu/cSSC1UlIYS41NQ=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=UG4VMLXiQwYBokcSCxAmyIBJgEdC2bsVwIIsX5qzfg22GLR8K5kxjtyrre8wmpqgc
         1L8v4/1126STgfVd4Ehqg2yp8HaPE2p9RbTUVYVqQS6nssCBAASpl2wlLikXfJmFoV
         MUhGRuxUO2XYH/Z8sgHM/pZApd6OlnyTAoik5Yz/lLosp8TDp+xVHFxeO4eCbDMlkf
         6SRmn1ODduxN0mtDwp6k4z/3JpUodDjxCW5I+v14Tz7tTZrB682FOwbwgxxNgbgOgo
         oLK/deo5iL/dNVid86ahz1QPOAvj3Xau/c+jF4pAuxfrgJ7oMYheru00elFTIkxVDJ
         TNj7Smbu7c/DA==
Received: by mail-wr1-f70.google.com with SMTP id x2-20020a5d54c2000000b0015dfd2b4e34so6069074wrv.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 06:26:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vJToJAd3e7XitzB+9QvxgrvOdQZu/cSSC1UlIYS41NQ=;
        b=TLIOLAM6i71+W9IG8+H6UuCNU/wo30YdB31BM0f7uzQU/jfKkJe93pubXDtFqKfKJJ
         oQmGaWdhSNbxU0w1HcO4/k0aIhW2vdvonwk64+Tg8H0Fof+Mr0c658/KdvOF8FGErhIv
         V/ePy5LhuxuRHR9Wo/StBEqCYP6zrRBQLsP0qY0WABppMSuf3F0jUcmsdN5FEIjIBmLt
         xWVafROOAzEdRPl1ahGT4aT/YGLe4n4/6aQb0oFmaP0vIVGndT42KDeiFdukdfdet8fv
         mWV4nBEkDq2IBlrP8HNuuNC1DZDRs7PuJBPsZkF389I71euB4DL6l4tTRkeWMkeDKxx7
         ayZg==
X-Gm-Message-State: AOAM533iuBi+d23+9nW2ipB+fEiLQNs3CV1igj5Cb518UYPbFm8wipXu
        kxpWJKs5ibgVRq2gcqDIe3ZDUs76IxWtKEYf5uTiO3jX5auOSQs9FhGeN7QtFmVzMG+haUxQ7wv
        O2QRhPhKdqtiN+BQon9ElVhcPYTeqW4sQuwu8D+gKyQ==
X-Received: by 2002:a05:6000:1287:: with SMTP id f7mr29033677wrx.221.1632144362275;
        Mon, 20 Sep 2021 06:26:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymf7l0CKsN1xSthBcoxGq3X4DmkxIw9o+QPMTz1O6EvUcCymMCo5tuwGlI5/sIFl5hOJNaIQ==
X-Received: by 2002:a05:6000:1287:: with SMTP id f7mr29033647wrx.221.1632144362053;
        Mon, 20 Sep 2021 06:26:02 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id y9sm23062787wmj.36.2021.09.20.06.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 06:26:01 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] dt-bindings: riscv: correct e51 and u54-mc CPU bindings
Date:   Mon, 20 Sep 2021 15:25:59 +0200
Message-Id: <20210920132559.151678-1-krzysztof.kozlowski@canonical.com>
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

Hi Rob,

You previously acked this patch but I think it will be easier if you
take it directly.

Best regards,
Krzysztof
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

