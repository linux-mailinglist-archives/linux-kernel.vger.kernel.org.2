Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF64E407C86
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 11:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbhILJGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 05:06:53 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:44418 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232742AbhILJGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 05:06:51 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8A5671FD69;
        Sun, 12 Sep 2021 09:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1631437536; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=uLTwGTmA1ofLHh00bpzXi4O/0dOGkYDWM0F2xDqoIag=;
        b=EVZkX4VutgGnK0qKuUscrU0r0w/yTYlF0po+4kxETKOjz3X7T3bYSG6Wf0yvCmydTxhtUT
        kWXPcG9D2OSbirZPMnQA8jISKFAc0fwA3vuFRKOa9m9KQIw3dgzxiToD6nPt/6OOgdfZyO
        Iw/XiH1H7WP1edfDg6Pj8wb7Jyi2uZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1631437536;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=uLTwGTmA1ofLHh00bpzXi4O/0dOGkYDWM0F2xDqoIag=;
        b=KDYW4amdUrgkDEbvJQvB5764axvtk3IutUOyVSjQWZTwTueCFWHS6hbFWVltByUJD165QI
        o4W3BnkCOnT2DeDg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 78ED9132FD;
        Sun, 12 Sep 2021 09:05:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id D5BCHeDCPWFaWQAAGKfGzw
        (envelope-from <bp@suse.de>); Sun, 12 Sep 2021 09:05:36 +0000
Date:   Sun, 12 Sep 2021 11:05:34 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sched/urgent for v5.15-rc1
Message-ID: <YT3C3lE09Yvx2e8h@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull two urgent scheduler fixes for v5.15-rc1.

Thx.

---

The following changes since commit e681dcbaa4b284454fecd09617f8b24231448446:

  sched: Fix get_push_task() vs migrate_disable() (2021-08-26 19:02:00 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v5.15_rc1

for you to fetch changes up to 868ad33bfa3bf39960982682ad3a0f8ebda1656e:

  sched: Prevent balance_push() on remote runqueues (2021-09-09 11:27:23 +0200)

----------------------------------------------------------------
- Make sure the idle timer expires in hardirq context, on PREEMPT_RT

- Make sure the run-queue balance callback is invoked only on the outgoing CPU

----------------------------------------------------------------
Sebastian Andrzej Siewior (1):
      sched/idle: Make the idle timer expire in hard interrupt context

Thomas Gleixner (1):
      sched: Prevent balance_push() on remote runqueues

 kernel/sched/core.c | 6 +++---
 kernel/sched/idle.c | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
