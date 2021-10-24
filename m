Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D264438819
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 11:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbhJXJuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 05:50:35 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59900 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbhJXJue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 05:50:34 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8783D2195A;
        Sun, 24 Oct 2021 09:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1635068893; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=GYOWGK3M7uzDDWFGZxvCDvOYGUknISGvw68MIBiyJ3I=;
        b=t7qDbM3HM5+IhFtRWBvlgwacNponznKJzMFcFLR1CiIabjzRkgmzEvYq5sCkDXIcd7ijs8
        +t8Oj7KUxoqUP90ofYu1QfEcOqaJc9FepNLnGoaf/Q8MhE0Wfqz0oz4Pnj5Nsiex5JXBSU
        GpCBbw02xi0dBaY8BUZpv13/YwRHYS8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1635068893;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=GYOWGK3M7uzDDWFGZxvCDvOYGUknISGvw68MIBiyJ3I=;
        b=xO9Pi27e2sIgoo5S2Zo8ywkLetR005qrFGaZsyYZS0CqU8c/uIYlo00N3NczYuR5ObBr98
        8yt+eqTpuDkTHyDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 70BF413310;
        Sun, 24 Oct 2021 09:48:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6R4hG90rdWFGPgAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 24 Oct 2021 09:48:13 +0000
Date:   Sun, 24 Oct 2021 11:48:14 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sched/urgent for v5.15-rc7
Message-ID: <YXUr3ouAhEJ2Ppi0@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a single urgent scheduler fix for 5.15.

Thx.

---

The following changes since commit 519d81956ee277b4419c723adfb154603c2565ba:

  Linux 5.15-rc6 (2021-10-17 20:00:13 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v5.15_rc7

for you to fetch changes up to 63acd42c0d4942f74710b11c38602fb14dea7320:

  sched/scs: Reset the shadow stack when idle_task_exit (2021-10-19 17:46:11 +0200)

----------------------------------------------------------------
- Reset clang's Shadow Call Stack on hotplug to prevent it from overflowing

----------------------------------------------------------------
Woody Lin (1):
      sched/scs: Reset the shadow stack when idle_task_exit

 kernel/sched/core.c | 1 +
 1 file changed, 1 insertion(+)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
