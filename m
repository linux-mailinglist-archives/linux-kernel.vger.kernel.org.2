Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54BA03BEDAE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 20:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbhGGSIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 14:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbhGGSIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 14:08:20 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7EFCC061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 11:05:39 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id v7so3138492pgl.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 11:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ixlD3mmJY3rOK6gSWbHkyf00NzYTwViXv8dwsVfEcag=;
        b=E3GAZMKdt/3MFOnIFKk9c/aT20QrnVlK+fQv1FfwNAw/VZDlg2SUiUkGGFyXlocEDp
         Q+SgAqm1xEnuUcQqL6j/apVpQwJ7HMzs+vPFv6dgXQigHJsLDVP9hMkzTReRNNYb/cmO
         nalEVKv9oo2HMp2YigcnvavTq3H/TMf/C1X7p7tEbbdizeax/LS8oWAD1AVTppTakvG/
         dMv+ehwD8Mqr61NfTvdLNAq4yFq8ygsHmnAt13uNrgAxHx8ekEvnE1LR7Ugw34EeSh43
         8LNd7DhC1lQm6d5Es7tg8PDziwcfYQjqxBmWkjmBxiOvhqHk7gHtnBrl1qwzBoAvhI1p
         yGVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=ixlD3mmJY3rOK6gSWbHkyf00NzYTwViXv8dwsVfEcag=;
        b=X9ui9RmAN9EcOI/TAMIhSeaSZGkxbgLJggdHS3RbJQoyGxjB4+HhSYSuUMI72lDPU0
         WSIALLPLrtnMVpfnsFIaaZG/19fbgkUVeuVRG0OYmZs4xIrkZdCqigvkI4y+DfmHJu1K
         K8GoD0c9OzZRk0j+f0Nhd0S9Sms9g+mSUMCuKmEBdFllcSyyv1CLGsZqCl8XNONtaUev
         uhn9xBSQ2QVt4B5/qHcBQIb7n+bSn8yRKHmOpNU+3H0JIMLme/S5N6tPrF6aQuPl164I
         tjyKOgK6nX6CWQ4bbzWAGjMv3f9K5NyLwez//CcuR9231L7R09ko1nsw4u+3dQIZ0YoX
         2uDg==
X-Gm-Message-State: AOAM533SVm6HxWBkD9S1b/D4524zu6jd9d2TYjktvmiD57rag1UzrI9z
        OQRMxDylk5uk1hvYOyPELa4=
X-Google-Smtp-Source: ABdhPJyfHVNJbMIuU2IIKR62N7jYsSkd91DpVUH7//kw/ywrO77De8xNbyycR1iQ2uISUNn0v4Bgdw==
X-Received: by 2002:a62:7e42:0:b029:325:6b42:609f with SMTP id z63-20020a627e420000b02903256b42609fmr5146135pfc.37.1625681139264;
        Wed, 07 Jul 2021 11:05:39 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4801:c8d0:8e3d:643a:56fb:b045])
        by smtp.gmail.com with ESMTPSA id 1sm9379711pfm.123.2021.07.07.11.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 11:05:38 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCHSET 0/4] perf inject: Fix broken data with mixed input/output
Date:   Wed,  7 Jul 2021 11:05:32 -0700
Message-Id: <20210707180536.72175-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The perf inject processes the input data and produces an output with
injected data according to the given options.  During the work, it
assumes the input and output files have the same format - either a
regular file or a pipe.  This works for the obvious cases, but
sometimes makes a trouble when input and output have different
formats (like for debugging).

For example, this patchset fixed the following cases

 1. input: pipe, output: file

  # perf record -a -o - sleep 1 | perf inject -b -o perf-pipe.data
  # perf report -i perf-pipe.data

 2. input: file, output: pipe

  # perf record -a -B sleep 1
  # perf inject -b -i perf.data | perf report -i -


Thanks,
Namhyung


Namhyung Kim (4):
  perf tools: Remove repipe argument from perf_session__new()
  perf tools: Pass a fd to perf_file_header__read_pipe()
  perf inject: Fix output from a pipe to a file
  perf inject: Fix output from a file to a pipe

 tools/perf/bench/synthesize.c       |  4 +-
 tools/perf/builtin-annotate.c       |  2 +-
 tools/perf/builtin-buildid-cache.c  |  2 +-
 tools/perf/builtin-buildid-list.c   |  2 +-
 tools/perf/builtin-c2c.c            |  2 +-
 tools/perf/builtin-diff.c           |  4 +-
 tools/perf/builtin-evlist.c         |  2 +-
 tools/perf/builtin-inject.c         | 67 +++++++++++++++++++++++++++--
 tools/perf/builtin-kmem.c           |  2 +-
 tools/perf/builtin-kvm.c            |  4 +-
 tools/perf/builtin-lock.c           |  2 +-
 tools/perf/builtin-mem.c            |  3 +-
 tools/perf/builtin-record.c         |  2 +-
 tools/perf/builtin-report.c         |  2 +-
 tools/perf/builtin-sched.c          |  4 +-
 tools/perf/builtin-script.c         |  4 +-
 tools/perf/builtin-stat.c           |  4 +-
 tools/perf/builtin-timechart.c      |  3 +-
 tools/perf/builtin-top.c            |  2 +-
 tools/perf/builtin-trace.c          |  2 +-
 tools/perf/tests/topology.c         |  4 +-
 tools/perf/util/data-convert-bt.c   |  2 +-
 tools/perf/util/data-convert-json.c |  2 +-
 tools/perf/util/header.c            | 12 +++---
 tools/perf/util/header.h            |  2 +-
 tools/perf/util/session.c           | 11 ++---
 tools/perf/util/session.h           | 12 +++++-
 27 files changed, 115 insertions(+), 49 deletions(-)

-- 
2.32.0.93.g670b81a890-goog

