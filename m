Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92A7135B28A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 11:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235280AbhDKJDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 05:03:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:52288 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235247AbhDKJDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 05:03:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 73EB3AEFB;
        Sun, 11 Apr 2021 09:03:33 +0000 (UTC)
Date:   Sun, 11 Apr 2021 11:03:32 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v5.12-rc7
Message-ID: <20210411090332.GA13409@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull two more urgent fixes (not gonna say "final" this time) from
x86-land.

Thx.

---

The following changes since commit e49d033bddf5b565044e2abe4241353959bc9120:

  Linux 5.12-rc6 (2021-04-04 14:15:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.12-rc7

for you to fetch changes up to 632a1c209b8773cb0119fe3aada9f1db14fa357c:

  x86/traps: Correct exc_general_protection() and math_error() return paths (2021-04-09 13:45:09 +0200)

----------------------------------------------------------------
- Fix the vDSO exception handling return path to disable interrupts
again.

- A fix for the CE collector to return the proper return values to its
callers which are used to convey what the collector has done with the
error address.

----------------------------------------------------------------
Thomas Tai (1):
      x86/traps: Correct exc_general_protection() and math_error() return paths

William Roche (1):
      RAS/CEC: Correct ce_add_elem()'s returned values

 arch/x86/kernel/traps.c |  4 ++--
 drivers/ras/cec.c       | 15 ++++++++++++---
 2 files changed, 14 insertions(+), 5 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
