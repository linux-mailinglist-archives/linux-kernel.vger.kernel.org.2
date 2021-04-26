Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5915636BBB2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 00:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237138AbhDZWeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 18:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbhDZWeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 18:34:15 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3C2C061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 15:33:30 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lb9nE-008WA2-L9; Mon, 26 Apr 2021 22:33:28 +0000
Date:   Mon, 26 Apr 2021 22:33:28 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] coredump-related stuff
Message-ID: <YIc/uDc9dCe9KXq9@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Just a couple of patches this cycle; use of seek + write instead of
expanding truncate and minor header cleanup

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.coredump

for you to fetch changes up to a64b89088bb1413bb84424f0b16a4d1f9bb0e947:

  coredump.h: move CONFIG_COREDUMP-only stuff inside the ifdef (2021-03-08 10:21:11 -0500)

----------------------------------------------------------------
Al Viro (2):
      coredump: don't bother with do_truncate()
      coredump.h: move CONFIG_COREDUMP-only stuff inside the ifdef

 arch/powerpc/platforms/cell/spufs/coredump.c |  3 +-
 fs/binfmt_elf.c                              |  4 +-
 fs/binfmt_elf_fdpic.c                        |  3 +-
 fs/coredump.c                                | 72 +++++++++++++++++-----------
 include/linux/binfmts.h                      |  1 +
 include/linux/coredump.h                     | 14 +++---
 6 files changed, 54 insertions(+), 43 deletions(-)
