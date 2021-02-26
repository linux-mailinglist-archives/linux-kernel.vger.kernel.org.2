Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88B163262F1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 13:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhBZMuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 07:50:05 -0500
Received: from lucky1.263xmail.com ([211.157.147.133]:36818 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhBZMt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 07:49:58 -0500
Received: from localhost (unknown [192.168.167.235])
        by lucky1.263xmail.com (Postfix) with ESMTP id C3D59CBEB5;
        Fri, 26 Feb 2021 20:47:33 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED: 0
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [124.126.19.250])
        by smtp.263.net (postfix) whith ESMTP id P19731T140184928626432S1614343654275055_;
        Fri, 26 Feb 2021 20:47:34 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <5a97b5e13e8a8963c362dac91eb51f91>
X-RL-SENDER: zhaoxiao@uniontech.com
X-SENDER: zhaoxiao@uniontech.com
X-LOGIN-NAME: zhaoxiao@uniontech.com
X-FST-TO: tytso@mit.edu
X-SENDER-IP: 124.126.19.250
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   zhaoxiao <zhaoxiao@uniontech.com>
To:     tytso@mit.edu
Cc:     linux-kernel@vger.kernel.org, zhaoxiao <zhaoxiao@uniontech.com>
Subject: [PATCH] random: remove the redundant space for the pointer variables.
Date:   Fri, 26 Feb 2021 20:47:31 +0800
Message-Id: <20210226124731.26626-1-zhaoxiao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following pointer variables don't meet the kernel coding style,
so remove the redundant space.

Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>
---
 drivers/char/random.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 0fe9e200e4c8..bbec50b8641e 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -920,8 +920,8 @@ static int crng_slow_load(const char *cp, size_t len)
 	static unsigned char	lfsr = 1;
 	unsigned char		tmp;
 	unsigned		i, max = CHACHA_KEY_SIZE;
-	const char *		src_buf = cp;
-	char *			dest_buf = (char *) &primary_crng.state[4];
+	const char		*src_buf = cp;
+	char			*dest_buf = (char *)&primary_crng.state[4];
 
 	if (!spin_trylock_irqsave(&primary_crng.lock, flags))
 		return 0;
@@ -1855,7 +1855,7 @@ random_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
 }
 
 static __poll_t
-random_poll(struct file *file, poll_table * wait)
+random_poll(struct file *file, poll_table *wait)
 {
 	__poll_t mask;
 
-- 
2.30.1



