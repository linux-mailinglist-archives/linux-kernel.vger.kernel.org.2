Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE95441EC4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 17:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbhKAQr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 12:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbhKAQrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 12:47:25 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BEAC061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 09:44:51 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o10-20020a17090a3d4a00b001a6555878a8so4946237pjf.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 09:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Ty8ra5n0G4eOQKbo8aQNfAJPHQXp4+FFmeIlBUhfJ/k=;
        b=l0hysAKC+ph+IvrN2fo7yQlTAV4pOytfm9GD4bySLMWUKeVvhdQBnf8J0PtyId/Ado
         O0ScYj7EmYJAVZmgiuumu6TIBgY+DOkKtr35UWRCD9oj7TFrXGupEjGhcq0m9wEk7uRK
         WEINi1FcYEnfgeQFNuAYduD0o/BTFlNCUTEe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Ty8ra5n0G4eOQKbo8aQNfAJPHQXp4+FFmeIlBUhfJ/k=;
        b=1DkhZFZPBIG9JD5GmIjs8/zPF3mRcLITAAaN7SGTsdBSLEd15oj2vimlkvoCR2Hrsb
         80B4bz5fYDR8CrADSDUdG+uGIL/rbW+fvaY42T+wly5rjuCFwv9EN2LvJ8RQv3rD2r/p
         Gd9WVYSYb6n4Xt9phxaQOzKjy1ducFkEn7dVKl0Mvg0/en8jynwHKB5sf+uGwnFYQNjR
         /583zmT0L+CdN8TugZae2jFIXEBCLGcIFohdXGFjboHH5n1i67IRlTSMMUw6QmT1Z/e6
         RJTAVXX/9O6jgaiaA9JW/FyOFPLlRnL9BCsals4r47m8HCpXPkD3RVyFC1RcE24L/VPh
         X+bA==
X-Gm-Message-State: AOAM531C07dURa9zHULSd2/Y3shSMMnlQA8R6jlr4MQtXZTd5DxkjNSX
        0SEw5qb/77OHMCW8+aV27NXLRg==
X-Google-Smtp-Source: ABdhPJyoT7GJc+5ZHhi7eCzmytnKmDmE8lPYYwCR+As40gPW5Ghx0mWPi74kjS9BRhqRskPTBkIwmw==
X-Received: by 2002:a17:90a:928a:: with SMTP id n10mr80600pjo.128.1635785091469;
        Mon, 01 Nov 2021 09:44:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x2sm14465pjd.50.2021.11.01.09.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 09:44:51 -0700 (PDT)
Date:   Mon, 1 Nov 2021 09:44:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Waiman Long <longman@redhat.com>
Subject: [GIT PULL] seccomp updates for v5.16-rc1
Message-ID: <202111010938.243DED4@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these seccomp updates for v5.16-rc1. These are x86-specific,
but I carried these since they're also seccomp-specific. This flips
the prior conservative defaults for spec_store_bypass_disable and
spectre_v2_user from "seccomp" to "prctl", as enough time has passed
to allow system owners to have updated the defensive stances of their
various workloads, and it's long overdue to unpessimize seccomp threads.
Extensive rationale and details are in Andrea's main patch[1].

Thanks!

-Kees

[1] https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?h=for-next/seccomp&id=2f46993d83ff4abb310ef7b4beced56ba96f0d9d

The following changes since commit e4e737bb5c170df6135a127739a9e6148ee3da82:

  Linux 5.15-rc2 (2021-09-19 17:28:22 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/seccomp-v5.16-rc1

for you to fetch changes up to d9bbdbf324cda23aa44873f505be77ed4b61d79c:

  x86: deduplicate the spectre_v2_user documentation (2021-10-04 12:12:57 -0700)

----------------------------------------------------------------
seccomp updates for v5.16-rc1

- set spec_store_bypass_disable & spectre_v2_user to prctl (Andrea Arcangeli)

----------------------------------------------------------------
Andrea Arcangeli (2):
      x86: change default to spec_store_bypass_disable=prctl spectre_v2_user=prctl
      x86: deduplicate the spectre_v2_user documentation

 Documentation/admin-guide/hw-vuln/spectre.rst   | 61 +++----------------------
 Documentation/admin-guide/kernel-parameters.txt |  5 +-
 arch/x86/kernel/cpu/bugs.c                      |  4 +-
 3 files changed, 10 insertions(+), 60 deletions(-)

-- 
Kees Cook
