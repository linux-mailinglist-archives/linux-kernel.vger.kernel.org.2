Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCCD45DEC0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 17:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356567AbhKYQuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 11:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356493AbhKYQsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 11:48:10 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF62C0619D4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 08:26:57 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id o17so6619957qtk.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 08:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9uz1IolA8FW7q23QLBe0ePOJRpjEYFd+b9isybJslW0=;
        b=jGdVUjuOnpecTWNFXke1qJ4g8a5fLvoZfllXOdArSxoTVzXKlOERPEAC/+DF/xYUKb
         wln4zoCNJ3bdRpWlG8lRxApXQgqFWMI5HKn+b/A8/y09nBhsdATFsKpCnAIaPqD+BRHV
         LpL6Uakdv9nvbHcp2T7rLgMyea9cCIQGMVU+Raf+92FecQdlHHucWstM7RSGU71S6XwW
         dPC4WOLOC1hI4kt2KRpbEC8F610SAt/T2ZkGLYMQvtlW6qLJ21azyF9UBamWKLKTYFMD
         CxxkKMOymky9FRTS9zRaMkGdqsaoxNOf1bJ9pQXD0HwHBaoQjyfPTdTwsffIlksaqRWQ
         LXlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9uz1IolA8FW7q23QLBe0ePOJRpjEYFd+b9isybJslW0=;
        b=zgaVe/rdEIFysHYzQsADFJWI+K5DLSfxkprF4xoEmtgs8QTIIITfedxvQ0TIJslVcn
         kkFeMwxfBDj61DLez/BA+s6Cx3LkZNroj2d8DBZmjgL/XOywVP2uj6VkPPMjSsIaJewN
         w07fwkGHZc6xrsPM2TVM9piLvHk22Qcy2ikmWZdIV58eegyW5eHn1ChPM5nvsEYu+MyY
         Z8Mm+gSyLNHpbhQ7qhR6A3uf8WJP5z1+A7VB5GAl3sayiM5qRWH+RkuWvKUm7L4yWi72
         K7DIEOyx4trOlMyd0Cv3kQWPNF8AXyXYHPyQQvE6V9weSslLokTr1f+1Y2zjlcMC9fEP
         F2yg==
X-Gm-Message-State: AOAM531EdoDiApuSC5cy2y/1uaxzGeUtikPqPu+vyoKuOIp/7RXbbshp
        31Z8MHK/ms6nNb2vkxFoOqGHbhZzVA4=
X-Google-Smtp-Source: ABdhPJzejcehQXO4UJaFwLPFcjBCc0G4Efm6FAQD7xp42MzdYV7P3Cbk3GSJZzdMwIUur++ASX6y3A==
X-Received: by 2002:a05:622a:287:: with SMTP id z7mr18690016qtw.223.1637857616883;
        Thu, 25 Nov 2021 08:26:56 -0800 (PST)
Received: from godwin.fios-router.home (pool-108-18-207-184.washdc.fios.verizon.net. [108.18.207.184])
        by smtp.gmail.com with ESMTPSA id d9sm1740548qkn.131.2021.11.25.08.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 08:26:56 -0800 (PST)
From:   Sean Anderson <seanga2@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Changhee Han <ch0.han@lge.com>,
        Zhenliang Wei <weizhenliang@huawei.com>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Sean Anderson <seanga2@gmail.com>
Subject: [PATCH] tools/vm/page_owner_sort.c: Fix NULL-pointer dereference when comparing stack traces
Date:   Thu, 25 Nov 2021 11:26:53 -0500
Message-Id: <20211125162653.1855958-1-seanga2@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there is no newline in a block, then strchr returns NULL. We check for
this in stacktrace_compare, but not when culling. Fix this (and any future
bugs like it) by replacing NULL stack traces with "" in add_list.

Fixes: d0abbab9e9e9 ("tools/vm/page_owner_sort.c: sort by stacktrace before culling")
Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

 tools/vm/page_owner_sort.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/vm/page_owner_sort.c b/tools/vm/page_owner_sort.c
index b91d3381300c..1b2acf02d3cd 100644
--- a/tools/vm/page_owner_sort.c
+++ b/tools/vm/page_owner_sort.c
@@ -55,7 +55,7 @@ static int compare_stacktrace(const void *p1, const void *p2)
 {
 	const struct block_list *l1 = p1, *l2 = p2;
 
-	return strcmp(l1->stacktrace ?: "", l2->stacktrace ?: "");
+	return strcmp(l1->stacktrace, l2->stacktrace);
 }
 
 static int compare_num(const void *p1, const void *p2)
@@ -121,7 +121,7 @@ static void add_list(char *buf, int len)
 	list[list_size].page_num = get_page_num(buf);
 	memcpy(list[list_size].txt, buf, len);
 	list[list_size].txt[len] = 0;
-	list[list_size].stacktrace = strchr(list[list_size].txt, '\n');
+	list[list_size].stacktrace = strchr(list[list_size].txt, '\n') ?: "";
 	list_size++;
 	if (list_size % 1000 == 0) {
 		printf("loaded %d\r", list_size);
-- 
2.33.0

