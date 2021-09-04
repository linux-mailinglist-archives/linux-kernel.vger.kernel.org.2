Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF1EB400A09
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 08:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbhIDGWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 02:22:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:38732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229994AbhIDGWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 02:22:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF05060FDC;
        Sat,  4 Sep 2021 06:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630736502;
        bh=AnObMOhI4wFcczydNxDTVYOB0X2pxVjwqd3pFHcghCk=;
        h=Date:From:To:Cc:Subject:From;
        b=ZKdmQKuz5ANdkbGym+cgNjRWrKRCAGtMYk892GPyhT/0r5T/MEAEWNLce/xMeP6Pr
         Q1fVujQuA3eWhiQ+59OUuZHXmvzovZ2slihgtuBTlRckg0s08ghhJ5pIR3FfMy2o6A
         vqhmA9bMeNqTFqOsp7M/tjZ1IKIMIIMzigkGPQ5Q=
Date:   Sat, 4 Sep 2021 08:21:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [GIT PULL] More USB changes for 5.15-rc1
Message-ID: <YTMQc8Cqjr29gelw@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 835d31d319d9c8c4eb6cac074643360ba0ecab10:

  Merge tag 'media/v5.15-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media (2021-09-01 10:34:52 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.15-rc1-2

for you to fetch changes up to 1b4f3dfb4792f03b139edf10124fcbeb44e608e6:

  Merge tag 'usb-serial-5.15-rc1' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-next (2021-09-01 20:11:41 +0200)

----------------------------------------------------------------
More USB changes for 5.15-rc1

Here are some straggler USB-serial changes for 5.15-rc1.

These were not included in the first pull request as they came in "late"
from Johan and I had missed them in my pull request earlier this week.

Nothing big in here, just some USB to serial driver updates and fixes.
All of these were in linux-next before I pulled them into my tree, and
have been in linux-next all this week from my tree with no reported
problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Greg Kroah-Hartman (2):
      Merge tag 'usb-serial-5.15-rc1-2' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-next
      Merge tag 'usb-serial-5.15-rc1' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-next

Johan Hovold (7):
      USB: serial: io_edgeport: drop unused descriptor helper
      USB: serial: cp210x: fix control-characters error handling
      USB: serial: cp210x: fix flow-control error handling
      USB: serial: cp210x: clean up control-request timeout
      USB: serial: cp210x: clean up set-chars request
      USB: serial: cp210x: clean up type detection
      USB: serial: cp210x: determine fw version for CP2105 and CP2108

Robert Marko (1):
      USB: serial: pl2303: fix GL type detection

Utkarsh Verma (1):
      USB: serial: replace symbolic permissions by octal permissions

 drivers/usb/serial/cp210x.c      | 77 +++++++++++++++++-----------------------
 drivers/usb/serial/cypress_m8.c  |  6 ++--
 drivers/usb/serial/ftdi_sio.c    |  2 +-
 drivers/usb/serial/garmin_gps.c  |  2 +-
 drivers/usb/serial/io_edgeport.c | 33 -----------------
 drivers/usb/serial/io_ti.c       |  4 +--
 drivers/usb/serial/ipaq.c        |  4 +--
 drivers/usb/serial/iuu_phoenix.c | 10 +++---
 drivers/usb/serial/pl2303.c      |  1 +
 drivers/usb/serial/sierra.c      |  2 +-
 10 files changed, 48 insertions(+), 93 deletions(-)
