Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 806373DCA87
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 09:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbhHAHZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 03:25:56 -0400
Received: from mga02.intel.com ([134.134.136.20]:28526 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230519AbhHAHZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 03:25:54 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10062"; a="200472323"
X-IronPort-AV: E=Sophos;i="5.84,286,1620716400"; 
   d="scan'208";a="200472323"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2021 00:25:45 -0700
X-IronPort-AV: E=Sophos;i="5.84,286,1620716400"; 
   d="scan'208";a="519772111"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.138])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2021 00:25:42 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next] samples: mei: don't wait on read completion upon write.
Date:   Sun,  1 Aug 2021 10:25:32 +0300
Message-Id: <20210801072532.8668-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

The original mei driver communication was strictly write command and
receive response flow, the completion of write was determined when
response was ready using select(). This paradigm is a long time not
true.  There can be write without a response and an unsolicited read.
The driver is capable of handling those.
Adjust also the sample code and remove select() on read() from the
write flow. Add select to the read flow to showcase how to do the
read with a timeout.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 samples/mei/mei-amt-version.c | 51 ++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 21 deletions(-)

diff --git a/samples/mei/mei-amt-version.c b/samples/mei/mei-amt-version.c
index ad3e56042f96..867debd3b912 100644
--- a/samples/mei/mei-amt-version.c
+++ b/samples/mei/mei-amt-version.c
@@ -154,31 +154,52 @@ static bool mei_init(struct mei *me, const uuid_le *guid,
 static ssize_t mei_recv_msg(struct mei *me, unsigned char *buffer,
 			ssize_t len, unsigned long timeout)
 {
+	struct timeval tv;
+	fd_set set;
 	ssize_t rc;
 
+	tv.tv_sec = timeout / 1000;
+	tv.tv_usec = (timeout % 1000) * 1000000;
+
 	mei_msg(me, "call read length = %zd\n", len);
 
+	FD_ZERO(&set);
+	FD_SET(me->fd, &set);
+	rc = select(me->fd + 1, &set, NULL, NULL, &tv);
+	if (rc > 0 && FD_ISSET(me->fd, &set)) {
+		mei_msg(me, "have reply\n");
+	} else if (rc == 0) {
+		rc = -1;
+		mei_err(me, "read failed on timeout\n");
+		goto out;
+	} else { /* rc < 0 */
+		rc = errno;
+		mei_err(me, "read failed on select with status %zd %s\n",
+			rc, strerror(errno));
+		goto out;
+	}
+
 	rc = read(me->fd, buffer, len);
 	if (rc < 0) {
 		mei_err(me, "read failed with status %zd %s\n",
 				rc, strerror(errno));
-		mei_deinit(me);
-	} else {
-		mei_msg(me, "read succeeded with result %zd\n", rc);
+		goto out;
 	}
+
+	mei_msg(me, "read succeeded with result %zd\n", rc);
+
+out:
+	if (rc < 0)
+		mei_deinit(me);
+
 	return rc;
 }
 
 static ssize_t mei_send_msg(struct mei *me, const unsigned char *buffer,
 			ssize_t len, unsigned long timeout)
 {
-	struct timeval tv;
 	ssize_t written;
 	ssize_t rc;
-	fd_set set;
-
-	tv.tv_sec = timeout / 1000;
-	tv.tv_usec = (timeout % 1000) * 1000000;
 
 	mei_msg(me, "call write length = %zd\n", len);
 
@@ -189,19 +210,7 @@ static ssize_t mei_send_msg(struct mei *me, const unsigned char *buffer,
 			written, strerror(errno));
 		goto out;
 	}
-
-	FD_ZERO(&set);
-	FD_SET(me->fd, &set);
-	rc = select(me->fd + 1 , &set, NULL, NULL, &tv);
-	if (rc > 0 && FD_ISSET(me->fd, &set)) {
-		mei_msg(me, "write success\n");
-	} else if (rc == 0) {
-		mei_err(me, "write failed on timeout with status\n");
-		goto out;
-	} else { /* rc < 0 */
-		mei_err(me, "write failed on select with status %zd\n", rc);
-		goto out;
-	}
+	mei_msg(me, "write success\n");
 
 	rc = written;
 out:
-- 
2.31.1

