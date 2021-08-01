Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 643AF3DCE24
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 01:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbhHAXpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 19:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbhHAXpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 19:45:30 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7449AC06175F
        for <linux-kernel@vger.kernel.org>; Sun,  1 Aug 2021 16:45:22 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 917BD1F41069
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH 0/3] mtdblock: Advertise about UBI and UBI block
Date:   Sun,  1 Aug 2021 20:45:02 -0300
Message-Id: <20210801234509.18774-1-ezequiel@collabora.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard, and everyone else:

Browsing the internet for "JFFS2 mtd" results in tutorials, articles
and github.gists0 that point to mtdblock.

In fact, even the MTD wiki mentions that JFFS2
needs mtdblock to mount a rootfs:

  http://www.linux-mtd.infradead.org/faq/jffs2.html

Moreover, I suspect there may be lots of users
that still believe mtdblock is somehow needed to
mount SquashFS.

I've taken a verbose route and added a pr_warn
warning if the devices are NAND. I don't think using
NAND without UBI is too wise, and given the amount
of outdated tutorials I believe some advertising
will help.

These patches are compile-tested only, as I don't
have devices ready to test, but I can undust some
boards and do some experiments if you think it's needed.

Oh, and PS: We also need to update the wiki.

Ezequiel Garcia (3):
  mtdblock: Update old JFFS2 mention in Kconfig
  mtdblock: Add comment about UBI block devices
  mtdblock: Warn if the added for a NAND device

 drivers/mtd/Kconfig       | 10 ++++++----
 drivers/mtd/mtdblock.c    |  4 ++++
 drivers/mtd/mtdblock_ro.c |  4 ++++
 3 files changed, 14 insertions(+), 4 deletions(-)

-- 
2.32.0

