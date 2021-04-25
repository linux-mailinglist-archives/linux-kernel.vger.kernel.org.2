Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2CD36A61E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 11:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbhDYJkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 05:40:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:44722 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229485AbhDYJkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 05:40:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C7076AF79;
        Sun, 25 Apr 2021 09:39:28 +0000 (UTC)
Date:   Sun, 25 Apr 2021 11:39:31 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] locking/urgent for v5.12
Message-ID: <YIU4005K55S20FU1@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull one urgent locking fix for 5.12.

Thx.

---

The following changes since commit d434405aaab7d0ebc516b68a8fc4100922d7f5ef:

  Linux 5.12-rc7 (2021-04-11 15:16:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/locking_urgent_for_v5.12

for you to fetch changes up to 84a24bf8c52e66b7ac89ada5e3cfbe72d65c1896:

  locking/qrwlock: Fix ordering in queued_write_lock_slowpath() (2021-04-17 13:40:50 +0200)

----------------------------------------------------------------
- Fix ordering in the queued writer lock's slowpath.

----------------------------------------------------------------
Ali Saidi (1):
      locking/qrwlock: Fix ordering in queued_write_lock_slowpath()

 kernel/locking/qrwlock.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
