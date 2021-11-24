Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE6FD45CD63
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 20:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351460AbhKXTk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 14:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241791AbhKXTk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 14:40:27 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE5BC061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 11:37:17 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id b67so4103071qkg.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 11:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e1BsTSTQsX92QKnHfYivXq1wYo+pGVyM67U8hfGIOq0=;
        b=JctBCeEdFp7xNsigx3O9psf255XGKsMhL6+EfolZICWlUxxzj6V1hn9JjPf2R65qwM
         Dqd2R5VHHHAfJcQB3BWrLent7OZYZ/Z+OXmwskMQVE4VT66frjWeczy81EtjrnZRf6Gt
         hRKuVPYfJ6K1Gk/PVBY93ThWSTCt8q2c/HcVFKhyuW1JuPRYXqvP5b2byliax6jnlyk3
         IYB9cs/x//BFMb7iBBaPAAmxZdpVtYaLKcaJ8jjk6rHpz1SWIbqUSKoLSFX2TaC/JMFG
         +JwxHIbEL/qoa3vrqCPBKgzONSnuXNf5MSHOgnKFnz5846QpgRT79O0eH7076ZIzHGCS
         cY4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e1BsTSTQsX92QKnHfYivXq1wYo+pGVyM67U8hfGIOq0=;
        b=UkYoGHdK33rb0A+/nPC5hYkJk9ULteVQItvhyM4VYO5E+3a7eUGnj5BjFMq1ABST3X
         oL7pH/HdEm6N9nrNRS+k4Hy6OvRFONkA+GWmyKGf41z3RpbnrPkG5v9+eHtWXf5Nf5Io
         DBZelNa55FGdIlKyf2JWFeejnR3xMjKIaPP+ZFOduWQ2SnL1BGXT7P27aDTMg6zQccvS
         TLFMgqcABlr4Z2kZPBFgxsBLf57EbPAGjJj4vcuIjGH7MZEEOLI4IftlRLlbLMQRwOUp
         okT/Yetez71bBQtXFchRtrP0ti12Wnv/MsiSvNzjxNYK0473K07YXYoIEBzIpPl1d8hs
         Gj8Q==
X-Gm-Message-State: AOAM530y60LWMLCf29iIYHTmA0f3+Gx/RUIfFotjLMnlLGNE0g+Sc358
        ccu/V+OtorL89XMPDLvFhuwvXvnQGEY=
X-Google-Smtp-Source: ABdhPJw6vievJyMuB7j01RKG/h6+pOjItOFwG8w4sZ/fFSkjh747Lfr5kKf1+lrWpkXL84RpKcEQgw==
X-Received: by 2002:a05:620a:a09:: with SMTP id i9mr824353qka.768.1637782636636;
        Wed, 24 Nov 2021 11:37:16 -0800 (PST)
Received: from godwin.fios-router.home (pool-108-18-207-184.washdc.fios.verizon.net. [108.18.207.184])
        by smtp.gmail.com with ESMTPSA id o17sm353716qtv.30.2021.11.24.11.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 11:37:16 -0800 (PST)
From:   Sean Anderson <seanga2@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Zhenliang Wei <weizhenliang@huawei.com>,
        Changhee Han <ch0.han@lge.com>,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>,
        Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v2 2/2] tools/vm/page_owner_sort.c: Support sorting by stack trace
Date:   Wed, 24 Nov 2021 14:37:09 -0500
Message-Id: <20211124193709.1805776-2-seanga2@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211124193709.1805776-1-seanga2@gmail.com>
References: <20211124193709.1805776-1-seanga2@gmail.com>
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

Changes in v2:
- Fix truncated commit message (oops)

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

