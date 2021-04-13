Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89BCA35E4C9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 19:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbhDMRQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 13:16:29 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:45000 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbhDMRQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 13:16:28 -0400
Received: by mail-ot1-f43.google.com with SMTP id t17-20020a9d77510000b0290287a5143b41so5547103otl.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 10:16:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rMNN//f5PVNI24dvoMU737ZWcrimZ/+vulH1eX4cOok=;
        b=J9NqcjoeY236IpszS1OHbmy2lJT91tUuyc8y+ZsNA4JK31MgPAvBLVb2Z60Yrxzfye
         40xcHEvXNMamjMCuPhvIJE2TqymrCWWxyyZiYjaTM8UdHTZb5noYg0SSFPPqci2mNTHx
         XfvV69H2SZDC/5e1ATz4DZSUoqFWTeFGVZIOz2ohu8OuQ4kM3qkvEhJrwTfaEtIugazU
         l0HlmUJTz8Ib1a1uTxwn/hma2a14lmaN5sEnE+dWG/SiIUpPfiXvSo3pqCcE++cO7Gm0
         GMG0slJH1feWDaTvWnkDWTmsgrq14BHTjJ9ZmAw4V/lgVE6jY62OrGop1NeyBSG4p2s5
         QlYA==
X-Gm-Message-State: AOAM530zujQHJrGnoof2vxQjWTCy0yx8GPAI9Tq0WHhWVRKQYn4RSZqD
        5ywb1HbcHWWqqeBsRoI4NA==
X-Google-Smtp-Source: ABdhPJwPNwlNKreq30T6hyLXjLEL/CTMgQH6pssCBeQ7b5Dknqo93DP6zvMQl53GVEbxvc36mwzB5g==
X-Received: by 2002:a05:6830:1359:: with SMTP id r25mr6814033otq.180.1618334167971;
        Tue, 13 Apr 2021 10:16:07 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id y4sm109278oia.53.2021.04.13.10.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 10:16:07 -0700 (PDT)
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
Subject: [PATCH v7 0/4] libperf userspace counter access
Date:   Tue, 13 Apr 2021 12:16:02 -0500
Message-Id: <20210413171606.1825808-1-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm resending just the libperf userspace counter access without the Arm 
bits so hopefully it can be picked up for 5.13. The Arm bits seem to be 
a never ending review filled with long periods of silence. :(

Prior versions are here[1][2][3][4][5][6][7].

Rob

[1] https://lore.kernel.org/r/20190822144220.27860-1-raphael.gault@arm.com/
[2] https://lore.kernel.org/r/20200707205333.624938-1-robh@kernel.org/
[3] https://lore.kernel.org/r/20200828205614.3391252-1-robh@kernel.org/
[4] https://lore.kernel.org/r/20200911215118.2887710-1-robh@kernel.org/  
[5] https://lore.kernel.org/r/20201001140116.651970-1-robh@kernel.org/
[6] https://lore.kernel.org/r/20210114020605.3943992-1-robh@kernel.org/
[7] https://lore.kernel.org/r/20210311000837.3630499-1-robh@kernel.org/

Rob Herring (4):
  tools/include: Add an initial math64.h
  libperf: Add evsel mmap support
  libperf: tests: Add support for verbose printing
  libperf: Add support for user space counter access

 tools/include/linux/math64.h             | 75 ++++++++++++++++++++
 tools/lib/perf/Documentation/libperf.txt |  2 +
 tools/lib/perf/evsel.c                   | 58 ++++++++++++++++
 tools/lib/perf/include/internal/evsel.h  |  1 +
 tools/lib/perf/include/internal/mmap.h   |  3 +
 tools/lib/perf/include/internal/tests.h  | 32 +++++++++
 tools/lib/perf/include/perf/evsel.h      |  2 +
 tools/lib/perf/libperf.map               |  2 +
 tools/lib/perf/mmap.c                    | 88 ++++++++++++++++++++++++
 tools/lib/perf/tests/Makefile            |  6 +-
 tools/lib/perf/tests/test-evsel.c        | 65 +++++++++++++++++
 11 files changed, 332 insertions(+), 2 deletions(-)
 create mode 100644 tools/include/linux/math64.h

-- 
2.27.0

