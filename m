Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C39430603D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 16:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236645AbhA0Pwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 10:52:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:50382 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235972AbhA0PuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 10:50:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EDB0CAE8D;
        Wed, 27 Jan 2021 15:49:40 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC 4/4] selftest: firmware: Add ZSTD compressed file tests
Date:   Wed, 27 Jan 2021 16:49:39 +0100
Message-Id: <20210127154939.13288-5-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210127154939.13288-1-tiwai@suse.de>
References: <20210127154939.13288-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's similar like XZ compressed files.  For the simplicity, both XZ
and ZSTD tests are done in a single function.  The format is specified
via $COMPRESS_FORMAT and the compression function is pre-defined.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 .../selftests/firmware/fw_filesystem.sh       | 75 ++++++++++++++-----
 tools/testing/selftests/firmware/fw_lib.sh    | 12 ++-
 2 files changed, 64 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/firmware/fw_filesystem.sh b/tools/testing/selftests/firmware/fw_filesystem.sh
index f1976e650672..abaceac83d6e 100755
--- a/tools/testing/selftests/firmware/fw_filesystem.sh
+++ b/tools/testing/selftests/firmware/fw_filesystem.sh
@@ -211,7 +211,7 @@ read_firmwares()
 	else
 		fwfile="$FW"
 	fi
-	if [ "$1" = "xzonly" ]; then
+	if [ "$1" = "componly" ]; then
 		fwfile="${fwfile}-orig"
 	fi
 	for i in $(seq 0 3); do
@@ -235,7 +235,7 @@ read_partial_firmwares()
 		fwfile="${FW}"
 	fi
 
-	if [ "$1" = "xzonly" ]; then
+	if [ "$1" = "componly" ]; then
 		fwfile="${fwfile}-orig"
 	fi
 
@@ -409,10 +409,8 @@ test_request_firmware_nowait_custom()
 	config_unset_uevent
 	RANDOM_FILE_PATH=$(setup_random_file)
 	RANDOM_FILE="$(basename $RANDOM_FILE_PATH)"
-	if [ "$2" = "both" ]; then
-		xz -9 -C crc32 -k $RANDOM_FILE_PATH
-	elif [ "$2" = "xzonly" ]; then
-		xz -9 -C crc32 $RANDOM_FILE_PATH
+	if [ -n "$2" -a "$2" != "normal" ]; then
+		compress-"$2"-$COMPRESS_FORMAT $RANDOM_FILE_PATH
 	fi
 	config_set_name $RANDOM_FILE
 	config_trigger_async
@@ -488,21 +486,58 @@ test_request_partial_firmware_into_buf_nofile 0 5
 test_request_partial_firmware_into_buf_nofile 1 6
 test_request_partial_firmware_into_buf_nofile 2 10
 
-test "$HAS_FW_LOADER_COMPRESS" != "yes" && exit 0
+test_request_firmware_compressed ()
+{
+	export COMPRESS_FORMAT="$1"
 
-# test with both files present
-xz -9 -C crc32 -k $FW
-xz -9 -C crc32 -k $FW_INTO_BUF
-config_set_name $NAME
-echo
-echo "Testing with both plain and xz files present..."
-do_tests both
+	# test with both files present
+	compress-both-$COMPRESS_FORMAT $FW
+	compress-both-$COMPRESS_FORMAT $FW_INTO_BUF
 
-# test with only xz file present
-mv "$FW" "${FW}-orig"
-mv "$FW_INTO_BUF" "${FW_INTO_BUF}-orig"
-echo
-echo "Testing with only xz file present..."
-do_tests xzonly
+	config_set_name $NAME
+	echo
+	echo "Testing with both plain and $COMPRESS_FORMAT files present..."
+	do_tests both
+
+	# test with only compressed file present
+	mv "$FW" "${FW}-orig"
+	mv "$FW_INTO_BUF" "${FW_INTO_BUF}-orig"
+
+	config_set_name $NAME
+	echo
+	echo "Testing with only $COMPRESS_FORMAT file present..."
+	do_tests componly
+
+	mv "${FW}-orig" "$FW"
+	mv "${FW_INTO_BUF}-orig" "$FW_INTO_BUF"
+}
+
+compress-both-XZ ()
+{
+	xz -k -9 -C crc32 "$@"
+}
+
+compress-componly-XZ ()
+{
+	xz -9 -C crc32 "$@"
+}
+
+compress-both-ZSTD ()
+{
+	zstd -q -k "$@"
+}
+
+compress-componly-ZSTD ()
+{
+	zstd -q --rm "$@"
+}
+
+if test "$HAS_FW_LOADER_COMPRESS_XZ" = "yes"; then
+	test_request_firmware_compressed XZ
+fi
+
+if test "$HAS_FW_LOADER_COMPRESS_ZSTD" = "yes"; then
+	test_request_firmware_compressed ZSTD
+fi
 
 exit 0
diff --git a/tools/testing/selftests/firmware/fw_lib.sh b/tools/testing/selftests/firmware/fw_lib.sh
index 5b8c0fedee76..3fa8282b053b 100755
--- a/tools/testing/selftests/firmware/fw_lib.sh
+++ b/tools/testing/selftests/firmware/fw_lib.sh
@@ -62,7 +62,8 @@ check_setup()
 {
 	HAS_FW_LOADER_USER_HELPER="$(kconfig_has CONFIG_FW_LOADER_USER_HELPER=y)"
 	HAS_FW_LOADER_USER_HELPER_FALLBACK="$(kconfig_has CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y)"
-	HAS_FW_LOADER_COMPRESS="$(kconfig_has CONFIG_FW_LOADER_COMPRESS=y)"
+	HAS_FW_LOADER_COMPRESS_XZ="$(kconfig_has CONFIG_FW_LOADER_COMPRESS_XZ=y)"
+	HAS_FW_LOADER_COMPRESS_ZSTD="$(kconfig_has CONFIG_FW_LOADER_COMPRESS_ZSTD=y)"
 	PROC_FW_IGNORE_SYSFS_FALLBACK="0"
 	PROC_FW_FORCE_SYSFS_FALLBACK="0"
 
@@ -98,9 +99,14 @@ check_setup()
 
 	OLD_FWPATH="$(cat /sys/module/firmware_class/parameters/path)"
 
-	if [ "$HAS_FW_LOADER_COMPRESS" = "yes" ]; then
+	if [ "$HAS_FW_LOADER_COMPRESS_XZ" = "yes" ]; then
 		if ! which xz 2> /dev/null > /dev/null; then
-			HAS_FW_LOADER_COMPRESS=""
+			HAS_FW_LOADER_COMPRESS_XZ=""
+		fi
+	fi
+	if [ "$HAS_FW_LOADER_COMPRESS_ZSTD" = "yes" ]; then
+		if ! which zstd 2> /dev/null > /dev/null; then
+			HAS_FW_LOADER_COMPRESS_ZSTD=""
 		fi
 	fi
 }
-- 
2.26.2

