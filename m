Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B97F83123BF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 12:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbhBGLP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 06:15:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:57406 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229445AbhBGLPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 06:15:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8D575AD24;
        Sun,  7 Feb 2021 11:15:13 +0000 (UTC)
Date:   Sun, 7 Feb 2021 12:15:10 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sched/urgent for v5.11-rc7
Message-ID: <20210207111510.GC32127@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

pls pull one sched/urgent revert for v5.11.

Thx.

---

The following changes since commit 1048ba83fb1c00cd24172e23e8263972f6b5d9ac:

  Linux 5.11-rc6 (2021-01-31 13:50:09 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v5.11_rc7

for you to fetch changes up to 2452483d9546de1c540f330469dc4042ff089731:

  Revert "lib: Restrict cpumask_local_spread to houskeeping CPUs" (2021-02-05 23:28:29 +0100)

----------------------------------------------------------------
- Revert an attempt to not spread IRQ threads on isolated CPUs which has
a bunch of problems.

----------------------------------------------------------------
Thomas Gleixner (1):
      Revert "lib: Restrict cpumask_local_spread to houskeeping CPUs"

 lib/cpumask.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
