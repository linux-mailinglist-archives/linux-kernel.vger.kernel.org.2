Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B9345CD62
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 20:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244748AbhKXTk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 14:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241791AbhKXTk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 14:40:26 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3089C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 11:37:16 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id f20so3821061qtb.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 11:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=avIkTTEMtm7HXU6RZmssD+R+UdQFA3/5sHLYNKRgvbI=;
        b=bSeudPDhN2iWVqxaZHMOZ6oteygEpuduSpI/+PyLLLpteNHeR1CHav37z+ERfR5M6M
         68oVUsm49ugqezknPZdYGT/zH0EUpseinu5rvzPLwx8ToHy5LrFfb7E0xZ/jXRWkk8dQ
         3GM3jOSgW0VN9u+eww2Bi6pHCjmtO+NZuWpMocRUTjXaMfnnhDjqXe/qm+owLkba9lAQ
         a+t9NH3qdibmDXiSVWcF5PIx17kV++PBoOG7WX7/waHrAUULXBklX0Vrcv24CsVff3H0
         MsmBHyD0A2J3LJYVcIL7CJ+XVRiHC9n2a6ZQ+kJFFSy8F5Z4GDsyTrlLSuCtKJgfQGIf
         uTXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=avIkTTEMtm7HXU6RZmssD+R+UdQFA3/5sHLYNKRgvbI=;
        b=E1VpDnjniMq6eUlawcaF6mJwXpQ7Md6uMhk8fNd3+idS5AfHAn7i3Fw+LmoPRBsgjm
         +Viv/KUQepdmOWlhvDFvLAiCRQhiVPM6Tw8WJr812+QmTI9wnGs96YNX55CkNxZmqzlQ
         bczEYb9OPmc20cvBTaMRFNOF4nN3kWJUYTMoTNVP7lixXni6P2EY7HK3YzFyTLysESxZ
         3DIQpl4O+sGZROYqQNHINBgyfRNZxa4m61n5GeqPyc0t2P3Nb3pR+5DfSFtElHwQV1PV
         qgmnSGstDWUeYPxfMvOelokxAy4DbwzMVBvrAQZBKIe2jf/BarkOH5XsNqMie3o1/sPN
         OBEw==
X-Gm-Message-State: AOAM533tF5Hjb4UIEif32hq4qy3MQlsEgSiLek9MbIRmjffbg0T41J+x
        OgjDRB0ygX5hcCs1sNkBAuKdRjsTLyw=
X-Google-Smtp-Source: ABdhPJxO1/rYnZBHw5Q2Jbguwz1kgZRompZ+R6wVe3i5R7m6hfDWCK1yPWprtR3lRhSoGzJkpJAk6Q==
X-Received: by 2002:ac8:5e47:: with SMTP id i7mr1580172qtx.600.1637782635913;
        Wed, 24 Nov 2021 11:37:15 -0800 (PST)
Received: from godwin.fios-router.home (pool-108-18-207-184.washdc.fios.verizon.net. [108.18.207.184])
        by smtp.gmail.com with ESMTPSA id o17sm353716qtv.30.2021.11.24.11.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 11:37:15 -0800 (PST)
From:   Sean Anderson <seanga2@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Zhenliang Wei <weizhenliang@huawei.com>,
        Changhee Han <ch0.han@lge.com>,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>,
        Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v2 1/2] tools/vm/page_owner_sort.c: Sort by stacktrace before culling
Date:   Wed, 24 Nov 2021 14:37:08 -0500
Message-Id: <20211124193709.1805776-1-seanga2@gmail.com>
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

(no changes since v1)

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

