Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 115E034721C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 08:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235722AbhCXHLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 03:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbhCXHLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 03:11:19 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FA6C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 00:11:19 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id v2so14018019pgk.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 00:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hOA91KZa0RMsWzyqfvojmi3qgn7CmaL9hdafy/3G/PU=;
        b=I/b9W7kpZi+CIhPY6lPlilbc3jUaW8nUIEs4nb/p/rMXp8iaZ4o2JnOKFdU5CDX6e7
         Zi/U8zdOC0ipDmTbew3PIAbZNQhlQBQ67d5IHmIrpdYvYNTsNP9wxADZZu1BUdeyPInu
         svYzUDfZc+P6CJPFmMGXswNSvTThblbVayD/9aaWojYg8PJqgAv7tenKL6zt6ikT2PtO
         SUYLx1RdAGK26O1DeJO145O9EFVLNDyo5XpUC5lzbvoS6vPmr3PpRRq1oNcojl0fNvlW
         de0HCwAzCEOs28CeXXkHJRLfO22C0gPnTDUAe/bted/5C4b6n0HEVZCxM0+Sh7BEWe/6
         y/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hOA91KZa0RMsWzyqfvojmi3qgn7CmaL9hdafy/3G/PU=;
        b=Y9Ey3H1DGIEyzBFaujiTjPFVsACr1wkyDw0qMcQJBLDDgl/dlkXJx6hCNchPEeB2CA
         FmVuaW4LeZTHJPhdgUAo3rUTqKn5GtVllXrBuduY9xUZo7DzkfEyo/Zzi7+w9YduCs1s
         Gk6OD89y2eEUo70K48TG/kA1/nXscv7tA+VzeiCqYE8oHDg0ya3XhDiHmuv2swNNXzIt
         TaI6UqITRnfZCW+JI89yJBEcIbx5k5jBCmt1liJXFuYDHAdMoRsfMOZWRNdgg1mjt9J2
         rViQNPEmWz4H5IQYVSDfjsgjqEDIomZ5DLEM4e27AgnhzGyIMSYlpn24B6/CXeMf6fIk
         GR6Q==
X-Gm-Message-State: AOAM5319xAMR5r7TkUfdTEzWRmT59Z0EIu/7vobLOs+ekfMngP1kw3oK
        BFLzMfkJZN58ATkVNQxAH3A=
X-Google-Smtp-Source: ABdhPJwLYAWgQaP1UcYs/Cegu1/Zm7QiDDKTAHx52iKAF48gjiP5QWzwXqWXcJFRh63vkGwAvN/PdA==
X-Received: by 2002:a05:6a00:c1:b029:20f:1d03:7177 with SMTP id e1-20020a056a0000c1b029020f1d037177mr1981055pfj.17.1616569878872;
        Wed, 24 Mar 2021 00:11:18 -0700 (PDT)
Received: from localhost.localdomain (ctf2.cs.nctu.edu.tw. [140.113.209.24])
        by smtp.gmail.com with ESMTPSA id gz4sm1234228pjb.0.2021.03.24.00.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 00:11:18 -0700 (PDT)
From:   Tim Yang <tl445047925@gmail.com>
To:     dvyukov@google.com
Cc:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Tim Yang <tl445047925@gmail.com>
Subject: [PATCH] kernel: kcov: fix a typo in comment
Date:   Wed, 24 Mar 2021 15:10:51 +0800
Message-Id: <20210324071051.55229-1-tl445047925@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a typo in comment.

Signed-off-by: Tim Yang <tl445047925@gmail.com>
---
 kernel/kcov.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index 80bfe71bbe13..6f59842f2caf 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -527,7 +527,7 @@ static int kcov_get_mode(unsigned long arg)
 
 /*
  * Fault in a lazily-faulted vmalloc area before it can be used by
- * __santizer_cov_trace_pc(), to avoid recursion issues if any code on the
+ * __sanitizer_cov_trace_pc(), to avoid recursion issues if any code on the
  * vmalloc fault handling path is instrumented.
  */
 static void kcov_fault_in_area(struct kcov *kcov)
-- 
2.25.1

