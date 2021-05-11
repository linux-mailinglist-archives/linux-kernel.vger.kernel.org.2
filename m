Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 313A537A4AB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 12:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbhEKKhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 06:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbhEKKhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 06:37:18 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE3FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 03:36:12 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id m190so15501810pga.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 03:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=20fPsPA+9WTsD5kDBLLT9Sw3U7rjYbUdTtKCGI1Jfrc=;
        b=oVsOUcDmTLpDInKQDoadILZs05yBkCofvmJC0No4oK9c3x5SiipZxCeRLQ4T9LPmor
         cz4qvGaRA1aVn0rwewf2R8vnmioLAeehmmwiXrL5fkU0qphehMgWwJpOUjhih60fEr1z
         jx5FzqhjVGX8lQA872jQRTqQbJfXsuEo6eK+Be7McJ1fLKuHJKzAcdVpRWWx/8KTSGzx
         YmN9xfkIWvFYGusKmmaWVl86K5rr4DmnIKdLgoLTmxAO0GVGyU+zt4zq/vhJTludAe1U
         v0+0ADwvfKzjZv+yuByv678Gg+QNPSsK5swGqw3iBgbCK3riw2gIakb5SZzVsM6NNIct
         88Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=20fPsPA+9WTsD5kDBLLT9Sw3U7rjYbUdTtKCGI1Jfrc=;
        b=h4fbXRswq/gZwvGt1iTK/Mgxg8sVij9WN3hdo9cyN3JbFM1rb1KnJWGMxtHg9JtY/I
         07FSeBTl0JsXZgCS+2hJbeTxwL3QZrdoaWz+B1ziHw0av2MI5DkjUVIRJlmZsek8IPti
         0Moy9ySPW5qRoPqZiENJ6dmqkQPY947k5YehhXt7vIU5twppp550wMjAEvsbLPpPROG2
         E/cjYtljL7BaeTv0JxpHICmoBcPCrG0nMO5IUWIsGGl26tWeMmkdgRU3SWn39bv9796Z
         vfsnV2bTseKrXbFKNaGZzylra3tN4b2zuemPAJ12kjsfCYA95nqnYYFUOJBuiIzvjHDb
         q5kw==
X-Gm-Message-State: AOAM532TyTllpH0dVzT8KinFvCzThbuVmAnf5cdEmQweQe2wSal30COU
        nK6zP8npOLKH6PxLHLG/PXk=
X-Google-Smtp-Source: ABdhPJyYxgZrkaDVwaUh36J2Xb9WjQDvSyGVixH3JxLQSGI6GUfG+XJHq7ds1b7SyEc1izpg3hUSDw==
X-Received: by 2002:a63:6f01:: with SMTP id k1mr11212537pgc.59.1620729371560;
        Tue, 11 May 2021 03:36:11 -0700 (PDT)
Received: from wuchi.mioffice.cn ([209.9.72.213])
        by smtp.gmail.com with ESMTPSA id f24sm13947394pfk.45.2021.05.11.03.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 03:36:11 -0700 (PDT)
From:   Chi Wu <wuchi.zero@gmail.com>
To:     jack@suse.cz
Cc:     akpm@linux-foundation.org, axboe@fb.com, hcochran@kernelspring.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mszeredi@redhat.com, sedat.dilek@gmail.com, tj@kernel.org,
        Chi Wu <wuchi.zero@gmail.com>
Subject: [PATCH v2] mm/page-writeback: Update the comment of Dirty position control
Date:   Tue, 11 May 2021 18:36:06 +0800
Message-Id: <20210511103606.3732-1-wuchi.zero@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210511090632.GH24154@quack2.suse.cz>
References: <20210511090632.GH24154@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the value of pos_ratio_polynom() clamp between 0 and
2LL << RATELIMIT_CALC_SHIFT, the global control line should be
consistent with it.

Signed-off-by: Chi Wu <wuchi.zero@gmail.com>
---
 mm/page-writeback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 0062d5c57d41..3882405dc051 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -845,7 +845,7 @@ static long long pos_ratio_polynom(unsigned long setpoint,
  *     ^ pos_ratio
  *     |
  *     |            |<===== global dirty control scope ======>|
- * 2.0 .............*
+ * 2.0  * * * * * * *
  *     |            .*
  *     |            . *
  *     |            .   *
-- 
2.17.1

