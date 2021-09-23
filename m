Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED183416448
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 19:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242532AbhIWRXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 13:23:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:51302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242530AbhIWRW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 13:22:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D77526109E;
        Thu, 23 Sep 2021 17:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632417687;
        bh=s2lEbsUK2QSTVWOGxFPXmMQe0lxrblhhxihNsi7x+iI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iI4qnQcfSOrNmU4uK7Z2ToKa0FxJ64z9GjA1adg3AIblkTmaVPQW9sAuInXDE40SK
         IVrZ1bFQOflf+TTx7Ltw4JgIJ7WFFCI82BbdZAj4aO6GaWLi76+9SycX5g9az5Fhet
         ttyaOCMZNPTZIhrvpTIy46AWnZ1PbthWAbuMHBENJAU8B0o0OAGjLohk1s5lBK5IbQ
         Gt+nIiSiCHYjCKVDuEI6N1cX6ZDCjhBIYKn/DQNX7zNAslbK0XjoVLMET8F5r849uE
         BRKjrAJ47yi1MIBPvAghs+eY+mBdlQnpvvWYZgc534ELbeGzTjqWJEz3fzFQG2eGa0
         63BOs4zTIWlhA==
From:   guoren@kernel.org
To:     anup.patel@wdc.com, atish.patra@wdc.com, palmerdabbelt@google.com,
        guoren@kernel.org, christoph.muellner@vrull.eu,
        philipp.tomsich@vrull.eu, hch@lst.de, liush@allwinnertech.com,
        wefu@redhat.com, lazyparser@gmail.com, drew@beagleboard.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        taiten.peng@canonical.com, aniket.ponkshe@canonical.com,
        heinrich.schuchardt@canonical.com, gordan.markus@canonical.com,
        Guo Ren <guoren@linux.alibaba.com>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH V2 2/2] dt-bindings: riscv: Add svpbmt in cpu mmu-type property
Date:   Fri, 24 Sep 2021 01:21:07 +0800
Message-Id: <20210923172107.1117604-2-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210923172107.1117604-1-guoren@kernel.org>
References: <20210923172107.1117604-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Previous patch has added svpbmt in arch/riscv and changed the
DT mmu-type. Update dt-bindings related property here.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Anup Patel <anup@brainfault.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Rob Herring <robh+dt@kernel.org>
---
 Documentation/devicetree/bindings/riscv/cpus.yaml | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index e534f6a7cfa1..5eea9b47dfc6 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -48,15 +48,18 @@ properties:
 
   mmu-type:
     description:
-      Identifies the MMU address translation mode used on this
-      hart.  These values originate from the RISC-V Privileged
-      Specification document, available from
+      Identifies the MMU address translation mode and page based
+      memory type used on used on this hart.  These values originate
+      from the RISC-V Privileged Specification document, available
+      from
       https://riscv.org/specifications/
     $ref: "/schemas/types.yaml#/definitions/string"
     enum:
       - riscv,sv32
       - riscv,sv39
+      - riscv,sv39,svpbmt
       - riscv,sv48
+      - riscv,sv48,svpbmt
       - riscv,none
 
   riscv,isa:
-- 
2.25.1

