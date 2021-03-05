Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5252232F428
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 20:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbhCETmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 14:42:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbhCETmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 14:42:11 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB53C06175F
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 11:42:10 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id z6so1482205wrh.11
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 11:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=PXXsisettvtG626o8G5UFd6fcAq7tGjSyM7Qp09eMjc=;
        b=Ef9tENAmYuuNON1s1900rWv8JzjeyBEGi7mTFEkpGlgve5wKs3C1Y9UcTagGowk6fB
         yncL2YenKxd/8IGJCgDfh2Nf0lybvbVW8/XhDxHJg+CrTnUPkBuAWn8lJujebUmKajPC
         BarhpabND0t0dQuTvpusHQlqSoZm9m3KihUHDdDebWnBvK5saIbI/4IGaEf+ojZ980El
         gjg1otXhhtxylPjvB1/SAQ9XzoO9ZlwB01tZ9sJBM01hMqeVAx8qjF5kI9md1xEoAoGp
         7SSHkxbkzoBxvuedruOTNLrSt43VQZ+3QjpT3BHcaqaXfDXo6oMOwVUmNZ/xmkY0dWmg
         QSaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=PXXsisettvtG626o8G5UFd6fcAq7tGjSyM7Qp09eMjc=;
        b=aFs1IKcqaxBdft0wPlnUt4l19gc4v3xAWp2MOdl0atxjdkVWjd1qnGIM5xk/Eunrgr
         XX/xIxzz9nPdQfxiuNSKhnl+gy3QvrsfwcK5bC2a+1olc2hsWAb17O69epyWb45l8p4J
         fIYAplNm2vPivldXlyQjPS2bOUjUetzZLeWW7obM9gGguUM92cAm/5/sFyFIUn5TmFA5
         j5FB7vHxCuxB+Nz5KxarVqznEUEq1oWovasNKNEXVAHmbbQyQRHuscgGHTqitwK7hCgR
         7C2wxB9puhGCBDaGj8deWeU82HYqEbHRlndEoXLgy2zKkudIGvKbIBEmnSJuTGIHgmrm
         +Nvg==
X-Gm-Message-State: AOAM531o/qWC6HRUvMNp45F0pkB2iJquqyxmqRxSZ6M19jfwC4pWgT5m
        08JNqwPB7Uidk76QQEQnDEW8AhvZIQ==
X-Google-Smtp-Source: ABdhPJx6oXROxqM2BtAkojWNPnIKEm5QF2g7Q/hOAtw/5J/vn/c5F47IiZwhM7r+wDan0JgRrZUv7BZIdg==
Sender: "elver via sendgmr" <elver@elver.muc.corp.google.com>
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:e:611c:f54a:61d6])
 (user=elver job=sendgmr) by 2002:adf:e548:: with SMTP id z8mr11274105wrm.246.1614973329440;
 Fri, 05 Mar 2021 11:42:09 -0800 (PST)
Date:   Fri,  5 Mar 2021 20:42:05 +0100
Message-Id: <20210305194206.3165917-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH 1/2] lib/vsprintf: do not show no_hash_pointers message
 multiple times
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     linux-kernel@vger.kernel.org, vbabka@suse.cz, timur@kernel.org,
        pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not show no_hash_pointers message multiple times if the option was
passed more than once (e.g. via generated command line).

Signed-off-by: Marco Elver <elver@google.com>
---
 lib/vsprintf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 41ddc353ebb8..4a14889ccb35 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -2096,6 +2096,9 @@ EXPORT_SYMBOL_GPL(no_hash_pointers);
 
 static int __init no_hash_pointers_enable(char *str)
 {
+	if (no_hash_pointers)
+		return 0;
+
 	no_hash_pointers = true;
 
 	pr_warn("**********************************************************\n");

base-commit: fe07bfda2fb9cdef8a4d4008a409bb02f35f1bd8
-- 
2.30.1.766.gb4fecdf3b7-goog

