Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52EE844F772
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 11:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbhKNKoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 05:44:14 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:60490 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhKNKoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 05:44:13 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 74217218F8;
        Sun, 14 Nov 2021 10:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1636886477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=iU5slcwCQ68RGH/2AEVrOEZJGgHITjS4jmghf8+gUek=;
        b=J55S4VHqrIqGjwAOXz15X3eSKPH51w0w7dQv0J6Z7wFrWLM+V+ggmBmpWVX4Oa0Lue3bCw
        xlN+07ygmcJ2LWSLmh+vHZbJFUjg0GenP7m0RkHQLh9OWvMRIMGdgdUHjwMij2AquggcoI
        Z/HEb6HSOuh5A+1ty+fj0ezHd+Q829E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1636886477;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=iU5slcwCQ68RGH/2AEVrOEZJGgHITjS4jmghf8+gUek=;
        b=mKX7t5QKWbytq6G4jI39uxEw5NwGBFuYr4l4T++ZHIrbYO5txbYjytGpY7p76A3+y7W6W8
        2E0WmpW1xbYtEEBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5F7351348A;
        Sun, 14 Nov 2021 10:41:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LeHWFs3nkGEvKgAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 14 Nov 2021 10:41:17 +0000
Date:   Sun, 14 Nov 2021 11:41:10 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] perf/urgent for v5.16-rc1
Message-ID: <YZDnxpLswv1HwBaz@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a couple of perf/urgent fixes before v5.16-rc1 releases.

Thx.

---

The following changes since commit debe436e77c72fcee804fb867f275e6d31aa999c:

  Merge tag 'ext4_for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4 (2021-11-10 17:05:37 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v5.16_rc1

for you to fetch changes up to 4716023a8f6a0f4a28047f14dd7ebdc319606b84:

  perf/core: Avoid put_page() when GUP fails (2021-11-11 13:09:34 +0100)

----------------------------------------------------------------
- Prevent unintentional page sharing by checking whether a page
reference to a PMU samples page has been acquired properly before that

- Make sure the LBR_SELECT MSR is saved/restored too

- Reset the LBR_SELECT MSR when resetting the LBR PMU to clear any
residual data left

----------------------------------------------------------------
Greg Thelen (1):
      perf/core: Avoid put_page() when GUP fails

Like Xu (1):
      perf/x86/vlbr: Add c->flags to vlbr event constraints

Wanpeng Li (1):
      perf/x86/lbr: Reset LBR_SELECT during vlbr reset

 arch/x86/events/intel/core.c |  4 +++-
 arch/x86/events/intel/lbr.c  |  2 ++
 kernel/events/core.c         | 10 +++++-----
 3 files changed, 10 insertions(+), 6 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
