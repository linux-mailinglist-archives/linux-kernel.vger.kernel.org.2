Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE903427F4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 22:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbhCSVoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 17:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbhCSVoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 17:44:01 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE96C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 14:44:01 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id q3so4496547qkq.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 14:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jDv3Vwcwrzw0s8YLRDszFG/olRN1O25W09Kkt1GWGZo=;
        b=B6JItigGQCd9O1jieLKD20m6/D8V2je0eLdTBXLHOoNkTdyIO51PG6vLXqgjYz4M0W
         t6ADIBVmXI4102r02mNVWMH/6OQGIrC8YHP+1XZMzsB4U5cyrxohu9auHffBqnRAuoaX
         /Mpof4D/O0ZEUyXOQ8KQjkVpuxe58cAq3iM7FIN2N9/l+KEn+mQVzmqfOqMOSRPwOQtH
         Rw245DRJKmcj6owpm5nyPj4/x5MeoIjfM566oHvw6GCv2f/nXjJGAZLfa8n+PpVur8Td
         sjD7CpsmSfIlgY4XB+60qH3q+HL0qBwH4Bn2Av9K+/7piAnPw8G9OtrMIkSchpjhFRTO
         J3+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jDv3Vwcwrzw0s8YLRDszFG/olRN1O25W09Kkt1GWGZo=;
        b=Zd3ou0PF7C8KCZsFT8SdN4c6wtQLlGgIUMhrIUIRxQ3vmqTW3Q+VYENawXpj0SFgpg
         op4bOYHdlYfh2yPDjjyu46QgGdNK1ZZ9+SGBTLCEEY7GQw+7eH829jlmHEzzmVdJynQe
         kdjI2J1G4iqoCXmWgC6Hox6mQ28dtRuRfBwgyuFil4Xylt40lFUCKRh3IPQCbrKJBwGd
         sOOdj+8D54DIuzNCNybpSqHT3yFjTLrTvgnM3EYzsOsLQaanvxkmh3zPNULRWNJxg4VH
         XC/zD7THC9e/0eWuWQrwbXbsHIAZYqpyt3fWVEjp+pVQCUeF5chpm8yEdDcUYZ8Fpw44
         aAmg==
X-Gm-Message-State: AOAM530Yx2YBSk6eR92LVj9GUkPprJaPVpByMHkT81lnQPNdKLbipvwv
        cpji0NSpycdx20NxiqTgctM=
X-Google-Smtp-Source: ABdhPJzdlezScCktKDt+uM7MB7bvhvoXvdUxXy8/b2b8OSCwP7HNtvy7lCMyV5J4/ay7aupJGhtuhA==
X-Received: by 2002:a37:8905:: with SMTP id l5mr661875qkd.321.1616190240448;
        Fri, 19 Mar 2021 14:44:00 -0700 (PDT)
Received: from localhost.localdomain ([37.19.198.27])
        by smtp.gmail.com with ESMTPSA id g4sm754452qtg.86.2021.03.19.14.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 14:43:59 -0700 (PDT)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     catalin.marinas@arm.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] mm: kmemleak: Fix a typo
Date:   Sat, 20 Mar 2021 03:11:40 +0530
Message-Id: <20210319214140.23304-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


s/interruptable/interruptible/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 mm/kmemleak.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index c0014d3b91c1..f09f1a9402a9 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1202,7 +1202,7 @@ static void update_refs(struct kmemleak_object *object)
 }

 /*
- * Memory scanning is a long process and it needs to be interruptable. This
+ * Memory scanning is a long process and it needs to be interruptible. This
  * function checks whether such interrupt condition occurred.
  */
 static int scan_should_stop(void)
--
2.26.2

