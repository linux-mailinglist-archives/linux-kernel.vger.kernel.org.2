Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20CAE413156
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 12:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbhIUKMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 06:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbhIUKMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 06:12:01 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87267C061760
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 03:10:32 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id k2-20020adfc702000000b0016006b2da9bso3332808wrg.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 03:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+aOzJl+IOHEzliD/59W8D7vvkFuM5qZHbYDQFSYPXT0=;
        b=aFGoLLrFkaG1Jv4QLHaJkF6I3uEoq4A5AJzdm69l+j3q/5szCUvpqk9ZBSpifegZh7
         7mIN1MOkeF95mNesAfw2+ILFm7i3Kt9YsMHs5CI0eED0o5koHyQnW6Uq9U0f1iH9johY
         mvSiUClnJeCiqROBHKO51gLbqDHgUYsrqn2TmtZEuNckaKHqkdMD85zsmEVrAT8aASQU
         eUHxu0Qp8wOoFHuNFe2UyGkFC/qUwXTeerJNNKW/c+P+uzILzp4NrET0Ozjz5L73lFG6
         BXfwgGS9ZVeotQ1x1+5LnibZ0TmWgtFQvB/s5jMaYE8qH50/tMfYBpeqMXmb7jf960FS
         8VTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+aOzJl+IOHEzliD/59W8D7vvkFuM5qZHbYDQFSYPXT0=;
        b=Ahv1CM1rtxhttP8mVIePmsaT6t8xq3NCOeSRHl/pMKnx98QMP5XbMJfE3A8zi1ItZa
         RLN4CMTZA+N3RjmyshDVB1TdSymb0035kB4FzM8n/skopCgDwq5tHivMD6Nmu6vtDsX+
         Uc+ietA9qEHq8l101aUg2XafmwjIZjoq3Nm4RRrQ4MQj2V51xkScuS1+XfoUEyOvJMKR
         +AWc3SDrxDOl4RHJgFG6hItne4dnUnWeWEAxrnWy0IFWc6aGpMkCbUdG0nAyvPJmMTSP
         VhFTxnWe+xT2RJYFI/PkYqBg1xR5SrS70KnyC2hzGgglEWy2+LiVV3UG9xIZ08b06DIN
         DlbA==
X-Gm-Message-State: AOAM531NlDMmzjsDlBEgXsazsLoxxtrC2YPg256Ft/aO4d/zCvzjQi1m
        0IN9qMz+uZbENz9DaZjCo0cuHXct4A==
X-Google-Smtp-Source: ABdhPJys3pVww4ZkhI5lNJvpGxC7FpDSW8fdyC3vE/S9sO05lABxATNp5/Fu8r8Y8OsHyFWVo/Rz/kH4aw==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:dd03:c280:4625:60db])
 (user=elver job=sendgmr) by 2002:adf:ea90:: with SMTP id s16mr34027049wrm.235.1632219031088;
 Tue, 21 Sep 2021 03:10:31 -0700 (PDT)
Date:   Tue, 21 Sep 2021 12:10:14 +0200
In-Reply-To: <20210921101014.1938382-1-elver@google.com>
Message-Id: <20210921101014.1938382-5-elver@google.com>
Mime-Version: 1.0
References: <20210921101014.1938382-1-elver@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v2 5/5] kfence: add note to documentation about skipping
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

