Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8415D370DC0
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 17:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbhEBP5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 May 2021 11:57:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:53258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230154AbhEBP47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 May 2021 11:56:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1FBF5611F1;
        Sun,  2 May 2021 15:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619970967;
        bh=FfwBTdMsJob++dR3yEGaSzVovkhtbO+t+qb20kLdr0k=;
        h=From:To:Cc:Subject:Date:From;
        b=fD/cvrjegc49TM7CUugP83G+yq9qZ7WLvnL4ldJyYFSyazXuaR1HNzHaDwEo3fLRP
         mzpIt5GPaOoTjCymD/NmTJ0vv47CsiPvPhPpvnwyGk8DgNdEJGgWhBvcCEKBlCEGqh
         pWe5+clch6XX5UbVovPjRDsXVgdZ4Yherx5yoQklNBpK/lyfWxcCirXgE+CPlR/Qqe
         2oBw9BHwPmXJBfYVc0UCk4QXWdmSITZfrBfxykw5RK+nhYG2l/n4CEMxwSdpDnFaIo
         LsB6rPcpT0v1meEWN+Tb1E3wKDtroG8HziM1WhcwIv1n3Dxj1STQ9+KUFUGE/Kgq4E
         OmpzzzwtCy9+g==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH] habanalabs: wait for interrupt wrong timeout calculation
Date:   Sun,  2 May 2021 18:56:02 +0300
Message-Id: <20210502155602.13277-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

Wait for interrupt timeout calculation is wrong, hence timeout occurs
when user waits on an interrupt with certain timeout values.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/command_submission.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index ff8791a651fd..af3c497defb1 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -2017,7 +2017,7 @@ static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 		if (completion_value >= target_value) {
 			*status = CS_WAIT_STATUS_COMPLETED;
 		} else {
-			timeout -= jiffies_to_usecs(completion_rc);
+			timeout = completion_rc;
 			goto wait_again;
 		}
 	} else {
-- 
2.25.1

