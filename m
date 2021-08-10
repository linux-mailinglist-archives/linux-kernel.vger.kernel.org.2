Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E08F3E5BB9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 15:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241379AbhHJNcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 09:32:46 -0400
Received: from smtpbg126.qq.com ([106.55.201.22]:14341 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241323AbhHJNco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 09:32:44 -0400
X-QQ-mid: bizesmtp34t1628602305the7cwzb
Received: from localhost.localdomain (unknown [171.223.97.227])
        by esmtp6.qq.com (ESMTP) with 
        id ; Tue, 10 Aug 2021 21:31:44 +0800 (CST)
X-QQ-SSF: 01000000004000B0C000B00A0000000
X-QQ-FEAT: +tn22CAhD2kaX1sEDvhOy6vLyfS0JdCaMR18D85vKzCRR9KqPomsaL4fIAJWL
        TkDKxlk0UGiSm6uzt7Xmr8KyfJ9675LA8K32aV86+6QoBdN67C/2xjYxUzASCq/iQab6ibL
        seIoVTN7TY26uwsKInkpqMiBUSABCesfw+l5/XIMYh+74/c5jmYBRk+NFjJRHlNmUJFo3yj
        rCuj2LaJQk+Yia5MWqESJKOGOI33p2FV7cu5cLeVbqLXbyZpw0SVy62sx/o7w+3nx2RZOtj
        0TbHRmyXWuCWoAixZ0EbyizKti5XgLErGIiXYI2wSkhmx7RF2cFrZ7uL4aThaFspF718e/K
        qpF13vqjYkbBUGlMglTeTLOfkSVCcV/hRWvIGeO
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     wens@csie.org
Cc:     mripard@kernel.org, linux@armlinux.org.uk,
        jernej.skrabec@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] ARM: sunxi: Add a missing SPDX license header
Date:   Tue, 10 Aug 2021 21:31:38 +0800
Message-Id: <20210810133138.109309-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing SPDX license header to arch/arm/mach-sunxi/platsmp.c.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/arm/mach-sunxi/platsmp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-sunxi/platsmp.c b/arch/arm/mach-sunxi/platsmp.c
index bdde9ef3aaa9..052097e78e6e 100644
--- a/arch/arm/mach-sunxi/platsmp.c
+++ b/arch/arm/mach-sunxi/platsmp.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * SMP support for Allwinner SoCs
  *
@@ -8,9 +9,6 @@
  * Based on code
  *  Copyright (C) 2012-2013 Allwinner Ltd.
  *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
  */
 
 #include <linux/delay.h>
-- 
2.32.0

