Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F144434607
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 09:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhJTHqU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 20 Oct 2021 03:46:20 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:35724 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhJTHqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 03:46:19 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id A451960F6B67;
        Wed, 20 Oct 2021 09:44:03 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 4QEm0mEuHRPv; Wed, 20 Oct 2021 09:44:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id F41D860F6B6A;
        Wed, 20 Oct 2021 09:44:01 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dXwyZmJQ0YJk; Wed, 20 Oct 2021 09:44:01 +0200 (CEST)
Received: from blindfold.corp.sigma-star.at (unknown [82.150.214.1])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 81A7360F6B67;
        Wed, 20 Oct 2021 09:44:01 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        hch@lst.de
Subject: [PATCH] MAINTAINERS: Remove joern@lazybastard.org
Date:   Wed, 20 Oct 2021 09:43:28 +0200
Message-Id: <20211020074328.20072-1-richard@nod.at>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joern's mail bounces and nobody knows where to find thim
these days.
So remove him from MAINTAINERS.

Cc: hch@lst.de
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 MAINTAINERS | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0590fe14b3bc..08e005468b11 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3318,12 +3318,6 @@ F:	include/linux/blk*
 F:	kernel/trace/blktrace.c
 F:	lib/sbitmap.c
 
-BLOCK2MTD DRIVER
-M:	Joern Engel <joern@lazybastard.org>
-L:	linux-mtd@lists.infradead.org
-S:	Maintained
-F:	drivers/mtd/devices/block2mtd.c
-
 BLUETOOTH DRIVERS
 M:	Marcel Holtmann <marcel@holtmann.org>
 M:	Johan Hedberg <johan.hedberg@gmail.com>
@@ -14734,12 +14728,6 @@ F:	include/net/phonet/
 F:	include/uapi/linux/phonet.h
 F:	net/phonet/
 
-PHRAM MTD DRIVER
-M:	Joern Engel <joern@lazybastard.org>
-L:	linux-mtd@lists.infradead.org
-S:	Maintained
-F:	drivers/mtd/devices/phram.c
-
 PICOLCD HID DRIVER
 M:	Bruno Prémont <bonbons@linux-vserver.org>
 L:	linux-input@vger.kernel.org
-- 
2.26.2

