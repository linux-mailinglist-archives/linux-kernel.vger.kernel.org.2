Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747D4341528
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 06:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbhCSFy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 01:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233942AbhCSFyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 01:54:08 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C776EC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 22:54:07 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id q11so2447822pld.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 22:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H2onNyMv0+ob/okZPqoYsmcDlvNeiUOmNnhS+8A8w4M=;
        b=C8SKwinwmwSUzf5AlT9yBNtEOjHhq+9nRDgun2x7axvox9mO9RmbDDOYset/McEz4q
         LJhTTNko1qjcO2Sh1oXzR/iqyl9hsAl0lOMIXFo7Ea+gxhCspcR57FeZ+2llp7BXVYiA
         5gVkJo/EG7KxNMId/41ri84R8fuRz4GsyLWSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H2onNyMv0+ob/okZPqoYsmcDlvNeiUOmNnhS+8A8w4M=;
        b=sobaREvMZyyw1flRdnh2xVcLxC37iF43zLreUuU4WX1z6ejg16zcev/hsPrekztQea
         DG5tFdLT7eFBgiK9maST7OHNmJPqAUvVOLRG6ot0VxvBBoC7sEC7n8tM4/tZA1Ifcrlh
         ljioOZSu+a2cEa/HRE2HjxVXBk8KNxyFckdOHWTRMsVjYF38Xui3ydbudY31OhfDlZTB
         oEkSC3GmRW46PBhx17dy8ehldpRRds4KsKkRL+sxgOxQw8EodbeO8qt8eckl5H+RxMs2
         hBNWUySJMh8jZ8QG5d3T3CA0cPLlxtewjmgoNcg/i9LuDcQMGy9CuKYgDmFRuNG1Bhh3
         g3UA==
X-Gm-Message-State: AOAM533qjciEx3oq4LnN8g4Z1Tm8SzuIIJI5J7/DVPvBokKanfDhBDEx
        gBzi7iHbbvY2k15qpQn2cVPCrg==
X-Google-Smtp-Source: ABdhPJwBJIVaqetY0pJPd1jFqZzlJCm42nUgGVEXObUT1HHZrsn7+lVmW2zrxq8DFoQkuOtzPe/rUA==
X-Received: by 2002:a17:902:9a97:b029:e6:cb9a:292a with SMTP id w23-20020a1709029a97b02900e6cb9a292amr10264047plp.14.1616133247329;
        Thu, 18 Mar 2021 22:54:07 -0700 (PDT)
Received: from senozhatsky.flets-east.jp ([2409:10:2e40:5100:6577:f83d:5865:dfac])
        by smtp.gmail.com with ESMTPSA id o13sm4043704pgv.40.2021.03.18.22.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 22:54:06 -0700 (PDT)
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ricardo Ribalda <ribalda@chromium.org>
Cc:     Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv3 6/6] MAINTAINERS: update Senozhatsky email address
Date:   Fri, 19 Mar 2021 14:53:42 +0900
Message-Id: <20210319055342.127308-7-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
In-Reply-To: <20210319055342.127308-1-senozhatsky@chromium.org>
References: <20210319055342.127308-1-senozhatsky@chromium.org>
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

