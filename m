Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B419C306035
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 16:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235625AbhA0PvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 10:51:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:50374 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235953AbhA0PuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 10:50:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DE9F2AE76;
        Wed, 27 Jan 2021 15:49:40 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC 3/4] selftest: firmware: Fix the request_firmware_into_buf() test for XZ format
Date:   Wed, 27 Jan 2021 16:49:38 +0100
Message-Id: <20210127154939.13288-4-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210127154939.13288-1-tiwai@suse.de>
References: <20210127154939.13288-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The test uses a different firmware name, and we forgot to adapt for
the XZ compressed file tests.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 tools/testing/selftests/firmware/fw_filesystem.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/firmware/fw_filesystem.sh b/tools/testing/selftests/firmware/fw_filesystem.sh
index 2424a97da65b..f1976e650672 100755
--- a/tools/testing/selftests/firmware/fw_filesystem.sh
+++ b/tools/testing/selftests/firmware/fw_filesystem.sh
@@ -492,6 +492,7 @@ test "$HAS_FW_LOADER_COMPRESS" != "yes" && exit 0
 
 # test with both files present
 xz -9 -C crc32 -k $FW
+xz -9 -C crc32 -k $FW_INTO_BUF
 config_set_name $NAME
 echo
 echo "Testing with both plain and xz files present..."
@@ -499,6 +500,7 @@ do_tests both
 
 # test with only xz file present
 mv "$FW" "${FW}-orig"
+mv "$FW_INTO_BUF" "${FW_INTO_BUF}-orig"
 echo
 echo "Testing with only xz file present..."
 do_tests xzonly
-- 
2.26.2

