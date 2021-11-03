Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4534441D6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 13:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbhKCMsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 08:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbhKCMsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 08:48:05 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D78EC061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 05:45:29 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id g184so2274076pgc.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 05:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y2nSdHgQfwg8AfD5xMlGZZ/kVCHjM8ptgo0r0VuianE=;
        b=aQPZScxUmVjCRzlQXRTFdCH5gp2ztq0r6esSpLRy+kIDyERPZDmCSrcZ/ja5Kbx//E
         znsm/D78DODY9jj8LScuX51+XhiIeHn/rJ0PWIedRIoFVgywDwyT4FF/6rPrH5qESVXA
         qwyFuv+R4IXVYmimi2u0QvW4R4Cr98jeZYHhjJQ9ljy/d1sVJYBvJRFBzKAK3Z/lhNjr
         7fEGuMOaeR5En7ELQ8QtX5aQ/xzBhlysXM7oosXPTaDl7EO+TCss9AB60m9BbhOX4CGC
         r2MpMlTiY9CJ6riN3qRPX67BTzyc+VRasMQKCFkmDgt9cAMry6+qA1cDg59yV2Qt0+YV
         SHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y2nSdHgQfwg8AfD5xMlGZZ/kVCHjM8ptgo0r0VuianE=;
        b=qeYrull0OJes/yBhAookwbL05IPwDbqxUUwZh5xJ4twhRDYtmw1aac99Pp2wA71I6F
         V6js9MwpOUz75h1EHhy8wWp0CgBLUijUZpB0ulqacTgTGaY3fHeBcGNZF0rZ+nStZ2Ci
         4+H86PF7q85GryRcw1YJbIordKy5NKU+n9fyAckIomP5DzIlhA9XX9PXc4ouVMMJJnGP
         F9Ar56fz8gANXBiFbdIXcNwVV1B+ga+03yAevqqOS4vowTNFAdEFeurA5tzonu+D+6TI
         CJT7GjXqAAFm8SEXwdgpIfOMow1bVEpCUq7qL2G4kLU6E71NEVdcTEID4uMX24N3Q8Pv
         Q2aw==
X-Gm-Message-State: AOAM5330F/EkKrtbQD66mGsXW9ClmzcirNFTiovYmDPHWlqG7qP8iqS+
        qYX/YMHaY1GKMQcmL1BvU7Y=
X-Google-Smtp-Source: ABdhPJwDk4qWexpr+V0Fh42A8OX7yL6sR8mptZHDoR7vislj6OWKaB1/Pufw8wmmTw6zx5g72wUALQ==
X-Received: by 2002:a63:2147:: with SMTP id s7mr30086807pgm.140.1635943528451;
        Wed, 03 Nov 2021 05:45:28 -0700 (PDT)
Received: from kushal ([115.96.218.96])
        by smtp.gmail.com with ESMTPSA id 1sm2206743pfm.163.2021.11.03.05.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 05:45:28 -0700 (PDT)
From:   Kushal Kothari <kushalkothari285@gmail.com>
To:     rppt@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mike.rapoport@gmail.com,
        kushalkothari2850@gmail.com
Cc:     Kushal Kothari <kushalkothari285@gmail.com>
Subject: [PATCH v2] mm: Fix ERROR:do not initialise statics to 0 or NULL in memblock.c
Date:   Wed,  3 Nov 2021 18:15:23 +0530
Message-Id: <20211103124523.10670-1-kushalkothari285@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default value of static variable is zero and bool is false so
not need to set it here.
This patch fixes this ERROR in memblock.c
Error found with checkpatch.pl.

Signed-off-by: Kushal Kothari <kushalkothari285@gmail.com>
---

Changes in v2: Correct the subject line and remove <stdbool.h> which isn't
necessary 

 mm/memblock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 5c3503c98b2f..9e2b7c1dbd03 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -152,10 +152,10 @@ static __refdata struct memblock_type *memblock_memory = &memblock.memory;
 	} while (0)
 
 static int memblock_debug __initdata_memblock;
-static bool system_has_some_mirror __initdata_memblock = false;
+static bool system_has_some_mirror __initdata_memblock;
 static int memblock_can_resize __initdata_memblock;
-static int memblock_memory_in_slab __initdata_memblock = 0;
-static int memblock_reserved_in_slab __initdata_memblock = 0;
+static int memblock_memory_in_slab __initdata_memblock;
+static int memblock_reserved_in_slab __initdata_memblock;
 
 static enum memblock_flags __init_memblock choose_memblock_flags(void)
 {
-- 
2.25.1

