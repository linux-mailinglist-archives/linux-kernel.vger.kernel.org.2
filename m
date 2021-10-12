Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC2BE42AC03
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 20:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbhJLSgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 14:36:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25052 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233602AbhJLSgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 14:36:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634063660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nYn2UN+PCHx5GV9R556nliuyOIUvMr2XfooerQCV58o=;
        b=fgL2myVnBAVi3jLvtlPspRPKcFt/GU2mlW2/WBGHlrRUR1nwPZqcD7qQ3vhdMMIHYJFMby
        pKOwVuIg2CMZKMh1Qrs0DiHOJ52DNk8iOngMIm75QXXYkg86gu3rRpARQP4BLGOad7RfPD
        zAfP3rvhM6As4qhW5Zu3xKOUFS69pWw=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-LkG7425nNLaFZQI5TKUs_w-1; Tue, 12 Oct 2021 14:34:19 -0400
X-MC-Unique: LkG7425nNLaFZQI5TKUs_w-1
Received: by mail-pl1-f200.google.com with SMTP id v7-20020a1709029a0700b0013daaeaa33eso70032plp.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 11:34:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nYn2UN+PCHx5GV9R556nliuyOIUvMr2XfooerQCV58o=;
        b=f7YGn7ko3Yr8ebj2GdAa912bOFWGEFkgALk0o0MqZcwFTk2fmmdk/BsbnHPekl9Lka
         vS59GGdgTG76HkEZ9aJs52DUqj+W6AbHUf7GTOi+Lo3Z0ghH5zMw46dz8BgXHE6S5QcP
         HPWrQqBhY4Z0w1yZjjJ4lsAWWQggphh15K+zasPnlFAut58At28xSVGkfeBWNfWrjPW3
         q3AcuJPPYx14T0NX1PNc5Ok7zGOsp7MNwKv55Ltwh30bmNhRdCb5H2cThuQ91xwaZQAB
         dHb6t6Z32dnxiBefx0ZqyWcDS9QhjTRq11GvSq3j2S0ccv3mRCrOMR3PLTdk124c+MmX
         QOkQ==
X-Gm-Message-State: AOAM533YrPDNz1881XcgFbuRNZeL9CY5RjBwWBJTpNqdSyL2/5NJ2uAp
        y61LmgLJByt0QytfMwr7MRDOgmzZYNs5TKOUqYmV6r2aiauKQkyX4iORoHN1aGJsRoC00ElVPfH
        xsi0/S1yqHVt9kqg9pFxw7+/p
X-Received: by 2002:a63:2b12:: with SMTP id r18mr23683930pgr.256.1634063658322;
        Tue, 12 Oct 2021 11:34:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzuhdPj8LMwjOhpOZoKPlUbm6hkFroKNtw/F5RLD4p3o4kgtU+iDfWu7RevbajN7vmCUgI5rg==
X-Received: by 2002:a63:2b12:: with SMTP id r18mr23683880pgr.256.1634063658052;
        Tue, 12 Oct 2021 11:34:18 -0700 (PDT)
Received: from samantha.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id b10sm11617706pfi.122.2021.10.12.11.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 11:34:17 -0700 (PDT)
From:   wefu@redhat.com
To:     anup.patel@wdc.com, atish.patra@wdc.com, palmerdabbelt@google.com,
        guoren@kernel.org, christoph.muellner@vrull.eu,
        philipp.tomsich@vrull.eu, hch@lst.de, liush@allwinnertech.com,
        wefu@redhat.com, lazyparser@gmail.com, drew@beagleboard.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        taiten.peng@canonical.com, aniket.ponkshe@canonical.com,
        heinrich.schuchardt@canonical.com, gordan.markus@canonical.com,
        guoren@linux.alibaba.com, arnd@arndb.de, wens@csie.org,
        maxime@cerno.tech, dlustig@nvidia.com, gfavor@ventanamicro.com,
        andrea.mondelli@huawei.com, behrensj@mit.edu, xinhaoqu@huawei.com,
        huffman@cadence.com, mick@ics.forth.gr,
        allen.baum@esperantotech.com, jscheid@ventanamicro.com,
        rtrauben@gmail.com, Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 1/2] dt-bindings: riscv: Add mmu-supports with svpbmt
Date:   Wed, 13 Oct 2021 02:33:43 +0800
Message-Id: <20211012183344.105637-2-wefu@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20211012183344.105637-1-wefu@redhat.com>
References: <20211012183344.105637-1-wefu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Fu <wefu@redhat.com>

Previous patch has added svpbmt in arch/riscv and changed the
DT mmu-type. Update dt-bindings related property here.

Signed-off-by: Wei Fu <wefu@redhat.com>
Co-developed-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Anup Patel <anup@brainfault.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Rob Herring <robh+dt@kernel.org>
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index e534f6a7cfa1..c481c110d391 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -59,6 +59,11 @@ properties:
       - riscv,sv48
       - riscv,none
 
+  mmu-supports-svpbmt:
+    description:
+      Describes the CPU's mmu-supports-svpbmt support
+    $ref: '/schemas/types.yaml#/definitions/phandle'
+
   riscv,isa:
     description:
       Identifies the specific RISC-V instruction set architecture
-- 
2.25.4

