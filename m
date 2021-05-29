Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9860394DFE
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 22:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhE2UD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 16:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbhE2UDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 16:03:53 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FECC06174A
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:17 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id a13so2553512oid.9
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9c/jewxPCWAXySvELUdq/qwVXLJZWJe6/GqALNqnijY=;
        b=asPM6+lFwiR9wGWh2urUrcW8H97Kf3hXt2nTw51TJRh/qL1zp9pUiCqZHuMxrhaNpV
         qQOFm/XJfuB61vhE0fK+t5VjClr7kBflfjHg+cuMu31EqMr3BFYoLmaXpIpXBAPIRZAs
         Pgq2lzUssxHfyKbW7uRkXSUgQYJaa9K3SRUl0b4d3VAb5fYrEk8x52EC8pnyoPJ43LFs
         JHPzdEAkW60VPxwN0i4vC7/KbZuNh08DYu4PTstsDYO2cZYfR/VfPAifBg1A5UpW4iMr
         qxipOyvk9Owy1esN5IW1+KyV8S1hETjTeh4xYI0L5tPvL//KFTpD3Lv4ESiLwChWySgN
         Xfsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9c/jewxPCWAXySvELUdq/qwVXLJZWJe6/GqALNqnijY=;
        b=cS1kgvdWiVmS/LiiRYOxhFkNQHDRz8YpcxqNcbcJsRGkwVyeIr+bZP+E5BlPln2J9/
         sQ7tdXvGlgSpz79dDuo3vvBN6xtQhlNC+vEVOuA27qcH81RS4OsC8oYECW2djlufDzow
         5cc4sWlBQS130lrkzIZn2kw/blCTAs/q6G5DCYFzDF4RYpgRmzevflLmVLgQRPaCc8vz
         TV8ARTUaCXjtJoyTwmAKAYvuqtDSKpE/rvh5zoUQ1CtTzAhzxvc9acl+g/k6mImSscFK
         yHqGnZOi8PM0efE4n4Rn6tWxDGfYRk0xoDgRIv+afCCXRU4poYS7SANGgXev5IpXycvC
         bpeg==
X-Gm-Message-State: AOAM533g/eGNUDvzUYEUoJBCuxn7Z82rqVqdeAAiAn4VWI5MdLvfPkkC
        ZjsA4C+gyGwmnQamlBNTaJc=
X-Google-Smtp-Source: ABdhPJwyDbLyB9+eOAqJkX5ohHCLIIUiAQBTRpvHoX8f1i6NuGXCovmA5+oEWKHtLrLwX5FcWIjVUg==
X-Received: by 2002:aca:d409:: with SMTP id l9mr9939696oig.77.1622318536577;
        Sat, 29 May 2021 13:02:16 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t39sm1868064ooi.42.2021.05.29.13.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 13:02:16 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v6 03/34] dyndbg: display KiB of data memory used.
Date:   Sat, 29 May 2021 13:59:58 -0600
Message-Id: <20210529200029.205306-4-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210529200029.205306-1-jim.cromie@gmail.com>
References: <20210529200029.205306-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If booted with verbose>=1, dyndbg prints the memory usage in bytes,
of builtin modules' prdebugs.  KiB reads better.

no functional changes.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 3a7d1f9bcf4d..ab8fc16911ae 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1117,9 +1117,9 @@ static int __init dynamic_debug_init(void)
 		goto out_err;
 
 	ddebug_init_success = 1;
-	vpr_info("%d modules, %d entries and %d bytes in ddebug tables, %d bytes in __dyndbg section\n",
-		 modct, entries, (int)(modct * sizeof(struct ddebug_table)),
-		 (int)(entries * sizeof(struct _ddebug)));
+	vpr_info("%d prdebugs in %d modules, %d KiB in ddebug tables, %d kiB in __dyndbg section\n",
+		 entries, modct, (int)((modct * sizeof(struct ddebug_table)) >> 10),
+		 (int)((entries * sizeof(struct _ddebug)) >> 10));
 
 	/* apply ddebug_query boot param, dont unload tables on err */
 	if (ddebug_setup_string[0] != '\0') {
-- 
2.31.1

