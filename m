Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4460E4131B7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 12:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbhIUKhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 06:37:14 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:26496 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbhIUKhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 06:37:11 -0400
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 21 Sep 2021 03:35:43 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 21 Sep 2021 03:35:41 -0700
X-QCInternal: smtphost
Received: from ekangupt-linux.qualcomm.com ([10.204.67.11])
  by ironmsg02-blr.qualcomm.com with ESMTP; 21 Sep 2021 16:05:31 +0530
Received: by ekangupt-linux.qualcomm.com (Postfix, from userid 2319895)
        id AA5BC428F; Tue, 21 Sep 2021 16:05:29 +0530 (IST)
From:   Jeya R <jeyr@codeaurora.org>
To:     linux-arm-msm@vger.kernel.org, srinivas.kandagatla@linaro.org
Cc:     Jeya R <jeyr@codeaurora.org>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, fastrpc.upstream@qti.qualcomm.com
Subject: [PATCH] misc: fastrpc: fix improper packet size calculation
Date:   Tue, 21 Sep 2021 16:05:27 +0530
Message-Id: <1632220527-29547-1-git-send-email-jeyr@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The buffer list is sorted and this is not being considered while
calculating packet size. This would lead to improper copy length
calculation for non-dmaheap buffers which would eventually cause
sending improper buffers to DSP.

Fixes: c68cfb718c8f ("misc: fastrpc: Add support for context Invoke method")
Signed-off-by: Jeya R <jeyr@codeaurora.org>
---
 drivers/misc/fastrpc.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index beda610..a7e550f 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -719,16 +719,21 @@ static int fastrpc_get_meta_size(struct fastrpc_invoke_ctx *ctx)
 static u64 fastrpc_get_payload_size(struct fastrpc_invoke_ctx *ctx, int metalen)
 {
 	u64 size = 0;
-	int i;
+	int oix = 0;
 
 	size = ALIGN(metalen, FASTRPC_ALIGN);
-	for (i = 0; i < ctx->nscalars; i++) {
+	for (oix = 0; oix < ctx->nbufs; oix++) {
+		int i = ctx->olaps[oix].raix;
+
+		if (ctx->args[i].length == 0)
+			continue;
+
 		if (ctx->args[i].fd == 0 || ctx->args[i].fd == -1) {
 
-			if (ctx->olaps[i].offset == 0)
+			if (ctx->olaps[oix].offset == 0)
 				size = ALIGN(size, FASTRPC_ALIGN);
 
-			size += (ctx->olaps[i].mend - ctx->olaps[i].mstart);
+			size += (ctx->olaps[oix].mend - ctx->olaps[oix].mstart);
 		}
 	}
 
-- 
2.7.4

