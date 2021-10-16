Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73FEF42FFDF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 05:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243536AbhJPDYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 23:24:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:46580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239436AbhJPDYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 23:24:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E173260F48;
        Sat, 16 Oct 2021 03:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634354533;
        bh=Jf4L74iJt8dTh8+70BoRRcla4hHCR7ElnQB8sFYGcQ0=;
        h=From:To:Cc:Subject:Date:From;
        b=TSVkR/fgejh/cc4vYhED/Qlpf3/2unMW6voGAbNb/MWFPJtsb488Fed0Q5qSTJ67z
         zbbFzCiv8ijfff+1FyFaMUv1GA4Gi/h5Cy7xgIUpGLUszqsuQayZOMrAHFoNaZNPOp
         SBADtxVg8xSKutdPcIn6d29R3rmIjd+I9S0Il0Mb2ypvgTP4DzdPgK6nWOZSQoJPsX
         a5yM+mJ5ZKCGDPecDvQ8F4Wa9VAbaL4F+c/RmrdSpUpPVKzRJhZW+IoHGEoZGEU5D/
         eJSPiR79qbZf7VBWGjKPv6M3YHuLK/qQ8wcMWIlvxbGNoqoisFt7Q+Q92NTZSbCGz+
         hdj0sKglCDzhQ==
From:   guoren@kernel.org
To:     guoren@kernel.org, anup@brainfault.org, atish.patra@wdc.com,
        maz@kernel.org, tglx@linutronix.de, palmer@dabbelt.com,
        heiko@sntech.de, robh@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V4 0/3] irqchip: riscv: Add thead,c900-plic support
Date:   Sat, 16 Oct 2021 11:21:57 +0800
Message-Id: <20211016032200.2869998-1-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Add the compatible string "thead,c900-plic" to the riscv plic
bindings to support allwinner d1 SOC which contains c906 core.

Changes since V4:
 - Update description in errata style
 - Update enum suggested by Anup, Heiko, Samuel
 - Update comment by Anup
 - Add cover-letter

Changes since V3:
 - Rename "c9xx" to "c900"
 - Add thead,c900-plic in the description section
 - Add sifive_plic_chip and thead_plic_chip for difference

Changes since V2:
 - Add a separate compatible string "thead,c9xx-plic"
 - set irq_mask/unmask of "plic_chip" to NULL and point
   irq_enable/disable of "plic_chip" to plic_irq_mask/unmask
 - Add a detailed comment block in plic_init() about the
   differences in Claim/Completion process of RISC-V PLIC and C9xx
   PLIC.

Guo Ren (3):
  irqchip/sifive-plic: Add thead,c900-plic support
  dt-bindings: update riscv plic compatible string
  dt-bindings: vendor-prefixes: add T-Head Semiconductor

 .../sifive,plic-1.0.0.yaml                    | 11 +++++-
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 ++
 drivers/irqchip/irq-sifive-plic.c             | 34 +++++++++++++++++--
 3 files changed, 44 insertions(+), 3 deletions(-)

-- 
2.25.1

