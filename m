Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95BEC31B0ED
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 16:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhBNPUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 10:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhBNPUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 10:20:14 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A759EC061574;
        Sun, 14 Feb 2021 07:19:32 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lBJBH-00DuWt-74; Sun, 14 Feb 2021 15:19:27 +0000
Date:   Sun, 14 Feb 2021 15:19:27 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] sendfile fixes
Message-ID: <YCk/f0efY5OhibCn@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Making sendfile() to pipe destination do the right thing, should
make "fs/pipe: allow sendfile() to pipe again" redundant.  Sat in -next
for 3 weeks...

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.sendfile

for you to fetch changes up to b964bf53e540262f2d12672b3cca10842c0172e7:

  teach sendfile(2) to handle send-to-pipe directly (2021-01-25 23:29:36 -0500)

----------------------------------------------------------------
Al Viro (3):
      do_splice_to(): move the logics for limiting the read length in
      take the guts of file-to-pipe splice into a helper function
      teach sendfile(2) to handle send-to-pipe directly

 fs/internal.h   |  9 +++++++++
 fs/read_write.c | 19 +++++++++++++------
 fs/splice.c     | 44 ++++++++++++++++++++++++--------------------
 3 files changed, 46 insertions(+), 26 deletions(-)
