Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71BBD37549A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 15:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbhEFNWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 09:22:06 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:6871 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233444AbhEFNWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 09:22:02 -0400
X-Greylist: delayed 456 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 May 2021 09:22:01 EDT
Received: from spf.mail.chinamobile.com (unknown[172.16.121.19]) by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee26093ec76f4c-a2182; Thu, 06 May 2021 21:17:43 +0800 (CST)
X-RM-TRANSID: 2ee26093ec76f4c-a2182
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.22.251.0])
        by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea6093ec73c9f-b0b67;
        Thu, 06 May 2021 21:17:42 +0800 (CST)
X-RM-TRANSID: 2eea6093ec73c9f-b0b67
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH] ASoc: Fix unused define in jz4740-i2s.h
Date:   Thu,  6 May 2021 21:18:33 +0800
Message-Id: <20210506131833.27420-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete unused define of JZ4740_I2S_BIT_CLK, because it is unused
in any files.

Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 sound/soc/jz4740/jz4740-i2s.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.h b/sound/soc/jz4740/jz4740-i2s.h
index 44f120160..4da14eac1 100644
--- a/sound/soc/jz4740/jz4740-i2s.h
+++ b/sound/soc/jz4740/jz4740-i2s.h
@@ -7,6 +7,4 @@
 #define JZ4740_I2S_CLKSRC_EXT 0
 #define JZ4740_I2S_CLKSRC_PLL 1
 
-#define JZ4740_I2S_BIT_CLK		0
-
 #endif
-- 
2.20.1.windows.1



