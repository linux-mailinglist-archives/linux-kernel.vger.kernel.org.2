Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8253CE324
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 18:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346471AbhGSPer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 11:34:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:53810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244138AbhGSO4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 10:56:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 52E6A6113B
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 15:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626708863;
        bh=iJGDeioKhi53yR8ur5WqtbjBAKLmrzAuyczDgeYb8H0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=LQ4E35KdG6uqDeIXVFdQU67qHt724VuUeoMM3BkdzJGkxj9f7Uqh0A2x0SEhJ9LIX
         dMyCdIsxOTFfIZGhq0mIFO/TgQj3hcB+mIwYv2JigV8NDD2OALK5crh5IoAho0URaO
         WCg5Haued3PI0i5+1zac7jyqDNlufsCAAcj4ebeWgB0H2/tJMRU77mo1Ke9qPRM2jW
         akyzjs1u7H1IWcuWLE9sBbLqz0EX3zTNmlIAMBoB9gp/9jeCZmoeC7u89zhMUmnn58
         2WkWhPy7heDOk52cw30yMdo0xomO1jchLsLbXXlEkHDAZrNCDisriKRLVGYzcCr2Sk
         +I5dkeEh2slkg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] habanalabs: remove redundant warning message
Date:   Mon, 19 Jul 2021 18:34:15 +0300
Message-Id: <20210719153417.4787-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210719153417.4787-1-ogabbay@kernel.org>
References: <20210719153417.4787-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This warning is redundant as we will print a notice in case the device
is still in use after the FD was closed. No need to print the same
message per context.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/context.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/misc/habanalabs/common/context.c b/drivers/misc/habanalabs/common/context.c
index abbba4194d3b..cd06852aa17c 100644
--- a/drivers/misc/habanalabs/common/context.c
+++ b/drivers/misc/habanalabs/common/context.c
@@ -184,9 +184,6 @@ void hl_ctx_free(struct hl_device *hdev, struct hl_ctx *ctx)
 {
 	if (kref_put(&ctx->refcount, hl_ctx_do_release) == 1)
 		return;
-
-	dev_warn(hdev->dev,
-		"user process released device but its command submissions are still executing\n");
 }
 
 int hl_ctx_init(struct hl_device *hdev, struct hl_ctx *ctx, bool is_kernel_ctx)
-- 
2.25.1

