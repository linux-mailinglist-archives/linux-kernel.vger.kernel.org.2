Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCA84307B7
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 12:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245287AbhJQKJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 06:09:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:40074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241780AbhJQKI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 06:08:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1002361027;
        Sun, 17 Oct 2021 10:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634465209;
        bh=Gwm5E436OHpLTj5lYxf4kealrJMu/eFgCtB5F7y0UNg=;
        h=Date:From:To:Cc:Subject:From;
        b=IGBP1OELIyevzPCk5lg5rPggCNhQUsLBxrX+iofhiOolY1of1n4NSxHedINWMTP0L
         /vXeUEYorNyXIs0PEZEGJ0iorhTz/CxbjdyEM6v0Jhb9AuyA/aCf+AFXgEtN6/9Ax0
         SZWffyc4OFAfPhjOJ8IFlAc9Zl8M3sBiZuET3aVo=
Date:   Sun, 17 Oct 2021 12:06:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Subject: [GIT PULL] Driver core fixes for 5.15-rc6
Message-ID: <YWv1tz7ZCDOtebFE@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 9e1ff307c779ce1f0f810c7ecce3d95bbae40896:

  Linux 5.15-rc4 (2021-10-03 14:08:47 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.15-rc6

for you to fetch changes up to 81967efb5f3966e8692f9173c7fa2964034ece5d:

  drivers: bus: Delete CONFIG_SIMPLE_PM_BUS (2021-10-05 17:47:22 +0200)

----------------------------------------------------------------
Driver core fixes for 5.15-rc6

Here are some small driver core fixes for 5.15-rc6, all of which have
been in linux-next for a while with no reported issues.

They include:
	- kernfs negative dentry bugfix
	- simple pm bus fixes to resolve reported issues

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Ian Kent (1):
      kernfs: don't create a negative dentry if inactive node exists

Saravana Kannan (3):
      driver core: Reject pointless SYNC_STATE_ONLY device links
      drivers: bus: simple-pm-bus: Add support for probing simple bus only devices
      drivers: bus: Delete CONFIG_SIMPLE_PM_BUS

 arch/arm/configs/multi_v7_defconfig |  1 -
 arch/arm/configs/oxnas_v6_defconfig |  1 -
 arch/arm/configs/shmobile_defconfig |  1 -
 arch/arm/mach-omap2/Kconfig         |  1 -
 arch/arm64/configs/defconfig        |  1 -
 drivers/base/core.c                 |  3 ++-
 drivers/bus/Kconfig                 | 12 -----------
 drivers/bus/Makefile                |  2 +-
 drivers/bus/simple-pm-bus.c         | 42 ++++++++++++++++++++++++++++++++++---
 drivers/soc/canaan/Kconfig          |  1 -
 fs/kernfs/dir.c                     |  9 +++++++-
 11 files changed, 50 insertions(+), 24 deletions(-)
