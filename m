Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7538A32067D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 18:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhBTRlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 12:41:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhBTRlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 12:41:36 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47211C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 09:40:56 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lDWFQ-00GNvt-VM; Sat, 20 Feb 2021 17:40:53 +0000
Date:   Sat, 20 Feb 2021 17:40:52 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     syzbot <syzbot+3d2c27c2b7dc2a94814d@syzkaller.appspotmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, snovitoll@gmail.com,
        syzkaller-bugs@googlegroups.com
Subject: [git pull] work.namei stuff (v2)
Message-ID: <YDFJpF216gaPavrc@zeniv-ca.linux.org.uk>
References: <0000000000001fb73f05bb767334@google.com>
 <0000000000000ca18b05bbc556d6@google.com>
 <CAHk-=wiEBTD884i-U9DU7aDdRxXuz66Q1r-rKTiJUzZoYFgp+g@mail.gmail.com>
 <YDFJKR5uG1N+g9TL@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDFJKR5uG1N+g9TL@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of that pile is LOOKUP_CACHED series; the rest is a couple of
misc cleanups in the general area...

There's a minor bisect hazard in the end of series, and normally
I would've just folded the fix into the previous commit, but this branch is
shared with Jens' tree, with stuff on top of it in there, so that would've
required rebases outside of vfs.git.

NOTE: I'm less than thrilled by the "let's allow offloading pathwalks
to helper threads" push, but LOOKUP_CACHED is useful on its own.

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.namei

for you to fetch changes up to eacd9aa8cedeb412842c7b339adbaa0477fdd5ad:

  fix handling of nd->depth on LOOKUP_CACHED failures in try_to_unlazy* (2021-02-20 12:33:12 -0500)

----------------------------------------------------------------
Al Viro (3):
      do_tmpfile(): don't mess with finish_open()
      saner calling conventions for unlazy_child()
      fix handling of nd->depth on LOOKUP_CACHED failures in try_to_unlazy*

Jens Axboe (3):
      fs: make unlazy_walk() error handling consistent
      fs: add support for LOOKUP_CACHED
      fs: expose LOOKUP_CACHED through openat2() RESOLVE_CACHED

Steven Rostedt (VMware) (1):
      fs/namei.c: Remove unlikely of status being -ECHILD in lookup_fast()

 fs/namei.c                   | 89 ++++++++++++++++++++++----------------------
 fs/open.c                    |  6 +++
 include/linux/fcntl.h        |  2 +-
 include/linux/namei.h        |  1 +
 include/uapi/linux/openat2.h |  4 ++
 5 files changed, 56 insertions(+), 46 deletions(-)
