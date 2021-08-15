Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF8B3EC80F
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 10:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236614AbhHOICf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 04:02:35 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:40590 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235569AbhHOICf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 04:02:35 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D288121FAB;
        Sun, 15 Aug 2021 08:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629014524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=d/u4ZiwbqdGZp6rNP0sBCIQsg2OulNuw9+R3vtXNsnw=;
        b=1Xl6vEMiyf1EOe50CDNYId4eZO2f1/8sVqd08KxjK6Zvw1Tl2462qXorSwSfONHtXCiXy3
        75IAH97tlyrnuo/zRYrh21miub7sSkq1ICFj++s6pszOftxn41BKsWvtc3tuvNoMiFtQA2
        GdO+LAsezsgagZd5knUoX5+1i8FxR18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629014524;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=d/u4ZiwbqdGZp6rNP0sBCIQsg2OulNuw9+R3vtXNsnw=;
        b=QB4ti0LTKR3cIbNycer2uxfrJmIAX/f7UjZtyfIx9OJA8JjYdI4+SSiqdmBE5A873cs8a2
        I5hM+HaGP823IuBQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id C1DF813668;
        Sun, 15 Aug 2021 08:02:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id T3GULvzJGGEQPwAAGKfGzw
        (envelope-from <bp@suse.de>); Sun, 15 Aug 2021 08:02:04 +0000
Date:   Sun, 15 Aug 2021 10:02:48 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] efi/urgent for v5.14-rc6
Message-ID: <YRjKKLSZD5aN88W2@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the EFI accumulated pile of fixes (by way of Ard) for
v5.14-rc6.

Thx.

---

The following changes since commit ddab1e71d2df3513ed6029435b97dcd83fbaa372:

  Merge tag 'efi-urgent-for-v5.14-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi into efi/urgent (2021-07-20 13:30:14 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/efi_urgent_for_v5.14_rc6

for you to fetch changes up to 55203550f9afb027389bd24ce85bd90044c3aa81:

  Merge tag 'efi-urgent-for-v5.14-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi into efi/urgent (2021-08-10 10:24:49 +0200)

----------------------------------------------------------------
Ard says:

A batch of fixes for the arm64 stub image loader:

- fix a logic bug that can make the random page allocator fail
  spuriously
- force reallocation of the Image when it overlaps with firmware
  reserved memory regions
- fix an oversight that defeated on optimization introduced earlier
  where images loaded at a suitable offset are never moved if booting
  without randomization
- complain about images that were not loaded at the right offset by the
  firmware image loader.

----------------------------------------------------------------
Ard Biesheuvel (4):
      efi/libstub: arm64: Force Image reallocation if BSS was not reserved
      efi/libstub: arm64: Relax 2M alignment again for relocatable kernels
      efi/libstub: arm64: Warn when efi_random_alloc() fails
      efi/libstub: arm64: Double check image alignment at entry

Benjamin Herrenschmidt (1):
      arm64: efi: kaslr: Fix occasional random alloc (and boot) failure

Thomas Gleixner (1):
      Merge tag 'efi-urgent-for-v5.14-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi into efi/urgent

 drivers/firmware/efi/libstub/arm64-stub.c  | 71 +++++++++++++++++++++++++-----
 drivers/firmware/efi/libstub/randomalloc.c |  2 +
 2 files changed, 63 insertions(+), 10 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
