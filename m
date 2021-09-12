Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 663A2407C7F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 11:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbhILJDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 05:03:42 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:44192 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbhILJDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 05:03:41 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DC0611FDAE;
        Sun, 12 Sep 2021 09:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1631437345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=QySOdgPm+HiUGJUgILMD/1/8LIC83NDqIu5nEavy49Y=;
        b=DT0xAVSUJrujkMJv4XTyjQQTc5FCn5F+UenJRlFaOLTzqQC472B/+YwLOqMOrHo/Omd36p
        ZjR2fWWf5ubGrr5706O8CRCCji38lSmueIdLOZVD8mMeUg4yeknSgF1pwj/nh5Fm50i4LG
        po8vRuLYgtY2e2sJykeBcAFKT8rJv4w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1631437345;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=QySOdgPm+HiUGJUgILMD/1/8LIC83NDqIu5nEavy49Y=;
        b=pdUbmbyQwalEhoZXJTw8PRXMztyQJzAMZRMwpQ0xRHS4G/h/10aADs58MxCoJYZX6msp85
        Psw8/YOyg9hCbfCw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id C5512132FD;
        Sun, 12 Sep 2021 09:02:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id Xgu2LyHCPWECWQAAGKfGzw
        (envelope-from <bp@suse.de>); Sun, 12 Sep 2021 09:02:25 +0000
Date:   Sun, 12 Sep 2021 11:02:23 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] locking/urgent for v5.15-rc1
Message-ID: <YT3CHxmA+NscNPgt@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull several locking fixes which accumulated over the merge
window.

Thx.

---

The following changes since commit 8596e589b787732c8346f0482919e83cc9362db1:

  Merge tag 'timers-core-2021-08-30' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2021-08-30 15:31:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/locking_urgent_for_v5.15_rc1

for you to fetch changes up to e5480572706da1b2c2dc2c6484eab64f92b9263b:

  locking/rtmutex: Fix ww_mutex deadlock check (2021-09-09 10:31:22 +0200)

----------------------------------------------------------------
 - Fix the futex PI requeue machinery to not return to userspace in
inconsistent state

- Avoid a potential null pointer dereference in the ww_mutex deadlock check

- Other smaller cleanups and optimizations

----------------------------------------------------------------
Colin Ian King (1):
      futex: Return error code instead of assigning it without effect

Mike Galbraith (1):
      locking/rwsem: Add missing __init_rwsem() for PREEMPT_RT

Peter Zijlstra (1):
      locking/rtmutex: Fix ww_mutex deadlock check

Thomas Gleixner (4):
      futex: Prevent inconsistent state and exit race
      futex: Clarify comment for requeue_pi_wake_futex()
      futex: Avoid redundant task lookup
      futex: Remove unused variable 'vpid' in futex_proxy_trylock_atomic()

 include/linux/rwsem.h    |  12 +--
 kernel/futex.c           | 190 +++++++++++++++++++++++++++--------------------
 kernel/locking/rtmutex.c |   2 +-
 kernel/locking/rwsem.c   |  10 ++-
 4 files changed, 120 insertions(+), 94 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
