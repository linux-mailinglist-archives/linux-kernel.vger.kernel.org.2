Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D413731B88D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 13:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhBOMAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 07:00:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:38088 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230042AbhBOL7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 06:59:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 33FABACD4;
        Mon, 15 Feb 2021 11:59:03 +0000 (UTC)
Date:   Mon, 15 Feb 2021 12:59:05 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/cache for v5.12
Message-ID: <20210215115905.GD7265@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a couple of resctrl fixes for v5.12.

Thx.

---

The following changes since commit 7c53f6b671f4aba70ff15e1b05148b10d58c2837:

  Linux 5.11-rc3 (2021-01-10 14:34:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cache_for_v5.12

for you to fetch changes up to 6d3b47ddffed70006cf4ba360eef61e9ce097d8f:

  x86/resctrl: Apply READ_ONCE/WRITE_ONCE to task_struct.{rmid,closid} (2021-01-11 11:43:23 +0100)

----------------------------------------------------------------
Avoid IPI-ing a task in certain cases and prevent load/store tearing
when accessing a task's resctrl fields concurrently.

----------------------------------------------------------------
Reinette Chatre (1):
      x86/resctrl: Use task_curr() instead of task_struct->on_cpu to prevent unnecessary IPI

Tom Rix (1):
      x86/resctrl: Add printf attribute to log function

Valentin Schneider (1):
      x86/resctrl: Apply READ_ONCE/WRITE_ONCE to task_struct.{rmid,closid}

 arch/x86/include/asm/resctrl.h         | 11 +++++++----
 arch/x86/kernel/cpu/resctrl/internal.h |  1 +
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 24 ++++++++++--------------
 3 files changed, 18 insertions(+), 18 deletions(-)



-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
