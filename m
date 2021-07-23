Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F423D3AD0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 15:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbhGWMVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 08:21:02 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:45437 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234853AbhGWMVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 08:21:01 -0400
Received: (Authenticated sender: alex@ghiti.fr)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 1A8A660003;
        Fri, 23 Jul 2021 13:01:30 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH 0/5] Small cleanup for mm/init.c and address conversion macros
Date:   Fri, 23 Jul 2021 15:01:23 +0200
Message-Id: <20210723130128.47664-1-alex@ghiti.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch allows to have only one definition of the address
conversion macros for all kernel types.

The following patches bring small cleanups to mm/init.c and the last
patch makes the size of the DTB early mapping consistent between 32-bit
and 64-bit kernels.

Alexandre Ghiti (5)
  riscv: Introduce va_kernel_pa_offset for 32-bit kernel
  riscv: Get rid of map_size parameter to create_kernel_page_table
  riscv: Use __maybe_unused instead of #ifdefs around variable
    declarations
  riscv: Simplify BUILTIN_DTB device tree mapping handling
  riscv: Move early fdt mapping creation in its own function

 arch/riscv/include/asm/page.h |  15 +----
 arch/riscv/mm/init.c          | 121 +++++++++++++++-------------------
 2 files changed, 54 insertions(+), 82 deletions(-)

-- 
2.30.2

