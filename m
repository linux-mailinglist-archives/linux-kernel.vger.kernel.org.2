Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68FC9454E49
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 21:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbhKQUL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 15:11:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhKQUL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 15:11:27 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45240C061570;
        Wed, 17 Nov 2021 12:08:28 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 200so3260839pga.1;
        Wed, 17 Nov 2021 12:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=easNv7ldUg0wyKCSvoNE0jPZ5GtQFsUnAPEr3FcOTYU=;
        b=idgI18SAqNrFuU5tc1SkAAUsAvBnxCnlwn3kEH3Awfg08ACcOsHolDVH3uP/FhBYH4
         2ERC/r/iVQoTgghFjUNTDo26yjDw+MaNt7P9bw6a17u+ICbGJGtiXt/5fdWFOt3TgZEM
         /W0lg/uby4txXbmEWpwgLzkfs6Wiln+Dxhs0HmaZyk65jYJuty7EP8MemX2CtMR+tJcT
         xPKRMO0/U5cXYefsxYT4DDk285Uah7K9LbOSqkaFkPv7Nk8z7A01JMo7lz/k1cjR3eIr
         IAS08h+pO5a+srTPL8G/w/V3iBrEI5+YUGb9ozncCXeIDnZfnkMO+qpFnEw35FL9XpgL
         daXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=easNv7ldUg0wyKCSvoNE0jPZ5GtQFsUnAPEr3FcOTYU=;
        b=mhlj/1DWlAtY5QnZK4kQNlWuAVWLnj5PS80T5qSIxfWS8ZywjYV0Jlvke3saxgwwiA
         6V9i/XV0i0s6s9+idt3cUJjLNE9YH3cs+oAxfgL4JKWKEVZF6QsCJTe0sbM0iA9fhuPZ
         j7r9F78/lsctef0QIhiUhuPt+JlQERkcn9ow42XbpZpAE0EZDC0qo2QXXVHHlSrI04lF
         zS5lrh/PbLqXYuFIiwNhewfyRDpTm5hTfh6PNneaaeeByqY2XBaBOUVbnm8WHHyitSUu
         YdwNh19IV2mWGnGH0DN6Wu1luxt/KRmKyrYG58L9gYLRZfBQzDK8V8wBCB1B3Fn/BHMx
         yz7g==
X-Gm-Message-State: AOAM533GxlOnJ9QPJVK1JIIiwWYynsBdg8OrJ91uzW7kMWz9zYkMEBVs
        cdNL0QFCn16h+fBdzrAV914=
X-Google-Smtp-Source: ABdhPJwE5EHKi+VDEKpnkjFocdG51dZZ9hVmJ70xs2RPYrPD/RyOkKH2U316Ko/czdyS0igRKI4xGg==
X-Received: by 2002:a63:334d:: with SMTP id z74mr7137924pgz.468.1637179707472;
        Wed, 17 Nov 2021 12:08:27 -0800 (PST)
Received: from nickserv.localdomain (c-98-35-167-56.hsd1.ca.comcast.net. [98.35.167.56])
        by smtp.gmail.com with ESMTPSA id rm1sm6511050pjb.3.2021.11.17.12.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 12:08:27 -0800 (PST)
From:   Nick Terrell <nickrterrell@gmail.com>
To:     Nick Terrell <terrelln@fb.com>
Cc:     linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        Helge Deller <deller@gmx.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v2 0/3] Fix stack usage on parisc & improve code size bloat
Date:   Wed, 17 Nov 2021 12:14:56 -0800
Message-Id: <20211117201459.1194876-1-nickrterrell@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Terrell <terrelln@fb.com>

I'll be sending these patches to Linus through my tree. Just submitting them
for comment before I do so. I'm somewhat unsure of the correct workflow for
patches I submit myself, so let me know if there is something different I
should do.

This patch set contains 3 commits:
1. Fixes a minor unused variable warning reported by Kernel test robot [0].
2. Improves the reported code bloat (-88KB / 374KB) [1] by outlining
   some functions that are unlikely to be used in performance sensitive
   workloads.
3. Fixes the reported excess stack usage on parisc [2] by removing -O3
   from zstd's compilation flags. -O3 triggered bugs in the hppa-linux-gnu
   gcc-8 compiler. -O2 performance is acceptable: neutral compression,
   about -1% decompression speed. We also reduce code bloat
   (-105KB / 374KB).

After this commit our code bloat is cut from 374KB to 105KB with gcc-11.
If we wanted to cut the remaining 105KB we'd likely have to trade
signicant performance, so I want to say that this is enough for now.

We should be able to get further gains without sacrificing speed, but
that will take some significant optimization effort, and isn't suitable
for a quick fix. I've opened an upstream issue [3] to track the code size,
and try to avoid future regressions, and improve it in the long term.

[0] https://lore.kernel.org/linux-mm/202111120312.833wII4i-lkp@intel.com/T/
[1] https://lkml.org/lkml/2021/11/15/710
[2] https://lkml.org/lkml/2021/11/14/189
[3] https://github.com/facebook/zstd/issues/2867

Signed-off-by: Nick Terrell <terrelln@fb.com>

v1 -> v2:
* (1/3) Update commit message & add a comment.

Nick Terrell (3):
  lib: zstd: Fix unused variable warning
  lib: zstd: Don't inline functions in zstd_opt.c
  lib: zstd: Don't add -O3 to cflags

 lib/zstd/Makefile                            |  2 --
 lib/zstd/common/compiler.h                   |  7 +++++++
 lib/zstd/compress/zstd_compress_superblock.c |  2 ++
 lib/zstd/compress/zstd_opt.c                 | 14 +++++++++++++-
 4 files changed, 22 insertions(+), 3 deletions(-)

--
2.33.1

