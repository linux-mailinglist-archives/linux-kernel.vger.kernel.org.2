Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 814DC32F2F1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 19:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhCESkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 13:40:23 -0500
Received: from mga05.intel.com ([192.55.52.43]:37580 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230269AbhCESkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 13:40:02 -0500
IronPort-SDR: n3Cp1u/za9n4ZJCwMldIZq9eUNBNPoFzLYz6huS9QHXzIXBCqEoTrQIsYu1pGFhHRCRviAlPMa
 VRg9QwyS6Vcg==
X-IronPort-AV: E=McAfee;i="6000,8403,9914"; a="272715775"
X-IronPort-AV: E=Sophos;i="5.81,226,1610438400"; 
   d="scan'208";a="272715775"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2021 10:40:01 -0800
IronPort-SDR: zkxbpHsFyJwZVkSR/xlj1BUO0klvYJqhJesQcjjaw3i4SkMt1Xy5PuHjfxJk9aoU9ufyI/imsj
 RKtpPGMBEdXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,226,1610438400"; 
   d="scan'208";a="370304005"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 05 Mar 2021 10:40:00 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5C719132; Fri,  5 Mar 2021 20:40:00 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Borislav Petkov <bp@suse.de>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] scripts/decodecode: Decode 32-bit code correctly on x86_64
Date:   Fri,  5 Mar 2021 20:39:48 +0200
Message-Id: <20210305183948.37738-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On x86_64 host the objdump uses current architecture which is 64-bit
and hence decodecode shows wrong instructions.

Fix it by supplying '-M i386' in case of ARCH i?86 or x86.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 scripts/decodecode | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/scripts/decodecode b/scripts/decodecode
index 31d884e35f2f..020a84982249 100755
--- a/scripts/decodecode
+++ b/scripts/decodecode
@@ -75,21 +75,25 @@ disas() {
 
 	${CROSS_COMPILE}as $AFLAGS -o $t.o $t.s > /dev/null 2>&1
 
-	if [ "$ARCH" = "arm" ]; then
+	case "$ARCH" in
+	arm)
 		if [ $width -eq 2 ]; then
 			OBJDUMPFLAGS="-M force-thumb"
 		fi
 
 		${CROSS_COMPILE}strip $t.o
-	fi
-
-	if [ "$ARCH" = "arm64" ]; then
+		;;
+	arm64)
 		if [ $width -eq 4 ]; then
 			type=inst
 		fi
 
 		${CROSS_COMPILE}strip $t.o
-	fi
+		;;
+	i?86|x86)
+			OBJDUMPFLAGS="-M i386"
+		;;
+	esac
 
 	if [ $pc_sub -ne 0 ]; then
 		if [ $PC ]; then
-- 
2.30.1

