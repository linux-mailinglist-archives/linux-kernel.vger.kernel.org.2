Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBC4F3FEFB6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 16:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345653AbhIBOxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 10:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345545AbhIBOxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 10:53:00 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B05BC061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 07:52:02 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so1627053pjc.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 07:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5pN7v4ea6JVRwcYbzT57F/Ba7bm6wPYHneE0JrKsfnw=;
        b=C48iHpr9pk3IoBBMVMEBx2Bu9bbVIVnxI7aTRrg216+oElP2+iRKLXWaxvQZkD9gKQ
         68XH8arQbIKh3eBwMlttfSZ3FdVccNrTtRSu8NpEVwQCz391nA0bNW2HiJiK/UwUld8t
         q6wRUyv/otnHJkTPlToE8wHDy6463hid0O+nRgP7toC2pFymBUu+A/q3EXb2+42bICkd
         3KiNGU0SAYhocJXy6XBTDmMYBQ1Ulr6yNsq+OlOMK6WNi/EarQE01atkJYpQMnSoG3Jd
         lSgcGY2oNa3WmMkNxKOOk7b0DmldYiEWAzoGSZexF2IspMIihP1gOi89ct2JFi+yXFdQ
         dC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5pN7v4ea6JVRwcYbzT57F/Ba7bm6wPYHneE0JrKsfnw=;
        b=YjNE3WHClyg/gJf7AeKGWZk2ZgLJul3lTioNT3RnKsP4LwIHo60LtTqeDX+1nUvyHq
         cIkZysk9O/NRsxPOOzRg1rvm6yOaQG+xU3KahuxY3gBEP/DcKO67DeNs7oliVsuPYFmb
         RKu+X7aYpY/SNEbgv6ij5PzRjfaiqJUo8uSnBzriLTOFSAJh1WPl7AYO9m4RDVXvGDf3
         OjtA16FoYLwN/3Kgb9tknZ6hET5JbN5mCuKZYuxE6huuOKFFBKtkugOjqCwo5HJit72P
         wTdQbhLKczCPZlySUU05LmSCjcIJAAostXFlDLAoOAIVr2USg7VFlLOnuFpWU5NlIsxR
         emBQ==
X-Gm-Message-State: AOAM531EPZp1C6CaEQbE4ZGbEAXKjviplunnO8AmUv/GBYypbAjyVlZv
        OJcDhJRO3iXnZgb+AGk4Ozo=
X-Google-Smtp-Source: ABdhPJz2/G7LEhOrRZn6jyYAddm5ciJMDPjIESVGasISc9KGr3JWIAEQfc8xYpRX79JHbpYKduKD6w==
X-Received: by 2002:a17:90a:194a:: with SMTP id 10mr4406460pjh.176.1630594321634;
        Thu, 02 Sep 2021 07:52:01 -0700 (PDT)
Received: from octofox.cadence.com ([2601:641:401:1d20:49eb:5986:4393:7ed3])
        by smtp.gmail.com with ESMTPSA id o14sm3189746pgl.85.2021.09.02.07.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 07:52:00 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL 0/7] xtensa updates for 5.15
Date:   Thu,  2 Sep 2021 07:51:36 -0700
Message-Id: <20210902145136.21967-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the following Xtensa architecture updates for v5.15:

The following changes since commit 36a21d51725af2ce0700c6ebcb6b9594aac658a6:

  Linux 5.14-rc5 (2021-08-08 13:49:31 -0700)

are available in the Git repository at:

  git://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20210902

for you to fetch changes up to 7b7cec477fc3cd42ce565dfc3e53f144504fc95c:

  xtensa: move core-y in arch/xtensa/Makefile to arch/xtensa/Kbuild (2021-08-11 11:37:13 -0700)

----------------------------------------------------------------
Xtensa updates for v5.15

- fix kconfig unmet dependency warning for HAVE_FUTEX_CMPXCHG
- add fairness to handling IRQs of the same priority
- fix pointer usage before NULL check in ISS console driver
- build system cleanups

----------------------------------------------------------------
Masahiro Yamada (4):
      xtensa: remove unneeded exports
      xtensa: do not build variants directory
      xtensa: build platform directories unconditionally
      xtensa: move core-y in arch/xtensa/Makefile to arch/xtensa/Kbuild

Max Filippov (2):
      xtensa: add fairness to IRQ handling
      xtensa: ISS: don't use string pointer before NULL check

Randy Dunlap (1):
      xtensa: fix kconfig unmet dependency warning for HAVE_FUTEX_CMPXCHG

 arch/xtensa/Kbuild                  |  1 +
 arch/xtensa/Kconfig                 |  2 +-
 arch/xtensa/Makefile                | 12 ------------
 arch/xtensa/kernel/traps.c          |  7 +++++++
 arch/xtensa/platforms/Makefile      |  4 ++++
 arch/xtensa/platforms/iss/console.c |  6 +++---
 6 files changed, 16 insertions(+), 16 deletions(-)
 create mode 100644 arch/xtensa/platforms/Makefile

-- 
Thanks.
-- Max
