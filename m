Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 414F436A653
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 11:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhDYJrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 05:47:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:46468 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229551AbhDYJrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 05:47:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0244AAD69;
        Sun, 25 Apr 2021 09:46:42 +0000 (UTC)
Date:   Sun, 25 Apr 2021 11:46:44 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] perf/urgent for v5.12
Message-ID: <YIU6hPAcb0g1QdV4@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull two urgent perf fixes for 5.12.

Thx.

---

The following changes since commit bf05bf16c76bb44ab5156223e1e58e26dfe30a88:

  Linux 5.12-rc8 (2021-04-18 14:45:32 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v5.12

for you to fetch changes up to 4b2f1e59229b9da319d358828cdfa4ddbc140769:

  perf/x86/kvm: Fix Broadwell Xeon stepping in isolation_ucodes[] (2021-04-22 14:36:01 +0200)

----------------------------------------------------------------
- Fix BDW Xeon's stepping in the PEBS isolation table of CPUs

- Fix a panic when initializing perf uncore machinery on HSW and BDW servers

----------------------------------------------------------------
Jim Mattson (1):
      perf/x86/kvm: Fix Broadwell Xeon stepping in isolation_ucodes[]

Kan Liang (1):
      perf/x86/intel/uncore: Remove uncore extra PCI dev HSWEP_PCI_PCU_3

 arch/x86/events/intel/core.c         |  2 +-
 arch/x86/events/intel/uncore_snbep.c | 61 +++++++++++++++---------------------
 2 files changed, 27 insertions(+), 36 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
