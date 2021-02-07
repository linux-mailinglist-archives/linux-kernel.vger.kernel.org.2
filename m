Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFE9C3124A9
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 15:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbhBGOYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 09:24:53 -0500
Received: from m12-16.163.com ([220.181.12.16]:46231 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229506AbhBGOWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 09:22:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=XJ0jN4TivWmsd7Gg17
        XbglXMUAayDDaFbfvGITSxg8s=; b=QzTr/YdR/3yFM8F6z5E79i2C1wd2k0GRab
        srFQ3JanZc0PHGtz2+Jv1KCuYM8fUR73E0wu4aAt2yUKLyvx2700VJLcqBGL2yL1
        9FO++0g1CzgQgqz/fYPdOojHnncAIvVNLhdJl9P8dDkezS2gz71MNAc7F1APVW3i
        xrph+sT3w=
Received: from localhost.localdomain (unknown [223.87.231.49])
        by smtp12 (Coremail) with SMTP id EMCowABXX1tT9x9gIk8ibA--.39273S2;
        Sun, 07 Feb 2021 22:21:08 +0800 (CST)
From:   alex_luca@163.com
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Luca <alex_luca@163.com>, Zhang Kun <zhangkun@cdjrlc.com>
Subject: [PATCH] bus: bt1-apb:Fix duplicate included linux/clk.h
Date:   Sun,  7 Feb 2021 22:20:50 +0800
Message-Id: <20210207142050.23445-1-alex_luca@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: EMCowABXX1tT9x9gIk8ibA--.39273S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUjmhwUUUUU
X-Originating-IP: [223.87.231.49]
X-CM-SenderInfo: xdoh5spoxftqqrwthudrp/1tbiHh8uylSIsp-DxQABsT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Kun <zhangkun@cdjrlc.com>

Remove one of the duplicate header hlinux/clk.h which isn't necessary.

Signed-off-by: Zhang Kun <zhangkun@cdjrlc.com>
---
 drivers/bus/bt1-apb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bus/bt1-apb.c b/drivers/bus/bt1-apb.c
index b25ff941e7c7..e9e196cd9253 100644
--- a/drivers/bus/bt1-apb.c
+++ b/drivers/bus/bt1-apb.c
@@ -19,7 +19,6 @@
 #include <linux/nmi.h>
 #include <linux/of.h>
 #include <linux/regmap.h>
-#include <linux/clk.h>
 #include <linux/reset.h>
 #include <linux/time64.h>
 #include <linux/clk.h>
-- 
2.17.1


