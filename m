Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 405C93FB393
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 12:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236316AbhH3KGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 06:06:37 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57144 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233248AbhH3KGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 06:06:35 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6AC6D21F1D;
        Mon, 30 Aug 2021 10:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1630317941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7igE3j/M+TU8XtCceo1WJuzaQVZMsWLdDbJuziXDqdo=;
        b=FO39eG4r+l9pF25GYOnQWvWaubPhyfk5X+bRMFbqYBfH6BL1w/s3OO9PZwBixRgGF3/kjw
        2ygFXpaN6NMja7xUFl9CE4kemI9SkxcauSiquUIomwR0neaxWoe+IL9CfzDt68qiZFuncP
        MUVqSdO1D1bSGItPnRDovD60vJ6uW4U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1630317941;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7igE3j/M+TU8XtCceo1WJuzaQVZMsWLdDbJuziXDqdo=;
        b=ZavlJ0JaTqsipM42kL+K9rRxGo6DNA8B9eNeSVVbnJjJ4U+KId9sU+r+IYDJT4IP9D2Hur
        Kv0IJStpIWCiXXDg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 586DB1365C;
        Mon, 30 Aug 2021 10:05:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id MgqUFHWtLGF4QAAAGKfGzw
        (envelope-from <bp@suse.de>); Mon, 30 Aug 2021 10:05:41 +0000
Date:   Mon, 30 Aug 2021 12:06:22 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/cleanups for v5.15
Message-ID: <YSytntfrU9n4fuo/@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the random cleanups pile for 5.15.

Thx.

---

The following changes since commit 36a21d51725af2ce0700c6ebcb6b9594aac658a6:

  Linux 5.14-rc5 (2021-08-08 13:49:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cleanups_for_v5.15

for you to fetch changes up to 5b3fd8aa5df0244fc19f2572598dee406bcc6b07:

  x86/kaslr: Have process_mem_region() return a boolean (2021-08-24 10:54:15 +0200)

----------------------------------------------------------------
- The usual round of minor cleanups and fixes

----------------------------------------------------------------
Baokun Li (1):
      x86/power: Fix kernel-doc warnings in cpu.c

Jing Yangyang (1):
      x86/kaslr: Have process_mem_region() return a boolean

Sebastian Andrzej Siewior (4):
      x86/mmiotrace: Replace deprecated CPU-hotplug functions.
      x86/mtrr: Replace deprecated CPU-hotplug functions.
      x86/microcode: Replace deprecated CPU-hotplug functions.
      x86/mce/inject: Replace deprecated CPU-hotplug functions.

 arch/x86/boot/compressed/kaslr.c     |  2 +-
 arch/x86/kernel/cpu/mce/inject.c     |  8 ++++----
 arch/x86/kernel/cpu/microcode/core.c | 18 +++++++++---------
 arch/x86/kernel/cpu/mtrr/mtrr.c      |  8 ++++----
 arch/x86/mm/mmio-mod.c               |  4 ++--
 arch/x86/power/cpu.c                 | 31 ++++++++++++++++---------------
 6 files changed, 36 insertions(+), 35 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
