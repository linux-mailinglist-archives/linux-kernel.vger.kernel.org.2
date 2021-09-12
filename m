Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD59407C7E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 11:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbhILI70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 04:59:26 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:43822 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbhILI7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 04:59:24 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 49BCF1FDAE;
        Sun, 12 Sep 2021 08:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1631437089; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=lEzmMcX5MudQpJHR4iJRAKNiHkE+rMRkwwxMwEwHvSk=;
        b=F4WkTP2MjD7OPfhk/SbkQv0yfFIjBLRYjMhg40WZPVEjt68pVVHOT0b1LkuM75V6UJBIDW
        +4NKTZuYfCe4pJa89gbHVRBHF0iCcOTnjZasw1Vu0aDZXfwJlh9OLribKkHVBgsPADU6N5
        7Z+TzalC9gv7rINWhF0Nr3qalKCM12o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1631437089;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=lEzmMcX5MudQpJHR4iJRAKNiHkE+rMRkwwxMwEwHvSk=;
        b=+WfGlchE+EO1EJ46wAZCVr/yifzi4t3ub30dQusOTFf7FLqOmGDDIKRRNyJyN8Q7x1+lb4
        LSnGfo6IHWeITHDA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 3322F132FD;
        Sun, 12 Sep 2021 08:58:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id L7YqDCHBPWFIWAAAGKfGzw
        (envelope-from <bp@suse.de>); Sun, 12 Sep 2021 08:58:09 +0000
Date:   Sun, 12 Sep 2021 10:57:56 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] timers/urgent for v5.15-rc1
Message-ID: <YT3BFM+SWiqghjKm@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a single urgent timers fix before 5.15-rc1 releases.

Thx.

---

The following changes since commit 8596e589b787732c8346f0482919e83cc9362db1:

  Merge tag 'timers-core-2021-08-30' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2021-08-30 15:31:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/timers_urgent_for_v5.15_rc1

for you to fetch changes up to 39ff83f2f6cc5cc1458dfcea9697f96338210beb:

  time: Handle negative seconds correctly in timespec64_to_ns() (2021-09-08 17:44:26 +0200)

----------------------------------------------------------------
- Handle negative second values properly when converting a timespec64 to nanoseconds.

----------------------------------------------------------------
Lukas Hannen (1):
      time: Handle negative seconds correctly in timespec64_to_ns()

 include/linux/time64.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
