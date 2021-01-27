Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D046830603C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 16:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236427AbhA0PwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 10:52:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:50362 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236003AbhA0PuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 10:50:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D2623AE47;
        Wed, 27 Jan 2021 15:49:40 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC 2/4] selftests: firmware: Simplify test patterns
Date:   Wed, 27 Jan 2021 16:49:37 +0100
Message-Id: <20210127154939.13288-3-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210127154939.13288-1-tiwai@suse.de>
References: <20210127154939.13288-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test patterns are almost same in three sequential tests.
Make the unified helper function for improving the readability.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 .../selftests/firmware/fw_filesystem.sh       | 106 +++++-------------
 1 file changed, 30 insertions(+), 76 deletions(-)

diff --git a/tools/testing/selftests/firmware/fw_filesystem.sh b/tools/testing/selftests/firmware/fw_filesystem.sh
index c2a2a100114b..2424a97da65b 100755
--- a/tools/testing/selftests/firmware/fw_filesystem.sh
+++ b/tools/testing/selftests/firmware/fw_filesystem.sh
@@ -435,6 +435,32 @@ test_request_partial_firmware_into_buf()
 	echo "OK"
 }
 
+do_tests ()
+{
+	mode="$1"
+	suffix="$2"
+
+	for i in $(seq 1 5); do
+		test_batched_request_firmware$suffix $i $mode
+	done
+
+	for i in $(seq 1 5); do
+		test_batched_request_firmware_into_buf$suffix $i $mode
+	done
+
+	for i in $(seq 1 5); do
+		test_batched_request_firmware_direct$suffix $i $mode
+	done
+
+	for i in $(seq 1 5); do
+		test_request_firmware_nowait_uevent$suffix $i $mode
+	done
+
+	for i in $(seq 1 5); do
+		test_request_firmware_nowait_custom$suffix $i $mode
+	done
+}
+
 # Only continue if batched request triggers are present on the
 # test-firmware driver
 test_config_present
@@ -442,25 +468,7 @@ test_config_present
 # test with the file present
 echo
 echo "Testing with the file present..."
-for i in $(seq 1 5); do
-	test_batched_request_firmware $i normal
-done
-
-for i in $(seq 1 5); do
-	test_batched_request_firmware_into_buf $i normal
-done
-
-for i in $(seq 1 5); do
-	test_batched_request_firmware_direct $i normal
-done
-
-for i in $(seq 1 5); do
-	test_request_firmware_nowait_uevent $i normal
-done
-
-for i in $(seq 1 5); do
-	test_request_firmware_nowait_custom $i normal
-done
+do_tests normal
 
 # Partial loads cannot use fallback, so do not repeat tests.
 test_request_partial_firmware_into_buf 0 10
@@ -472,25 +480,7 @@ test_request_partial_firmware_into_buf 2 10
 # a hung task, which would require a hard reset.
 echo
 echo "Testing with the file missing..."
-for i in $(seq 1 5); do
-	test_batched_request_firmware_nofile $i
-done
-
-for i in $(seq 1 5); do
-	test_batched_request_firmware_into_buf_nofile $i
-done
-
-for i in $(seq 1 5); do
-	test_batched_request_firmware_direct_nofile $i
-done
-
-for i in $(seq 1 5); do
-	test_request_firmware_nowait_uevent_nofile $i
-done
-
-for i in $(seq 1 5); do
-	test_request_firmware_nowait_custom_nofile $i
-done
+do_tests nofile _nofile
 
 # Partial loads cannot use fallback, so do not repeat tests.
 test_request_partial_firmware_into_buf_nofile 0 10
@@ -505,48 +495,12 @@ xz -9 -C crc32 -k $FW
 config_set_name $NAME
 echo
 echo "Testing with both plain and xz files present..."
-for i in $(seq 1 5); do
-	test_batched_request_firmware $i both
-done
-
-for i in $(seq 1 5); do
-	test_batched_request_firmware_into_buf $i both
-done
-
-for i in $(seq 1 5); do
-	test_batched_request_firmware_direct $i both
-done
-
-for i in $(seq 1 5); do
-	test_request_firmware_nowait_uevent $i both
-done
-
-for i in $(seq 1 5); do
-	test_request_firmware_nowait_custom $i both
-done
+do_tests both
 
 # test with only xz file present
 mv "$FW" "${FW}-orig"
 echo
 echo "Testing with only xz file present..."
-for i in $(seq 1 5); do
-	test_batched_request_firmware $i xzonly
-done
-
-for i in $(seq 1 5); do
-	test_batched_request_firmware_into_buf $i xzonly
-done
-
-for i in $(seq 1 5); do
-	test_batched_request_firmware_direct $i xzonly
-done
-
-for i in $(seq 1 5); do
-	test_request_firmware_nowait_uevent $i xzonly
-done
-
-for i in $(seq 1 5); do
-	test_request_firmware_nowait_custom $i xzonly
-done
+do_tests xzonly
 
 exit 0
-- 
2.26.2

