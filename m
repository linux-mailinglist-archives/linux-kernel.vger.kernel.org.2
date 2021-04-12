Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D8335BC42
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 10:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237317AbhDLIf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 04:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237019AbhDLIf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 04:35:28 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EA3C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 01:35:10 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id x21-20020a17090a5315b029012c4a622e4aso6688720pjh.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 01:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pizZNzREwJ8JNpXJLbilIEpw+MUWppPCVd3LEkiYJrU=;
        b=sNGF7Fpt+gjDiRIdua1tCLAW7K251qfWvkT7bvZvXwhyyEQXfYAOYezX79F4yAn/fM
         T4JNPbQbCJyzVKmnnpiHF0BN86ndT9AWvqOVlL3LB7uwgAxXA26DVrSvhX+U+n1KBrct
         jX4uBn5XUCL5oJTf8aqduBVi6Ixm9ked0Pt3JdDpyTVeAR5DXGdNbZqYo6w7s1isfwpB
         542EjpgsDR03HsuI4rWcgZEiBjrUVeBTzL7dufG6AzngYxiqFN/YriGTkm4SJcLFCR/S
         XAK0yP0V0T4pMX+/7OAr7o0kWgjSfXBsEkJIQAqM3/oB/L5DOTa5Qqzepqqz/gadDrZC
         7OXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pizZNzREwJ8JNpXJLbilIEpw+MUWppPCVd3LEkiYJrU=;
        b=YpKUzpR2X0I/Xwj/M0fg+dqQnXg9Nu8JEyTf2yCpsDoGjemFQn06NRM02aUSGUEQ0U
         N1HtzhP7UX141zDbAa5ndzs6t49XzTB1rQFEnDnK7tjwHwyQ+ze+SD8mY9trmdY8zVk7
         pIhshe/EAJ4zD0NHHbjlIKqdOgsl67YQUjMrt59zOzRUFSYOKqBXH8mgXrLeN21/+yRw
         ZEhOZvj0FJYnmJwAyOeG+asjSsmLyUzJ1Bbcjf99QcBcCE4QkrUsVaxrfTcGfqr6OOcP
         h5aOITna2EeTdiMirk7TQ4ULx3A5OSK63Cd1jWtJuvTkRoLozcKHimybmVASadvjjIDE
         zgUA==
X-Gm-Message-State: AOAM532XZnjptzx6NY9QXjptkrCGlprbNwE1rLGyYFM1TmLF9MvQ8m+3
        oP8D9LN14U9EMzCpPQv+M9jkig==
X-Google-Smtp-Source: ABdhPJzO8B2h/uCqjk4SmYMbiCi+x0co/V1Du+IC8i/YyXa+gNGxkGz57aH+0E9PbMchWW0A4Hsgaw==
X-Received: by 2002:a17:902:e803:b029:e9:7f25:862c with SMTP id u3-20020a170902e803b02900e97f25862cmr22699123plg.27.1618216509753;
        Mon, 12 Apr 2021 01:35:09 -0700 (PDT)
Received: from localhost ([116.206.101.232])
        by smtp.gmail.com with ESMTPSA id b21sm10276208pji.39.2021.04.12.01.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 01:35:09 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Steve MacLean <Steve.MacLean@Microsoft.com>,
        Yonatan Goldschmidt <yonatan.goldschmidt@granulate.io>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 0/3] perf: Allow TIME_CONV to be backwards-compatible and dump it
Date:   Mon, 12 Apr 2021 16:34:56 +0800
Message-Id: <20210412083459.462817-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The event PERF_RECORD_TIME_CONV was extended for clock parameters, but
the tool fails to be backwards-compatible for the old event format.

Based on checking the event size, this patch series can decide if the
extended clock parameters are contained in the perf event or not.  This
allows the event PERF_RECORD_TIME_CONV to be backwards-compatible.

The last patch also is introduced for dumping the event, for both the
old and latest event formats.

The patch set has been tested on Arm64 HiSilicon D06 platform.

Leo Yan (3):
  perf jit: Let convert_timestamp() to be backwards-compatible
  perf session: Add swap operation for event TIME_CONV
  perf session: Dump PERF_RECORD_TIME_CONV event

 tools/perf/util/jitdump.c | 31 +++++++++++++++++++++----------
 tools/perf/util/session.c | 35 +++++++++++++++++++++++++++++++++--
 tools/perf/util/tsc.c     | 31 +++++++++++++++++++++++++++++++
 tools/perf/util/tsc.h     |  4 ++++
 4 files changed, 89 insertions(+), 12 deletions(-)

-- 
2.25.1

