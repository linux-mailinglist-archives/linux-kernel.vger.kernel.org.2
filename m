Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9DC3C1DE7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 05:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbhGIDsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 23:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbhGIDsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 23:48:06 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28278C06175F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 20:45:24 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id f5so3926679qvu.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 20:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ah5lKE1KgaSrHINjMzc+1QvbN54WzaVknCFAGgnica8=;
        b=V7cFXGIQ9xTGSjgvKX7oCmAvnKX5hYH/20rTE3J2x7ppO4uGMaO2SB0CmKOeHwmJXN
         eDOrAY2X7ZWetez4ruCTLbssWz/EE9EAGCKgxRjJzbfzUeToD5RtKyEN2YRO4LZvtJ/0
         I3lPeXmGk5fXMN7WUWI62WcbD76RYJTQwF4fG4MMPEU4803qL6kFZ3Nd7/ZUymfCbcFX
         Dz0UNoQ6Ahp7aRJrTscI01MQ6c1Sa8jXBHq7TVxfhUNfzvI4FF/UiSMz0fEKSpD8tMx8
         FJqyJLfMTT37INZFONJ0+XM2D3KJ574xck+lYOmrXECOx4K0kq1oPGFUCdMx9LkxPMX+
         6NRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ah5lKE1KgaSrHINjMzc+1QvbN54WzaVknCFAGgnica8=;
        b=jgUKM3iX4xxAYZ34SlDmlYmE6T9Rb0n8As+EQk9FnsQ8DzGyrcoTPGV6uSnaViYOeH
         7DjiJmy0IKbW1fwiTAqPDWsoX+yy1xc1J6hNx3ykY1uMMjXkOJULK5AuPnOM8LcMlJYF
         +sTp6T5/u4oolg22DunFK2aB1O+Az+kuAz1JF9H97QoV0os3ZWkYae2bfefru6Y0qsjw
         mQ9H/GVL0W016MKUwaQJo+FniJugQoxHx6NE3h2cLXxfGEK5TPzTDDBw/zrAzMQeq8ER
         BF3tzxya9LxC3lxvcZUeyuk5qUKWst0RUyAuouDPMSNXFgX558Ah8ZwomzuIP83XBnzo
         Yvtg==
X-Gm-Message-State: AOAM530rLHaa+o1fwQCBrScilXCK1O9K07qIsc9QetcMFZx56HQPui3M
        wXzLymSKmGTGXBGtttpx2j870X2g0A4=
X-Google-Smtp-Source: ABdhPJxFSE3t8qcA0k+/5DBIPCjRvMWrWcSkapbDaE68hGlikVQ3qeMPHZ/82WynNek4QTcbyXIbfg==
X-Received: by 2002:ad4:458f:: with SMTP id x15mr33618277qvu.36.1625802323134;
        Thu, 08 Jul 2021 20:45:23 -0700 (PDT)
Received: from localhost ([207.98.216.60])
        by smtp.gmail.com with ESMTPSA id h6sm1948876qke.100.2021.07.08.20.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 20:45:22 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/2] lib: bitmap: add performance test for bitmap_print_to_pagebuf
Date:   Thu,  8 Jul 2021 20:45:18 -0700
Message-Id: <20210709034519.2859777-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210709034519.2859777-1-yury.norov@gmail.com>
References: <20210709034519.2859777-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds performance test for a fully set bitmap. Functional tests are
in lib/test_printf.c. 

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/test_bitmap.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 4ea73f5aed41..452d525007da 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -430,6 +430,42 @@ static void __init test_bitmap_parselist(void)
 	}
 }
 
+static void __init test_bitmap_printlist(void)
+{
+	unsigned long *bmap = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	char *buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
+	char expected[256];
+	int ret, slen;
+	ktime_t time;
+
+	if (!buf || !bmap)
+		goto out;
+
+	memset(bmap, -1, PAGE_SIZE);
+	slen = snprintf(expected, 256, "0-%ld", PAGE_SIZE * 8 - 1);
+	if (slen < 0)
+		goto out;
+
+	time = ktime_get();
+	ret = bitmap_print_to_pagebuf(true, buf, bmap, PAGE_SIZE * 8);
+	time = ktime_get() - time;
+
+	if (ret != slen + 1) {
+		pr_err("bitmap_print_to_pagebuf: result is %d, expected %d\n", ret, slen);
+		goto out;
+	}
+
+	if (strncmp(buf, expected, slen)) {
+		pr_err("bitmap_print_to_pagebuf: result is %s, expected %s\n", buf, expected);
+		goto out;
+	}
+
+	pr_err("bitmap_print_to_pagebuf: input is '%s', Time: %llu\n", buf, time);
+out:
+	kfree(buf);
+	kfree(bmap);
+}
+
 static const unsigned long parse_test[] __initconst = {
 	BITMAP_FROM_U64(0),
 	BITMAP_FROM_U64(1),
@@ -669,6 +705,7 @@ static void __init selftest(void)
 	test_bitmap_arr32();
 	test_bitmap_parse();
 	test_bitmap_parselist();
+	test_bitmap_printlist();
 	test_mem_optimisations();
 	test_for_each_set_clump8();
 	test_bitmap_cut();
-- 
2.30.2

