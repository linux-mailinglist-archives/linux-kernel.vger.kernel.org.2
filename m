Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8153E3A00
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 13:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbhHHLce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 07:32:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:44634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229608AbhHHLcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 07:32:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8D64D60F9E;
        Sun,  8 Aug 2021 11:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628422334;
        bh=gTlB7/oIJrcuRrwRMe5ov+m47G7mdWJJYd2dApd0NeY=;
        h=Date:From:To:Cc:Subject:From;
        b=LFy6MAOYXhAvQq0tVqQqY7R/jLeZOTkXIoTz+EArLR3NNMb3tx0R/GyN1nvbBATic
         mpOeEtxodJ3nveRkScexEK/PZq6kaRykHdEq6gTGNGDlgFSS43HCMkEomTw4szrXob
         +bHHk+xtm1emhgMUOMEsMlLgmP1gGrcUUEUaW54I=
Date:   Sun, 8 Aug 2021 13:32:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 5.14-rc5
Message-ID: <YQ/Au3O0GhQvrMc4@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ff1176468d368232b684f75e82563369208bc371:

  Linux 5.14-rc3 (2021-07-25 15:35:14 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.14-rc5

for you to fetch changes up to 6bfc5272904af6873aa6bc7cd5732552f9c6e955:

  Merge tag 'icc-5.14-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc into char-misc-linus (2021-08-03 14:10:59 +0200)

----------------------------------------------------------------
Char/Misc driver fixes for 5.14-rc5

Here are some small char/misc driver fixes for 5.14-rc5.

They resolve a few regressions that people reported:
	- acrn driver fix
	- fpga driver fix
	- interconnect tiny driver fixes

All have been in linux-next for a while with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Colin Ian King (1):
      interconnect: Fix undersized devress_alloc allocation

Greg Kroah-Hartman (2):
      Merge tag 'fpga-fixes-for-5.14' of git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga into char-misc-linus
      Merge tag 'icc-5.14-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc into char-misc-linus

Kajol Jain (1):
      fpga: dfl: fme: Fix cpu hotplug issue in performance reporting

Mike Tipton (4):
      interconnect: Zero initial BW after sync-state
      interconnect: Always call pre_aggregate before aggregate
      interconnect: qcom: icc-rpmh: Ensure floor BW is enforced for all nodes
      interconnect: qcom: icc-rpmh: Add BCMs to commit list in pre_aggregate

Shuo Liu (1):
      virt: acrn: Do hcall_destroy_vm() before resource release

 drivers/fpga/dfl-fme-perf.c          |  2 ++
 drivers/interconnect/core.c          |  9 ++++++++-
 drivers/interconnect/qcom/icc-rpmh.c | 22 ++++++++++------------
 drivers/virt/acrn/vm.c               | 16 ++++++++--------
 4 files changed, 28 insertions(+), 21 deletions(-)
