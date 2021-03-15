Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC6C33BE9B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 15:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241017AbhCOOsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 10:48:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:49712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234450AbhCOODX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 10:03:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CE72064EED;
        Mon, 15 Mar 2021 14:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615817002;
        bh=hRi6m1Bb5VR/buKeMZd3yV/trt2XhIAgjIg+RXM4Ky8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SrdpR2BAq8JzHHrzdPAYoU8T3esuLFXny+xa5XsyJ5A3ZWe9pem1wiVsSa4crZxYr
         vlM5zEPMwn6e0kPPjtcNcFY7UkTtsu2xNZTMA83zM9Oe2WxqFbhLftSUj3136nCtqg
         tRlW/6hM7N1d3BhiwYlwHjvH/irCtGzt3JfEV7uI=
From:   gregkh@linuxfoundation.org
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.11 254/306] io_uring: perform IOPOLL reaping if canceler is thread itself
Date:   Mon, 15 Mar 2021 14:55:17 +0100
Message-Id: <20210315135516.228552704@linuxfoundation.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210315135507.611436477@linuxfoundation.org>
References: <20210315135507.611436477@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

From: Jens Axboe <axboe@kernel.dk>

[ Upstream commit d052d1d685f5125249ab4ff887562c88ba959638 ]

We bypass IOPOLL completion polling (and reaping) for the SQPOLL thread,
but if it's the thread itself invoking cancelations, then we still need
to perform it or no one will.

Fixes: 9936c7c2bc76 ("io_uring: deduplicate core cancellations sequence")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/io_uring.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 241313278e5a..00ef0b90d149 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -8891,7 +8891,8 @@ static void io_uring_try_cancel_requests(struct io_ring_ctx *ctx,
 		}
 
 		/* SQPOLL thread does its own polling */
-		if (!(ctx->flags & IORING_SETUP_SQPOLL) && !files) {
+		if ((!(ctx->flags & IORING_SETUP_SQPOLL) && !files) ||
+		    (ctx->sq_data && ctx->sq_data->thread == current)) {
 			while (!list_empty_careful(&ctx->iopoll_list)) {
 				io_iopoll_try_reap_events(ctx);
 				ret = true;
-- 
2.30.1



