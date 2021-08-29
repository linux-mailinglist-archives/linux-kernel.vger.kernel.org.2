Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E998E3FAAFD
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 13:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbhH2LEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 07:04:30 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58050 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235142AbhH2LE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 07:04:29 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 666D12202C;
        Sun, 29 Aug 2021 11:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1630235016; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=wpe5zT8C/4zU1B/83usllo49V/GR4ZSWX19vPeC/bpg=;
        b=Q1rihNexZxm6mRKzd0yLFlq+sxRAYscdkVdGHJuYQ1dPow+47f6xGtNe2RQb0VVvwIIL7B
        iHlLe2uHPcETbRbRbyvtSZepXmGdLIaoyLdayg0PnvKCWfFYEZQgyT4WtoeuIYw0CghQoa
        m7cwPyKUQ1aprAyXWlq+5e1Hn5g7v7A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1630235016;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=wpe5zT8C/4zU1B/83usllo49V/GR4ZSWX19vPeC/bpg=;
        b=PrB+/j9MO4VVzF1fdirBSHZ1MYidcTYBecAd51RjoezGxgzTedPMnlxgHt1EeXVQoGEnZa
        J5I4L1d93/XllPAQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 50C0B13775;
        Sun, 29 Aug 2021 11:03:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id LGJbE4hpK2HTawAAGKfGzw
        (envelope-from <bp@suse.de>); Sun, 29 Aug 2021 11:03:36 +0000
Date:   Sun, 29 Aug 2021 13:04:12 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] perf/urgent for v5.14
Message-ID: <YStprPbm18fl8JC6@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a couple last-minute urgent perf fixes for v5.14.

Thx.

---

The following changes since commit e22ce8eb631bdc47a4a4ea7ecf4e4ba499db4f93:

  Linux 5.14-rc7 (2021-08-22 14:24:56 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v5.14

for you to fetch changes up to ccf26483416a339c114409f6e7cd02abdeaf8052:

  perf/x86/amd/power: Assign pmu.module (2021-08-26 09:12:57 +0200)

----------------------------------------------------------------
- Prevent the amd/power module from being removed while in use

- Mark AMD IBS as not supporting content exclusion

- Add a workaround for AMD erratum #1197 where IBS registers might
not be restored properly after exiting CC6 state

- Fix a potential truncation of a 32-bit variable due to shifting

- Read the correct bits describing the number of configurable address
ranges on Intel PT

----------------------------------------------------------------
Colin Ian King (1):
      perf/x86/intel/uncore: Fix integer overflow on 23 bit left shift of a u32

Kim Phillips (3):
      perf/x86/amd/ibs: Work around erratum #1197
      perf/x86/amd/ibs: Extend PERF_PMU_CAP_NO_EXCLUDE to IBS Op
      perf/x86/amd/power: Assign pmu.module

Xiaoyao Li (1):
      perf/x86/intel/pt: Fix mask of num_address_ranges

 arch/x86/events/amd/ibs.c            | 9 +++++++++
 arch/x86/events/amd/power.c          | 1 +
 arch/x86/events/intel/pt.c           | 2 +-
 arch/x86/events/intel/uncore_snbep.c | 2 +-
 4 files changed, 12 insertions(+), 2 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
