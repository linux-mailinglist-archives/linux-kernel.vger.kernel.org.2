Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0CC6409CB6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 21:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241664AbhIMTNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 15:13:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:39372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241529AbhIMTNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 15:13:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 79D2C60C40;
        Mon, 13 Sep 2021 19:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631560311;
        bh=fGJW8cKB6KxYOgmGCwco1CVxr5lwPCVcEaYhwvaGZV8=;
        h=From:To:Cc:Subject:Date:From;
        b=LCDiG/bdolhP9aoaoH2EEAYFPWRWAEP409P74fmvwyARbjM6ozclMrlTDjmlb59qu
         LVfSVzA6MxLEIHXmPKdqMUFGAKkYWb2L9vDBv7F0SS6kHMeogI60RTqWqpS1etIDSu
         kd3qzBJQ10SQRSH3WjC19NnedcoYibxWeaK1q/XI/FqUrXaZiuvKVbPzqkJSy06wRk
         Syl+bHevd8iC4BqrxrQ4R7GQKhvCsw67oCXr6PX97WfowCutpSObADiWd6qj1wAcrK
         Z1mkMltpdhbn/QBt4Yoo5hH5HyHtz0tmwlMsozcFz4yHCchtGXHzLFaAqBo1BFmJ3C
         L2i2fJqPrSjwA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 1/2] habanalabs: rate limit multi CS completion errors
Date:   Mon, 13 Sep 2021 22:11:45 +0300
Message-Id: <20210913191146.92956-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

As user can send wrong arguments to multi CS API, we rate limit
the amount of errors dumped to dmesg, in addition we change the
severity to warning.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/command_submission.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 5b7de857fbc1..a4ed91ed991d 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -2630,7 +2630,8 @@ static int hl_multi_cs_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 		 * completed after the poll function.
 		 */
 		if (!mcs_data.completion_bitmap) {
-			dev_err(hdev->dev, "Multi-CS got completion on wait but no CS completed\n");
+			dev_warn_ratelimited(hdev->dev,
+				"Multi-CS got completion on wait but no CS completed\n");
 			rc = -EFAULT;
 		}
 	}
-- 
2.17.1

