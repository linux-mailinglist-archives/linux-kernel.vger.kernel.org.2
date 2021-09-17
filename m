Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3398D40F686
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 13:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343884AbhIQLJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 07:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243255AbhIQLJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 07:09:38 -0400
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B413AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 04:08:16 -0700 (PDT)
Received: by mail-wm1-x34a.google.com with SMTP id b23-20020a1c8017000000b0030b48f258d3so272059wmd.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 04:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=vzNr90124HBGMksCA+v8zEh8chsocOdGVYWBleMT7ko=;
        b=HKCkuYw5S8ETo96SXud0sKArbtkaCJ6uKSE8Z5ggKIbOYUFndfaY9N7HytQezaZR1o
         AvjDoDe63aCCd9Xn0yHcGwKucID7F+MBgzEhF1I8kP/7vFRfUhahkX5/B0aRD/Az0kcm
         Frf2IAWm8GXm4ziW0aHikywvY8Zs+s73fBH9SS9wEZ7oa5ds/Ar4Jqtpuu0YIXv2bHYJ
         TWE6EZzdCOFKz0x1IMFuK1YrQrMEzsDr52HPP9Kkhnr3/vH9CaqI19vOKYvgND/mJ86+
         XrIrigK7kjHPMWS/tUqzPRAql9nHhAIeJzYjlUpimMYEnZVNWViXr0TrKaUEb46PLTQC
         sINg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vzNr90124HBGMksCA+v8zEh8chsocOdGVYWBleMT7ko=;
        b=Uogh5LBDz6ItUR6V5hLWSmcyooGdwMwVQx9yW6x/I74s52GS+mTMxg+++byLvWCqqz
         In55Q2TZMHdreh8D3X97l/uEhp+ZuB6pz66mccHMZNX4nGHS143vYOcVpJ0iESA/0K/W
         XJoEipZKMACAW+M/wHWlITciKeQ3fqNBePVi79kP8NGWeq3Iz4c7nCtCkjo4OveLnhka
         H6XNginqJBLkQL93S1Xe+t5jeUX1NhKIGu6SYeSlX7FtmeXCWTvK4R3U7HoXl5ILLsl2
         KahI7YBbTubTMMlJv3HbH9hc3TgcqPelk6ngb0YTQQ2gI2si0rD8ZTv47Dma7I0ifqHQ
         75MQ==
X-Gm-Message-State: AOAM531y4bJkJY8DFwQyEbtkO9o80MfcN3oYszBRqopgSeUAY0TDzaQi
        iaea2sjrA58vV1eImz96+X1GQNrSQw==
X-Google-Smtp-Source: ABdhPJyIdwHM+EXD4Pob8DSaRIHbKtfrgeHA9h+Iz8+YtK1Yl9Q/G+jUQ/ZxnG6ALfNdmYApBDZwCOKEMw==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:1a57:84a3:9bae:8070])
 (user=elver job=sendgmr) by 2002:a1c:3845:: with SMTP id f66mr9628773wma.63.1631876895324;
 Fri, 17 Sep 2021 04:08:15 -0700 (PDT)
Date:   Fri, 17 Sep 2021 13:07:56 +0200
In-Reply-To: <20210917110756.1121272-1-elver@google.com>
Message-Id: <20210917110756.1121272-3-elver@google.com>
Mime-Version: 1.0
References: <20210917110756.1121272-1-elver@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH 3/3] kfence: add note to documentation about skipping covered allocations
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
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
 Documentation/dev-tools/kfence.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/dev-tools/kfence.rst b/Documentation/dev-tools/kfence.rst
index 0fbe3308bf37..e698234999d6 100644
--- a/Documentation/dev-tools/kfence.rst
+++ b/Documentation/dev-tools/kfence.rst
@@ -269,6 +269,14 @@ tail of KFENCE's freelist, so that the least recently freed objects are reused
 first, and the chances of detecting use-after-frees of recently freed objects
 is increased.
 
+If pool utilization reaches 75% or above, to reduce the probability of the pool
+containing ~100% allocated objects yet ensure diverse coverage of allocations,
+KFENCE limits currently covered allocations of the same source from further
+filling up the pool. A side-effect is that this also limits frequent long-lived
+allocations of the same source filling up the pool permanently, thereby
+reducing the risk of the pool becoming full and the sampled allocation rate
+dropping to zero.
+
 Interface
 ---------
 
-- 
2.33.0.464.g1972c5931b-goog

