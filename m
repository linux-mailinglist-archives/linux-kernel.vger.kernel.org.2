Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 272FE30A991
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 15:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbhBAOVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 09:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbhBAOVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 09:21:39 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561A9C061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 06:20:59 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id i9so13352041wmq.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 06:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qm7Jt2x0s9JgF26OHsGV3axILPja8aYp/XWSz+LFWt0=;
        b=y9t+UrASMPrswsDAnJKQyQlHLabM3YdAkO/JaXG/SeTagTDvne4m2pUq1wQdI6Kg7v
         d0WyYshWBrJ4UxduXJETdMjhVw17qruBEb6/Xs3WURsthNVfiKRfsOLFuG5qn1gJMBJj
         7uxV5e+jpZui7pThvEABUZT7kGX0Le+5No+pDiqaULvE1sFnT81Nw6mOrjnCAd1LYleP
         wOT19mCkpgNJtu7gnTReRmzpNObECIwkq5p+VeowfYC+/GNve1IQ7iCbHejRNFaQCPWD
         DIBK5TtAF9xL8qISH3SDDor/FA4BLbl/TODkbUeQa9LI6iU3J6ecHKIxJqpaim6xUs9l
         MJcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qm7Jt2x0s9JgF26OHsGV3axILPja8aYp/XWSz+LFWt0=;
        b=D0A/inwf+RLWTkhnTr7BKM0WPjjbWyC+VkMevGOcWSXPEbjL82J2o5R9K7b4Z9tCSW
         ZZloQ3ugOML/3yzEaibNhDuOafbm+42BHFIr9vgaToyTDokFlPY354UYfPKXnknxE3Nn
         xTwVkgMFd2uUlsEzH3IxRTw7Rkt7Gmql+R+lYXDEYI4Wscoz719d9tYYmNqYMIn2KUGE
         lUweTYp7tLSwoVITKKB/J5Ocv8wWlX5LLSpxpEdbaUC7oUlSj45vQ7FRltpGnan5Yd0X
         PORcxkBnscs79Ay1xwy3VchiG2AQ/uIfe6/VgQyYqSKqb+GWJUqhsjLWdH5XflLltct3
         ZgWg==
X-Gm-Message-State: AOAM532hMM0PMPgK0nmiBJq9urVpuN/NC7UsYNC/4J9ajglCgjuZaqCn
        rbWFg8YtVig7viJS0qvnyto2iw==
X-Google-Smtp-Source: ABdhPJyBZFWnw6y1sShBINT0Yg5ZzaFmerG+/NvkruCBtCPNMHHs7rjHGN0KHfC4hAEoPxAO1XvuQw==
X-Received: by 2002:a1c:f604:: with SMTP id w4mr15427426wmc.39.1612189258057;
        Mon, 01 Feb 2021 06:20:58 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id r25sm29071604wrr.64.2021.02.01.06.20.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Feb 2021 06:20:57 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Georgi Djakov <georgi.djakov@linaro.org>
Subject: [PATCH] mm/page_io: Use pr_alert_ratelimited for swap read/write errors
Date:   Mon,  1 Feb 2021 16:20:55 +0200
Message-Id: <20210201142055.29068-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there are errors during swap read or write, they can easily fill
the log buffer and remove any previous messages that might be useful
for debugging, especially on systems that rely for logging only on
the kernel ring-buffer.

For example, on a systems using zram as swap, we are more likely to
see any page allocation errors preceding the swap write errors if the
alerts are ratelimited.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 mm/page_io.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index 92f7941c6d01..485fa5cca4a2 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -41,9 +41,9 @@ void end_swap_bio_write(struct bio *bio)
 		 * Also clear PG_reclaim to avoid rotate_reclaimable_page()
 		 */
 		set_page_dirty(page);
-		pr_alert("Write-error on swap-device (%u:%u:%llu)\n",
-			 MAJOR(bio_dev(bio)), MINOR(bio_dev(bio)),
-			 (unsigned long long)bio->bi_iter.bi_sector);
+		pr_alert_ratelimited("Write-error on swap-device (%u:%u:%llu)\n",
+				     MAJOR(bio_dev(bio)), MINOR(bio_dev(bio)),
+				     (unsigned long long)bio->bi_iter.bi_sector);
 		ClearPageReclaim(page);
 	}
 	end_page_writeback(page);
@@ -106,9 +106,9 @@ static void end_swap_bio_read(struct bio *bio)
 	if (bio->bi_status) {
 		SetPageError(page);
 		ClearPageUptodate(page);
-		pr_alert("Read-error on swap-device (%u:%u:%llu)\n",
-			 MAJOR(bio_dev(bio)), MINOR(bio_dev(bio)),
-			 (unsigned long long)bio->bi_iter.bi_sector);
+		pr_alert_ratelimited("Read-error on swap-device (%u:%u:%llu)\n",
+				     MAJOR(bio_dev(bio)), MINOR(bio_dev(bio)),
+				     (unsigned long long)bio->bi_iter.bi_sector);
 		goto out;
 	}
 
