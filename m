Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4B9A42A855
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 17:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237450AbhJLPgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 11:36:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:56374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237430AbhJLPgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 11:36:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D42FD6103D;
        Tue, 12 Oct 2021 15:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634052882;
        bh=0P5VyqUgzjD9h+Pv4V64yy8+3aAAXuj4+n7+F5VEBf8=;
        h=From:To:Cc:Subject:Date:From;
        b=QKB9Fe1YNuoXEynoPNmfsCG807LtmLa++Hbsad9rfJfeBtH3p6Pws8Fip0iT4Pp6m
         P3JF8kvvqVeXCv3LOfa+YSpeGCktfVijo83GlZ8Oe+tyrqlhmupYB5Q3VgBF5fygUb
         pAbBVxEKDGvmz+4y3glwjrMmIklZflxIsXO6LwOeFZARREAMdaLHOMM6VkD5A+stFt
         3N0JIzB3Eis2eVJaQfRBErD/kE+ndI2dG/N9hu5GXBhbHYAo36R/GQXbN5MuuRPx7v
         s1sgIc3JNH02Mqe+F/TOEpwhHwbPWFs247jsZhAmLQnm6zb5RS9cUJPHFWOCO2Shvo
         ETzLWBVPptiNQ==
From:   guoren@kernel.org
To:     guoren@kernel.org, anup@brainfault.org, atish.patra@wdc.com,
        maz@kernel.org, tglx@linutronix.de, palmer@dabbelt.com
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Rob Herring <robh@kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH V2 1/2] dt-bindings: update riscv plic compatible string
Date:   Tue, 12 Oct 2021 23:34:31 +0800
Message-Id: <20211012153432.2817285-1-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Add the compatible string "thead,c9xx-plic" to the riscv plic
bindings to support SOCs with thead,c9xx processor cores.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Palmer Dabbelt <palmerdabbelt@google.com>
Cc: Anup Patel <anup@brainfault.org>
Cc: Atish Patra <atish.patra@wdc.com>
---
 .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index 08d5a57ce00f..202eb7666f9b 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -46,6 +46,7 @@ properties:
       - enum:
           - sifive,fu540-c000-plic
           - canaan,k210-plic
+          - thead,c9xx-plic
       - const: sifive,plic-1.0.0
 
   reg:
-- 
2.25.1

