Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C74BF3B5A8E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 10:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbhF1ImL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 04:42:11 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:49990 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbhF1ImK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 04:42:10 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 54D772022D;
        Mon, 28 Jun 2021 08:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624869584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=zts5Fg+3+/R4VMWjyIltUDUKV75Jq5sRs86cDB/ug1o=;
        b=yQqqhaJ/CHAWQdSiuhvBPt0W7ZCSSi7MYqfHndPp74som5heLerExGYZYkuNCnmFcSbWM1
        SxplcdB5ydtqAf0kFvv8OQbCiE0vOMeDCMEGWyY//u/gLYYif751GbNQW6Hay95bBeCpry
        AXFQ3AINqXwrA5r/V/XA0P1yuncixlo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624869584;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=zts5Fg+3+/R4VMWjyIltUDUKV75Jq5sRs86cDB/ug1o=;
        b=LvB1dvkKEU3OfpgVUgxv/U3SgHukbV/yCh5PsivmEL6z72eHi4K/+bM5ErSqUAvlVxhRHc
        gtbu7TopPGF7blCw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 39714118DD;
        Mon, 28 Jun 2021 08:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624869584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=zts5Fg+3+/R4VMWjyIltUDUKV75Jq5sRs86cDB/ug1o=;
        b=yQqqhaJ/CHAWQdSiuhvBPt0W7ZCSSi7MYqfHndPp74som5heLerExGYZYkuNCnmFcSbWM1
        SxplcdB5ydtqAf0kFvv8OQbCiE0vOMeDCMEGWyY//u/gLYYif751GbNQW6Hay95bBeCpry
        AXFQ3AINqXwrA5r/V/XA0P1yuncixlo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624869584;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=zts5Fg+3+/R4VMWjyIltUDUKV75Jq5sRs86cDB/ug1o=;
        b=LvB1dvkKEU3OfpgVUgxv/U3SgHukbV/yCh5PsivmEL6z72eHi4K/+bM5ErSqUAvlVxhRHc
        gtbu7TopPGF7blCw==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id PGr1DNCK2WCsPwAALh3uQQ
        (envelope-from <bp@suse.de>); Mon, 28 Jun 2021 08:39:44 +0000
Date:   Mon, 28 Jun 2021 10:39:38 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/sev for v5.14
Message-ID: <YNmKyjD8UH6ETawm@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the current pile of enhancements and fixes to the SEV side
of things, for v5.14.

Thx.

---

The following changes since commit 614124bea77e452aa6df7a8714e8bc820b489922:

  Linux 5.13-rc5 (2021-06-06 15:47:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sev_for_v5.14_rc1

for you to fetch changes up to 8d9d46bbf3b6b7ff8edcac33603ab45c29e0e07f:

  x86/sev: Use "SEV: " prefix for messages from sev.c (2021-06-23 11:56:18 +0200)

----------------------------------------------------------------
- Differentiate the type of exception the #VC handler raises depending
on code executed in the guest and handle the case where failure to
get the RIP would result in a #GP, as it should, instead of in a #PF

- Disable interrupts while the per-CPU GHCB is held

- Split the #VC handler depending on where the #VC exception has
happened and therefore provide for precise context tracking like the
rest of the exception handlers deal with noinstr regions now

- Add defines for the GHCB version 2 protocol so that further shared
development with KVM can happen without merge conflicts

- The usual small cleanups

----------------------------------------------------------------
Brijesh Singh (1):
      x86/sev: Add defines for GHCB version 2 MSR protocol requests

Joerg Roedel (7):
      x86/sev: Fix error message in runtime #VC handler
      x86/insn-eval: Make 0 a valid RIP for insn_get_effective_ip()
      x86/insn: Extend error reporting from insn_fetch_from_user[_inatomic]()
      x86/sev: Propagate #GP if getting linear instruction address failed
      x86/sev: Make sure IRQs are disabled while GHCB is active
      x86/sev: Split up runtime #VC handler for correct state tracking
      x86/sev: Use "SEV: " prefix for messages from sev.c

 arch/x86/entry/entry_64.S         |   4 +-
 arch/x86/include/asm/idtentry.h   |  29 ++----
 arch/x86/include/asm/sev-common.h |  16 ++-
 arch/x86/kernel/sev.c             | 201 +++++++++++++++++++++-----------------
 arch/x86/kernel/umip.c            |  10 +-
 arch/x86/lib/insn-eval.c          |  30 +++---
 6 files changed, 160 insertions(+), 130 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
