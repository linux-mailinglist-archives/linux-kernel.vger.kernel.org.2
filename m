Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2371432049C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 10:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbhBTJHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 04:07:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbhBTJFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 04:05:52 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3E4C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 01:05:06 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id a9so4706926plh.8
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 01:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ndod0SKs53DoouSdXHyF0CmTt+j+rMCAZ9tnPJESopM=;
        b=QjB1Nxc4ywJRLTx9HaVrpbljgBRGmnEsfaNukEUqOHjHViUDS2tM3XzMVRJHY7Oe4E
         o5pVmVpAuJUXZT5miqEw6XxVoPPcMfznVLtA5iN/ibuzFLyw45x5zIpqTVaAX27xgodG
         KM+sEifyExnfEF4mzJIlS4kSONlE1hHHtxsK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ndod0SKs53DoouSdXHyF0CmTt+j+rMCAZ9tnPJESopM=;
        b=EtEGJRd9aEzTOhN5XlBm4aRIqVXCtgJkrlQOiMer9WdxjVfWKejfMLasLHnC0hAUsL
         UJBfz6VgeZgqM8sF/W8s15CVNrtKKyXpEU35J8gAmJCxPQZguVG6wnzzvdR7gBWHhgRt
         hiYZPsrKQjeuQyNi6/SKfXfyIPnIo16Qh2c4pQbkolbL1LphGvU57ZfanIfDvJ+5DBCe
         wv0aCwAIf3yUzzMsJEMOrN9I/Au1xyH2C0kIDCHxiLjtVBufJuLyLRfAm7i/0oUknNDd
         xacHPRHYKtGZw1Xe873sMMPRNNvoJ9XDajLSqTWXofpmBXLCXUl0jr2SrBmEsBaPugOI
         TPTg==
X-Gm-Message-State: AOAM532j0AQWbfOaArBwH1wacOVwe8UxI54TAIxWkkY8Wl6utp0Bdyon
        fimpzUDXzhAj9ihCRIXK6tG68Q==
X-Google-Smtp-Source: ABdhPJw4zQv/KdqhfaP8jiaNEc7ce9WHZ6hI4p2HSr3DJWVeW1Kxjfa49GF4nYmsLq3DtCJB0mlpbQ==
X-Received: by 2002:a17:90a:2848:: with SMTP id p8mr13172691pjf.55.1613811905938;
        Sat, 20 Feb 2021 01:05:05 -0800 (PST)
Received: from ubuntu.netflix.com (136-25-20-203.cab.webpass.net. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id g62sm12226727pgc.32.2021.02.20.01.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Feb 2021 01:05:05 -0800 (PST)
From:   Sargun Dhillon <sargun@sargun.me>
To:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        =?UTF-8?q?Mauricio=20V=C3=A1squez=20Bernal?= <mauricio@kinvolk.io>,
        Rodrigo Campos <rodrigo@kinvolk.io>,
        Tycho Andersen <tycho@tycho.pizza>,
        Giuseppe Scrivano <gscrivan@redhat.com>
Subject: [RFC PATCH 0/3] Seccomp non-preemptible notifier
Date:   Sat, 20 Feb 2021 01:04:59 -0800
Message-Id: <20210220090502.7202-1-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset addresses a race condition we've dealt with recently with
seccomp. Specifically programs interrupting syscalls while they're in
progress. This was exacerbated by Golang's recent adoption of "async
preemption", in which they try to interrupt any syscall that's been
running for more than 10ms during GC. During certain syscalls, it's
non-trivial to write them in a reetrant manner in userspace (mount).

This has a couple semantic changes, and relaxes a check on seccomp_data.
I can deal with these, but this was a first cut. I also expect that the
patch would be squashed down, but it's split out for easier review.

Sargun Dhillon (3):
  seccomp: Refactor notification handler to prepare for new semantics
  seccomp: Add wait_killable semantic to seccomp user notifier
  selftests/seccomp: Add test for wait killable notifier

 include/uapi/linux/seccomp.h                  | 10 +++
 kernel/seccomp.c                              | 63 +++++++++++++------
 tools/testing/selftests/seccomp/seccomp_bpf.c | 60 ++++++++++++++++++
 3 files changed, 114 insertions(+), 19 deletions(-)

-- 
2.25.1

