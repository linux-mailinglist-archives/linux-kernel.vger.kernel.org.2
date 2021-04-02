Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6254635305E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 22:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234981AbhDBUns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 16:43:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:52500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231149AbhDBUnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 16:43:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E3E461177
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 20:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617396224;
        bh=dWu4Y7lYBKipZYJpWvLnLR79oT1dy5VYsrwmwapX+qM=;
        h=From:To:Subject:Date:From;
        b=kLDKIdX4cjsTaVoml/tTsUguzEmh3/PhlsxTC47F7ik1Ro5kn7+Q7LWLKPgaWsHDP
         aDUGQFcYtr+HlgbE3veISQ2ByZJOZ8jcJd5DexNc9uEAGGG/t9h9c7d2psqUd+RVpI
         91+pf7Bo1EHZ9al7ATCPum3A4zVelWoruoWDc30KB1f+xNaTX89f4YbzBfiZaWOsKO
         aazq7QFtdz6tXIhR+8cvtDu1d0iNW5OS6jNZ+piRRwL30Bfz8YlJIgCg8+HNxgnhZu
         fmd8vHfuJL404ZIH8QftZrH652amf7O8YA9xDComuL3efitu+6fFKNnwV9lg0YTf8m
         dbHtats0C5Hag==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH] habanalabs: remove the store jobs array from CS IOCTL
Date:   Fri,  2 Apr 2021 23:43:40 +0300
Message-Id: <20210402204340.14717-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The store part was never implemented in the code and never been used
by the userspace applications.

We currently use the related parameters to a different purpose with
a defined union. However, there is no point in that and it is better
to just remove the union and the store parameters.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 include/uapi/misc/habanalabs.h | 35 ++++++++++------------------------
 1 file changed, 10 insertions(+), 25 deletions(-)

diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 90798eaac728..d3e017b5f0db 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -644,17 +644,10 @@ struct hl_cs_in {
 	/* holds address of array of hl_cs_chunk for execution phase */
 	__u64 chunks_execute;
 
-	union {
-		/* this holds address of array of hl_cs_chunk for store phase -
-		 * Currently not in use
-		 */
-		__u64 chunks_store;
-
-		/* Sequence number of a staged submission CS
-		 * valid only if HL_CS_FLAGS_STAGED_SUBMISSION is set
-		 */
-		__u64 seq;
-	};
+	/* Sequence number of a staged submission CS
+	 * valid only if HL_CS_FLAGS_STAGED_SUBMISSION is set
+	 */
+	__u64 seq;
 
 	/* Number of chunks in restore phase array. Maximum number is
 	 * HL_MAX_JOBS_PER_CS
@@ -666,18 +659,10 @@ struct hl_cs_in {
 	 */
 	__u32 num_chunks_execute;
 
-	union {
-		/* Number of chunks in restore phase array -
-		 * Currently not in use
-		 */
-		__u32 num_chunks_store;
-
-		/* timeout in seconds - valid only if HL_CS_FLAGS_CUSTOM_TIMEOUT
-		 * is set. this parameter is ignored in case of future multiple
-		 * users support.
-		 */
-		__u32 timeout;
-	};
+	/* timeout in seconds - valid only if HL_CS_FLAGS_CUSTOM_TIMEOUT
+	 * is set
+	 */
+	__u32 timeout;
 
 	/* HL_CS_FLAGS_* */
 	__u32 cs_flags;
@@ -1051,8 +1036,8 @@ struct hl_debug_args {
  * Each JOB will be enqueued on a specific queue, according to the user's input.
  * There can be more then one JOB per queue.
  *
- * The CS IOCTL will receive three sets of JOBS. One set is for "restore" phase,
- * a second set is for "execution" phase and a third set is for "store" phase.
+ * The CS IOCTL will receive two sets of JOBS. One set is for "restore" phase
+ * and a second set is for "execution" phase.
  * The JOBS on the "restore" phase are enqueued only after context-switch
  * (or if its the first CS for this context). The user can also order the
  * driver to run the "restore" phase explicitly
-- 
2.25.1

