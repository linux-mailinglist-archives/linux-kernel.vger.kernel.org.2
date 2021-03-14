Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6226733A4D7
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 13:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235439AbhCNMor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 08:44:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:41902 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235393AbhCNMoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 08:44:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 12614AC17;
        Sun, 14 Mar 2021 12:44:14 +0000 (UTC)
Date:   Sun, 14 Mar 2021 13:44:11 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] perf/urgent for v5.12-rc3
Message-ID: <20210314124411.GC27191@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull there perf urgent fixes for v5.12-rc3.

Thx.

---

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v5.12-rc3

for you to fetch changes up to c8e2fe13d1d1f3a02842b7b909d4e4846a4b6a2c:

  x86/perf: Use RET0 as default for guest_get_msrs to handle "no PMU" case (2021-03-10 16:45:09 +0100)

----------------------------------------------------------------
- Make sure PMU internal buffers are flushed for per-CPU events too and
  properly handle PID/TID for large PEBS.

- Handle the case properly when there's no PMU and therefore return an
  empty list of perf MSRs for VMX to switch instead of reading random
  garbage from the stack.

----------------------------------------------------------------
Kan Liang (2):
      perf/core: Flush PMU internal buffers for per-CPU events
      perf/x86/intel: Set PERF_ATTACH_SCHED_CB for large PEBS and LBR

Sean Christopherson (1):
      x86/perf: Use RET0 as default for guest_get_msrs to handle "no PMU" case

 arch/x86/events/core.c       | 15 ++++++---------
 arch/x86/events/intel/core.c |  5 ++++-
 arch/x86/kvm/vmx/vmx.c       |  2 +-
 include/linux/perf_event.h   |  2 ++
 kernel/events/core.c         | 42 ++++++++++++++++++++++++++++++++++++++----
 5 files changed, 51 insertions(+), 15 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
