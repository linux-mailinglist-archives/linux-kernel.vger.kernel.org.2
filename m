Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2937E3D3C18
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 16:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235485AbhGWOP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 10:15:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:58692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235479AbhGWOP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 10:15:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 35B6160EB6;
        Fri, 23 Jul 2021 14:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627052190;
        bh=tdVOEe4kpflhW7beWGqOMTIAvaMDr4Qf1Q0gT0xUqFo=;
        h=Date:From:To:Cc:Subject:From;
        b=QsuDj4lbrdF9Nmc74q7baNhRAWgZhfZVYtBvsgG73ZdIjjh+nSNPAV3+uSjPvOubT
         /+ZK4lBlpw1lfR/Y6RV2OKmgWc2ei2uH5+SwaJzdFdcwJlzrVIaX48iEh7XaN0+UhH
         XkekibvHUmKu+G1DFP4xSHhqDVw0hVg9ZbyQHHVA=
Date:   Fri, 23 Jul 2021 16:56:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 5.14-rc3
Message-ID: <YPrYnDNc9hRmqa+z@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 2734d6c1b1a089fb593ef6a23d4b70903526fe0c:

  Linux 5.14-rc2 (2021-07-18 14:13:49 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.14-rc3

for you to fetch changes up to c453db6cd96418c79702eaf38259002755ab23ff:

  nds32: fix up stack guard gap (2021-07-21 15:51:37 +0200)

----------------------------------------------------------------
Char/Misc fixes for 5.14-rc3

Here are some small char/misc driver fixes for 5.14-rc3.

Included in here are:
	- MAINTAINERS file updates for 2 changes in different driver
	  subsystems.
	- mhi bus bugfixes
	- nds32 bugfix that resolves a reported problem.

All have been in linux-next with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Bhaumik Bhatt (2):
      bus: mhi: pci_generic: Apply no-op for wake using sideband wake boolean
      bus: mhi: core: Validate channel ID when processing command completions

Greg Kroah-Hartman (1):
      nds32: fix up stack guard gap

Jorgen Hansen (1):
      MAINTAINERS: Update for VMCI driver

Loic Poulain (1):
      bus: mhi: pci_generic: Fix inbound IPCR channel

Shuo Liu (1):
      MAINTAINERS: Change ACRN HSM driver maintainer

 MAINTAINERS                   | 10 +++++++++-
 arch/nds32/mm/mmap.c          |  2 +-
 drivers/bus/mhi/core/main.c   | 17 +++++++++++-----
 drivers/bus/mhi/pci_generic.c | 45 ++++++++++++++++++++++++++++++++++---------
 4 files changed, 58 insertions(+), 16 deletions(-)
