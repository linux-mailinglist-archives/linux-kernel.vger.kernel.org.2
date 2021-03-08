Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDD833081A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 07:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234884AbhCHG20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 01:28:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:39922 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234855AbhCHG2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 01:28:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 999ABAC0C;
        Mon,  8 Mar 2021 06:28:20 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     masahiroy@kernel.org
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH] kbuild: dummy-tools, support MPROFILE_KERNEL checks for ppc
Date:   Mon,  8 Mar 2021 07:28:20 +0100
Message-Id: <20210308062820.6166-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ppc64le checks for -mprofile-kernel to define MPROFILE_KERNEL Kconfig.
Kconfig calls arch/powerpc/tools/gcc-check-mprofile-kernel.sh for that
purpose. This script performs two checks:
1) build with -mprofile-kernel should contain "_mcount"
2) build with -mprofile-kernel with a function marked as "notrace"
   should not produce "_mcount"

So support this in dummy-tools' gcc, so that we have MPROFILE_KERNEL
always true.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Masahiro Yamada <masahiroy@kernel.org>
---
 scripts/dummy-tools/gcc | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/scripts/dummy-tools/gcc b/scripts/dummy-tools/gcc
index 0d0589cf8184..7b10332b23ba 100755
--- a/scripts/dummy-tools/gcc
+++ b/scripts/dummy-tools/gcc
@@ -73,6 +73,15 @@ if arg_contain -S "$@"; then
 		echo "%gs"
 		exit 0
 	fi
+
+	# For arch/powerpc/tools/gcc-check-mprofile-kernel.sh
+	if arg_contain -m64 "$@" && arg_contain -mlittle-endian "$@" &&
+		arg_contain -mprofile-kernel "$@"; then
+		if ! test -t 0 && ! grep -q notrace; then
+			echo "_mcount"
+		fi
+		exit 0
+	fi
 fi
 
 # To set GCC_PLUGINS
-- 
2.30.1

