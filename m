Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE9453D0A34
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 10:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbhGUHUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 03:20:08 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:56447 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234290AbhGUHTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 03:19:08 -0400
Received: (Authenticated sender: alex@ghiti.fr)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id AFF95FF804;
        Wed, 21 Jul 2021 07:59:38 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH -fixes 0/3] Fixes regarding CONFIG_PHYS_RAM_BASE 
Date:   Wed, 21 Jul 2021 09:59:34 +0200
Message-Id: <20210721075937.696811-1-alex@ghiti.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commits: 

7094e6acaf7a ("riscv: Simplify xip and !xip kernel address conversion macros")
9b79878ced8f ("riscv: Remove CONFIG_PHYS_RAM_BASE_FIXED")

expose CONFIG_PHYS_RAM_BASE for all kernel types whereas this value is
implementation-specific, so that breaks the kernel genericity.

The first patch in this patchset removes the usage of CONFIG_PHYS_RAM_BASE
by introducing a new global variable that holds this value.

The second patch reverts 9b79878ced8f ("riscv: Remove 
CONFIG_PHYS_RAM_BASE_FIXED").

The last patch is an optimization 'symmetrical' to the one introduced in
the first patch: this is not a fix, then it is not necessary to pull
this into -fixes.

Alexandre Ghiti (3):
  riscv: Get rid of CONFIG_PHYS_RAM_BASE in kernel physical address
    conversion
  Revert "riscv: Remove CONFIG_PHYS_RAM_BASE_FIXED"
  riscv: Optimize kernel virtual address conversion macro

 arch/riscv/Kconfig            |  6 ++++++
 arch/riscv/include/asm/page.h |  9 +++++----
 arch/riscv/mm/init.c          | 17 ++++++++++++-----
 3 files changed, 23 insertions(+), 9 deletions(-)

-- 
2.30.2

