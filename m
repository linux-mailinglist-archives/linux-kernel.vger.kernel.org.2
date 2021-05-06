Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6748A374D4E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 04:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbhEFCLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 22:11:34 -0400
Received: from mail-m176218.qiye.163.com ([59.111.176.218]:63312 "EHLO
        mail-m176218.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbhEFCLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 22:11:32 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m176218.qiye.163.com (Hmail) with ESMTPA id 45F7A32009E;
        Thu,  6 May 2021 10:10:33 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Colin Ian King <colin.king@canonical.com>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net
Subject: [PATCH] ASoC: codecs: lpass-rx-macro: Remove unneeded semicolon
Date:   Thu,  6 May 2021 10:09:49 +0800
Message-Id: <20210506021005.4897-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGktKS1ZLSEJLHxpJH0hLHk1VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NzY6PQw4GT8QQ0MfSjAhExI4
        FA4KCR5VSlVKTUlLSU1MS0hPS01LVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFJS09KNwY+
X-HM-Tid: 0a793f70e415d978kuws45f7a32009e
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

./sound/soc/codecs/lpass-rx-macro.c:2631:2-3: Unneeded semicolon

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 sound/soc/codecs/lpass-rx-macro.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
index b0ebfc8d180c..8dff72fc7bab 100644
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

