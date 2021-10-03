Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2828420127
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 12:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhJCKS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 06:18:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:45696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229875AbhJCKS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 06:18:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AC1C661A05;
        Sun,  3 Oct 2021 10:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633256201;
        bh=rINtyPohnMxSn3h+VYLTlMoq+gRIQzSxEl3nEfbFUWc=;
        h=Date:From:To:Cc:Subject:From;
        b=SOpN489ht7MmcIoOM9DeFWDWDiU+fZQ4M6Xu+vPitXQIvtyozTW3zehA6w9Ww5jdA
         GxQtZADR/6+QeqKo5SJ/gu6UMwjQNRp9L57vImHNM1l9Aq2RRnCTSdmZ1QG7tZEpJ+
         1AMqUAM0DWdesKdDA7L37OFHTYMrYvIyBgX5VYJM=
Date:   Sun, 3 Oct 2021 12:16:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Subject: [GIT PULL] Driver core fixes for 5.15-rc4
Message-ID: <YVmDByRt0G36h1nC@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.15-rc4

for you to fetch changes up to df38d852c6814cbbd010d81e84efb9dc057d5ba6:

  kernfs: also call kernfs_set_rev() for positive dentry (2021-09-28 18:18:15 +0200)

----------------------------------------------------------------
Driver core fixes for 5.15-rc4

Here are some driver core and kernfs fixes for reported issues for
5.15-rc4.  These fixes include:
	- kernfs positive dentry bugfix
	- debugfs_create_file_size error path fix
	- cpumask sysfs file bugfix to preserve the user/kernel abi (has
	  been reported multiple times.)
	- devlink fixes for mdiobus devices as reported by the subsystem
	  maintainers.

Also included in here are some devlink debugging changes to make it
easier for people to report problems when asked.  They have already
helped with the mdiobus and other subsystems reporting issues.

All of these have been linux-next for a while with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Hou Tao (1):
      kernfs: also call kernfs_set_rev() for positive dentry

Nirmoy Das (1):
      debugfs: debugfs_create_file_size(): use IS_ERR to check for error

Saravana Kannan (6):
      driver core: fw_devlink: Improve handling of cyclic dependencies
      driver core: fw_devlink: Add support for FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD
      net: mdiobus: Set FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD for mdiobus parents
      driver core: Set deferred probe reason when deferred by driver core
      driver core: Create __fwnode_link_del() helper function
      driver core: Add debug logs when fwnode links are added/deleted

Tobias Klauser (1):
      cpumask: Omit terminating null byte in cpumap_print_{list,bitmask}_to_buf

 drivers/base/core.c        | 90 ++++++++++++++++++++++++++++++++--------------
 drivers/net/phy/mdio_bus.c |  4 +++
 fs/debugfs/inode.c         |  2 +-
 fs/kernfs/dir.c            |  9 +++--
 include/linux/cpumask.h    |  7 ++--
 include/linux/fwnode.h     | 11 ++++--
 6 files changed, 87 insertions(+), 36 deletions(-)
