Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D68293123B2
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 11:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbhBGK5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 05:57:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:50568 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229445AbhBGK5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 05:57:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D5867AD6A;
        Sun,  7 Feb 2021 10:57:00 +0000 (UTC)
Date:   Sun, 7 Feb 2021 11:56:58 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] timers/urgent for v5.11-rc7
Message-ID: <20210207105658.GB32127@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull two more timers-related fixes for v5.11.

Thx.

---

The following changes since commit 211e5db19d15a721b2953ea54b8f26c2963720eb:

  rtc: mc146818: Detect and handle broken RTCs (2021-01-27 09:36:22 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/timers_urgent_for_v5.11_rc7

for you to fetch changes up to 24c242ec7abb3d21fa0b1da6bb251521dc1717b5:

  ntp: Use freezable workqueue for RTC synchronization (2021-02-05 18:03:13 +0100)

----------------------------------------------------------------
- Use a freezable workqueue for RTC sync because the sync can happen at any time
and trigger suspend assertion checks in the i2c subsystem.

- Correct a previous RTC validation change to check only bit 6 in register D
because some Intel machines use bits 0-5.

----------------------------------------------------------------
Geert Uytterhoeven (1):
      ntp: Use freezable workqueue for RTC synchronization

Thomas Gleixner (1):
      rtc: mc146818: Dont test for bit 0-5 in Register D

 drivers/rtc/rtc-cmos.c         | 4 ++--
 drivers/rtc/rtc-mc146818-lib.c | 4 ++--
 kernel/time/ntp.c              | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
