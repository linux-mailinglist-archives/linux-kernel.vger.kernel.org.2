Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3CDB43E926
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 21:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhJ1UAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 16:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbhJ1UAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 16:00:38 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78613C061745
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 12:58:11 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id r67-20020a252b46000000b005bea12c4befso10105552ybr.19
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 12:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:cc;
        bh=L0mp2T+2GGA+M5SSznk5lc9pAGSuDVifknCJAl2jqKU=;
        b=iptt9SQQjxmAT1L7OevdbVi0Lgb0simKZeL4vRD83gQxFdqPbPbajzgIxRKgHe2yxl
         CWmSNUiop3qCv8SfoOBvmBYv3xWbB9tA2jaO14nlbJ8bT6ml2bladDkKfotZvMCEPqhU
         MfvujQwdeHDK4T6QApfwWpj+9+LZ4j7y5u78FLLXaUhQ7MvPr/IPT7zfvTChRaSMbqHl
         k0ZgYoHNLUaifsxk6s5ANmBz6ZIg+0+xWIet0StiX3nfuZQ9eRfOyD8+grLqhFQzhKhY
         U1QE4eMk7B8gZf0mQFmQtLu/Fm247JnHVLVCoNpkb2pq2jEeG1trGTbk/Wfz+xUJ9uto
         VzcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=L0mp2T+2GGA+M5SSznk5lc9pAGSuDVifknCJAl2jqKU=;
        b=nmH/TWR0a2MjB6iCgnvUhEpan5qno2M65vo9/tyb4EhdzzKwC0tL0MTk2TRMG0iWz6
         wpgbnXf1dUCVkrwLDH1jqQKtnjXqw2gTCyb4e39m7Sy5eP+e41Rw3h31X9gFxACTGfJj
         JW77yprTciX2qTwWlWDv3TvohmSLJJUf+rD238XMmJSmS2R2X+waBiCdrM8qAJbTvrOU
         Hpqs7OOwpjoGeIysDzPmYjdWi3g2GmM6vCW/Ytit1/vAdmDf+oKGMmUXneXQOES7TZms
         g2lDtcKUDLSytME5WTqzztROzoSdSUOk3OXgo0WUNPByswuxo9cL3h7OlAnz7ebREVME
         Chgw==
X-Gm-Message-State: AOAM533N7AThxi6R5hSySpRFhY3Bf622G2kwmWFuaFrm/VVkJhqdq649
        vtctq7iHpiOIVCTBHD0XpRo24D3knwXXKmhKrA==
X-Google-Smtp-Source: ABdhPJwxtElX6ecFHi1ltNUmp+V0Tfuj8R83nPF76JBqLVsmL6AGXUwNYXsq+yKnnaMa3OsZ/bdIgL97vmjlZFiIWQ==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:9b57:752f:2f0a:3a13])
 (user=kaleshsingh job=sendgmr) by 2002:a25:cc8:: with SMTP id
 191mr6787174ybm.63.1635451090590; Thu, 28 Oct 2021 12:58:10 -0700 (PDT)
Date:   Thu, 28 Oct 2021 12:57:56 -0700
Message-Id: <20211028195805.2684854-1-kaleshsingh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v2 0/2] tracing/kselftest: histogram trigger expression tests
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     surenb@google.com, hridya@google.com, namhyung@kernel.org,
        kernel-team@android.com, rostedt@goodmis.org, mhiramat@kernel.org,
        Kalesh Singh <kaleshsingh@google.com>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds kselftest for histogram trigger expressions and is
dependent on the series at [1] and can be applied on top of those after
dropping the patch 7 in [1].

This version drops the changes to reset_trigger_file().

[1] https://lore.kernel.org/r/20211025200852.3002369-1-kaleshsingh@google.com/

Kalesh Singh (2):
  tracing/histogram: Document hist trigger variables (v2)
  tracing/selftests: Add tests for hist trigger expression parsing (v6)

 kernel/trace/trace.c                          | 11 ++++
 .../trigger/trigger-hist-expressions.tc       | 65 +++++++++++++++++++
 2 files changed, 76 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/trigger-hist-expressions.tc

-- 
2.33.0.1079.g6e70778dc9-goog

