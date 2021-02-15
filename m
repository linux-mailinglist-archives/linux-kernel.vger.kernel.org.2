Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1894A31B876
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 12:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhBOL4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 06:56:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:35402 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229917AbhBOL4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 06:56:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6FC86AC32;
        Mon, 15 Feb 2021 11:55:36 +0000 (UTC)
Date:   Mon, 15 Feb 2021 12:55:38 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/cpu for v5.12
Message-ID: <20210215115538.GC7265@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a single cleanup to the x86/cpu area for v5.12.

Thx.

---

The following changes since commit 7c53f6b671f4aba70ff15e1b05148b10d58c2837:

  Linux 5.11-rc3 (2021-01-10 14:34:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cpu_for_v5.12

for you to fetch changes up to fb35d30fe5b06cc24444f0405da8fbe0be5330d1:

  x86/cpufeatures: Assign dedicated feature word for CPUID_0x8000001F[EAX] (2021-01-28 17:41:24 +0100)

----------------------------------------------------------------
Assign a dedicated feature word to a CPUID leaf which is widely used.

----------------------------------------------------------------
Sean Christopherson (1):
      x86/cpufeatures: Assign dedicated feature word for CPUID_0x8000001F[EAX]

 arch/x86/include/asm/cpufeature.h              |  7 +++++--
 arch/x86/include/asm/cpufeatures.h             | 17 +++++++++++------
 arch/x86/include/asm/disabled-features.h       |  3 ++-
 arch/x86/include/asm/required-features.h       |  3 ++-
 arch/x86/kernel/cpu/common.c                   |  3 +++
 arch/x86/kernel/cpu/scattered.c                |  5 -----
 tools/arch/x86/include/asm/disabled-features.h |  3 ++-
 tools/arch/x86/include/asm/required-features.h |  3 ++-
 8 files changed, 27 insertions(+), 17 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
