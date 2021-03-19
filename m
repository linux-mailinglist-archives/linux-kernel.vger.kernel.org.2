Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E560341509
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 06:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbhCSFpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 01:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233829AbhCSFpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 01:45:13 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B21C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 22:45:13 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id w11so2437043ply.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 22:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H2onNyMv0+ob/okZPqoYsmcDlvNeiUOmNnhS+8A8w4M=;
        b=GnMmh68CPHszgAzJpnyZrhj8aF/iSFi5ftsRchbani/IhyClfBBkmy2nvQjjfwVu1P
         Ecrfu2VRVh0iPQXiybZimKsvOx+yCfB3kQeBIAQAE4pkLwKEdNg3ol3k0vBufSSe9R5M
         QimliNXxqnKhAFapQ7UYHL2QCO3ukyGDNDStE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H2onNyMv0+ob/okZPqoYsmcDlvNeiUOmNnhS+8A8w4M=;
        b=YOfmQXvb/Qq6nTpXtr81G1cnbDZ4RUf0x6S3OglAbglbg7+WN7muHqwRrsMYxWDMPq
         n0NNiPQk42tvaI04AOWg6BXuwxjZzoohSyV1vNyiTm5lPhlBr5cEjD/8ZTgXmh+fTLoy
         jvHn4nLdOM2vInxOAELqS75/5rkUPciPWIqymEIL8cpYuvMHO/syevVVch1xkEc3c5oV
         oQaxckJkHHdL1BMrmWnS5kldezh+J4kQNxKTiugGUZJmhPPXXE8ckGSFq+PLqVjVZjb2
         afihDOn0HqDg1TmIEl30jwPmhhSi8UzyMjiYazprgL+aLH/zGW9XbPg7jrnPNTm44zGk
         ggJg==
X-Gm-Message-State: AOAM531E0YYRJkSmZRu5ev4tbUgpJH5scrLZpodXMQaCQSxZ9iCH+9yy
        5c/1TyNnmjdpJBlz9ajaVIUpjsYnqh8fjg==
X-Google-Smtp-Source: ABdhPJw7r9SsAw+c1CMuTxyAUukgu4Z0TtsvbxmQAXmY+8SGS411Ard3SGU/HxPawldPDrYtZ+k1EA==
X-Received: by 2002:a17:90b:1c0e:: with SMTP id oc14mr8043503pjb.188.1616132713095;
        Thu, 18 Mar 2021 22:45:13 -0700 (PDT)
Received: from senozhatsky.flets-east.jp ([2409:10:2e40:5100:6577:f83d:5865:dfac])
        by smtp.gmail.com with ESMTPSA id h16sm3869876pfc.194.2021.03.18.22.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 22:45:12 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Petr Mladek <pmladek@suse.com>, Minchan Kim <minchan@kernel.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] MAINTAINERS: update Senozhatsky email address
Date:   Fri, 19 Mar 2021 14:45:08 +0900
Message-Id: <20210319054508.124762-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I don't check my @gmail.com addresses often enough these days.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 MAINTAINERS | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b2baeb5e4a68..01b000cd5774 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14433,7 +14433,7 @@ F:	kernel/sched/psi.c
 
 PRINTK
 M:	Petr Mladek <pmladek@suse.com>
-M:	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
+M:	Sergey Senozhatsky <senozhatsky@chromium.org>
 R:	Steven Rostedt <rostedt@goodmis.org>
 R:	John Ogness <john.ogness@linutronix.de>
 S:	Maintained
@@ -19293,7 +19293,7 @@ F:	drivers/net/vrf.c
 VSPRINTF
 M:	Petr Mladek <pmladek@suse.com>
 M:	Steven Rostedt <rostedt@goodmis.org>
-M:	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
+M:	Sergey Senozhatsky <senozhatsky@chromium.org>
 R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
 R:	Rasmus Villemoes <linux@rasmusvillemoes.dk>
 S:	Maintained
@@ -19944,7 +19944,7 @@ F:	drivers/staging/media/zoran/
 ZRAM COMPRESSED RAM BLOCK DEVICE DRVIER
 M:	Minchan Kim <minchan@kernel.org>
 M:	Nitin Gupta <ngupta@vflare.org>
-R:	Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
+R:	Sergey Senozhatsky <senozhatsky@chromium.org>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	Documentation/admin-guide/blockdev/zram.rst
@@ -19958,7 +19958,7 @@ F:	drivers/tty/serial/zs.*
 ZSMALLOC COMPRESSED SLAB MEMORY ALLOCATOR
 M:	Minchan Kim <minchan@kernel.org>
 M:	Nitin Gupta <ngupta@vflare.org>
-R:	Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
+R:	Sergey Senozhatsky <senozhatsky@chromium.org>
 L:	linux-mm@kvack.org
 S:	Maintained
 F:	Documentation/vm/zsmalloc.rst
-- 
2.31.0.rc2.261.g7f71774620-goog

