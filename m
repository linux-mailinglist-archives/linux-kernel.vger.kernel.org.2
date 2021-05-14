Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 267793803FB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 09:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbhENHHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 03:07:33 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:2919 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbhENHHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 03:07:31 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FhKHs16hRzBvNb;
        Fri, 14 May 2021 15:03:37 +0800 (CST)
Received: from localhost (10.174.179.215) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.498.0; Fri, 14 May 2021
 15:06:09 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <perex@perex.cz>, <tiwai@suse.com>, <gregkh@linuxfoundation.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ALSA: gus: Replace unsafe strcpy() with strscpy()
Date:   Fri, 14 May 2021 15:05:07 +0800
Message-ID: <20210514070507.16600-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix smatch warning:
sound/isa/gus/gus_main.c:396 snd_gus_check_version() error:
 strcpy() 'card->longname' too large for 'card->shortname' (80 vs 32)

Even if this is not a real bug since the longest length of card->longname
now is 31, replace strcpy() with strscpy() in order to avoid possible
future mistake.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/isa/gus/gus_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/isa/gus/gus_main.c b/sound/isa/gus/gus_main.c
index b7518122a10d..7524ce5785de 100644
--- a/sound/isa/gus/gus_main.c
+++ b/sound/isa/gus/gus_main.c
@@ -384,7 +384,7 @@ static int snd_gus_check_version(struct snd_gus_card * gus)
 			}
 		}
 	}
-	strcpy(card->shortname, card->longname);
+	strscpy(card->shortname, card->longname, sizeof(card->shortname));
 	gus->uart_enable = 1;	/* standard GUSes doesn't have midi uart trouble */
 	snd_gus_init_control(gus);
 	return 0;
-- 
2.17.1

