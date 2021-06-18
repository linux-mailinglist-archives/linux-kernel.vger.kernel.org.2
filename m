Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33EC73AC8E3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 12:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbhFRKeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 06:34:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:47954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232880AbhFRKel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 06:34:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 17FD7613D1;
        Fri, 18 Jun 2021 10:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624012351;
        bh=fmuksRjjlfbWGZWj9ssWyfsZV5V6RiJXO+W+xbQyJbg=;
        h=Date:From:To:Cc:Subject:From;
        b=2Z+HIO16TWPspgi6vsv6iGuabfV9jqnxt9b5bp2B9XG8Qfdi23BwWIxIYkWdB/+10
         rVKNzHVBBCrTOZdGS49qsCTkO9TSlEpIyUMqhdgrZa7muM3f6fOTaOQhHmsmzI/uob
         bm1poQttpscLoy9zJ2ZWqeHGqOPRc8/3NvhkM7FU=
Date:   Fri, 18 Jun 2021 12:32:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 5.13-rc7
Message-ID: <YMx2NueY1Eu9ZECV@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 009c9aa5be652675a06d5211e1640e02bbb1c33d:

  Linux 5.13-rc6 (2021-06-13 14:43:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.13-rc7

for you to fetch changes up to a7d8d1c7a7f73e780aa9ae74926ae5985b2f895f:

  usb: core: hub: Disable autosuspend for Cypress CY7C65632 (2021-06-17 15:34:21 +0200)

----------------------------------------------------------------
USB fixes for 5.13-rc7

Here are 3 small USB fixes for reported problems for 5.13-rc7.  They
include:
	- disabling autosuspend for a cypress USB hub
	- fixing the battery charger detection for the chipidea driver
	- fixing a kernel panic in the dwc3 driver due to a previous
	  change in 5.13-rc1.

All have been in linux-next with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andrew Lunn (1):
      usb: core: hub: Disable autosuspend for Cypress CY7C65632

Breno Lima (1):
      usb: chipidea: imx: Fix Battery Charger 1.2 CDP detection

Greg Kroah-Hartman (1):
      Merge tag 'usb-v5.13-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/peter.chen/usb into usb-linus

Peter Chen (1):
      usb: dwc3: core: fix kernel panic when do reboot

 drivers/usb/chipidea/usbmisc_imx.c | 16 ++++++++++++++--
 drivers/usb/core/hub.c             |  7 +++++++
 drivers/usb/dwc3/core.c            |  2 +-
 3 files changed, 22 insertions(+), 3 deletions(-)
