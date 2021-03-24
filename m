Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D2C347328
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 09:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbhCXICy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 04:02:54 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13677 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbhCXICc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 04:02:32 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F50yP2JmSznVBR;
        Wed, 24 Mar 2021 15:59:57 +0800 (CST)
Received: from hulk-robot-4.huawei.com (10.175.124.27) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Wed, 24 Mar 2021 16:02:19 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <robinmholt@gmail.com>, <steve.wahl@hpe.com>, <arnd@arndb.de>,
        <mike.travis@hpe.com>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] misc: sgi-xp: xp_main: make some symbols static
Date:   Wed, 24 Mar 2021 08:48:23 +0000
Message-ID: <20210324084823.7393-1-zou_wei@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sparse tool complains as follows:

drivers/misc/sgi-xp/xp_main.c:24:22: warning:
 symbol 'xp_dbg_name' was not declared. Should it be static?
drivers/misc/sgi-xp/xp_main.c:28:15: warning:
 symbol 'xp_dbg_subname' was not declared. Should it be static?

These symbols are not used outside of xp_main.c, so this
commit marks them static.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/misc/sgi-xp/xp_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/sgi-xp/xp_main.c b/drivers/misc/sgi-xp/xp_main.c
index cf2965aa5c05..87d156c15f35 100644
--- a/drivers/misc/sgi-xp/xp_main.c
+++ b/drivers/misc/sgi-xp/xp_main.c
@@ -21,11 +21,11 @@
 
 /* define the XP debug device structures to be used with dev_dbg() et al */
 
-struct device_driver xp_dbg_name = {
+static struct device_driver xp_dbg_name = {
 	.name = "xp"
 };
 
-struct device xp_dbg_subname = {
+static struct device xp_dbg_subname = {
 	.init_name = "",		/* set to "" */
 	.driver = &xp_dbg_name
 };
-- 
2.17.1

