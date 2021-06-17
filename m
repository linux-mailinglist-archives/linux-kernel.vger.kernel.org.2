Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFD333AAD2A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 09:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbhFQHQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 03:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhFQHQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 03:16:45 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACA6C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 00:14:38 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id g6so4286739pfq.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 00:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=85RnxmNfZQ8/MVeEvF9lQbp3hYxEIOazME+WV67yzA4=;
        b=WoWz3v0EyTxjrcTz6zPdtAOyfzdEM0oYDtxuYL8Vn1ikwipgwAvrzpFOrlj7MiP+I8
         CKK9HUDMfT130ZgR3Ose/51C9+1qaWb0EabfKRol/zr54NqY6uLr6u+HsMhDjRQYsag7
         2fkKlhtSob0WPxeQFtPrIPPO1StFpF0F76xKiN4XQnDfCojO0fby3adXxN8XzBozLvBj
         scglTCUKWLxqpTfn9gMs1VKMJU8Jxu5qkjIpcUfZXJ69baJUkxkrJUK+F3YcSA9fLkdm
         dcweOKSi9sE3k6GRpYdJ70Vq56szhSwIbktnq/aKdWkv0EtAKnLW8hfoVoXfGM9H8n0c
         OPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=85RnxmNfZQ8/MVeEvF9lQbp3hYxEIOazME+WV67yzA4=;
        b=NXlkWUgmTlDynXa15QDxsNA1739qI+UNVl/2OwLCqwBgKVDyPWhsptxLSjVGpsqdJ0
         qrLg1QVmPhlKFMIEb7Ys90z8B5wl3ikFm/H/6N53F1/bm0Gy6GuFmcFOlHHPeHSwzAgK
         R5oF3SiOG+p6Z9nuybUIDYFGnHo7vnd0BMb1R5ws94PXuTr3HEKrCKT1UYijEALLcCLR
         0Ohx0YEPlDUO6PCLeQBw0yUU5g/0irQ3ouUi1PgHGXgeR/IQpns73CrT07KNITRF2J5q
         EOjb6hNvZKyQK+5IlPrwajoWiKwemUr/E39tmrpVq86IO4JqM0yqWDgB1Wgpq/OXOqm+
         Af5w==
X-Gm-Message-State: AOAM530XMcs74dX+JxCHgv6JC0/Sxcr3TK/6nXaurLh+60cNrLIwm83t
        +XIAeyFywrHVcbRos0EZz8k3Ag==
X-Google-Smtp-Source: ABdhPJwEf0xNVriqJja4agdx+lXj1PRHlOa3NmlQQV3cK9Qq98bQy5O3xdqQsdkemKBSDF9t9WRZ0Q==
X-Received: by 2002:a63:3ec3:: with SMTP id l186mr3592247pga.371.1623914078050;
        Thu, 17 Jun 2021 00:14:38 -0700 (PDT)
Received: from C02ZK051LVCK.local.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id 127sm876869pfe.21.2021.06.17.00.14.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jun 2021 00:14:37 -0700 (PDT)
From:   Xin He <hexin.op@bytedance.com>
To:     tglx@linutronix.de, keescook@chromium.org, swboyd@chromium.org
Cc:     linux-kernel@vger.kernel.org, Xin He <hexin.op@bytedance.com>
Subject: [PATCH] debugobjects: add missing empty function debug_object_active_state()
Date:   Thu, 17 Jun 2021 15:10:27 +0800
Message-Id: <20210617071027.60278-1-hexin.op@bytedance.com>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All other functions are defined for when CONFIG_DEBUG_OBJECTS
is not set.

Signed-off-by: Xin He <hexin.op@bytedance.com>
---
 include/linux/debugobjects.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/debugobjects.h b/include/linux/debugobjects.h
index 8d2dde23e9fb..af0d73d8d29b 100644
--- a/include/linux/debugobjects.h
+++ b/include/linux/debugobjects.h
@@ -99,6 +99,9 @@ static inline void
 debug_object_free      (void *addr, const struct debug_obj_descr *descr) { }
 static inline void
 debug_object_assert_init(void *addr, const struct debug_obj_descr *descr) { }
+static inline void
+debug_object_active_state(void *addr, const struct debug_obj_descr *descr,
+			  unsigned int expect, unsigned int next) { }
 
 static inline void debug_objects_early_init(void) { }
 static inline void debug_objects_mem_init(void) { }
-- 
2.20.1

