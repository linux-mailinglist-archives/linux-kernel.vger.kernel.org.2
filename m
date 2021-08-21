Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB783F3B56
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 18:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234707AbhHUQCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 12:02:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:33276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232241AbhHUQCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 12:02:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B2C761207;
        Sat, 21 Aug 2021 16:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629561681;
        bh=WePY85F/oodyHxze3GzmygVKpRUvQpEBmC67xVfk9ds=;
        h=Date:From:To:Cc:Subject:From;
        b=BdbQYy+Qws2azBbhGL+S6QKeXQgRkgbknbxS4TRBAdwbSdqN8KaXYSwcrdqBl5lkJ
         +PdQ3ENVFQRgD9ojYv8RCWAQ/SUnh2Bz2Y00t7a6hOJujQUd58Jb+LTl8XgyjtINBJ
         mr/BGJra1QCEiWTjwCqM1gc63OEQ+11mx+NH1594=
Date:   Sat, 21 Aug 2021 18:01:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 5.14-rc7
Message-ID: <YSEjTuxs84bqTkCe@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 36a21d51725af2ce0700c6ebcb6b9594aac658a6:

  Linux 5.14-rc5 (2021-08-08 13:49:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.14-rc7

for you to fetch changes up to d30836a9528906ee9d42b7cd59108f3bb4e16b01:

  Merge tag 'icc-5.14-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc into char-misc-linus (2021-08-15 11:21:02 +0200)

----------------------------------------------------------------
Char/Misc driver fixes for 5.14-rc7

Here are some small driver fixes for 5.14-rc7.

They consist of:
	- revert for an interconnect patch that was found to have
	  problems.
	- ipack tpci200 driver fixes for reported problems
	- slimbus messaging and ngd fixes for reported problems.

All are small and have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Dongliang Mu (2):
      ipack: tpci200: fix many double free issues in tpci200_pci_probe
      ipack: tpci200: fix memory leak in the tpci200_register

Georgi Djakov (1):
      Revert "interconnect: qcom: icc-rpmh: Add BCMs to commit list in pre_aggregate"

Greg Kroah-Hartman (1):
      Merge tag 'icc-5.14-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc into char-misc-linus

Srinivas Kandagatla (4):
      slimbus: messaging: start transaction ids from 1 instead of zero
      slimbus: messaging: check for valid transaction id
      slimbus: ngd: set correct device for pm
      slimbus: ngd: reset dma setup during runtime pm

 drivers/interconnect/qcom/icc-rpmh.c | 10 +++---
 drivers/ipack/carriers/tpci200.c     | 60 +++++++++++++++++++-----------------
 drivers/slimbus/messaging.c          |  7 +++--
 drivers/slimbus/qcom-ngd-ctrl.c      | 22 +++++++------
 4 files changed, 54 insertions(+), 45 deletions(-)
