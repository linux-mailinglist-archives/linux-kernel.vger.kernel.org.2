Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09FA33FAAF2
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 12:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235126AbhH2Kuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 06:50:50 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57248 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235019AbhH2Kus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 06:50:48 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F1A8222098;
        Sun, 29 Aug 2021 10:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1630234195; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=vhSF2MK1IN0ux8+U8tybOSenPYU3FhscnLAoqhgLP2Q=;
        b=I5zUDiVYo6aIYgUe5yaGx1OSl1kcIXPyuG/vZ0FPFzV2Dp4e91fFnUZ2DxoF9KU/r4mf5R
        znj+0OxG/fM/h6UnpM1lZPkd7pBhagkNeFdFr7G/wZNPjWN5ydAUV9wWVMRB0Aq4kiDt33
        7vAB4m74q0A0saaDIPXI7fsGaf3RPE0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1630234195;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=vhSF2MK1IN0ux8+U8tybOSenPYU3FhscnLAoqhgLP2Q=;
        b=QT3/2H96ziQ7yNT76cuEyCGa4IAYO+iVQkjUHo/8BUieYKgkO8T4raJ1ApKr3CjBE6OZje
        nzJ7tU0+OXJpubDg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id DA5F41371C;
        Sun, 29 Aug 2021 10:49:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id XWB1NFJmK2HfaQAAGKfGzw
        (envelope-from <bp@suse.de>); Sun, 29 Aug 2021 10:49:54 +0000
Date:   Sun, 29 Aug 2021 12:50:30 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v5.14
Message-ID: <YStmdmbJidlytmUh@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull two final x86/urgent fixes for 5.14.

Thx.

---

The following changes since commit 7c60610d476766e128cc4284bb6349732cbd6606:

  Linux 5.14-rc6 (2021-08-15 13:40:53 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v5.14

for you to fetch changes up to 527f721478bce3f49b513a733bacd19d6f34b08c:

  x86/resctrl: Fix a maybe-uninitialized build warning treated as error (2021-08-22 09:11:29 +0200)

----------------------------------------------------------------
- Fix build error on RHEL where -Werror=maybe-uninitialized is set.

- Restore the firmware's IDT when calling EFI boot services and before
ExitBootServices() has been called. This fixes a boot failure on what
appears to be a tablet with 32-bit UEFI running a 64-bit kernel.

----------------------------------------------------------------
Babu Moger (1):
      x86/resctrl: Fix a maybe-uninitialized build warning treated as error

Joerg Roedel (1):
      x86/efi: Restore Firmware IDT before calling ExitBootServices()

 arch/x86/boot/compressed/efi_thunk_64.S | 30 +++++++++++++++++++++---------
 arch/x86/boot/compressed/head_64.S      |  3 +++
 arch/x86/kernel/cpu/resctrl/monitor.c   |  6 ++++++
 3 files changed, 30 insertions(+), 9 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
