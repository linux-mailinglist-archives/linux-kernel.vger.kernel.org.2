Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68246376B52
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 22:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhEGU4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 16:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhEGU4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 16:56:37 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8A5C061761
        for <linux-kernel@vger.kernel.org>; Fri,  7 May 2021 13:55:36 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id s20so5877717plr.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 13:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RPwYxQ/G3rhOoLfwIgiJmY5QnE9mrhjUeAyG7fqUPTY=;
        b=LNxZxepW+UC0Y1XBj2dy4y1rp1H6OzGzwlDR5/k47T6tyxD79Y/i4yJwV5N0lZ+VFZ
         a8Xu/wG2Tm7gtc0rRRA8uUCmZHCDoCL9NS9Sm2WL7Qh6S0U++r1/xl0A2IeMQkpThR5W
         LaAH+0LietCJ7G1AT7P3w0Joc/JNVwQhcV8P8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RPwYxQ/G3rhOoLfwIgiJmY5QnE9mrhjUeAyG7fqUPTY=;
        b=ufMPqF9pfBNTrmBiwrhBntz1724mb35tgt0pu3D2hyPL4vqkn9ahccLQRcJM1AmTO+
         WywUncXkNVyBb57FIE1qzRELqUQZ+vkxupxwGDciL/P6Q7IEzeLTUIblU0yZmTvdH1Rv
         K9a2E92+gM8x6QXkr1qt7T7zVKU7BUEGPWF5qduXLsauaLIhrvh4DYnJU1e2X/g+Oku2
         aebOYD5qlo5Gd8+TMWK2C2hajfYF6UJB8PFr6aHFNzv/pV034SW+g781tNVflCVx4dei
         ANdO9btS4iIPO8FhqCkr+EEAvXpaekkswtlWZ3IRQZwBW0SibHdTUjtltYyieJ8w904V
         AzYw==
X-Gm-Message-State: AOAM533U6AFhFo0zqKWdWIEpdjNgDHC2do8z3gdiBtSMJmIXaqvdolo8
        MHhvs+Bkac4j4DTr3Y5S7L/HjQ==
X-Google-Smtp-Source: ABdhPJzk5q+RqqaeU/dImKZTUfx8BnrHWZjv79jeHRGyFTZRMB87eu1vtuUpAfgd2ErT3+E0DOME3g==
X-Received: by 2002:a17:90a:c087:: with SMTP id o7mr12769919pjs.65.1620420935943;
        Fri, 07 May 2021 13:55:35 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:3c7e:d35:3a19:632f])
        by smtp.gmail.com with ESMTPSA id ge4sm13161565pjb.49.2021.05.07.13.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 13:55:35 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Seth LaForge <sethml@google.com>,
        Ricky Liang <jcliang@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        clang-built-linux@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 0/3] arm64: perf: Make compat tracing better
Date:   Fri,  7 May 2021 13:55:10 -0700
Message-Id: <20210507205513.640780-1-dianders@chromium.org>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The goal for this series is to improve "perf" behavior when 32-bit
userspace code is involved. This turns out to be fairly important for
Chrome OS which still runs 32-bit userspace for the time being (long
story there).

I won't repeat everything said in the individual patches since since
they are wordy enough as it is.

Please enjoy and I hope this isn't too ugly/hacky for inclusion in
mainline.

Thanks to Nick Desaulniers for his early review of these patches and
to Ricky for the super early prototype that some of this is based on.


Douglas Anderson (3):
  arm64: perf: perf_callchain_user() compat support for
    clang/non-APCS-gcc-arm
  arm64: perf: Improve compat perf_callchain_user() for clang leaf
    functions
  arm64: perf: Add a config option saying 32-bit thumb code uses R11 for
    FP

 arch/arm64/Kconfig                 |  12 ++
 arch/arm64/kernel/perf_callchain.c | 329 +++++++++++++++++++++++++----
 2 files changed, 305 insertions(+), 36 deletions(-)

-- 
2.31.1.607.g51e8a6a459-goog

