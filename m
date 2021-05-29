Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB5B394B10
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 10:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhE2ISU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 04:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbhE2IST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 04:18:19 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56790C06174A
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 01:16:43 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso8379361pjx.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 01:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fex-emu.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=552P3X5AIoGxxPcUinhjnI4ENWQ5hjfJcdOghjeB50g=;
        b=nVG4zATPnvEUnsT20GCN2Y9RrH6Yogs49GvQMGcXGU8y6weZSxMIoccx8xNqN5/bqM
         ASzT04YhgJ+B3Foab4MaxDIUUgmrSyUuQ+dhavd4NoIzfLE6Tlo4m4XkRXPwuWjwx9ax
         pbsycT7n9powy4uKf5UqEE7DsSl/lcGHhxUVsHBRVtwW69lLWYGX3wErvK+DWAeGpKDM
         ld6dqXwu3mg9yUyXVxTLsJNc6S8SA2t2p9A+Nd1bi3GC7+aG+JbAqnzx0C6d3y6hYHLi
         fkCTcBXloV5vEtcjV7jhRqehIMsw+ncO50vvYkGZMM3VCZ6EZ2BlHrAH+4TpbARBvXG6
         X6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=552P3X5AIoGxxPcUinhjnI4ENWQ5hjfJcdOghjeB50g=;
        b=Eb2x2e/b8WR+oyALmosyO0ihmUbRozmP2hxWvXj0H113qLiKCGe7LwDhd31X/F6mUI
         VFEnRDwgpyqQQ+nT5j3qRjly1EbrX08LCbHCNF6/w+itsauNKx9CKycx9rpAxb9j7XVv
         IATcNatMxKrkmnMjcjDfCUidVCzVaa54h7a9IUBeLT8XX/1TyJwHm7M4j259YBvsYLbC
         A73BMJvX18kBSemW7s/XiHFWnsS2/QtymTvBYYNaeHp6ezwqkHGi9l3oN3jBIvyftmZi
         EvJKJrDBu7c5eTed8OG80TJ9M8jEH4blW6obYfbwCicVyL9A34zMeSEQXjtSuAP9392h
         VD3w==
X-Gm-Message-State: AOAM532QW7j9YEKnQ8hU5N+42ovh0XIo8Gd85RMrWW3U5K5UCCoK4yeg
        Szq3z+lpjFyPg3FkBVhMiyi6Hw==
X-Google-Smtp-Source: ABdhPJwC8i3Kx+oHJ3a0r6rH9uYevXBf2fLB8vKPm/rP+tPvcdxw8CoiYaYcwUyjQXkkBymNNkhqnA==
X-Received: by 2002:a17:90a:e391:: with SMTP id b17mr8646314pjz.75.1622276202956;
        Sat, 29 May 2021 01:16:42 -0700 (PDT)
Received: from localhost.localdomain (76-242-91-105.lightspeed.sntcca.sbcglobal.net. [76.242.91.105])
        by smtp.gmail.com with ESMTPSA id b12sm6613960pgs.52.2021.05.29.01.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 01:16:42 -0700 (PDT)
From:   houdek.ryan@fex-emu.org
X-Google-Original-From: Houdek.Ryan@fex-emu.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ryan Houdek <Houdek.Ryan@fex-emu.org>
Subject: [PATCH 0/4] arm64: Implement userspace syscall dispatch
Date:   Sat, 29 May 2021 01:16:16 -0700
Message-Id: <20210529081620.164422-1-Houdek.Ryan@fex-emu.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryan Houdek <Houdek.Ryan@fex-emu.org>

arm64: Implement userspace syscall dispatch

The first patch moves the userspace dispatch code from the common
syscall entry path. This is necessary since arm64 doesn't support
the common syscall entry path.

The second patch exposes where the sigreturn landing pad location is.
The syscall user dispatch code checks this landing pad to see if
it should skip invoking the userspace dispatch path.

The third patch is where the userspace dispatcher work is hooked up
to arm64 syscall dispatcher. Fairly straight forward, adds a new check
to the trace enter and exit paths for user dispatch.

The fourth patch just updates the selftests to handle aarch64.

The sud_bench application shows a consistent 2.3% overhead on my device
when testing. Going from 477ns to 488ns per syscall.

Ryan Houdek (4):
  Move userspace syscall dispatch outside of common entry
  arm64: Track the sigreturn landing pad location
  arm64: Enable userspace syscall dispatch
  arm64: tools: Update syscall user dispatch tests

 arch/Kconfig                                  |  4 ++++
 arch/arm64/Kconfig                            |  1 +
 arch/arm64/include/asm/syscall.h              |  2 ++
 arch/arm64/include/asm/thread_info.h          |  4 +++-
 arch/arm64/kernel/ptrace.c                    | 24 +++++++++++++++++++
 arch/arm64/kernel/syscall.c                   |  9 +++++++
 arch/arm64/kernel/vdso/sigreturn.S            |  1 +
 arch/arm64/kernel/vdso/vdso.lds.S             |  1 +
 include/linux/syscall_user_dispatch.h         |  4 +++-
 kernel/entry/Makefile                         |  3 ++-
 kernel/entry/common.c                         |  3 +--
 kernel/entry/common.h                         |  7 ------
 kernel/entry/syscall_user_dispatch.c          |  2 --
 .../syscall_user_dispatch/sud_benchmark.c     |  2 +-
 .../syscall_user_dispatch/sud_test.c          |  9 +++++++
 15 files changed, 61 insertions(+), 15 deletions(-)
 delete mode 100644 kernel/entry/common.h

-- 
2.30.2

