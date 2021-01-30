Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFACF3093BF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 10:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbhA3Jw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 04:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbhA3DBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 22:01:36 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F90C061797
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 18:52:53 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id q131so7396660pfq.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jan 2021 18:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:cc:from:to:message-id;
        bh=z0ZSRAm22becpoRJb9gtSQVe8ycgGNmfWJKMTAVmy7w=;
        b=GwLpMbfM6WAZVcr1QevQus5d4SobAJ9SIZ+mvNqxCPS66/pVg0HN0aNAdR8AcX6nSw
         q+U2qhTq1d6Is3uT/3wqIOKAkEpSuP6v7yKV9w05AGZG+nzq5EMV1kErrpPP4cu3u5FW
         UOlrZoFd1ZJIdH6mchJkoWCgCoFYgQzBl8sv8814DDmMASYUkwpgAICeYzRKtUqSEO6B
         BnT4tqtV/J54KOPQAei/GckKR6pqQyQ0hjwgiTO1rC68ZbQGhSqkkyl1IHVMfQucV+a1
         xmmJFGm7Xf6lDZM1Dq0t0K6Awx3gTJBHpw3Ot6xtLVit/Y4r/AegD3NL+nqYYq5094ed
         Z6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:cc:from:to:message-id;
        bh=z0ZSRAm22becpoRJb9gtSQVe8ycgGNmfWJKMTAVmy7w=;
        b=hmoQou61VXjT2lF3pjfsKwNqxzVe5+yfthiv6O0xTQdCR0jLyB0TwDTRpXZUHmEK1+
         ltIgmkymlA0vU4S8KfSNLQxE3p/qXtw3PzsQxxGMTtj5iwxELnQvvt3vrox6COsu2Zt+
         E3CPqP3GvFqOX5E57pLfSM5RqZdVPT1RVCdQ8pNbflYvRl1K+6V0iGSSzyt2SU4UQasw
         M3COcmEtXMGQEYPzwyrai3ZoAPojh4MUPXKl29F01I/ugHUNvKx951DgVzGUHWkY+AmN
         qExjvPIC0QM5lML2kZP1rg5xI+FwGiGQYOm3S/9wceomiDf2Wxq3FbbEIksee1sCDRlk
         izsg==
X-Gm-Message-State: AOAM5322TejilE0+19j/B55vNK6/scPQ5eVks13gwRDWfdxUfPGyAN9O
        1SRxjfDUtmet0pmaejjfNp6i2A==
X-Google-Smtp-Source: ABdhPJz6ksfwhE/qfo7BaGpKQo1YSgYeKx5gzN2g1HwK7oNMEiNEL+mIJm7O/+1TZKkZ8sRUWkzI9g==
X-Received: by 2002:a63:c207:: with SMTP id b7mr7310629pgd.184.1611975172866;
        Fri, 29 Jan 2021 18:52:52 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id p7sm9877162pfn.52.2021.01.29.18.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jan 2021 18:52:51 -0800 (PST)
Date:   Fri, 29 Jan 2021 18:52:51 -0800 (PST)
X-Google-Original-Date: Fri, 29 Jan 2021 18:52:49 PST (-0800)
Subject: [GIT PULL] A Single RISC-V Fix for 5.11-rc6
CC:         linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-72236532-fb2c-406a-9a7e-509c579364c5@palmerdabbelt-glaptop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 19c329f6808995b142b3966301f217c831e7cf31:

  Linux 5.11-rc4 (2021-01-17 16:37:05 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-5.11-rc6

for you to fetch changes up to 336e8eb2a3cfe2285c314cd85630076da365f6c6:

  riscv: Fixup pfn_valid error with wrong max_mapnr (2021-01-22 20:18:03 -0800)

----------------------------------------------------------------
A Single RISC-V Fix for 5.11-rc6

* A fix to avoid initializing max_mapnr to be too large, which may
  manifest on NUMA systems.

----------------------------------------------------------------
Guo Ren (1):
      riscv: Fixup pfn_valid error with wrong max_mapnr

 arch/riscv/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
