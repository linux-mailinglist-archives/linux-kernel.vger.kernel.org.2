Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C57F9320A96
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 14:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbhBUNeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 08:34:12 -0500
Received: from mga14.intel.com ([192.55.52.115]:52576 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229605AbhBUNeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 08:34:03 -0500
IronPort-SDR: wQEkwCk47p1eIm01MIO4RjXIGdVyY4FpTKPyCLsAcc7RyGWhJNVVeG2YxDdzkd32Xfa6crSq1U
 oGKZ0bAAT4kA==
X-IronPort-AV: E=McAfee;i="6000,8403,9901"; a="183494893"
X-IronPort-AV: E=Sophos;i="5.81,194,1610438400"; 
   d="scan'208";a="183494893"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2021 05:33:22 -0800
IronPort-SDR: SP8rIHBiCZq6y6i5GCVbCVO3AyohuYs+L5PTMUS/xIqC4roygfgiiTigjh9vaKT5NSUaiipaVG
 ED4GTSfBad+Q==
X-IronPort-AV: E=Sophos;i="5.81,194,1610438400"; 
   d="scan'208";a="389176796"
Received: from shsi6026.sh.intel.com (HELO localhost) ([10.239.147.88])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2021 05:33:20 -0800
From:   shuo.a.liu@intel.com
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Yejune Deng <yejune.deng@gmail.com>,
        Shuo Liu <shuo.a.liu@intel.com>
Subject: [PATCH RESEND] virt: acrn: Use vfs_poll() instead of f_op->poll()
Date:   Sun, 21 Feb 2021 21:33:06 +0800
Message-Id: <20210221133306.33530-1-shuo.a.liu@intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yejune Deng <yejune.deng@gmail.com>

Use a more advanced function vfs_poll() in acrn_irqfd_assign().
At the same time, modify the definition of events.

Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
---
 drivers/virt/acrn/irqfd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/virt/acrn/irqfd.c b/drivers/virt/acrn/irqfd.c
index a8766d528e29..98d6e9b18f9e 100644
--- a/drivers/virt/acrn/irqfd.c
+++ b/drivers/virt/acrn/irqfd.c
@@ -112,7 +112,7 @@ static int acrn_irqfd_assign(struct acrn_vm *vm, struct acrn_irqfd *args)
 {
 	struct eventfd_ctx *eventfd = NULL;
 	struct hsm_irqfd *irqfd, *tmp;
-	unsigned int events;
+	__poll_t events;
 	struct fd f;
 	int ret = 0;
 
@@ -158,7 +158,7 @@ static int acrn_irqfd_assign(struct acrn_vm *vm, struct acrn_irqfd *args)
 	mutex_unlock(&vm->irqfds_lock);
 
 	/* Check the pending event in this stage */
-	events = f.file->f_op->poll(f.file, &irqfd->pt);
+	events = vfs_poll(f.file, &irqfd->pt);
 
 	if (events & POLLIN)
 		acrn_irqfd_inject(irqfd);
-- 
2.28.0

