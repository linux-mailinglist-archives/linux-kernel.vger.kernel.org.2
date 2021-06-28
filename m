Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91D853B695F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 21:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235807AbhF1T7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 15:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbhF1T7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 15:59:45 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68539C061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 12:57:18 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id v12so9559880plo.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 12:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=xZB+48Xt6ODEdQPyWqRZn/VY5k+bIIkDjFatm6tmQ2Y=;
        b=JS8r3Cne2SK8SluNsv0cW9nPIdsf4yGx+Pyh2S0wGA8xmI5Azhnj5bGV/P+X2jlGsM
         uU0mHd6U+oDmvEjVP2VaFvnZDcD4utHAKLjfEY68ymI/JqGQkhiiso42rNthAHXhmlaK
         /vbtSLSmdsz3tAnEcSY30Dcblww8jhHMm7NDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=xZB+48Xt6ODEdQPyWqRZn/VY5k+bIIkDjFatm6tmQ2Y=;
        b=TtaeNCSKtR6F35g5wwe0ys/OJqnKggJSoSzhGSrATwoNqfkw9T18vMjyMWrCoHdvC1
         oKFXb/F6tvq6TyQeT0kwPYsQEcDCf+/Gh8JvnGxJYwoS2RG97cWgHHznyAGWee5LY6eK
         jmOnEVFHIFR93N82xuYhzjKN9xozCzgHbcukwvMJYk+MntTw2/ctI3AKO48YlFSmmAUy
         YuJjdyjAEKueQnb2orTq7CEfj855KTh+1UB8mnIxQpoYrtyikTwO8vmFyTIGr1EWgXOp
         cxYq1Bt7+QD26jnb9XI4c+AdX26+aKtcc0pJ0f9vwMvYYJWI+GagVAWAZPqwXKXg9afq
         w8Cw==
X-Gm-Message-State: AOAM530KPHjb7kf5U39F1QrfMS0XCgMsWxMglNgIf6/3BuC2JKtGchYb
        uHZF2YktbC1+w8rjcO5ZLLJKNA==
X-Google-Smtp-Source: ABdhPJwvMC/imBeKQXNS2OQQ8AsOsZZHsalITJCS4YBkq8gu0TQ01d09N/d7tpmyFGCMsOr3IQrn2A==
X-Received: by 2002:a17:90b:93:: with SMTP id bb19mr9516000pjb.139.1624910237889;
        Mon, 28 Jun 2021 12:57:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t27sm2603755pga.90.2021.06.28.12.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 12:57:17 -0700 (PDT)
Date:   Mon, 28 Jun 2021 12:57:16 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Kees Cook <keescook@chromium.org>,
        Rodrigo Campos <rodrigo@kinvolk.io>,
        Sargun Dhillon <sargun@sargun.me>,
        Tycho Andersen <tycho@tycho.pizza>,
        Will Drewry <wad@chromium.org>
Subject: [GIT PULL] seccomp updates for v5.14-rc1
Message-ID: <202106281254.440E6D926@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these seccomp updates for v5.14-rc1. Note that the commit
dates show "today", but this has been in -next for a while. I didn't
correctly manage my "for-linus/seccomp" fixes branch (which this is
based on) that was pulled for v5.13-rc4.

Thanks!

-Kees

The following changes since commit ddc473916955f7710d1eb17c1273d91c8622a9fe:

  seccomp: Refactor notification handler to prepare for new semantics (2021-05-29 11:13:27 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v5.14-rc1

for you to fetch changes up to 9a03abc16c77062c73972df08206f1031862d9b4:

  selftests/seccomp: Avoid using "sysctl" for report (2021-06-28 12:49:52 -0700)

----------------------------------------------------------------
seccomp updates for v5.14-rc1

Add "atomic addfd + send reply" mode to SECCOMP_USER_NOTIF to better
handle EINTR races visible to seccomp monitors. (Rodrigo Campos,
Sargun Dhillon)

Improve seccomp selftests for readability in CI systems. (Kees Cook)

----------------------------------------------------------------
Kees Cook (3):
      selftests/seccomp: More closely track fds being assigned
      selftests/seccomp: Flush benchmark output
      selftests/seccomp: Avoid using "sysctl" for report

Rodrigo Campos (2):
      seccomp: Support atomic "addfd + send reply"
      selftests/seccomp: Add test for atomic addfd+send

 Documentation/userspace-api/seccomp_filter.rst     | 12 +++++
 include/uapi/linux/seccomp.h                       |  1 +
 kernel/seccomp.c                                   | 51 +++++++++++++++++++---
 .../testing/selftests/seccomp/seccomp_benchmark.c  | 10 ++++-
 tools/testing/selftests/seccomp/seccomp_bpf.c      | 51 ++++++++++++++++++++--
 5 files changed, 113 insertions(+), 12 deletions(-)

-- 
Kees Cook
