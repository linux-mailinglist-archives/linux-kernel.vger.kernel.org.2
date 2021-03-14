Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBFBE33A2BF
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 06:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbhCNFJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 00:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhCNFJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 00:09:23 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DEDC061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 21:09:22 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id z190so28625003qka.9
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 21:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OIER2FStt2RnHoMWp+ZnilVL13UULLynSzYONsk5UYs=;
        b=m4314wVnFUSddEXyAUnKlKbwcRJyVf0L8Be15jre9bklG3xdmk90K62fLO54LQZml3
         JMneNnxeVDE8jrik/vd3d8WWshOLkvFWMFM+bEW08Btmi2l4ssGcgVeSgiowaPK1TBi8
         z1mMBpeFfBawURI+nGM7Lr/XV/tJNtS/Z+QMzLmVmd8ikTINCYiK2KbkL1mfX3KVMdJN
         YsNRckvg0+kD5II83fljPLZij4kFSnOD6dpNxkHC0jzpmF9KgZdzOKlJAfiNfQYYgft7
         JT9gYlUoY/i7tKJgcLnzvrpRt2p6/tqUpCv1OR/Igz9dFJSzWP/QTp6Cccd8AJfIuJSf
         a0jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OIER2FStt2RnHoMWp+ZnilVL13UULLynSzYONsk5UYs=;
        b=d8N4wnpCsS4EUG6iEKZusROlNGW2zXIojwaOD5dwHfXRMKJzyyRNMVD/dvvkCUktlW
         4GNtsBlPHht7QktGTP8zIn4ZRE7XXL/od0zRACUdNXB55S3Qg608aqLu32EQkres3ZOV
         rT/Bkp1FdEFA/MECNstE83z47xW/MfYlu2jY4q0AUdSi/z0EZBz7K/IVRAH7R6IoeDCg
         TLAD1XTiLCtkYaUAKOr9eUWkvxBft0Szz8MNOnNYtGNLWflURY3AOfVeSF539eW24H8x
         QsxS8lw9uIcyfMJvjDNy/D2/Pic6SKztqSNbf2UG9nkY/ldjFlaD25CVzLJMRtC15xmB
         7mdQ==
X-Gm-Message-State: AOAM531wZkemIfdcpV18iO0USayel9rhM+Q8eo68JnGdqk2X1HpR8FH3
        aPKOd7nIJAyrL7+r6Qkf4EE=
X-Google-Smtp-Source: ABdhPJyOEy7K6cYSgkG/nj8Cu6eUDAeKYquaZMcuyqx1t2/C3iqx6E/Pe55bd9Z7X3L/WbbEwq1wDg==
X-Received: by 2002:a37:a0d1:: with SMTP id j200mr19632951qke.426.1615698561948;
        Sat, 13 Mar 2021 21:09:21 -0800 (PST)
Received: from localhost.localdomain ([37.19.198.30])
        by smtp.gmail.com with ESMTPSA id m21sm8186364qka.28.2021.03.13.21.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 21:09:21 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     rostedt@goodmis.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] kernel: trace: A typo fix in the file trace_event_perf.c
Date:   Sun, 14 Mar 2021 10:36:56 +0530
Message-Id: <20210314050656.9402-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/suprises/surprises/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 kernel/trace/trace_event_perf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
index a71181655958..d1eac45b79d2 100644
--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -16,7 +16,7 @@ static char __percpu *perf_trace_buf[PERF_NR_CONTEXTS];

 /*
  * Force it to be aligned to unsigned long to avoid misaligned accesses
- * suprises
+ * surprises
  */
 typedef typeof(unsigned long [PERF_MAX_TRACE_SIZE / sizeof(unsigned long)])
 	perf_trace_t;
--
2.26.2

