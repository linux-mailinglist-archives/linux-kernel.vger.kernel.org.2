Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C5736A674
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 12:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbhDYKNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 06:13:21 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:33261 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229466AbhDYKNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 06:13:20 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R431e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0UWg2GZT_1619345556;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UWg2GZT_1619345556)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 25 Apr 2021 18:12:37 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     perex@perex.cz
Cc:     srinivas.kandagatla@linaro.org, bgoswami@codeaurora.org,
        lgirdwood@gmail.com, broonie@kernel.org, tiwai@suse.com,
        nathan@kernel.org, ndesaulniers@google.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] ASoC: q6dsp: q6afe: remove unneeded dead-store initialization
Date:   Sun, 25 Apr 2021 18:12:33 +0800
Message-Id: <1619345553-29781-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variables 'wait' and 'port_id' are being initialized, however the
values are never read and updated later on, hence the redundant
initializations can be removed.

Cleans up clang warnings:
sound/soc/qcom/qdsp6/q6afe.c:933:21: warning: Value stored to 'wait'
during its initialization is never read
sound/soc/qcom/qdsp6/q6afe.c:1186:6: warning: Value stored to 'port_id'
during its initialization is never read

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 sound/soc/qcom/qdsp6/q6afe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
index cad1cd1..442bf27 100644
--- a/sound/soc/qcom/qdsp6/q6afe.c
+++ b/sound/soc/qcom/qdsp6/q6afe.c
@@ -930,7 +930,7 @@ int q6afe_get_port_id(int index)
 static int afe_apr_send_pkt(struct q6afe *afe, struct apr_pkt *pkt,
 			    struct q6afe_port *port, uint32_t rsp_opcode)
 {
-	wait_queue_head_t *wait = &port->wait;
+	wait_queue_head_t *wait;
 	struct aprv2_ibasic_rsp_result_t *result;
 	int ret;
 
@@ -1183,7 +1183,7 @@ int q6afe_port_stop(struct q6afe_port *port)
 	struct afe_port_cmd_device_stop *stop;
 	struct q6afe *afe = port->afe;
 	struct apr_pkt *pkt;
-	int port_id = port->id;
+	int port_id;
 	int ret = 0;
 	int index, pkt_size;
 	void *p;
-- 
1.8.3.1

