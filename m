Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40E1636B1BC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 12:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbhDZKlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 06:41:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:51002 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232656AbhDZKlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 06:41:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D0C8BAD69;
        Mon, 26 Apr 2021 10:40:23 +0000 (UTC)
Date:   Mon, 26 Apr 2021 12:40:26 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/boot for v5.13
Message-ID: <YIaYmp9vs75H4xgk@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the changes to the x86 booting area for v5.13.

Thx.

---

The following changes since commit 84196390620ac0e5070ae36af84c137c6216a7dc:

  Merge tag 'selinux-pr-20210322' of git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux (2021-03-22 11:34:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_boot_for_v5.13

for you to fetch changes up to c361e5d4d07d63768880e1994c7ed999b3a94cd9:

  x86/setup: Move trim_snb_memory() later in setup_arch() to fix boot hangs (2021-04-14 08:16:48 +0200)

----------------------------------------------------------------
Consolidation and cleanup of the early memory reservations, along with a
couple of gcc11 warning fixes.

----------------------------------------------------------------
Arnd Bergmann (2):
      x86/boot/tboot: Avoid Wstringop-overread-warning
      x86/boot/compressed: Avoid gcc-11 -Wstringop-overread warning

Mike Rapoport (3):
      x86/setup: Consolidate early memory reservations
      x86/setup: Merge several reservations of start of memory
      x86/setup: Move trim_snb_memory() later in setup_arch() to fix boot hangs

 arch/x86/boot/compressed/misc.c |   2 -
 arch/x86/kernel/setup.c         | 109 +++++++++++++++++++++-------------------
 arch/x86/kernel/tboot.c         |  44 +++++++++-------
 3 files changed, 84 insertions(+), 71 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
