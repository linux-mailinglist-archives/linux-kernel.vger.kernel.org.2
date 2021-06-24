Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43F1B3B2E6C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 14:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhFXMDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 08:03:08 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:58127 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbhFXMDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 08:03:05 -0400
Received: (Authenticated sender: alex@ghiti.fr)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id A8F47240014;
        Thu, 24 Jun 2021 12:00:42 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jisheng Zhang <jszhang@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Zong Li <zong.li@sifive.com>, Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH v8 0/2] Map the kernel with correct permissions the first time 
Date:   Thu, 24 Jun 2021 14:00:39 +0200
Message-Id: <20210624120041.2786419-1-alex@ghiti.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel permissions are fixed after the kernel page table is created:         
avoid that by mapping the kernel 'correctly' the first time.                       
     
Patch 1 introduces a new helper to set kernel mapping permissions while          
avoiding all the casts when using set_memory_* API.                              
                                                                                 
Patch 2  is the bulk of this work and deals with mapping the kernel with          
the right permissions.                                                           

Changes in v8:
* Move set_kernel_memory inline function into set_memory.h header as suggested
  by Jisheng
* Make set_kernel_memory arguments name consistent

Changes in v7:
* Split long lines and reintroduce parameters names of set_kernel_memory
  callback, as suggested by Christoph
* Make set_kernel_memory __always_inline as suggested by Christoph
* Change 64b spelling into 64-bit, as suggested by Christoph

Changes in v6:
* load_sz was placed in init section but is now used in kernel address
  conversions macros, so remove this attribute.

Changes in v5:
* Remove non-relevant commits to this patchset that raised issues
* Make load_sz non-static as it is used in kernel address conversions
  macros
* Rebased on top for-next

Changes in v4:
* Add patch 1 as noted by Jisheng
* Changes patch 2 title as suggested by Anup
* Add Reviewed-by from Anup
                                                                                 
Changes in v3:                                                                   
* Add a patch that factorizes kernel address conversions                         
* Add a helper called set_kernel_memory in its own patch, as suggested by        
  Christoph                                                                      
* Prefer IS_ENABLED over #ifdef, as suggested by Christoph                       
* Split overly long lines, as suggested by Christoph                             
* Simplify kernel mapping by mapping ALL text as readonly and taking advantage   
  of already present code that enables write for init text before                
  free_initmem_default.                                                          
                                                                                 
Changes in v2:                                                                   
* Rebased on top of for-next (and "riscv: mm: fix build errors caused by         
  mk_pmd()")                                                                     
* Get rid of protect_kernel_linear_mapping_text_rodata as suggested by           
  Jisheng                                                                        
* Improve code in general compared to previous RFC 

Alexandre Ghiti (2):
  riscv: Introduce set_kernel_memory helper
  riscv: Map the kernel with correct permissions the first time

 arch/riscv/include/asm/page.h       |  13 +++-
 arch/riscv/include/asm/sections.h   |  17 +++++
 arch/riscv/include/asm/set_memory.h |  24 ++++--
 arch/riscv/kernel/setup.c           |  12 +--
 arch/riscv/mm/init.c                | 112 ++++++++++++----------------
 5 files changed, 97 insertions(+), 81 deletions(-)

-- 
2.30.2

