Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8424193E1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 14:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234212AbhI0MMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 08:12:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:37928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234073AbhI0MMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 08:12:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7B71F60F94;
        Mon, 27 Sep 2021 12:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632744665;
        bh=LUmUeH5VcgxkiD9H6mkTNR+3W/FcVnc5tGucpwOcXIs=;
        h=From:To:Cc:Subject:Date:From;
        b=OLr8llLY+UB7oI7yRf1Put+8rniUWQFiI4sAnoOUajNDjVZJULCsjd7ZY13HgrCHF
         uuOFj+Liz5P0UMSpI9QDsQec43lG3ljPkxjSBk/2lPSh3Op2i7P5DE+akl25c1TK6z
         RPyOFpBv/GOEKOX17ouAkiLnozw/T1fkpcyiv2vbsPIQTNJLkN9M5Rap4HOnL1xc6i
         kPG8JzTo7GrxhFfiXSlcKbqVYrRDpgqv9HoYWz/OrT1qqnFuwON4hnGzkKsXHiBVvC
         stUiEf98glMTN2hYWUDsE/VK50BuI0Ht1G5BDZ9mHYN7FSV7U5SQiBabQnz8XU3f4l
         zXRDmbEUVe6Tw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Rajaravi Krishna Katta <rkatta@habana.ai>
Subject: [PATCH 1/2] habanalabs: fix resetting args in wait for interrupt
Date:   Mon, 27 Sep 2021 15:10:54 +0300
Message-Id: <20210927121055.97751-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajaravi Krishna Katta <rkatta@habana.ai>

If _hl_interrupt_wait_ioctl returns EINTR, resetting args would clear
user flags and will result in error in case the userspace will repeat
the ioctl call.

Signed-off-by: Rajaravi Krishna Katta <rkatta@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/command_submission.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 91b57544f7c6..39fc6d4fb971 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -2878,8 +2878,6 @@ static int hl_interrupt_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 				args->in.interrupt_timeout_us, args->in.addr,
 				args->in.target, interrupt_offset, &status);
 
-	memset(args, 0, sizeof(*args));
-
 	if (rc) {
 		if (rc != -EINTR)
 			dev_err_ratelimited(hdev->dev,
@@ -2888,6 +2886,8 @@ static int hl_interrupt_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 		return rc;
 	}
 
+	memset(args, 0, sizeof(*args));
+
 	switch (status) {
 	case CS_WAIT_STATUS_COMPLETED:
 		args->out.status = HL_WAIT_CS_STATUS_COMPLETED;
-- 
2.17.1

