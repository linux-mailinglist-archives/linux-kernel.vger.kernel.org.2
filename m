Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A27DA45CD51
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 20:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351487AbhKXTih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 14:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351446AbhKXTh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 14:37:59 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E81AC06173E
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 11:34:46 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id a2so3787197qtx.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 11:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ri2KPYGBCnao6/BnQ4+pDpAprHVTjBGafjmpwI8B0C0=;
        b=hnmLGFTx46ZwC9Zz019yxIeySG8isS4N1Hb+xt0uxyXiedpxlfbVvU0t2Uv7qsM6jg
         grVsJAh7q/zfD4UrSCD+SqQzKKFomfAVn/m3z4w4o4Uka//1RoTZGdm4ZreZp8Rhul5Y
         zdGo7zMlD8xdOjBNuLrfxIJfmaRk6YSixiyP6NXeWqJFCG8d76SSpSUzgBxLehXb3iVY
         WPDsGd7zEbiDFE4Mn5Y0ewPNiWTMJ6/7J53NAC7kRtavdaudJm0TBA4jma8AHZ9rUYEK
         mHqp5g+uu2Il55/+/N/tlhXfnD66q08Pw+m53g6KOh9VhN6YpvdLFWRj7rS79zTMb2Nq
         Fz6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ri2KPYGBCnao6/BnQ4+pDpAprHVTjBGafjmpwI8B0C0=;
        b=M23S/rg6ULIXzok/GHImPzHsW3c6k0p82HNVfILR03dgsp4+FJHPUzuhv/tz4iWS5A
         pCLr19TOkSCrsoDBg855jTxRDRCu+u+Ak1Ix/2TCcTMWjmyfYQ84NQuHLCsYKapzdESU
         k3JKMzpiCrHA2gtsyTMNTDwuwnV3/2jovpeodnqha6Rp/jE8ZfYlCrZDzx9CW55AqSta
         13F8KmEEAhKaSgrCQQJ77K76OdnOueHx91ufcgZxvcp4b8eynRlyIP913wwCXEnps4u3
         hqiEb4fJYiVZ8iMdZ2Bugb6A/qvIbFAcq3NueHjvEz2Rg8G5/91C1i4LPPed1ldT9GxC
         dFHg==
X-Gm-Message-State: AOAM5316cSiAjk+ZQiiO4+9a9vyBhtDoB8ZyJlFTFrkeH1rYJgZQ6juX
        BFGIgfJ+rxP3hkVERRHORdiFOw2c4lM=
X-Google-Smtp-Source: ABdhPJxMF5WxEKEYu6BCd0iKW9S2ETZGQn1bUMt/CFz2UQF5u6ghl4h+M6BEXGOjGcQxn2MVEW8TLA==
X-Received: by 2002:ac8:5f89:: with SMTP id j9mr10309426qta.391.1637782485311;
        Wed, 24 Nov 2021 11:34:45 -0800 (PST)
Received: from godwin.fios-router.home (pool-108-18-207-184.washdc.fios.verizon.net. [108.18.207.184])
        by smtp.gmail.com with ESMTPSA id v2sm352059qkp.72.2021.11.24.11.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 11:34:44 -0800 (PST)
From:   Sean Anderson <seanga2@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Zhang Shengju <zhangshengju@cmss.chinamobile.com>,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Zhenliang Wei <weizhenliang@huawei.com>,
        Changhee Han <ch0.han@lge.com>,
        Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 2/2] tools/vm/page_owner_sort.c: Add
Date:   Wed, 24 Nov 2021 14:34:40 -0500
Message-Id: <20211124193440.1805610-2-seanga2@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211124193440.1805610-1-seanga2@gmail.com>
References: <20211124193440.1805610-1-seanga2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the ability to sort by stacktraces. This is helpful when
comparing multiple dumps of page_owner taken at different times, since
blocks will not be reordered if they were allocated/free'd.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

 tools/vm/page_owner_sort.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/tools/vm/page_owner_sort.c b/tools/vm/page_owner_sort.c
index 9ad3772a294d..b91d3381300c 100644
--- a/tools/vm/page_owner_sort.c
+++ b/tools/vm/page_owner_sort.c
@@ -29,7 +29,6 @@ struct block_list {
 	int page_num;
 };
 
-static int sort_by_memory;
 static regex_t order_pattern;
 static struct block_list *list;
 static int list_size;
@@ -134,13 +133,16 @@ static void add_list(char *buf, int len)
 
 static void usage(void)
 {
-	printf("Usage: ./page_owner_sort [-m] <input> <output>\n"
-		"-m	Sort by total memory. If this option is unset, sort by times\n"
+	printf("Usage: ./page_owner_sort [OPTIONS] <input> <output>\n"
+		"-m	Sort by total memory.\n"
+		"-s	Sort by the stack trace.\n"
+		"-t	Sort by times (default).\n"
 	);
 }
 
 int main(int argc, char **argv)
 {
+	int (*cmp)(const void *, const void *) = compare_num;
 	FILE *fin, *fout;
 	char *buf;
 	int ret, i, count;
@@ -149,10 +151,16 @@ int main(int argc, char **argv)
 	int err;
 	int opt;
 
-	while ((opt = getopt(argc, argv, "m")) != -1)
+	while ((opt = getopt(argc, argv, "mst")) != -1)
 		switch (opt) {
 		case 'm':
-			sort_by_memory = 1;
+			cmp = compare_page_num;
+			break;
+		case 's':
+			cmp = compare_stacktrace;
+			break;
+		case 't':
+			cmp = compare_num;
 			break;
 		default:
 			usage();
@@ -221,10 +229,7 @@ int main(int argc, char **argv)
 		}
 	}
 
-	if (sort_by_memory)
-		qsort(list2, count, sizeof(list[0]), compare_page_num);
-	else
-		qsort(list2, count, sizeof(list[0]), compare_num);
+	qsort(list2, count, sizeof(list[0]), cmp);
 
 	for (i = 0; i < count; i++)
 		fprintf(fout, "%d times, %d pages:\n%s\n",
-- 
2.33.0

