Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D6E35F881
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 18:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbhDNPyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 11:54:44 -0400
Received: from mail-oo1-f49.google.com ([209.85.161.49]:38669 "EHLO
        mail-oo1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbhDNPyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 11:54:40 -0400
Received: by mail-oo1-f49.google.com with SMTP id y23-20020a4ade170000b02901e6250b3be6so2225452oot.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 08:54:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lm3o/tNLv0sNYdaxU/WvJ/EJgnrxffFZNZN55gJZP8U=;
        b=fABIN/Ho0dlGGZrvNpWL2tV0y56xj0jy3PQhPEl9d1PCOAw4dRU6YXpiMa0McQAdQR
         QVzglJrlSvqHqyiZWquejXsNzgMFkJBrfIkm5HRV771/BWnia81GwS3qdlR8P8Y2uEXY
         5HSlUy2Em0IB0VAkXTBSHcELm0QAW+SEoix/nGSYRrG0SPkg4bBbD3S5ePvreJvgWxOL
         PaGG+P+DBBHuBZ5p7pG+WSGyUWV8Q6h0w9OXlHOF5DvwHHo9QKnp8M+TOLtfbLl9dBFQ
         xrGnKQ2ag2ZunAW8gzqJnD9WjdRFHQeXW86OwVKYdTlQPoOQjjGHnFJS92h9dz4oT3RT
         yeNw==
X-Gm-Message-State: AOAM530OagBlTOapoWwESY5OmRP5uTrTetEiA6HYe6IRvPhXSfYmU/1K
        T642HBAT9mCxgxCP+8kCFg==
X-Google-Smtp-Source: ABdhPJzXNpMwEYW1QMoXZwpjbaYh9B/hWI6hLOqPDbiOe6wk7uDpniNZ4p5nN8JmzVdmPWLJtrlp5w==
X-Received: by 2002:a4a:8c0d:: with SMTP id u13mr31316525ooj.59.1618415659073;
        Wed, 14 Apr 2021 08:54:19 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id x14sm41830otk.32.2021.04.14.08.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 08:54:14 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>
Subject: [PATCH v8 0/4] libperf userspace counter access
Date:   Wed, 14 Apr 2021 10:54:08 -0500
Message-Id: <20210414155412.3697605-1-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm resending just the libperf userspace counter access without the Arm 
bits so hopefully it can be picked up for 5.13. The Arm bits seem to be 
a never ending review filled with long periods of silence. :(

Prior versions are here[1][2][3][4][5][6][7][8].

Rob

[1] https://lore.kernel.org/r/20190822144220.27860-1-raphael.gault@arm.com/
[2] https://lore.kernel.org/r/20200707205333.624938-1-robh@kernel.org/
[3] https://lore.kernel.org/r/20200828205614.3391252-1-robh@kernel.org/
[4] https://lore.kernel.org/r/20200911215118.2887710-1-robh@kernel.org/
[5] https://lore.kernel.org/r/20201001140116.651970-1-robh@kernel.org/
[6] https://lore.kernel.org/r/20210114020605.3943992-1-robh@kernel.org/
[7] https://lore.kernel.org/r/20210311000837.3630499-1-robh@kernel.org/
[8] https://lore.kernel.org/r/20210413171606.1825808-1-robh@kernel.org/

Rob Herring (4):
  tools/include: Add an initial math64.h
  libperf: Add evsel mmap support
  libperf: tests: Add support for verbose printing
  libperf: Add support for user space counter access

 tools/include/linux/math64.h             | 75 ++++++++++++++++++++
 tools/lib/perf/Documentation/libperf.txt |  3 +
 tools/lib/perf/evsel.c                   | 80 +++++++++++++++++++++
 tools/lib/perf/include/internal/evsel.h  |  1 +
 tools/lib/perf/include/internal/mmap.h   |  3 +
 tools/lib/perf/include/internal/tests.h  | 32 +++++++++
 tools/lib/perf/include/perf/evsel.h      |  3 +
 tools/lib/perf/libperf.map               |  3 +
 tools/lib/perf/mmap.c                    | 88 ++++++++++++++++++++++++
 tools/lib/perf/tests/Makefile            |  6 +-
 tools/lib/perf/tests/test-evsel.c        | 66 ++++++++++++++++++
 11 files changed, 358 insertions(+), 2 deletions(-)
 create mode 100644 tools/include/linux/math64.h

-- 
2.27.0

