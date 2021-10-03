Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35CCE420121
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 12:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhJCJ51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 05:57:27 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59826 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbhJCJ50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 05:57:26 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2451522250;
        Sun,  3 Oct 2021 09:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1633254939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=TRg+ipz9bZOssMftBGeIOzKLlU13uhVvMD0yXjkQMfI=;
        b=Ld8aMXj0vzo4JnIzfv/4gb7lmjtd45uyQSgj4R4hGgEhyhHt3fk63S/f2TnW0QYrUWVjUY
        MiIU85eGsZUI1/Ig/fk07uaj8SJdhZ0M4GfGru7A8dVHxKthXYs1gG9pulbNLq5skAV29l
        lKj8kJE5Jf2Q3Wufj94atGxbOYuZphc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1633254939;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=TRg+ipz9bZOssMftBGeIOzKLlU13uhVvMD0yXjkQMfI=;
        b=AbAwddRu/zEu/1elswSc9VOhHn0G2Gu2p5rZCz4vYPv/4L4iZ0I6VFwgKpDDrUH7mO/zSn
        zSbZuX6ALnxLPlDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 039AB13BFC;
        Sun,  3 Oct 2021 09:55:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gcprABt+WWH9AgAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 03 Oct 2021 09:55:38 +0000
Date:   Sun, 3 Oct 2021 11:55:33 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] perf/urgent for v5.15-rc4
Message-ID: <YVl+FSNMK3BSy9gd@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull three urgent perf fixes for v5.15.

Thx.

---

The following changes since commit e4e737bb5c170df6135a127739a9e6148ee3da82:

  Linux 5.15-rc2 (2021-09-19 17:28:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v5.15_rc4

for you to fetch changes up to f792565326825ed806626da50c6f9a928f1079c1:

  perf/core: fix userpage->time_enabled of inactive events (2021-10-01 13:57:54 +0200)

----------------------------------------------------------------
- Make sure the destroy callback is reset when a event initialization fails

- Update the event constraints for Icelake

- Make sure the active time of an event is updated even for inactive events

----------------------------------------------------------------
Anand K Mistry (1):
      perf/x86: Reset destroy callback on event init failure

Kan Liang (1):
      perf/x86/intel: Update event constraints for ICX

Song Liu (1):
      perf/core: fix userpage->time_enabled of inactive events

 arch/x86/events/core.c       |  1 +
 arch/x86/events/intel/core.c |  1 +
 include/linux/perf_event.h   |  4 +++-
 kernel/events/core.c         | 34 ++++++++++++++++++++++++++++++----
 4 files changed, 35 insertions(+), 5 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
