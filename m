Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1F5F4475F0
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 21:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236487AbhKGUyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 15:54:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:56372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235763AbhKGUyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 15:54:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F267361505;
        Sun,  7 Nov 2021 20:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636318308;
        bh=mHnPpqckjGdffJ5Q0QtT+NHlp24t8jkN+3FnNIpGrhs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fk7Bqi6peTyrFsCwW0oqc+gyeNT6vnvZBed+PpFwHT1phJK/Tcg4rgc2BsicISU5a
         16lywb+iNfoFDkhEac2XbwVZiagwSAjNDT97UDQxCq50JRxGfb+5VJ+rhWe+JPI3qa
         I1ZWAnlfcw0gnCp6FmlXm5ykYdvJQTRgrdbEWnvBZj7Srg5Tw1dNovah3QDkxMMvwI
         SpHOdC2uHIJH3a7BH9tsVhtEUqmC8YaJCApTYloayaRxU3qWFbKA0nRvSZFRoiAZMu
         nCueb7WZLa0Y1TAZuGTMwWy9X9qF8e20Z/ivc2bDM6WqoPX5S1nGfKXfNpA7MPqc2F
         juxFPB3EKaSRQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Dani Liberman <dliberman@habana.ai>
Subject: [PATCH 05/10] habanalabs: change wait for interrupt timeout to 64 bit
Date:   Sun,  7 Nov 2021 22:51:31 +0200
Message-Id: <20211107205136.2329007-5-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211107205136.2329007-1-ogabbay@kernel.org>
References: <20211107205136.2329007-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dani Liberman <dliberman@habana.ai>

In order to increase maximum wait-for-interrupt timeout, change it
to 64 bit variable. This wait is used only by newer ASICs, so no
problem in changing this interface at this time.

Signed-off-by: Dani Liberman <dliberman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/common/command_submission.c    | 22 ++++++++++++++-----
 include/uapi/misc/habanalabs.h                | 18 +++++++++------
 2 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index 9ebcd9894d83..54a5425a77a0 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -2765,8 +2765,23 @@ static int hl_cs_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 	return 0;
 }
 
+static inline unsigned long hl_usecs64_to_jiffies(const u64 usecs)
+{
+	if (usecs <= U32_MAX)
+		return usecs_to_jiffies(usecs);
+
+	/*
+	 * If the value in nanoseconds is larger than 64 bit, use the largest
+	 * 64 bit value.
+	 */
+	if (usecs >= ((u64)(U64_MAX / NSEC_PER_USEC)))
+		return nsecs_to_jiffies(U64_MAX);
+
+	return nsecs_to_jiffies(usecs * NSEC_PER_USEC);
+}
+
 static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
-				u32 timeout_us, u64 user_address,
+				u64 timeout_us, u64 user_address,
 				u64 target_value, u16 interrupt_offset,
 				u32 *status,
 				u64 *timestamp)
@@ -2778,10 +2793,7 @@ static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 	long completion_rc;
 	int rc = 0;
 
-	if (timeout_us == U32_MAX)
-		timeout = timeout_us;
-	else
-		timeout = usecs_to_jiffies(timeout_us);
+	timeout = hl_usecs64_to_jiffies(timeout_us);
 
 	hl_ctx_get(hdev, ctx);
 
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 00b309590499..c5760acebdd1 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -911,14 +911,18 @@ struct hl_wait_cs_in {
 	 */
 	__u32 flags;
 
-	/* Multi CS API info- valid entries in multi-CS array */
-	__u8 seq_arr_len;
-	__u8 pad[3];
+	union {
+		struct {
+			/* Multi CS API info- valid entries in multi-CS array */
+			__u8 seq_arr_len;
+			__u8 pad[7];
+		};
 
-	/* Absolute timeout to wait for an interrupt in microseconds.
-	 * Relevant only when HL_WAIT_CS_FLAGS_INTERRUPT is set
-	 */
-	__u32 interrupt_timeout_us;
+		/* Absolute timeout to wait for an interrupt in microseconds.
+		 * Relevant only when HL_WAIT_CS_FLAGS_INTERRUPT is set
+		 */
+		__u64 interrupt_timeout_us;
+	};
 };
 
 #define HL_WAIT_CS_STATUS_COMPLETED	0
-- 
2.25.1

