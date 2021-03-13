Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69701339CE0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 09:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbhCMIXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 03:23:37 -0500
Received: from mail-m17635.qiye.163.com ([59.111.176.35]:49616 "EHLO
        mail-m17635.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbhCMIXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 03:23:16 -0500
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.231])
        by mail-m17635.qiye.163.com (Hmail) with ESMTPA id A99E4400159;
        Sat, 13 Mar 2021 16:23:13 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Wang Qing <wangqing@vivo.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sound: soc: codecs: Remove unnecessary THIS_MODULE
Date:   Sat, 13 Mar 2021 16:23:02 +0800
Message-Id: <1615623786-16302-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZSx1DTBhLSkoYS0IfVkpNSk5NSUhMQk9LSU9VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKSkNITVVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ORQ6Sjo5TD8LA1E5FwI#KDkQ
        IRNPCQ1VSlVKTUpOTUlITEJPSE1OVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISllXWQgBWUFKTUJPNwY+
X-HM-Tid: 0a782aaead1cd991kuwsa99e4400159
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As THIS_MODULE has been set in module_platform_driver(), so remove it.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 sound/soc/codecs/lpass-rx-macro.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
index c9c21d22..5b9d4e9
--- a/sound/soc/codecs/lpass-rx-macro.c
+++ b/sound/soc/codecs/lpass-rx-macro.c
@@ -3585,7 +3585,6 @@ static const struct of_device_id rx_macro_dt_match[] = {
 static struct platform_driver rx_macro_driver = {
 	.driver = {
 		.name = "rx_macro",
-		.owner = THIS_MODULE,
 		.of_match_table = rx_macro_dt_match,
 		.suppress_bind_attrs = true,
 	},
-- 
2.7.4

