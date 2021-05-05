Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C7B37356C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 09:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbhEEHRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 03:17:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:46250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231530AbhEEHQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 03:16:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99EC461182;
        Wed,  5 May 2021 07:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620198883;
        bh=NOCLPCGSDszziLl/ZTU726sXTwkD28Tc4E0pcvGwF4Q=;
        h=Date:From:To:Cc:Subject:From;
        b=lNHOENVBn/M3fHhcQ8NL3Xkln+ldmcT1JSXHLCJgzAgsjBf3gkPM3mcBUTNVYRzXN
         iY3gX1h1O39c21VbKvg8jAw3sa/puUVNJ1uiaYm8Vw9FP1YsIqyxBV+k+fqCRIWn7y
         RejtrHmT1kpp/TeqSxrFDRIp3u/+wNmnJYIPGDUY=
Date:   Wed, 5 May 2021 09:14:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 5.13-rc1
Message-ID: <YJJF4O/Ztpw5PQbK@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 8e3a3249502d8ff92d73d827fb41dd44c5a16f76:

  Merge tag 'char-misc-5.13-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc (2021-04-26 11:03:17 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.13-rc1-round2

for you to fetch changes up to 7b1ae248279bea33af9e797a93c35f49601cb8a0:

  dyndbg: fix parsing file query without a line-range suffix (2021-04-30 07:43:20 +0200)

----------------------------------------------------------------
Char/Misc fixes for 5.13-rc1

Here are 2 char/misc fixes for 5.13-rc1 to resolve reported issues.

The first is a bugfix for the nitro_enclaves driver that fixed some
important problems.  The second was a dyndbg bugfix that resolved some
reported problems in dynamic debugging control.

Both have been in linux-next for a while with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Mathias Krause (1):
      nitro_enclaves: Fix stale file descriptors on failed usercopy

Shuo Chen (1):
      dyndbg: fix parsing file query without a line-range suffix

 drivers/virt/nitro_enclaves/ne_misc_dev.c | 43 ++++++++++++-------------------
 lib/dynamic_debug.c                       |  2 +-
 2 files changed, 18 insertions(+), 27 deletions(-)
