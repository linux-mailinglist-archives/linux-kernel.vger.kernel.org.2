Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4493322E26
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 16:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbhBWP6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 10:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233221AbhBWP6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 10:58:45 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57511C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 07:58:04 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id f3so10334267qtx.18
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 07:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=8+RAJRfk7OgTbqYxM+UQ8jVedyDuoEoPCHMyB2VOKvw=;
        b=snwCyNWSPwFiEEeXVMcwvUJc/IRLxmiXQcR7NjazF5zumyLDL41CwJuCP2fGuVho1C
         z5RYgOeRTAfC/A8s46Ycm002cgQir0u2TrRHv7a5W5s5GaHUNAl+Q4ozk53eCwJcm+bj
         8qt9sgY/Jlt+1Xnvh/HLfAm021tDWKoeAa7kBxKFmXWHPqn+A0H8GJv3kqUwWVXA4yHh
         5DpuhixsHvEA2k4L6Da4x3qFZm0yPkbdZ4I4MJoYXkJD8djPs6fCBa7k88HX/Q007WzO
         8r6bkwmdzRd9sxsvGiHLRdTI4pnJ7U1qvIlPgmmCmTLDaohHrp/uhKmlMcwZPwn1/CO/
         Ksvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=8+RAJRfk7OgTbqYxM+UQ8jVedyDuoEoPCHMyB2VOKvw=;
        b=YcwNOcloknGhRY6e2ZPkUT2VztYbt3CPfL5MqE08Xi+Xiqkv1vL3+Hwgip4eaN8v/u
         gR3Dt5DjPu38/sJ0po5Xz9Y2cXRbhdbtbF2LSIK9NXfJzX0rcj9rQCN3gafHtHqJHxa8
         kZ0zM4rkQlV6de4QihaBsnh+6rYO1Z4dqQaKqq/VfCupAyKRI2Y7/qtNcqsHNW6Ctw6c
         aqhu2A1kyEDGIImqHWaenNuynGnkF0Oi4a2NOH6kDlQnwgFgKZdXWNRXpfGbhKBVwqce
         S7cL7sNtZs9ycIdIJigm0VlUa6MYBnYUAw8brI9c7rmK2tXD5WUsPp6rkI3DzMpIpnSB
         flrg==
X-Gm-Message-State: AOAM533F0TMflggtXDnkX5rOetc++gDGNpq7djobjzBxik0F/rRZOiUp
        VxTpT3J/3He2VhS7khRAHrisIE/crP4=
X-Google-Smtp-Source: ABdhPJxbhW6PmZUZmluboVPrGia5p5n2v2pDxQTnwmvGVtN8k23UllNq5Fr1Q5n5YQhxcPwFJhKZvg6Qm0c=
Sender: "ascull via sendgmr" <ascull@ascull.c.googlers.com>
X-Received: from ascull.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1510])
 (user=ascull job=sendgmr) by 2002:a0c:b495:: with SMTP id c21mr25640106qve.19.1614095882687;
 Tue, 23 Feb 2021 07:58:02 -0800 (PST)
Date:   Tue, 23 Feb 2021 15:57:55 +0000
Message-Id: <20210223155759.3495252-1-ascull@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [PATCH v2 0/4] Debug info for nVHE hyp panics
From:   Andrew Scull <ascull@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, maz@kernel.org, james.morse@arm.com,
        suzuki.poulose@arm.com, julien.thierry.kdev@gmail.com,
        will@kernel.org, catalin.marinas@arm.com, kernel-team@android.com,
        Andrew Scull <ascull@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Panics from arm64's nVHE hyp mode are hard to interpret. This series
adds some more debug info to help with diagnosis.

Using BUG() in nVHE hyp gives a meaningful address to locate invariants
that fail to hold. The host can also look up the bug to provide the file
and line, if the debug configs are enabled. Otherwise a kimg address is
much more useful than a hyp VA since it can be looked up in vmlinux.

The lib/bug.c changes apply on 5.11.

This arm64 KVM changes apply on top of the previous panic fix at
https://lore.kernel.org/r/20210219122406.1337626-1-ascull@google.com/

From v1 (https://lore.kernel.org/r/20210223094927.766572-1-ascull@google.com/):
 - keeping struct bug details in bug.c
 - using SPSR to distinguish hyp from host
 - inlined __hyp_panic_string

Andrew Scull (4):
  bug: Remove redundant condition check in report_bug
  bug: Factor out a getter for a bug's file line
  KVM: arm64: Use BUG and BUG_ON in nVHE hyp
  KVM: arm64: Log source when panicking from nVHE hyp

 arch/arm64/include/asm/kvm_hyp.h        |  1 -
 arch/arm64/include/asm/kvm_mmu.h        |  2 +
 arch/arm64/kernel/image-vars.h          |  3 +-
 arch/arm64/kvm/handle_exit.c            | 31 ++++++++++++++
 arch/arm64/kvm/hyp/include/hyp/switch.h |  2 -
 arch/arm64/kvm/hyp/nvhe/host.S          | 17 ++++----
 arch/arm64/kvm/hyp/nvhe/hyp-main.c      |  2 +-
 arch/arm64/kvm/hyp/nvhe/hyp-smp.c       |  6 +--
 arch/arm64/kvm/hyp/nvhe/psci-relay.c    |  2 -
 arch/arm64/kvm/hyp/vhe/switch.c         |  4 +-
 include/linux/bug.h                     |  3 ++
 lib/bug.c                               | 54 +++++++++++++------------
 12 files changed, 77 insertions(+), 50 deletions(-)

-- 
2.30.0.617.g56c4b15f3c-goog

