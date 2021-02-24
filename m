Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 470883238A4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 09:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbhBXIam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 03:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbhBXIaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 03:30:35 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601A5C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 00:29:53 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id w19so1362370qki.13
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 00:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RpU7wiB2viRDoJBxDY+B8fHhVuUV2u2xnN7aurcCHGA=;
        b=eECcClOIr8qPSiuoNP4nPtCCAjLglclTXMYZNWJOm1vRucLfGDVkhQE5YaUj1NL1wt
         88dIIakQzaDVFDBtDpfBUTLVTgP2fGVpXFU5bjh5rQumuhTRKLpOA8HLLBtFq8Fa8e7A
         2qNQRJsfP5Zu3XW66L8nEzwephpMAvaLUr3SCsbp2ot7y0lNjjHm1PR25bdbNg29V33Z
         uj90T4EqPamref4uagpeVWQIMxdjjLE7gXIMqL56iDQkABzm0bRvFzyLEXaZT4RF1edq
         G/1OJL6bLrCPGY23i6uQkVu4DL0Evij/NDVKTmiHvVVZr6S1sFe48Xw1X4yOoQqddr4d
         SsdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RpU7wiB2viRDoJBxDY+B8fHhVuUV2u2xnN7aurcCHGA=;
        b=ZeyQYcA5fNBx9sn74zZ7I7RAYzuk9NrVrcaPOy6WB+3WVJh+E9js33utmpFQFOj5NP
         +09Pujubf4LBHtBc8jyff/B0KZV7Uj/MLJC8drC1aYZFjmWDINjVVwFC6YE6SF2sC9tb
         +H2gUXeTTeRnEL0G6JaNyK256UeNcT0o3KC7kFoXNhnM1dS4mE4Hj7ddLARPcxrHKR4U
         QyebAeMVD4PavvOV5BOcQzg0YppZVWj3UVnWDxxjq6EYnTWtZ8adnNjsG+L/OgW3S2T6
         4aIjrO5C+uuXoaG85y6OqdWLbgvMkn7B+9pS+VsbAbTOhDS28j4HY6dwGjUuVBLLGsl/
         adOA==
X-Gm-Message-State: AOAM530RQkoM/2q4ZRdzbDJ6YPBKdKcEMeZ5McMYSm4ZwyQOQRtIwLYr
        pV10E4J5a8AZH8LVancKyUc=
X-Google-Smtp-Source: ABdhPJxT8Akg+rYB8nhD2e/0WTqS0ONFv62PaPns8jpnaZvq9Nskyue1Q21uivfjwMzuaPw63NcwMw==
X-Received: by 2002:a05:620a:11aa:: with SMTP id c10mr29275306qkk.35.1614155392711;
        Wed, 24 Feb 2021 00:29:52 -0800 (PST)
Received: from localhost.localdomain ([156.146.55.69])
        by smtp.gmail.com with ESMTPSA id q6sm1003206qkd.41.2021.02.24.00.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 00:29:52 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] arch: x86: mm: Fix compied to compiled in the file init.c
Date:   Wed, 24 Feb 2021 13:59:42 +0530
Message-Id: <20210224082942.863874-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/compied/compiled/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 arch/x86/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index dd694fb93916..34a1f1e19c86 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -29,7 +29,7 @@

 /*
  * We need to define the tracepoints somewhere, and tlb.c
- * is only compied when SMP=y.
+ * is only compiled when SMP=y.
  */
 #define CREATE_TRACE_POINTS
 #include <trace/events/tlb.h>
--
2.30.1

