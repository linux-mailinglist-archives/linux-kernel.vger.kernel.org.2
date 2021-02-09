Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0262D315C5C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbhBJBfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 20:35:40 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:52571 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbhBIWG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 17:06:57 -0500
X-Originating-IP: 86.202.109.140
Received: from localhost (lfbn-lyo-1-13-140.w86-202.abo.wanadoo.fr [86.202.109.140])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 2ACA01BF204;
        Tue,  9 Feb 2021 22:05:28 +0000 (UTC)
Date:   Tue, 9 Feb 2021 23:05:27 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] I3C fixes for 5.11
Message-ID: <20210209220527.GA498175@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Here is a single compilation warning fix for v5.11.

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/fixes-for-5.11

for you to fetch changes up to 291b5c9870fc546376d69cf792b7885cd0c9c1b3:

  i3c/master/mipi-i3c-hci: Fix position of __maybe_unused in i3c_hci_of_match (2020-12-31 18:41:37 +0100)

----------------------------------------------------------------
I3C fixes for 5.11

Drivers:
 - mipi-i3c-hci: fix compilation warning with Clang

----------------------------------------------------------------
Nathan Chancellor (1):
      i3c/master/mipi-i3c-hci: Fix position of __maybe_unused in i3c_hci_of_match

 drivers/i3c/master/mipi-i3c-hci/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
