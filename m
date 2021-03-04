Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6944F32CE4D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 09:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236442AbhCDIUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 03:20:46 -0500
Received: from lucky1.263xmail.com ([211.157.147.134]:51212 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbhCDIUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 03:20:33 -0500
Received: from localhost (unknown [192.168.167.16])
        by lucky1.263xmail.com (Postfix) with ESMTP id C39EEC769A;
        Thu,  4 Mar 2021 16:17:59 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [124.126.19.250])
        by smtp.263.net (postfix) whith ESMTP id P32470T140679651546880S1614845876146115_;
        Thu, 04 Mar 2021 16:18:01 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <dc80bfafc7abf267d8c78af64f6cc592>
X-RL-SENDER: maqianga@uniontech.com
X-SENDER: maqianga@uniontech.com
X-LOGIN-NAME: maqianga@uniontech.com
X-FST-TO: arnd@arndb.de
X-SENDER-IP: 124.126.19.250
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Qiang Ma <maqianga@uniontech.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Qiang Ma <maqianga@uniontech.com>
Subject: [PATCH] char: lp: remove redundant space
Date:   Thu,  4 Mar 2021 16:17:52 +0800
Message-Id: <20210304081752.23986-1-maqianga@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two lines of code don't meet the kernel coding style,
so remove the redundant space.

Signed-off-by: Qiang Ma <maqianga@uniontech.com>
---
 drivers/char/lp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/lp.c b/drivers/char/lp.c
index 862c2fd933c7..0e22e3b0a04e 100644
--- a/drivers/char/lp.c
+++ b/drivers/char/lp.c
@@ -546,7 +546,7 @@ static int lp_open(struct inode *inode, struct file *file)
 	}
 	/* Determine if the peripheral supports ECP mode */
 	lp_claim_parport_or_block(&lp_table[minor]);
-	if ( (lp_table[minor].dev->port->modes & PARPORT_MODE_ECP) &&
+	if ((lp_table[minor].dev->port->modes & PARPORT_MODE_ECP) &&
 	     !parport_negotiate(lp_table[minor].dev->port,
 				 IEEE1284_MODE_ECP)) {
 		printk(KERN_INFO "lp%d: ECP mode\n", minor);
@@ -590,7 +590,7 @@ static int lp_do_ioctl(unsigned int minor, unsigned int cmd,
 		return -ENODEV;
 	if ((LP_F(minor) & LP_EXIST) == 0)
 		return -ENODEV;
-	switch ( cmd ) {
+	switch (cmd) {
 		case LPTIME:
 			if (arg > UINT_MAX / HZ)
 				return -EINVAL;
-- 
2.20.1



