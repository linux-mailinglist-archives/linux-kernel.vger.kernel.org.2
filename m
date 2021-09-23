Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B740415C3C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 12:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240494AbhIWKt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 06:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240476AbhIWKtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 06:49:53 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A64C061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 03:48:21 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id e6-20020a0cb446000000b0037eeb9851dfso18984540qvf.17
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 03:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sS022PP0nBNSy8OKBYkYKJTWDCY37FWogqIg9gOqwaw=;
        b=lz2zeNS9KKJed9/idbHiyT52xuRsU8jmRFz/4Mh/ZlYvIfI3NDOCAuA2Mq6nkWqR9E
         JbggrFJJNsGHx4UKBCtnu9oTDdSfGQ0U63Ow6+INWd6jX6hEEq6oHYFPolUW7dRfVRSs
         R6LrBwtvFPJpvUbHCmbEJZIDifLmii2lv7P7cjnPv8SxIUaqliMUYRn+f2H7Ehom3Emb
         Nd3qoLdmJxeoeyBYCcPpjy52IK5R6kCxicripz/jbLDMASJ3WgAJNchlIAe9GvEqG38b
         Zbs2ntvM8UA5eMvtb3l9ZHTuJ7KdpkCnp5pvlUHdzViBukGzgMT6AgB9Jc6cAayCd8Gp
         3VSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sS022PP0nBNSy8OKBYkYKJTWDCY37FWogqIg9gOqwaw=;
        b=eLXTUZ4FDpk+b8Eey///vC3xh0Jj1lwBMugpo1BM+K15+FnCUh2n1fp5hjE3Hda7Cz
         cSK97R0N6UTIhXAmbW6ZfAzPUjHww09xJ5CjR9LJyAgI4MxaP1XUc83Rj03jYs9OIaWA
         7TN3xFqyvm0dmSoXCaGV1hFVDFkSPhA/PpGYstefpFU1kbtTY/89TSt2jcImI9/KuIHf
         5g/q8a6T7HcmikhtZYdcK0fU5hX1BwfcbB635txWpwYAJSiw6mlDZ0Q89tbNQDAJGWQx
         DEpHK/yNoEfeAy6jF8i3PsY12vEuB2twwjFYgsiU8BrWXdxkZP/jqk2bZz6e9GHUmzku
         my2A==
X-Gm-Message-State: AOAM533IdWoGs8yXdpRjTDffAMmP89Pw04JqknMh1YbKtreGZ8cPNRKp
        UBdRgvui9efbpl/E/e1+PgxRnmGqMA==
X-Google-Smtp-Source: ABdhPJwl3K/JOiSHRQnSOsLFlsdwEP0YkjR1wD9m+isgUOiNjdnzFZHgt8ubrMgehmtACfPt7lrjI06liQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:bd72:fd35:a085:c2e3])
 (user=elver job=sendgmr) by 2002:ad4:4990:: with SMTP id t16mr3775079qvx.32.1632394101026;
 Thu, 23 Sep 2021 03:48:21 -0700 (PDT)
Date:   Thu, 23 Sep 2021 12:48:03 +0200
In-Reply-To: <20210923104803.2620285-1-elver@google.com>
Message-Id: <20210923104803.2620285-5-elver@google.com>
Mime-Version: 1.0
References: <20210923104803.2620285-1-elver@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v3 5/5] kfence: add note to documentation about skipping
 covered allocations
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Taras Madan <tarasmadan@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a note briefly mentioning the new policy about "skipping currently
covered allocations if pool close to full." Since this has a notable
impact on KFENCE's bug-detection ability on systems with large uptimes,
it is worth pointing out the feature.

Signed-off-by: Marco Elver <elver@google.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
---
v2:
* Rewrite.
---
 Documentation/dev-tools/kfence.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/dev-tools/kfence.rst b/Documentation/dev-tools/kfence.rst
index 0fbe3308bf37..d45f952986ae 100644
--- a/Documentation/dev-tools/kfence.rst
+++ b/Documentation/dev-tools/kfence.rst
@@ -269,6 +269,17 @@ tail of KFENCE's freelist, so that the least recently freed objects are reused
 first, and the chances of detecting use-after-frees of recently freed objects
 is increased.
 
+If pool utilization reaches 75% (default) or above, to reduce the risk of the
+pool eventually being fully occupied by allocated objects yet ensure diverse
+coverage of allocations, KFENCE limits currently covered allocations of the
+same source from further filling up the pool. The "source" of an allocation is
+based on its partial allocation stack trace. A side-effect is that this also
+limits frequent long-lived allocations (e.g. pagecache) of the same source
+filling up the pool permanently, which is the most common risk for the pool
+becoming full and the sampled allocation rate dropping to zero. The threshold
+at which to start limiting currently covered allocations can be configured via
+the boot parameter ``kfence.skip_covered_thresh`` (pool usage%).
+
 Interface
 ---------
 
-- 
2.33.0.464.g1972c5931b-goog

