Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 756F3420132
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 12:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhJCK3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 06:29:33 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:49440 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbhJCK3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 06:29:32 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6DB061FD72;
        Sun,  3 Oct 2021 10:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1633256864; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=8UhOFT4TtNoV6131LD76uhrp7Bp8KgbC35ipQqLW7YE=;
        b=WUpIKzC4O/lZ6sCP2KqjswtM2R2lah0UqNPJs58v7OAO2VhC15NiGVlYORmqz/HmtD7jqg
        xffOEXX3i6KmS6HoMW13BV+9ThsMxDe3q5bQvpa2jW+CFM8VYiaUThVJw9jXNV5sRwFz34
        zn5mJLBgRrmT1oTlqFKGCaY7OAwl7lQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1633256864;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=8UhOFT4TtNoV6131LD76uhrp7Bp8KgbC35ipQqLW7YE=;
        b=IVf6rgMD+aiW6bSHKuIlQRxVftGQSuoGo7F1tbQqK5e6amNW7p0Wbs96k0nO9FV0WLdqsZ
        JnqsC96fviJu0wCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 599A613C00;
        Sun,  3 Oct 2021 10:27:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id frh+FaCFWWFgDAAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 03 Oct 2021 10:27:44 +0000
Date:   Sun, 3 Oct 2021 12:27:37 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sched/urgent for v5.15-rc4
Message-ID: <YVmFmV/BDpXrn/yw@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull three urgent fixes to scheduler land, for v5.15.

Thx.

---

The following changes since commit e4e737bb5c170df6135a127739a9e6148ee3da82:

  Linux 5.15-rc2 (2021-09-19 17:28:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v5.15_rc4

for you to fetch changes up to 83d40a61046f73103b4e5d8f1310261487ff63b0:

  sched: Always inline is_percpu_thread() (2021-10-01 13:57:57 +0200)

----------------------------------------------------------------
- Tell the compiler to always inline is_percpu_thread()

- Make sure tunable_scaling buffer is null-terminated after an update in sysfs

- Fix LTP named regression due to cgroup list ordering

----------------------------------------------------------------
Mel Gorman (1):
      sched/fair: Null terminate buffer when updating tunable_scaling

Michal Koutný (1):
      sched/fair: Add ancestors of unthrottled undecayed cfs_rq

Peter Zijlstra (1):
      sched: Always inline is_percpu_thread()

 include/linux/sched.h | 2 +-
 kernel/sched/debug.c  | 8 +++++++-
 kernel/sched/fair.c   | 6 +++++-
 3 files changed, 13 insertions(+), 3 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
