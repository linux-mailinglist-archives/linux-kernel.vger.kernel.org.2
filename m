Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2D9731B972
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 13:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhBOMlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 07:41:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:39408 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229805AbhBOMl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 07:41:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2C14DAC32;
        Mon, 15 Feb 2021 12:40:48 +0000 (UTC)
Date:   Mon, 15 Feb 2021 13:40:50 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/asm for v5.12
Message-ID: <20210215124050.GF7265@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull two sparse fixes in x86/asm for v5.12.

Thx.

---

The following changes since commit e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62:

  Linux 5.11-rc2 (2021-01-03 15:55:30 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_asm_for_v5.12

for you to fetch changes up to 5c99720b28381bb400d4f546734c34ddaf608761:

  x86/asm: Add a missing __iomem annotation in enqcmds() (2021-01-08 11:57:37 +0100)

----------------------------------------------------------------
Annotate new MMIO-accessing insn wrappers' arguments with __iomem.

----------------------------------------------------------------
Dave Jiang (2):
      x86/asm: Annotate movdir64b()'s dst argument with __iomem
      x86/asm: Add a missing __iomem annotation in enqcmds()

 arch/x86/include/asm/special_insns.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
