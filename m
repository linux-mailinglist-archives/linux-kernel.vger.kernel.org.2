Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA74370962
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 02:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbhEBATy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 20:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbhEBATx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 20:19:53 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54B7C06174A
        for <linux-kernel@vger.kernel.org>; Sat,  1 May 2021 17:19:01 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id k127so1892823qkc.6
        for <linux-kernel@vger.kernel.org>; Sat, 01 May 2021 17:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1Of0XcLlfHKCxHPsgc9mruieTzxAs761HczQBIKnhe0=;
        b=RJJsSKb3J60FEzVIAXoIuWglAxKe/2ieSjFdC/m8M4pCax51twizMiQJD4xRJf5cUP
         1PUHPfJmCTkgdV3QuOfLqnpf4Pq3A3bBE4/lsPM67Mxqg+LY6A9pqmBlfIvvRch3vTS8
         KaXFLUQZEAxFqfZ0qa3rBLWpEhsMn9YW8SQvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1Of0XcLlfHKCxHPsgc9mruieTzxAs761HczQBIKnhe0=;
        b=P41hwpU7O/RLbWGpMYK4kh4T6fDeIpa2UVYGv8pAaf0J82k2SfygtQH2FiJ8QsPxpJ
         OWta8+mThVU0nftpiFTjwXqy7epPvaVeg1IaF2vFfZwTIeJB0FNQQr82XTDPoAgYZtk7
         UnrLS5U0dhlkv6ZNZjL8uDBAAyYlKcusOdgaLOfQ2fv3Sdr26vyaN1iKfQETEETyz3oA
         FKb6JwKyMEbQWabzCp00ZEm7bguTfv3M+bGlPSqsMU2O2klEf5bxzanbkFO27TloqNli
         hKzFZ5WLDJ4wJjv5Vj9dAfe/pNJ2DKoneabrPJosAnmaXYlj1Aqeq2lUPW/axRo7fLJS
         zTQg==
X-Gm-Message-State: AOAM530z5stn885NWkr3MEAEoDYtUao/YS0+f5MtT1lGPghfCG3dPb0M
        tVO2sWmj3Ppl2YI9O5sMK57n6T2bt+YdYtST5mA=
X-Google-Smtp-Source: ABdhPJx+X8W3mQclWNKXDwLEWvNcsz3apjytoglj/cO4uLOZ16u8fa7kuVU/QBHXPMoJFD1AmA5xpw==
X-Received: by 2002:a37:b603:: with SMTP id g3mr12729945qkf.38.1619914740751;
        Sat, 01 May 2021 17:19:00 -0700 (PDT)
Received: from ubuntu.netflix.com (136-25-20-203.cab.webpass.net. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id p5sm5146067qkh.135.2021.05.01.17.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 May 2021 17:18:59 -0700 (PDT)
From:   Sargun Dhillon <sargun@sargun.me>
To:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>,
        Tycho Andersen <tycho@tycho.pizza>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        =?UTF-8?q?Mauricio=20V=C3=A1squez=20Bernal?= <mauricio@kinvolk.io>,
        Rodrigo Campos <rodrigo@kinvolk.io>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>
Subject: [PATCH 0/4] Atomic addfd send and reply
Date:   Sat,  1 May 2021 17:18:47 -0700
Message-Id: <20210502001851.3346-1-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is somewhat of a respin of "Handle seccomp notification preemption"
but without the controversial parts.

This patchset addresses a race condition we've dealt with recently with
seccomp. Specifically programs interrupting syscalls while they're in
progress. This was exacerbated by Golang's recent adoption of "async
preemption", in which they try to interrupt any syscall that's been
running for more than 10ms during GC. During certain syscalls, it's
non-trivial to write them in a reetrant manner in userspace (socket).

Rodrigo Campos (2):
  seccomp: Support atomic "addfd + send reply"
  selftests/seccomp: Add test for atomic addfd+send

Sargun Dhillon (2):
  Documentation: seccomp: Fix user notification documentation
  seccomp: Refactor notification handler to prepare for new semantics

 .../userspace-api/seccomp_filter.rst          | 28 +++++--
 include/uapi/linux/seccomp.h                  |  1 +
 kernel/seccomp.c                              | 79 ++++++++++++++-----
 tools/testing/selftests/seccomp/seccomp_bpf.c | 38 +++++++++
 4 files changed, 120 insertions(+), 26 deletions(-)

-- 
2.25.1

