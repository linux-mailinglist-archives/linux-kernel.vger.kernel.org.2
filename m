Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66CB845CD50
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 20:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351435AbhKXTib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 14:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351443AbhKXTh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 14:37:59 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77945C06175A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 11:34:45 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id s9so2479319qvk.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 11:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MAtkxOgfaoEezQQH002axUG92RdTRxxLQl5CdQtZeeY=;
        b=Qgs4k3W+9PKg4TIZniLNnpQOdMOg2LsVKb/KyBBbwlQLR1MQigB2YAPL4TQrtMK8xk
         zi2hL5BSAK8KbZ4fbf4XHuXfDJ3IdNFogveYOslQGHzRey19b4X8nAYfuyJBWyPYGe+4
         w9UEgCagQJ64ecsDt4BNiioFZ8cqifl9dGL8NhKLBK8fD7joEi0mhyVq9xePN1jxmBSu
         A/hWtLFCuKLFZwErunkBx6+tg1bdGgb79GcUqaZgFTrRCvgq0mNEHZTogtJRYSXGEgWr
         jsToMUJiuAnYPP+uL02ZZwL2to5KlkPR1tir8yymLF0Cm+R3z3kIcyS3erP1M7ZGEAhM
         v8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MAtkxOgfaoEezQQH002axUG92RdTRxxLQl5CdQtZeeY=;
        b=OX6X7700HHhF1YRL1EuUKjKchOQ1MihrjQetkHYC4jv7qCsqJiSGvjaiaiBy4T34eI
         RQ8nyMZwfIQuIC+xCbiOoX0o+3mVJg9KPqQJF7Sac7pA5KI6eakrCj40h6z7YTjr6sNS
         sNhqWalvb4YUAlldZcloY6gCvgdd/Etao92BLDzfNhVftALL1gwVz478i529uIgA72Wg
         ucmXv5wT0PgiDw9dKyv459xGXbUORjVNukXPzFBMCIqaO/odQUMVFcHDcezqi9LMCFfW
         haPTWyphs4BHNLVbJOLASXDtBqv9/z36nRTmEpLHXjCKPAoZssnSzJmPGmmTMUALOp5i
         KSoA==
X-Gm-Message-State: AOAM533zt+6WLqwnJHZn+DHmU+BQQ8AH5aUH124BqV1pWTP1kkIisOM/
        B4zCNEj6LDaw9Sgdn9GhgiIEhVcloTE=
X-Google-Smtp-Source: ABdhPJyXf8kWWKro54373VNa5H88ozxG5rdN72g7ohJj5U99fm1tw+50+Z7Px1PIHZU7wRK0AY1qpg==
X-Received: by 2002:a05:6214:2523:: with SMTP id gg3mr10671267qvb.56.1637782484476;
        Wed, 24 Nov 2021 11:34:44 -0800 (PST)
Received: from godwin.fios-router.home (pool-108-18-207-184.washdc.fios.verizon.net. [108.18.207.184])
        by smtp.gmail.com with ESMTPSA id v2sm352059qkp.72.2021.11.24.11.34.43
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
Subject: [PATCH 1/2] tools/vm/page_owner_sort.c: Sort by stacktrace before culling
Date:   Wed, 24 Nov 2021 14:34:39 -0500
Message-Id: <20211124193440.1805610-1-seanga2@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The contents of page_owner have changed to include more information than
the stack trace. On a modern kernel, the blocks look like

Page allocated via order 0, mask 0x0(), pid 1, ts 165564237 ns, free_ts 0 ns
 register_early_stack+0x4b/0x90
 init_page_owner+0x39/0x250
 kernel_init_freeable+0x11e/0x242
 kernel_init+0x16/0x130

Sorting by the contents of .txt will result in almost no repeated pages, as
the pid, ts, and free_ts will almost never be the same. Instead, sort by
the contents of the stack trace, which we assume to be whatever is after
the first line.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

 tools/vm/page_owner_sort.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/vm/page_owner_sort.c b/tools/vm/page_owner_sort.c
index 9ebb84a9c731..9ad3772a294d 100644
--- a/tools/vm/page_owner_sort.c
+++ b/tools/vm/page_owner_sort.c
@@ -23,6 +23,7 @@
 
 struct block_list {
 	char *txt;
+	char *stacktrace;
 	int len;
 	int num;
 	int page_num;
@@ -51,11 +52,11 @@ int read_block(char *buf, int buf_size, FILE *fin)
 	return -1; /* EOF or no space left in buf. */
 }
 
-static int compare_txt(const void *p1, const void *p2)
+static int compare_stacktrace(const void *p1, const void *p2)
 {
 	const struct block_list *l1 = p1, *l2 = p2;
 
-	return strcmp(l1->txt, l2->txt);
+	return strcmp(l1->stacktrace ?: "", l2->stacktrace ?: "");
 }
 
 static int compare_num(const void *p1, const void *p2)
@@ -121,6 +122,7 @@ static void add_list(char *buf, int len)
 	list[list_size].page_num = get_page_num(buf);
 	memcpy(list[list_size].txt, buf, len);
 	list[list_size].txt[len] = 0;
+	list[list_size].stacktrace = strchr(list[list_size].txt, '\n');
 	list_size++;
 	if (list_size % 1000 == 0) {
 		printf("loaded %d\r", list_size);
@@ -199,7 +201,7 @@ int main(int argc, char **argv)
 
 	printf("sorting ....\n");
 
-	qsort(list, list_size, sizeof(list[0]), compare_txt);
+	qsort(list, list_size, sizeof(list[0]), compare_stacktrace);
 
 	list2 = malloc(sizeof(*list) * list_size);
 	if (!list2) {
@@ -211,7 +213,7 @@ int main(int argc, char **argv)
 
 	for (i = count = 0; i < list_size; i++) {
 		if (count == 0 ||
-		    strcmp(list2[count-1].txt, list[i].txt) != 0) {
+		    strcmp(list2[count-1].stacktrace, list[i].stacktrace) != 0) {
 			list2[count++] = list[i];
 		} else {
 			list2[count-1].num += list[i].num;
-- 
2.33.0

