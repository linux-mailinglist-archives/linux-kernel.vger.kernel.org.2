Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3948460C5F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 02:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234009AbhK2BqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 20:46:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30609 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236984AbhK2BoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 20:44:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638150045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k2HyyYGI9uiNR/BblzOT5yZYpLYUd3YwWGGNeg4QQFI=;
        b=aBLkicOFl1ytHFlV2TmWVIp65OPnf93zjQyzHil81TJXixXV2PZ2S/SutO9/1GT5KDZUyN
        SRK5Kx3rq190AnANZ8Irz6XjUPh1eDujRp3WmPUztHdfuFs1By0VCoThaN+IV4h/z1j8Zr
        hkIDQANQeh2EBOWJnuExAnmZ8bKFokc=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-484--9wgvufbP4S-_1kCI284-A-1; Sun, 28 Nov 2021 20:40:43 -0500
X-MC-Unique: -9wgvufbP4S-_1kCI284-A-1
Received: by mail-pg1-f200.google.com with SMTP id z8-20020a6553c8000000b00324e0d208d3so6228464pgr.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 17:40:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k2HyyYGI9uiNR/BblzOT5yZYpLYUd3YwWGGNeg4QQFI=;
        b=BLUvA/425YkWYG0EIPoRhzWVk0rPYdU2pYrXCEQZB/AxBZU3dLSfwJ8E+JGtL8WFDU
         6KllBIKWvDwdffd32r6gwhqpKOpoi3senDhuzS6eQou8Uw8W77IZDkJ0RseTliNN5rB5
         X/AV6mNbg10ZiiuOOS6j4xJbNwH9SFhYKBatY1pT4y8HhbwCtklWXYgmPGTNK0Wk9YhN
         fwGGY8GZflm1M72LE2MGM9fqp7g5VaQk1vtgtHJQ+HmRJPe7LBsogVLxtmPNubrCm5sj
         p/ItImQ7i8FtFiZ7yh7IeDP1/ARQh4UFFcTQRqflJdAn/F96JsXhvLjDt/7EsD9UKU24
         v7Aw==
X-Gm-Message-State: AOAM530QZ0NwSbjI1OYS4EHL5wjEeDgS4j6EkAL4rHitgDVq9xhSp5Pu
        Qt9mGTmCmtjDA3UxxZjBxA9ntDTMDXjoqMpEfu5l7yThHC8tCU0jogPzUkGZc6AlgJBdZjn6Cxz
        jbLePaL638QIcxK65SK1sDpXR
X-Received: by 2002:a17:90a:db02:: with SMTP id g2mr35017332pjv.76.1638150042516;
        Sun, 28 Nov 2021 17:40:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzfqf9/+YWzUdcEIBNa1uk2fXxWr4qKG4LaM8zDp5rwntZetIY4fp+YtWSMVpTRzNqF/xMX/g==
X-Received: by 2002:a17:90a:db02:: with SMTP id g2mr35017297pjv.76.1638150042296;
        Sun, 28 Nov 2021 17:40:42 -0800 (PST)
Received: from samantha.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id e18sm10367575pgl.50.2021.11.28.17.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 17:40:41 -0800 (PST)
From:   wefu@redhat.com
To:     anup.patel@wdc.com, atishp04@gmail.com, palmer@dabbelt.com,
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
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH V4 1/2] dt-bindings: riscv: add MMU Standard Extensions support for Svpbmt
Date:   Mon, 29 Nov 2021 09:40:06 +0800
Message-Id: <20211129014007.286478-2-wefu@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20211129014007.286478-1-wefu@redhat.com>
References: <20211129014007.286478-1-wefu@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Fu <wefu@redhat.com> 

Previous patch has added svpbmt in arch/riscv and add "riscv,svpmbt"
in the DT mmu node. Update dt-bindings related property here.

Signed-off-by: Wei Fu <wefu@redhat.com>
Co-developed-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Anup Patel <anup@brainfault.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Rob Herring <robh+dt@kernel.org>
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index aa5fb64d57eb..9ff9cbdd8a85 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -63,6 +63,16 @@ properties:
       - riscv,sv48
       - riscv,none
 
+  mmu:
+    description:
+      Describes the CPU's MMU Standard Extensions support.
+      These values originate from the RISC-V Privileged
+      Specification document, available from
+      https://riscv.org/specifications/
+    $ref: '/schemas/types.yaml#/definitions/string'
+    enum:
+      - riscv,svpmbt
+
   riscv,isa:
     description:
       Identifies the specific RISC-V instruction set architecture
-- 
2.25.4

