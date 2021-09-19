Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC59F410CF6
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 20:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhISSsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 14:48:37 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45734 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhISSsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 14:48:36 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B254021C93;
        Sun, 19 Sep 2021 18:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1632077229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ptnL15rBQHdpzUMTpnJzyEbA+djEUj1yhTF8RUuKZLQ=;
        b=yv7OZjMzP9Nh2dDLOw4S0lqt8XteHR7pasN59eloColETsnnadQICQkmzGaNXIdwti0UYS
        NWHGwF3vznkoLAk2WVLFsafAo9EJmsdkZQg6yWv7qQKbGGTYgIZ59PHLVzFDj4yj4Cdg/1
        ru/uJS0pS570/SMymfDJR9WIvObVu0s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1632077229;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ptnL15rBQHdpzUMTpnJzyEbA+djEUj1yhTF8RUuKZLQ=;
        b=HqKPv47cQW4aJFZAbRfzzQ5Cz0XeV5OBOCI75yyTHabJETdkV50lu8iSWSl4xMtuqmszvN
        UiTiHIh74epW2LCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9D84113A4A;
        Sun, 19 Sep 2021 18:47:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ofQaJq2FR2E6DgAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 19 Sep 2021 18:47:09 +0000
Date:   Sun, 19 Sep 2021 20:47:09 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: [GIT PULL] Updated x86/urgent for v5.15-rc2
Message-ID: <YUeFrR016RVgUf/d@zn.tnic>
References: <163207602242.947088.16824174748243890514.tglx@xen13>
 <163207602540.947088.6038710845965846842.tglx@xen13>
 <YUeD9Gcx99EbMyMA@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YUeD9Gcx99EbMyMA@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

here's the updated x86/urgent set of changes for 5.15-rc2.

Please merge this one instead with the broken patch removed.

Thx.

---

The following changes since commit 8596e589b787732c8346f0482919e83cc9362db1:

  Merge tag 'timers-core-2021-08-30' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2021-08-30 15:31:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.15_rc2

for you to fetch changes up to 81065b35e2486c024c7aa86caed452e1f01a59d4:

  x86/mce: Avoid infinite loop for copy from user recovery (2021-09-14 10:27:03 +0200)

----------------------------------------------------------------
A set of x86 fixes:

  - Prevent a infinite loop in the MCE recovery on return to user space,
    which was caused by a second MCE queueing work for the same page and
    thereby creating a circular work list.

  - Make kern_addr_valid() handle existing PMD entries, which are marked not
    present in the higher level page table, correctly instead of blindly
    dereferencing them.

  - Pass a valid address to sanitize_phys(). This was caused by the mixture
    of inclusive and exclusive ranges. memtype_reserve() expect 'end' being
    exclusive, but sanitize_phys() wants it inclusive. This worked so far,
    but with end being the end of the physical address space the fail is
    exposed.

 - Increase the maximum supported GPIO numbers for 64bit. Newer SoCs exceed
   the previous maximum.

----------------------------------------------------------------
Andy Shevchenko (1):
      x86/platform: Increase maximum GPIO number for X86_64

Jeff Moyer (1):
      x86/pat: Pass valid address to sanitize_phys()

Mike Rapoport (1):
      x86/mm: Fix kern_addr_valid() to cope with existing but not present entries

Tony Luck (1):
      x86/mce: Avoid infinite loop for copy from user recovery

 arch/x86/Kconfig               |  5 +++++
 arch/x86/kernel/cpu/mce/core.c | 43 +++++++++++++++++++++++++++++++-----------
 arch/x86/mm/init_64.c          |  6 +++---
 arch/x86/mm/pat/memtype.c      |  7 ++++++-
 include/linux/sched.h          |  1 +
 5 files changed, 47 insertions(+), 15 deletions(-)
-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
-- 
