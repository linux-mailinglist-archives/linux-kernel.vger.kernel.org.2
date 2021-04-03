Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE90353381
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 12:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236575AbhDCK4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 06:56:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:52182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236663AbhDCKwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 06:52:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3598461006;
        Sat,  3 Apr 2021 10:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617447136;
        bh=DR1meucXrSCf66dg/QryAHxqWv3Np7BtpEkwjy6hXUc=;
        h=Date:From:To:Cc:Subject:From;
        b=JSS259HReKcpgwjskz3KbN+Xu2V9iKfKDOk5YeZ3kyQOJKEHezYSMEvrXSZOyN0Xf
         9T6/zLO2CqmNDN4X63Vh2mVBPTT29kloNywquzrq8LGPm3YeRDwpg7KyQXMi/TXYyW
         JFuML45Ks6E7T1DJo5agy1+i4ZCP9nodtbKKn4cs=
Date:   Sat, 3 Apr 2021 12:52:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 5.12-rc6
Message-ID: <YGhI3oAZas6R5jQ8@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 1e28eed17697bcf343c6743f0028cc3b5dd88bf0:

  Linux 5.12-rc3 (2021-03-14 14:41:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.12-rc6

for you to fetch changes up to 3756b6578709c55819742f6ba0c18f93e8901397:

  Merge tag 'icc-5.12-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc into char-misc-linus (2021-03-27 12:39:18 +0100)

----------------------------------------------------------------
Char/Misc driver fixes for 5.12-rc6

Here are a few small driver char/misc changes for 5.12-rc6.

Nothing major here, a few fixes for reported issues:
	- interconnect fixes for problems found
	- fbcon syzbot-found fix
	- extcon fixes
	- firmware stratix10 bugfix
	- MAINTAINERS file update.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Benjamin Li (1):
      interconnect: qcom: msm8939: remove rpm-ids from non-RPM nodes

Dinghao Liu (1):
      extcon: Fix error handling in extcon_dev_register

Du Cheng (1):
      drivers: video: fbcon: fix NULL dereference in fbcon_cursor()

Georgi Djakov (1):
      interconnect: Fix kerneldoc warning

Greg Kroah-Hartman (3):
      Merge tag 'extcon-fixes-for-5.12-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon into char-misc-next
      Merge tag 'fpga-fixes-for-5.12' of git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga into char-misc-linus
      Merge tag 'icc-5.12-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc into char-misc-linus

Jia-Ju Bai (1):
      interconnect: core: fix error return code of icc_link_destroy()

Krzysztof Kozlowski (1):
      extcon: Add stubs for extcon_register_notifier_all() functions

Richard Gong (1):
      firmware: stratix10-svc: reset COMMAND_RECONFIG_FLAG_PARTIAL to 0

Tomas Winkler (1):
      mei: allow map and unmap of client dma buffer only for disconnected client

Vinod Koul (1):
      MAINTAINERS: Add linux-phy list and patchwork

 MAINTAINERS                                        |  3 ++-
 drivers/extcon/extcon.c                            |  1 +
 drivers/interconnect/bulk.c                        |  2 +-
 drivers/interconnect/core.c                        |  2 ++
 drivers/interconnect/qcom/msm8939.c                | 16 +++++++--------
 drivers/misc/mei/client.c                          | 17 +++++++---------
 drivers/video/fbdev/core/fbcon.c                   |  3 +++
 include/linux/extcon.h                             | 23 ++++++++++++++++++++++
 .../linux/firmware/intel/stratix10-svc-client.h    |  2 +-
 9 files changed, 48 insertions(+), 21 deletions(-)
