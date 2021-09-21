Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35714132C6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 13:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbhIULpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 07:45:43 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:39675 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbhIULpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 07:45:42 -0400
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 21 Sep 2021 04:44:13 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 21 Sep 2021 04:44:12 -0700
X-QCInternal: smtphost
Received: from ekangupt-linux.qualcomm.com ([10.204.67.11])
  by ironmsg01-blr.qualcomm.com with ESMTP; 21 Sep 2021 17:14:10 +0530
Received: by ekangupt-linux.qualcomm.com (Postfix, from userid 2319895)
        id 95FD6425A; Tue, 21 Sep 2021 17:14:09 +0530 (IST)
From:   Jeya R <jeyr@codeaurora.org>
To:     linux-arm-msm@vger.kernel.org, srinivas.kandagatla@linaro.org
Cc:     Jeya R <jeyr@codeaurora.org>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, fastrpc.upstream@qti.qualcomm.com
Subject: [RESEND PATCH v2] misc: fastrpc: fix improper packet size calculation
Date:   Tue, 21 Sep 2021 17:14:07 +0530
Message-Id: <1632224647-32297-1-git-send-email-jeyr@codeaurora.org>
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
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
Changes in v2:
- updated commit message to proper format
- added fixes tag to commit message
- removed unnecessary variable initialization
- removed length check during payload calculation

 drivers/misc/fastrpc.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index beda610..69d45c4 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -719,16 +719,18 @@ static int fastrpc_get_meta_size(struct fastrpc_invoke_ctx *ctx)
 static u64 fastrpc_get_payload_size(struct fastrpc_invoke_ctx *ctx, int metalen)
 {
 	u64 size = 0;
-	int i;
+	int oix;
 
 	size = ALIGN(metalen, FASTRPC_ALIGN);
-	for (i = 0; i < ctx->nscalars; i++) {
+	for (oix = 0; oix < ctx->nbufs; oix++) {
+		int i = ctx->olaps[oix].raix;
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

