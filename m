Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB60241F179
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 17:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355090AbhJAPu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 11:50:27 -0400
Received: from 8bytes.org ([81.169.241.247]:42912 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230162AbhJAPuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 11:50:12 -0400
Received: from cap.home.8bytes.org (p4ff2b5b0.dip0.t-ipconnect.de [79.242.181.176])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by theia.8bytes.org (Postfix) with ESMTPSA id 291291A4;
        Fri,  1 Oct 2021 17:48:26 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        hpa@zytor.com, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brijesh Singh <brijesh.singh@amd.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] x86/mm: Fix some issues with using trampoline_pgd
Date:   Fri,  1 Oct 2021 17:48:13 +0200
Message-Id: <20211001154817.29225-1-joro@8bytes.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Hi,

here are a couple of fixes and documentation improvements for the use
of the trampoline_pgd in the kernel. Most importantly it fixes the
issue that switching to the trampoline_pgd will unmap the kernel stack
and real_mode_header, making crashes likely before the code can
actually jump to real mode.

The first patch adds a comment to document that the trampoline_pgd
aliases kernel page-tables in the user address range, establishing
global TLB entries for these addresses. The next two patches add
global TLB flushes when switching to and from the trampoline_pgd.

The last patch extends the trampoline_pgd to cover the whole kernel
address range. This is needed to make sure the stack and the
real_mode_header are still mapped after the switch and that the code
flow can safely reach real-mode.

Please review.

Thanks,

	Joerg

Changes v2->v3:

	- Addressed review comments from Dave Hansen

Link to v2: https://lore.kernel.org/lkml/20210929145501.4612-1-joro@8bytes.org/

Joerg Roedel (4):
  x86/realmode: Add comment for Global bit usage in trampline_pgd
  x86/mm/64: Flush global TLB on boot and AP bringup
  x86/mm: Flush global TLB when switching to trampoline page-table
  x86/64/mm: Map all kernel memory into trampoline_pgd

 arch/x86/include/asm/realmode.h |  1 +
 arch/x86/kernel/head64.c        | 15 ++++++++++++++
 arch/x86/kernel/head_64.S       | 19 +++++++++++++++++-
 arch/x86/kernel/reboot.c        | 12 ++---------
 arch/x86/mm/init.c              |  5 +++++
 arch/x86/realmode/init.c        | 35 ++++++++++++++++++++++++++++++++-
 6 files changed, 75 insertions(+), 12 deletions(-)


base-commit: 5816b3e6577eaa676ceb00a848f0fd65fe2adc29
-- 
2.33.0

