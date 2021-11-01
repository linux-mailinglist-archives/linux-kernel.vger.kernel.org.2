Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42158441941
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 10:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbhKAKBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 06:01:47 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:46312 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233783AbhKAKBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 06:01:09 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9DF42218D5;
        Mon,  1 Nov 2021 09:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1635760715; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=5ua4OgqdoBrN57IJZHFVT0uXihBHkSJ/HcI0SWh/3v8=;
        b=kVDluEwI+pKgWw+A+3u8jl15fuZtWF3yxe+0x7grD/yfoRSzwZTW1HdfPpji5KFIwMu6fU
        phjeIZ8IndKi7/LuCfoSJl8+VMvsiOWAWMi1QGWlrAMjEhvA/zcbQ/epVtecZPzbwQUGdG
        0m43nGaYWTfz8T8GLIf3HXEsGdiJgxs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1635760715;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=5ua4OgqdoBrN57IJZHFVT0uXihBHkSJ/HcI0SWh/3v8=;
        b=yEP+9wL0/Fgl0WY6SrQHrHoPbSoUd5G50MBMd1vkXVKy8Rx8oZd64AmOSJIYotUfpouz60
        N5dmuqekjMG4tPAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8BD4913AA9;
        Mon,  1 Nov 2021 09:58:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id P/L3IEu6f2G6QwAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 01 Nov 2021 09:58:35 +0000
Date:   Mon, 1 Nov 2021 10:58:36 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/cleanups for v5.16
Message-ID: <YX+6TDV7B8USNUji@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the usual pile of x86/cleanups for v5.16.

Thx.

---

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cleanups_for_v5.16_rc1

for you to fetch changes up to a757ac555ce1dafca848aa090b66cd04b5ce40e7:

  x86/Makefile: Remove unneeded whitespaces before tabs (2021-10-28 20:19:13 +0200)

----------------------------------------------------------------
The usual round of random minor fixes and cleanups all over the place.

----------------------------------------------------------------
Elyes HAOUAS (1):
      x86/Makefile: Remove unneeded whitespaces before tabs

Lukas Bulwahn (2):
      x86/Kconfig: Remove references to obsolete Kconfig symbols
      x86: Fix misspelled Kconfig symbols

Rob Herring (1):
      x86/of: Kill unused early_init_dt_scan_chosen_arch()

Tim Gardner (1):
      x86/smp: Remove unnecessary assignment to local var freq_scale

 arch/x86/Kconfig                 | 2 --
 arch/x86/Makefile                | 2 +-
 arch/x86/include/asm/ia32.h      | 2 +-
 arch/x86/include/asm/irq_stack.h | 2 +-
 arch/x86/include/asm/page_32.h   | 2 +-
 arch/x86/include/asm/uaccess.h   | 2 +-
 arch/x86/kernel/devicetree.c     | 5 -----
 arch/x86/kernel/smpboot.c        | 2 +-
 include/linux/of_fdt.h           | 1 -
 9 files changed, 6 insertions(+), 14 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
