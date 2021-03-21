Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 785903431D6
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 10:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbhCUJQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 05:16:51 -0400
Received: from smtp.h3c.com ([60.191.123.50]:18783 "EHLO h3cspam02-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229931AbhCUJQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 05:16:49 -0400
X-Greylist: delayed 1373 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Mar 2021 05:16:48 EDT
Received: from DAG2EX05-BASE.srv.huawei-3com.com ([10.8.0.68])
        by h3cspam02-ex.h3c.com with ESMTP id 12L9F2Rs099394;
        Sun, 21 Mar 2021 17:15:02 +0800 (GMT-8)
        (envelope-from xi.fengfei@h3c.com)
Received: from localhost.localdomain (10.99.222.162) by
 DAG2EX05-BASE.srv.huawei-3com.com (10.8.0.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Sun, 21 Mar 2021 17:15:05 +0800
From:   Fengfei Xi <xi.fengfei@h3c.com>
To:     <perex@perex.cz>, <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Fengfei Xi <xi.fengfei@h3c.com>
Subject: [PATCH] sound: remove unnecessary blank
Date:   Sun, 21 Mar 2021 16:59:48 +0800
Message-ID: <20210321085948.11491-1-xi.fengfei@h3c.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.99.222.162]
X-ClientProxiedBy: BJSMTP02-EX.srv.huawei-3com.com (10.63.20.133) To
 DAG2EX05-BASE.srv.huawei-3com.com (10.8.0.68)
X-DNSRBL: 
X-MAIL: h3cspam02-ex.h3c.com 12L9F2Rs099394
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary blank when calling kmalloc_array().

Signed-off-by: Fengfei Xi <xi.fengfei@h3c.com>
---
 sound/oss/dmasound/dmasound_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/oss/dmasound/dmasound_core.c b/sound/oss/dmasound/dmasound_core.c
index 49679aa86..78bb9dfe2 100644
--- a/sound/oss/dmasound/dmasound_core.c
+++ b/sound/oss/dmasound/dmasound_core.c
@@ -421,7 +421,7 @@ static int sq_allocate_buffers(struct sound_queue *sq, int num, int size)
 		return 0;
 	sq->numBufs = num;
 	sq->bufSize = size;
-	sq->buffers = kmalloc_array (num, sizeof(char *), GFP_KERNEL);
+	sq->buffers = kmalloc_array(num, sizeof(char *), GFP_KERNEL);
 	if (!sq->buffers)
 		return -ENOMEM;
 	for (i = 0; i < num; i++) {
-- 
2.17.1

