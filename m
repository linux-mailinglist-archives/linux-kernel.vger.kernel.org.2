Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5D1A36B129
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 11:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbhDZJ7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 05:59:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:37470 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232943AbhDZJ7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 05:59:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 71CB1B1A6;
        Mon, 26 Apr 2021 09:59:08 +0000 (UTC)
Date:   Mon, 26 Apr 2021 11:59:07 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dave Hansen <dave.hansen@intel.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/misc for v5.13
Message-ID: <YIaO65uYSqiK+tWf@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the x86 miscellaneous pile for v5.13.

Thx.

---

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_misc_for_v5.13

for you to fetch changes up to f281854fa743f3474b2d0d69533301f48cf0e184:

  tools/x86/kcpuid: Add AMD leaf 0x8000001E (2021-03-18 11:36:14 +0100)

----------------------------------------------------------------
A new kcpuid tool to dump the raw CPUID leafs of a CPU. It has the CPUID
bit definitions in a separate csv file which allows for adding support
for new CPUID leafs and bits without having to update the tool. The main
use case for the tool is hw enablement on preproduction x86 hw.

----------------------------------------------------------------
Andy Lutomirski (1):
      selftests/x86: Add a missing .note.GNU-stack section to thunks_32.S

Borislav Petkov (3):
      tools/x86/kcpuid: Add AMD Secure Encryption leaf
      tools/x86/kcpuid: Check last token too
      tools/x86/kcpuid: Add AMD leaf 0x8000001E

Feng Tang (1):
      tools/x86: Add a kcpuid tool to show raw CPU features

 tools/arch/x86/kcpuid/Makefile          |  24 ++
 tools/arch/x86/kcpuid/cpuid.csv         | 400 +++++++++++++++++++
 tools/arch/x86/kcpuid/kcpuid.c          | 657 ++++++++++++++++++++++++++++++++
 tools/testing/selftests/x86/thunks_32.S |   2 +
 4 files changed, 1083 insertions(+)
 create mode 100644 tools/arch/x86/kcpuid/Makefile
 create mode 100644 tools/arch/x86/kcpuid/cpuid.csv
 create mode 100644 tools/arch/x86/kcpuid/kcpuid.c

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
