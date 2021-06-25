Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 689D03B4428
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 15:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbhFYNOX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 09:14:23 -0400
Received: from m12-12.163.com ([220.181.12.12]:55139 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231375AbhFYNOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 09:14:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ULek8
        wIf2qSQJ+7M1wZ72IGb1LuwGdCmYvFvxyE4oH8=; b=XKnQMocAWEg1PmVKJQ7gW
        8NIGNcbU4WSkAWfdmyOedf7HQ0gbY+kSGWZeyzYO7oVAdH47Wbz1PLNlARVR6onl
        evL0QXpkUw/gNwivmZ/r7XGbXatw2Ox4IkbWSmoYYbIYYuIASYfgKwFEr/dNHtH1
        XLosdmx8LS6G2UGu97ARaw=
Received: from ubuntu.localdomain (unknown [218.17.89.92])
        by smtp8 (Coremail) with SMTP id DMCowACXTTXsytVgqbn0Lg--.61541S2;
        Fri, 25 Jun 2021 20:24:12 +0800 (CST)
From:   13145886936@163.com
To:     perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, gushengxian <gushengxian@yulong.com>
Subject: [PATCH] ASoC: codecs: lpass-rx-macro: remove nneeded semicolon
Date:   Fri, 25 Jun 2021 05:24:10 -0700
Message-Id: <20210625122410.471691-1-13145886936@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMCowACXTTXsytVgqbn0Lg--.61541S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUDTqcUUUUU
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5zrdx5xxdq6xppld0qqrwthudrp/xtbBdgy8g1UMRYywzAAAsp
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: gushengxian <gushengxian@yulong.com>

Remove an unneeded semicolon.

Signed-off-by: gushengxian <gushengxian@yulong.com>
---
 sound/soc/codecs/lpass-rx-macro.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
index 171ab7f519c0..3622961f7c2c 100644
--- a/sound/soc/codecs/lpass-rx-macro.c
+++ b/sound/soc/codecs/lpass-rx-macro.c
@@ -2628,7 +2628,7 @@ static int rx_macro_enable_rx_path_clk(struct snd_soc_dapm_widget *w,
 		break;
 	default:
 		break;
-	};
+	}
 	return 0;
 }
 
-- 
2.25.1


