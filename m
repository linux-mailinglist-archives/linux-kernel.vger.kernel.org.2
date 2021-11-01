Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3EF2441A2E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 11:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbhKAKui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 06:50:38 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41644 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbhKAKuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 06:50:37 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6EB8A1FD73;
        Mon,  1 Nov 2021 10:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1635763683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=cw9ue3nhsP0Gi81qrIByB24WKeFFRUlnZI1BRAVyoBo=;
        b=nbHV52rcyVCp+OuRTLpq9vbLQbppqi+eyIglSCrHbMVEoP4BY2/xemxzp35l8WuWd40phT
        N+pBJNlLYfmP2dSJy3j84mtBCzplVJQ27butemmeKTZmMFWKZ51Zwn4yHlam1wK1q//jSl
        EtGirIktIHH2Dtczu4ah99J3H7xtRBE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1635763683;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=cw9ue3nhsP0Gi81qrIByB24WKeFFRUlnZI1BRAVyoBo=;
        b=CqbSkHcFoiC4XItF+dTibQzZtzEJYjge66GeA0X6Ai1Dr9lbgnL6ctZ5MhrHdLG4tNtbRj
        YgzcbNdCBiIx+hCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 56DB413AA8;
        Mon,  1 Nov 2021 10:48:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nvujFOPFf2EgVQAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 01 Nov 2021 10:48:03 +0000
Date:   Mon, 1 Nov 2021 11:48:00 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/sev for v5.16
Message-ID: <YX/F4ORaVujMtqzG@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull some SEV improvements and fixes for v5.16.

Thx.

---

The following changes since commit 64570fbc14f8d7cb3fe3995f20e26bc25ce4b2cc:

  Linux 5.15-rc5 (2021-10-10 17:01:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sev_for_v5.16_rc1

for you to fetch changes up to 007faec014cb5d26983c1f86fd08c6539b41392e:

  x86/sev: Expose sev_es_ghcb_hv_call() for use by HyperV (2021-10-25 18:11:42 +0200)

----------------------------------------------------------------
- Export sev_es_ghcb_hv_call() so that HyperV Isolation VMs can use it too

- Non-urgent fixes and cleanups

----------------------------------------------------------------
Borislav Petkov (1):
      x86/sev: Carve out HV call's return value verification

Joerg Roedel (2):
      x86/sev: Fix stack type check in vc_switch_off_ist()
      x86/sev: Allow #VC exceptions on the VC2 stack

Tianyu Lan (1):
      x86/sev: Expose sev_es_ghcb_hv_call() for use by HyperV

Tom Lendacky (1):
      x86/sme: Use #define USE_EARLY_PGTABLE_L5 in mem_encrypt_identity.c

 arch/x86/include/asm/sev.h         |  6 ++++
 arch/x86/kernel/sev-shared.c       | 68 ++++++++++++++++++++++----------------
 arch/x86/kernel/sev.c              | 34 +++++++++++++------
 arch/x86/kernel/traps.c            |  2 +-
 arch/x86/mm/mem_encrypt_identity.c |  9 +++++
 5 files changed, 80 insertions(+), 39 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
