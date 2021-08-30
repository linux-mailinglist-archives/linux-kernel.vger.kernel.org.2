Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095193FB387
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 12:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236263AbhH3KC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 06:02:29 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:39894 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhH3KC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 06:02:28 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3D91B20081;
        Mon, 30 Aug 2021 10:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1630317694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=oTuVfXzm/MgGyC3tsUz6RBO5XfYsGoiG5O0vuDQao5s=;
        b=m0X7DbqEUsBZ/88k1gORh1kka/eLuFtfnLGLAMBOLNAnAIHWOAopC6SD7L9nG7fDRDFvQk
        nYd+6zvdVWorr7NM2UkS0KEeuCRXTpSbEGdim/oB1tH07gFI9wmjiqdIVJKA9xYAPOqglI
        yZ4p3sYSzQy6dQw+Kl8H1ZVlqt69T50=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1630317694;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=oTuVfXzm/MgGyC3tsUz6RBO5XfYsGoiG5O0vuDQao5s=;
        b=hgdX79pCz6grGol20zcFvs3I29rxJk9veSSvSNBp7k7Nnl07Zu9GWVuiumPJIT3OQpNRpe
        ck2Scl4WMmQuGlBw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 2CA6B1365C;
        Mon, 30 Aug 2021 10:01:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id jjYACn6sLGFOPwAAGKfGzw
        (envelope-from <bp@suse.de>); Mon, 30 Aug 2021 10:01:34 +0000
Date:   Mon, 30 Aug 2021 12:02:15 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/cache for v5.15
Message-ID: <YSysp4mh5rake4Vm@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the x86/resctrl changes for v5.15.

Thx.

---

The following changes since commit 36a21d51725af2ce0700c6ebcb6b9594aac658a6:

  Linux 5.14-rc5 (2021-08-08 13:49:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cache_for_v5.15

for you to fetch changes up to 111136e69c9df50c3ca7d4e3977344b8a2d0d947:

  x86/resctrl: Make resctrl_arch_get_config() return its value (2021-08-11 18:42:53 +0200)

----------------------------------------------------------------
- A first round of changes towards splitting the arch-specific bits from
the filesystem bits of resctrl, the ultimate goal being to support ARM's
equivalent technology MPAM, with the same fs interface (James Morse)

----------------------------------------------------------------
James Morse (25):
      x86/resctrl: Split struct rdt_resource
      x86/resctrl: Split struct rdt_domain
      x86/resctrl: Add a separate schema list for resctrl
      x86/resctrl: Pass the schema in info dir's private pointer
      x86/resctrl: Label the resources with their configuration type
      x86/resctrl: Walk the resctrl schema list instead of an arch list
      x86/resctrl: Store the effective num_closid in the schema
      x86/resctrl: Add resctrl_arch_get_num_closid()
      x86/resctrl: Pass the schema to resctrl filesystem functions
      x86/resctrl: Swizzle rdt_resource and resctrl_schema in pseudo_lock_region
      x86/resctrl: Add a helper to read/set the CDP configuration
      x86/resctrl: Move the schemata names into struct resctrl_schema
      x86/resctrl: Group staged configuration into a separate struct
      x86/resctrl: Allow different CODE/DATA configurations to be staged
      x86/resctrl: Rename update_domains() to resctrl_arch_update_domains()
      x86/resctrl: Add a helper to read a closid's configuration
      x86/resctrl: Pass configuration type to resctrl_arch_get_config()
      x86/resctrl: Make ctrlval arrays the same size
      x86/resctrl: Apply offset correction when config is staged
      x86/resctrl: Calculate the index from the configuration type
      x86/resctrl: Merge the ctrl_val arrays
      x86/resctrl: Remove rdt_cdp_peer_get()
      x86/resctrl: Expand resctrl_arch_update_domains()'s msr_param range
      x86/resctrl: Merge the CDP resources
      x86/resctrl: Make resctrl_arch_get_config() return its value

 arch/x86/kernel/cpu/resctrl/core.c        | 276 +++++++-----------
 arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 163 ++++++++---
 arch/x86/kernel/cpu/resctrl/internal.h    | 231 +++++----------
 arch/x86/kernel/cpu/resctrl/monitor.c     |  44 +--
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c |  12 +-
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 461 +++++++++++++++++-------------
 include/linux/resctrl.h                   | 184 ++++++++++++
 7 files changed, 776 insertions(+), 595 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
