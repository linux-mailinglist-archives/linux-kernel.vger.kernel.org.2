Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E08C3FAB11
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 13:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235184AbhH2LVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 07:21:36 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47318 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235110AbhH2LVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 07:21:34 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0CCCB1FD7C;
        Sun, 29 Aug 2021 11:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1630236042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=lypsDn7hn5MHISBdWFK37morqbPx++FXXDM2qqQB3sQ=;
        b=eTSVR9BAGookJYJ/TY7UAJ1H6XjoCCRee1+wTdtmnPHUTJyuiAr7ZSPL8U9DljMR6Uu6vP
        KrNGl7u7tK0BhwzzYTpRSpOfiTZLSbONU3TQ1AmIAHk1zIQRdQYnVG9D+3JGdUNggJtWnJ
        Edm6Msvtp4iSmjkP6LhS9VHR9pwlGMM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1630236042;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=lypsDn7hn5MHISBdWFK37morqbPx++FXXDM2qqQB3sQ=;
        b=7kTRxFpkY+jcU/GqPJNvuFKhSrLDceNUDjz2FTALiLaku0dPHbxMPkUUhY755tr2ZfBmJO
        BRk9effDMMTIuSAA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id E82EC1371C;
        Sun, 29 Aug 2021 11:20:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 8T9VOIltK2ESbgAAGKfGzw
        (envelope-from <bp@suse.de>); Sun, 29 Aug 2021 11:20:41 +0000
Date:   Sun, 29 Aug 2021 13:21:22 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sched/urgent for v5.14
Message-ID: <YSttskpCbUeAiwTj@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I believe this should be the last pull request from the tip gang for
5.14 and we should be pretty much ready so please pull two final urgent
scheduler fixes for v5.14.

Thx.

---

The following changes since commit 7c60610d476766e128cc4284bb6349732cbd6606:

  Linux 5.14-rc6 (2021-08-15 13:40:53 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v5.14

for you to fetch changes up to e681dcbaa4b284454fecd09617f8b24231448446:

  sched: Fix get_push_task() vs migrate_disable() (2021-08-26 19:02:00 +0200)

----------------------------------------------------------------
- Have get_push_task() check whether current has migration disabled and
thus avoid useless invocations of the migration thread

- Rework initialization flow so that all rq->core's are initialized,
even of CPUs which have not been onlined yet, so that iterating over
them all works as expected

----------------------------------------------------------------
Peter Zijlstra (1):
      sched: Fix Core-wide rq->lock for uninitialized CPUs

Sebastian Andrzej Siewior (1):
      sched: Fix get_push_task() vs migrate_disable()

 kernel/sched/core.c  | 143 +++++++++++++++++++++++++++++++++++++++++----------
 kernel/sched/sched.h |   5 +-
 2 files changed, 121 insertions(+), 27 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
