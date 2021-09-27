Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA2974194E9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 15:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234561AbhI0NSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 09:18:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234421AbhI0NSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 09:18:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C0B96103B;
        Mon, 27 Sep 2021 13:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632748586;
        bh=9bpIpSEjgHZGeH5+f9MLQYWRNrb/wOzN0Uc8dGTvIXc=;
        h=From:To:Cc:Subject:Date:From;
        b=nbGW5gnR6p34uEetecTHU1DNuwfp3IRIv4cQs6RMIkTMVfXzK59SVI+0zgt+1TvnL
         2CmcgtNz3oDs1tQAQOCWSdWo2vTboPdFe3O/H1MubHRrAYsxqMOAyFyYnaXMP/zK/q
         67DAzCV2mDv8GfRaENH1SA5GQNeUFTccY4mmtJrsjn0d9hjLijEMTGInAVfASPOMIa
         dyURFE7DHmeIYwarXWumHb0mnROr7nQ6FljlcvbuNjww7B/na2HB5Wf/wwkLJHVC6L
         ecn0BJ5B4wzxRHpfEVEVvpImD5+021Q2pvXrMAxSmf/8x0RdepcM/NL7GIoaHP+FaN
         oK3bO25sU7lTg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Isaac Hazan <isaac.hazan@intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] thunderbolt: fix -Wrestrict warning
Date:   Mon, 27 Sep 2021 15:16:11 +0200
Message-Id: <20210927131620.1587294-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

gcc-11 warns when building with W=1:

drivers/thunderbolt/xdomain.c: In function 'modalias_show':
drivers/thunderbolt/xdomain.c:733:16: error: 'sprintf' argument 3 overlaps destination object 'buf' [-Werror=restrict]
  733 |         return sprintf(buf, "%s\n", buf);
      |                ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/thunderbolt/xdomain.c:727:36: note: destination object referenced by 'restrict'-qualified argument 1 was declared here
  727 |                              char *buf)
      |                              ~~~~~~^~~

There is no need for the sprintf() here when a strcat() does
the same thing.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/thunderbolt/xdomain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
index d66ea4d616fd..eff32499610f 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -730,7 +730,7 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
 
 	/* Full buffer size except new line and null termination */
 	get_modalias(svc, buf, PAGE_SIZE - 2);
-	return sprintf(buf, "%s\n", buf);
+	return strlen(strcat(buf, "\n"));
 }
 static DEVICE_ATTR_RO(modalias);
 
-- 
2.29.2

