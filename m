Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD42438631
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 03:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbhJXBfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 21:35:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:59958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229769AbhJXBfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 21:35:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 64E0A60F35;
        Sun, 24 Oct 2021 01:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635039192;
        bh=pqe+fXRh/XNopuZBdqpoDaHgTvQEXnDDcjVSXlxVQQ8=;
        h=From:To:Cc:Subject:Date:From;
        b=NyK9Wv9R2p/ve/oETQXlcRHf2PGgEIn3Py1K1blfGOX9dNHaqjRy2yY9efYWjZ2vO
         9NCRZPbnt9HNeArN2m/aCgBGokMqYql/sfVRKi9QQKlHo5KedD3S47ZqfurGwEVGq2
         jpFQonD6VqGdx7M/h26+LE4Dh78s3azD1jk/R/uJRQ31qyEb0CtfOICe1d5MYObpKp
         YwrS0G5fzaAfXdvE6DK6jPOfVSK5UlYcVt9iyjqGf8HwxRCedLBsr5aK1XbPirOSvN
         vDE172b4O+zPYqTW4LJAZT/dU7r6uvKoyAIXuBudMsyMACK2AzQX5e9bG4sZev6i0V
         7WqIrn2dBopZA==
From:   guoren@kernel.org
To:     guoren@kernel.org, anup@brainfault.org, atish.patra@wdc.com,
        maz@kernel.org, tglx@linutronix.de, palmer@dabbelt.com,
        heiko@sntech.de, robh@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V5 0/3] Add thead,c900-plic support
Date:   Sun, 24 Oct 2021 09:33:00 +0800
Message-Id: <20211024013303.3499461-1-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Add the compatible string "thead,c900-plic" to the riscv plic
bindings to support allwinner d1 SOC which contains c906 core.

Changes since V5:
 - Move back to mask/unmask
 - Fixup the problem in eoi callback
 - Remove allwinner,sun20i-d1 IRQCHIP_DECLARE
 - Rewrite comment log
 - Add DT list
 - Fixup compatible string
 - Remove allwinner-d1 compatible
 - make dt_binding_check
 - Add T-head vendor-prefixes

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
  dt-bindings: vendor-prefixes: add T-Head Semiconductor
  dt-bindings: update riscv plic compatible string
  irqchip/sifive-plic: Fixup thead,c900-plic request_threaded_irq with
    ONESHOT

 .../sifive,plic-1.0.0.yaml                    | 15 +++++--
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 drivers/irqchip/irq-sifive-plic.c             | 44 ++++++++++++++++++-
 3 files changed, 56 insertions(+), 5 deletions(-)

-- 
2.25.1

