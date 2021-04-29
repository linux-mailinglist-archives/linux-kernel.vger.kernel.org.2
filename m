Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13CB636EB22
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 15:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237582AbhD2NJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 09:09:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:34344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234147AbhD2NJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 09:09:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EBBC261423;
        Thu, 29 Apr 2021 13:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619701698;
        bh=9cC7e2UFjfuEVz+wmCI1a4Mh3W4r2BKyn+Qiq5LvEeU=;
        h=From:To:Cc:Subject:Date:From;
        b=wS9Ab1yQGCHz5VN0VLNo2m3Mg3BfzjkkWq2SYXWsQPWUlplnN5drXMg4C8g9BKwiq
         C3mQB/GZ0BRrMOgJLbokF2imFyvxzrfkwmvyeieZYu4omeSqKfeOncDtPXCK7W6iOo
         BFP6hUA258jW/sURX2R45iFrt6L6glDoMInzAUT4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aditya Pakki <pakki001@umn.edu>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>, Kangjie Lu <kjlu@umn.edu>,
        Mark Brown <broonie@kernel.org>, Qiushi Wu <wu000273@umn.edu>,
        Wenwen Wang <wang6495@umn.edu>
Subject: [PATCH 0/7] Second set of revertion of all of the umn.edu commits
Date:   Thu, 29 Apr 2021 15:08:04 +0200
Message-Id: <20210429130811.3353369-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like the first set of 190 patches submitted here:
	https://lore.kernel.org/r/20210421130105.1226686-1-gregkh@linuxfoundation.org

I am working through all of the patches submitted by umn.edu email
addresses.  The remaining 79 set of patches that did not automatically
revert with git were looked at, and these are the remaining ones where a
revert was actually possible.  The other 72 commits did not need to be
listed at the moment as they fell into other categories (were already
fixed, applied to files not in the tree anymore, modified such that they
were no longer relevant, etc.)

The full report of all of this audit is currently being worked on by me
and other members of the LF Technical Advisarory Board, and will be
published when completed.

This remaining set of patches is to provide a public review of them, and
to determine if they are valid or not.  If the commit was valid, I'll
drop it from my list of reverts, if the commit was not correct, I'll
keep the revert and provide a "correct" fix for the issue as well.

The final set of "reverts of bad + correct patches" will be posted to
lkml and maintainers when all of this is completed.  Hopefully sometime
next week, but I'm not promising anything :)

Maintainers, if you could take a look at these and see if the original
was a valid commit or not, that would be most appreciated.  I'll be also
doing a review of them as well.

Thanks all for your help with this unexpected extra work...

greg k-h

Greg Kroah-Hartman (7):
  Revert "rocker: fix incorrect error handling in dma_rings_init"
  Revert "rtc: mc13xxx: fix a double-unlock issue"
  Revert "orinoco: avoid assertion in case of NULL pointer"
  Revert "ethtool: fix a potential missing-check bug"
  Revert "regulator: tps65910: fix a missing check of return value"
  Revert "leds: lp5523: fix a missing check of return value of
    lp55xx_read"
  Revert "serial: max310x: pass return value of spi_register_driver"

 drivers/leds/leds-lp5523.c                          | 4 +---
 drivers/net/ethernet/rocker/rocker_main.c           | 4 ++--
 drivers/net/wireless/intersil/orinoco/orinoco_usb.c | 3 +--
 drivers/regulator/tps65910-regulator.c              | 4 +---
 drivers/rtc/rtc-mc13xxx.c                           | 4 +---
 drivers/tty/serial/max310x.c                        | 4 ++--
 net/ethtool/ioctl.c                                 | 5 -----
 7 files changed, 8 insertions(+), 20 deletions(-)

-- 
2.31.1

