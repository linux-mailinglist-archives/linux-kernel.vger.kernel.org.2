Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9F0A366C7D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241952AbhDUNSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:18:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:49136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241612AbhDUNJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:09:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 067D16147E;
        Wed, 21 Apr 2021 13:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010512;
        bh=YbM/JDcEhtUKoOaWmqWbdFHG0wyL5M+A2QKrbumK1ek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZWtFzqqqw/EGB3vDBdQyv81UrU/QJ4C9ElOJM6iCyyGzwdTazwtTTZJciBy8oEDsm
         MKLyzeNUfNyWVh/aRaFuoC1uRWnv4FUUGCZfTSw3X4Oli2no/eMxJK5hGZXw8BJd9M
         irlFdsEW31X7GjuEEpANHb3Hg0CGDhv3GUTDp8b0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aditya Pakki <pakki001@umn.edu>, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 163/190] Revert "dmaengine: mv_xor: Fix a missing check in mv_xor_channel_add"
Date:   Wed, 21 Apr 2021 15:00:38 +0200
Message-Id: <20210421130105.1226686-164-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 7c97381e7a9a5ec359007c0d491a143e3d9f787c.

Commits from @umn.edu addresses have been found to be submitted in "bad
faith" to try to test the kernel community's ability to review "known
malicious" changes.  The result of these submissions can be found in a
paper published at the 42nd IEEE Symposium on Security and Privacy
entitled, "Open Source Insecurity: Stealthily Introducing
Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
of Minnesota) and Kangjie Lu (University of Minnesota).

Because of this, all submissions from this group must be reverted from
the kernel tree and will need to be re-reviewed again to determine if
they actually are a valid fix.  Until that work is complete, remove this
change to ensure that no problems are being introduced into the
codebase.

Cc: Aditya Pakki <pakki001@umn.edu>
Cc: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/mv_xor.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 23b232b57518..78bd52565571 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1144,10 +1144,7 @@ mv_xor_channel_add(struct mv_xor_device *xordev,
 		 dma_has_cap(DMA_MEMCPY, dma_dev->cap_mask) ? "cpy " : "",
 		 dma_has_cap(DMA_INTERRUPT, dma_dev->cap_mask) ? "intr " : "");
 
-	ret = dma_async_device_register(dma_dev);
-	if (ret)
-		goto err_free_irq;
-
+	dma_async_device_register(dma_dev);
 	return mv_chan;
 
 err_free_irq:
-- 
2.31.1

