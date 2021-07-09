Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFE4F3C2BAB
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 01:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbhGIXhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 19:37:23 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:53439 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbhGIXhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 19:37:23 -0400
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 9B909240003;
        Fri,  9 Jul 2021 23:34:37 +0000 (UTC)
Date:   Sat, 10 Jul 2021 01:34:37 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] I3C changes for 5.14
Message-ID: <YOjdDda7QIQOmR74@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Here is the I3C pull request for 5.14. Only two non-urgent fixes this cycle.

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-5.14

for you to fetch changes up to 3e5feb11a82945c88a1518fd2682ca8de66c37d3:

  i3c: master: svc: fix doc warning in svc-i3c-master.c (2021-06-09 02:02:45 +0200)

----------------------------------------------------------------
I3C for 5.14

Drivers:
 - svc: two small fixes

----------------------------------------------------------------
Yang Yingliang (2):
      i3c: master: svc: drop free_irq of devm_request_irq allocated irq
      i3c: master: svc: fix doc warning in svc-i3c-master.c

 drivers/i3c/master/svc-i3c-master.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
