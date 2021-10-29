Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC72A4401EF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 20:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbhJ2SgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 14:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbhJ2SgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 14:36:13 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF21C061766
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 11:33:44 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b5-20020a25a205000000b005c2150fc181so35034ybi.6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 11:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:cc;
        bh=f+Wd/uHd0tDpDpKgB2RrjDhKxBzjj44L//DvLwqhZG8=;
        b=eW/VrmX89o7qeFzNZregrH+8+eMzUZ0U8SJjNBa/0yKup6Ythv07w0FyKOgbVEfzWR
         JKtA6GrvkcPF3LMwNqVrtxvqOH5obrjYIAtNBYq3as/uUWdSMxmw13aN2LLPX+JiCIvT
         A1iAXxdIEydpaN/K5mWYeXe2rR78QtgXAu2O1Pb5Vk+XSuQRSD/gsj2w2T7q0z/SsjB+
         eCbT1NKFDAIaixWMxSA0MSDoPOG0THPByA/MKXQd05lQw4JE0I6es4XsANLf2L1QLtgf
         dk91Rpczm8eP4X9N+Kt+EEUliNLNfxMgxXWpXAWzHJ82FuxhFPTQgrqhhzOqSpii+PE0
         CMeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=f+Wd/uHd0tDpDpKgB2RrjDhKxBzjj44L//DvLwqhZG8=;
        b=NkVceKHMmfgiJpdR25SG7IYky0aEAp/D2HWjvgEdXd9y43bQ+IxIPgcujFQWDu7XKN
         pkDvOQUvLpoHZikp6/mFVJIRwkdgjNl/onrVOnss629RhkYXFA9wGiAHvcQsthXZqhyL
         +GDSF1b4eHHc9p3jdW3/EWgXEEwkU8m+k5cGYv6mzBZLb1A3xDIBlDJTffJYU6RKO3Mn
         ms2uySZWDLA3tf9tKLC7deOtHb0Ze6s9p+TvmxWMfhhqv1357qxrsIExCvD7dpCf6RPW
         LgBc7XTjbd63/a8wbOrXiBrYtcHKGdJoySZTA3oDjlyPv54JqbO2IMkYH8EiuIlVq1mo
         pdmg==
X-Gm-Message-State: AOAM533PyBdiHbfOSy3nFmu41yeBAA7CC0O0Udk6E2v6SiZDORNmdDdG
        Q0s2ErBSHAdeYQw+o6EmsnmYohe6QvZ4DYMQpw==
X-Google-Smtp-Source: ABdhPJy64tC7zgiLqGj9iAraiidsd9r20wqA5lUgPEIJEMAaZCArad3YsKwTU4oftDOVUW6lVN0tBZCa67yUYkwoWA==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:b03:1d88:1cf2:4973])
 (user=kaleshsingh job=sendgmr) by 2002:a25:2c4d:: with SMTP id
 s74mr12650592ybs.171.1635532424022; Fri, 29 Oct 2021 11:33:44 -0700 (PDT)
Date:   Fri, 29 Oct 2021 11:33:26 -0700
Message-Id: <20211029183339.3216491-1-kaleshsingh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH 0/4] tracing/histogram: Division optimization and expression kselftests
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     surenb@google.com, hridya@google.com, namhyung@kernel.org,
        kernel-team@android.com, rostedt@goodmis.org, mhiramat@kernel.org,
        Kalesh Singh <kaleshsingh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds optimiztion for division by constants and updates the
histogram trigger expression kselftests and documentation.

It is dependent on the series at [1] and the fix at [2]; and can be applied
on top of those after dropping the patch 7 in [1].

[1] https://lore.kernel.org/r/20211025200852.3002369-1-kaleshsingh@google.com/
[2] https://lore.kernel.org/r/20211028170548.2597449-1-kaleshsingh@google.com/

Kalesh Singh (4):
  tracing/histogram: Optimize division by constants (v2)
  tracing/histogram: Update division by 0 documentation (v1)
  tracing/histogram: Document hist trigger variables (v3)
  tracing/selftests: Add tests for hist trigger expression parsing (v7)

 Documentation/trace/histogram.rst             |   3 +-
 kernel/trace/trace.c                          |  11 ++
 kernel/trace/trace_events_hist.c              | 117 +++++++++++++++++-
 .../trigger/trigger-hist-expressions.tc       |  63 ++++++++++
 4 files changed, 192 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc

-- 
2.33.1.1089.g2158813163f-goog

