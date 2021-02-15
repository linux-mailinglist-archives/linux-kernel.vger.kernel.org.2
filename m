Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA76F31B963
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 13:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhBOMiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 07:38:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:38512 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229895AbhBOMiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 07:38:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 034B1AD29;
        Mon, 15 Feb 2021 12:38:10 +0000 (UTC)
Date:   Mon, 15 Feb 2021 13:38:07 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/build for v5.12
Message-ID: <20210215123807.GE7265@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull x86/build for v5.12.

Thx.

---

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_build_for_v5.12

for you to fetch changes up to bb73d07148c405c293e576b40af37737faf23a6a:

  x86/build: Treat R_386_PLT32 relocation as R_386_PC32 (2021-01-28 12:24:06 +0100)

----------------------------------------------------------------
- Treat R_386_PLT32 relocations like R_386_PC32 ones when building.

- Add documentation about "make kvm_guest/xen.config" in "make help" output.

----------------------------------------------------------------
Borislav Petkov (2):
      x86/build: Add {kvm_guest,xen}.config targets to make help's output
      x86/build: Realign archhelp

Fangrui Song (1):
      x86/build: Treat R_386_PLT32 relocation as R_386_PC32

 arch/x86/Makefile        | 28 ++++++++++++++++------------
 arch/x86/kernel/module.c |  1 +
 arch/x86/tools/relocs.c  | 12 ++++++++----
 3 files changed, 25 insertions(+), 16 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
