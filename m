Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3023D8E17
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 14:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236194AbhG1MoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 08:44:02 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:9105 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234759AbhG1Mn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 08:43:57 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.9]) by rmmx-syy-dmz-app12-12012 (RichMail) with SMTP id 2eec610150e447f-a7d05; Wed, 28 Jul 2021 20:43:19 +0800 (CST)
X-RM-TRANSID: 2eec610150e447f-a7d05
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.112.105.130])
        by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee5610150e4de6-d3396;
        Wed, 28 Jul 2021 20:43:19 +0800 (CST)
X-RM-TRANSID: 2ee5610150e4de6-d3396
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, rjui@broadcom.com, sbranden@broadcom.com
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH] ASoC: bcm: cygnus-pcm: Fix unused assignment about 'rc'
Date:   Wed, 28 Jul 2021 20:44:11 +0800
Message-Id: <20210728124411.3168-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete unused initialized value of 'rc', because it will
be assigned by the function devm_request_irq().

Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 sound/soc/bcm/cygnus-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/bcm/cygnus-pcm.c b/sound/soc/bcm/cygnus-pcm.c
index 7ad07239f..039365f76 100644
--- a/sound/soc/bcm/cygnus-pcm.c
+++ b/sound/soc/bcm/cygnus-pcm.c
@@ -830,7 +830,7 @@ static struct snd_soc_component_driver cygnus_soc_platform = {
 int cygnus_soc_platform_register(struct device *dev,
 				 struct cygnus_audio *cygaud)
 {
-	int rc = 0;
+	int rc;
 
 	dev_dbg(dev, "%s Enter\n", __func__);
 
-- 
2.20.1.windows.1



