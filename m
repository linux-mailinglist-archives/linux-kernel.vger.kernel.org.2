Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45EC544F798
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 12:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234214AbhKNLYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 06:24:02 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:40466 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbhKNLXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 06:23:55 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EC98E1FD50;
        Sun, 14 Nov 2021 11:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1636888859; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=bcqSLaSqjjmbFUTb/wEUvblcVNuYRBDpKIQuybXmWfQ=;
        b=s5DLNxSdImPYgUipMA7Bfdus0YBM6nw38ezuKA7srGNCf6daZfdrLWvapFgiU8AwDXGxg5
        rYPOQ4MghmB/pzCOMM6xgyGc3ExyL7RWekSYhNUgvJvIZYt7scGF8cV9EaWrfZwkgIfUkH
        +nOSeEgFVPW2hOpflNUtQyOgUd1KTbE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1636888859;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=bcqSLaSqjjmbFUTb/wEUvblcVNuYRBDpKIQuybXmWfQ=;
        b=laLwb5WKVG8E3nCXxYDXJ47WWcPK2wszv/1A9nrn3sRcNnXq4a2+D+xXarAcDBbiHbxckJ
        Nbzc8nTrjiR89jBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D1EF813A98;
        Sun, 14 Nov 2021 11:20:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cvDkMhvxkGH9MwAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 14 Nov 2021 11:20:59 +0000
Date:   Sun, 14 Nov 2021 12:20:52 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sched/urgent for v5.16-rc1
Message-ID: <YZDxFAYjVp2nRteh@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull sched/urgent fixes for v5.16-rc1.

Thx.

---

The following changes since commit debe436e77c72fcee804fb867f275e6d31aa999c:

  Merge tag 'ext4_for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4 (2021-11-10 17:05:37 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v5.16_rc1

for you to fetch changes up to a8b76910e465d718effce0cad306a21fa4f3526b:

  preempt: Restore preemption model selection configs (2021-11-11 13:09:33 +0100)

----------------------------------------------------------------
- Avoid touching ~100 config files in order to be able to select
the preemption model

- clear cluster CPU masks too, on the CPU unplug path

- prevent use-after-free in cfs

- Prevent a race condition when updating CPU cache domains

- Factor out common shared part of smp_prepare_cpus() into a common
helper which can be called by both baremetal and Xen, in order to fix a
booting of Xen PV guests

----------------------------------------------------------------
Boris Ostrovsky (1):
      x86/smp: Factor out parts of native_smp_prepare_cpus()

Mathias Krause (1):
      sched/fair: Prevent dead task groups from regaining cfs_rq's

Valentin Schneider (1):
      preempt: Restore preemption model selection configs

Vincent Donnefort (1):
      sched/core: Mitigate race cpus_share_cache()/update_top_cache_domain()

Wang ShaoBo (1):
      arch_topology: Fix missing clear cluster_cpumask in remove_cpu_topology()

 arch/x86/include/asm/smp.h   |  1 +
 arch/x86/kernel/smpboot.c    | 18 ++++++++++-----
 arch/x86/xen/smp_pv.c        | 12 ++--------
 drivers/base/arch_topology.c |  2 ++
 include/linux/kernel.h       |  2 +-
 include/linux/vermagic.h     |  2 +-
 init/Makefile                |  2 +-
 kernel/Kconfig.preempt       | 42 +++++++++++++++++------------------
 kernel/sched/autogroup.c     |  2 +-
 kernel/sched/core.c          | 53 ++++++++++++++++++++++++++++++++++----------
 kernel/sched/fair.c          |  4 ++--
 kernel/sched/rt.c            | 12 +++++++---
 kernel/sched/sched.h         |  3 ++-
 13 files changed, 96 insertions(+), 59 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
