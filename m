Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1CBF438DFD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 06:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbhJYEJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 00:09:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57126 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229379AbhJYEJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 00:09:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635134806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cNlijVk7PzQ228mi67x5njQYMSIM6uDFOTPJQHw/Nyc=;
        b=Xw6fAtsSdeMFnpvht4t3hxDA4cn/tSM0cUtsleuNEvvA1W0f9l+l9DZaWPbNFvKGTbMkU2
        fGIcpuvJ3LEf3kxSD7R0GPE0wSsTYbYWCJ6wDIUtrI92DW2fd1Xezrqa9YUctqbKkFPPnx
        8wPC6B2qOGaUfnbYMecJTkTPAVvz8eQ=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-550-VlaXD5xiMC6HHDKUsXLjRg-1; Mon, 25 Oct 2021 00:06:44 -0400
X-MC-Unique: VlaXD5xiMC6HHDKUsXLjRg-1
Received: by mail-pf1-f199.google.com with SMTP id t17-20020a056a00139100b0047bf45f2cc6so501143pfg.7
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 21:06:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cNlijVk7PzQ228mi67x5njQYMSIM6uDFOTPJQHw/Nyc=;
        b=JRVI6jvEDZPKNOs77h28A22PMVcxr/wPWjqstOQHI8pl7ZiHdOpA8/0YqnXQNoOJEl
         23Or2cLH5dqjHkTvTCKd6f2RNSFWNS4W96SUvQQ8qx0/EdHSQKLt6hKWWB+CSz9oRbGE
         bg3/7FrN9sM96IFAD06hXDa/LhqI2ih0nZlZSYi0w3wHsJaPNvgJEpBzLUYjoFPAPXcW
         9ZClucgCyy/V/gkm34rAtw0f2X+LYXIyJ37evhHxTTJ5dpowOEk5aL9ES68UR37ltnux
         TEeMQL6qGjtuLYYCqC1YNUiQJsIoCM0tJGeJX86f++X/0pyyNDYqk9LmIz/tp+FuwHhB
         a8HA==
X-Gm-Message-State: AOAM533tleX4rkxNHGlgwUTi/z6JQa4MammFAsa8e84gVyJYrxJcIm0X
        eIe59K45MMYjfLYnEfPwrI+axBfq+olQpqIodp4RoaAwgyreQ90YDkbXSrLW6H4ogKBONLBe/Fy
        bbcV8mzrxvdHEc5Xn5/8ARxTQ
X-Received: by 2002:a05:6a00:888:b0:44c:c00e:189c with SMTP id q8-20020a056a00088800b0044cc00e189cmr16143362pfj.79.1635134803321;
        Sun, 24 Oct 2021 21:06:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz74iLr6y99+nWWkiHWP1w3ziPdvlmjUT7sKfUmbESELDOMrhN6VxRhkVg/u74+SKHnw50Xgw==
X-Received: by 2002:a05:6a00:888:b0:44c:c00e:189c with SMTP id q8-20020a056a00088800b0044cc00e189cmr16143322pfj.79.1635134803111;
        Sun, 24 Oct 2021 21:06:43 -0700 (PDT)
Received: from samantha.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id a12sm19583944pjq.16.2021.10.24.21.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 21:06:42 -0700 (PDT)
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
Subject: [RESEND PATCH V3 1/2] dt-bindings: riscv: add mmu-supports-svpbmt for Svpbmt
Date:   Mon, 25 Oct 2021 12:06:06 +0800
Message-Id: <20211025040607.92786-2-wefu@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20211025040607.92786-1-wefu@redhat.com>
References: <20211025040607.92786-1-wefu@redhat.com>
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
index e534f6a7cfa1..76f324d85e12 100644
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

