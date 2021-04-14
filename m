Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A500035EB12
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 04:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbhDNCpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 22:45:09 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:34427 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229845AbhDNCpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 22:45:06 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=teawaterz@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UVVg1xZ_1618368278;
Received: from localhost(mailfrom:teawaterz@linux.alibaba.com fp:SMTPD_---0UVVg1xZ_1618368278)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 14 Apr 2021 10:44:44 +0800
From:   Hui Zhu <teawater@gmail.com>
To:     wufengguang@huawei.com, linux-kernel@vger.kernel.org
Cc:     Hui Zhu <teawater@antfin.com>
Subject: [PATCH for vm-scalability] usemem: Output a message after punch holes done
Date:   Wed, 14 Apr 2021 10:44:36 +0800
Message-Id: <20210414024436.30128-1-teawater@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hui Zhu <teawater@antfin.com>

When I use punch holes to setup a test page fragmentation environment, I
didn't know when the punch holes done.  I can only get this information
through top or something else.

This commit add code to output a message after punch holes done to
handle this issue.

Signed-off-by: Hui Zhu <teawater@antfin.com>
---
 usemem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/usemem.c b/usemem.c
index 5b90aae..0c76d17 100644
--- a/usemem.c
+++ b/usemem.c
@@ -791,6 +791,8 @@ long do_units(void)
 			for (i = 0; i < nptr; i++)
 				do_punch_holes(ptrs[i], lens[i]);
 		}
+		printf("punch holes done\n");
+		fflush(stdout);
 	}
 
 	while (sleep_secs)
-- 
1.8.3.1

