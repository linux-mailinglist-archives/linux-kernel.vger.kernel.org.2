Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 133EA376AB6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 21:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhEGTbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 15:31:20 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:54825 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbhEGTbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 15:31:16 -0400
X-Originating-IP: 90.65.108.55
Received: from localhost (lfbn-lyo-1-1676-55.w90-65.abo.wanadoo.fr [90.65.108.55])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id C485C20003;
        Fri,  7 May 2021 19:30:15 +0000 (UTC)
Date:   Fri, 7 May 2021 21:30:15 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] I3C changes for 5.13
Message-ID: <YJWVRyqnPVlz5vY5@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Here is the I3C pull request for 5.13. Only three fixes this cycle.

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-5.13

for you to fetch changes up to 0d95f41ebde40d552bb4fea64b1d618607915fd6:

  Revert "i3c master: fix missing destroy_workqueue() on error in i3c_master_register" (2021-04-24 22:21:01 +0200)

----------------------------------------------------------------
I3C for 5.13

Subsystem:
 - Fix i3c_master_register error path.

----------------------------------------------------------------
Colin Ian King (1):
      i3c: master: svc: remove redundant assignment to cmd->read_len

Jae Hyun Yoo (1):
      Revert "i3c master: fix missing destroy_workqueue() on error in i3c_master_register"

Rob Herring (1):
      dt-bindings: i3c: Fix silvaco,i3c-master-v1 compatible string

 Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml | 2 +-
 drivers/i3c/master.c                                          | 5 +----
 drivers/i3c/master/svc-i3c-master.c                           | 1 -
 3 files changed, 2 insertions(+), 6 deletions(-)

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

