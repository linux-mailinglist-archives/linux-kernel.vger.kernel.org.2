Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F15B944044D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 22:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbhJ2UsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 16:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbhJ2UsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 16:48:24 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB35C061714
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 13:45:55 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id d5so3185676wrc.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 13:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q7JMVL7G4r57WQGGqdVOy40eDcbhr5zqpbYFZ6tt2qc=;
        b=TU6GHjk8LerR625mUlOu+XAhKMtJtLYc934B26SqDBTji2fm78zsYJGU7Q73ULdHlN
         MazFt/euYGnGc6CWqnKqobfiVmn7dRKBJn1z7fg5tXjmi69G+RPYp2A3JoTs1EXdVtzz
         ebcchXX0wjf4b6OacFjRqN5OBNLT5eTK5GVgh+taVc5oDpJua4FFogYsa5/4zSSTf6tm
         A6BEOzQnsbfplx9puF8OmndEhvwnn5jayLUbagytRrDVP7TwsYWno7BFO0TUPVV2ZYSd
         Znk4KBJICkBtwAz6Aa+fPfwi1wLTjTPA87yZwquBtOlBQhEMSplescRH9h6zOHXa0VGK
         TEZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q7JMVL7G4r57WQGGqdVOy40eDcbhr5zqpbYFZ6tt2qc=;
        b=p54iAMi6Or+/AI+WArCJDxOrNBS+Ha6P0hWJ7XQ6ljC8I04oQNkBBxsUI1Ou4FodqS
         dLb11XmObh1R10lANtCVnFsOC15g91EkEy+Wf1K0LMYlLbvem+wrbNNdFv781+EBPcf+
         96BqKoOxEwXdI2ME3hMpD3eObqMZWSZdVCb6Zqu6SSd1IJ2AgodM5Cma5ayMi3dLgumu
         N2Z/JyWNewZAmtl99oSNE9nX8cmU96zIFqBXK9u7wjp6suOZjTjwysXwf0UxKK0OSlNX
         +WLWwil5V0xdsGW2nTK1F8JmTZol+y7FW7Rl0EKKc7lNjxLSh6TE0NekZCLnXx4dranu
         0Epw==
X-Gm-Message-State: AOAM5335msHOG32pOTcZYEm0NQLNfT8KbHpyL0FCuhaWPm4+Dc9rDLjQ
        EfxT1vsf/Qce0gPVTejlhS2+AT9TgcDcHg==
X-Google-Smtp-Source: ABdhPJwkeK557CAOYJFHk4vaxAvdSjgL4VwKyuX2MH+nuV/lj+hlA0Fk/sliiMoFNZnLG4A8SLDkfQ==
X-Received: by 2002:a7b:c248:: with SMTP id b8mr1968818wmj.190.1635540353553;
        Fri, 29 Oct 2021 13:45:53 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:334:ac00:7d50:ff5:f5c1:e225])
        by smtp.gmail.com with ESMTPSA id k22sm6749196wrd.59.2021.10.29.13.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 13:45:53 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [GIT PULL] gpio: fixes for v5.15
Date:   Fri, 29 Oct 2021 22:45:50 +0200
Message-Id: <20211029204550.24882-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

This is the last batch of fixes for the GPIO subsystem. Nothing worth
noting, just minor driver fixes.

Please pull.

Best Regards,
Bartosz Golaszewski

The following changes since commit 6fda593f3082ef1aa783ac13e89f673fd69a2cb6:

  gpio: mockup: Convert to use software nodes (2021-10-06 13:04:04 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio-fixes-for-v5.15

for you to fetch changes up to c0eee6fbfa2b3377f1efed10dad539abeb7312aa:

  gpio: mlxbf2.c: Add check for bgpio_init failure (2021-10-25 10:15:05 +0200)

----------------------------------------------------------------
gpio fixes for v5.15

- fix the return value check when parsing the ngpios property in gpio-xgs-iproc
- check the return value of bgpio_init() in gpio-mlxbf2

----------------------------------------------------------------
Asmaa Mnebhi (1):
      gpio: mlxbf2.c: Add check for bgpio_init failure

Jonas Gorski (1):
      gpio: xgs-iproc: fix parsing of ngpios property

 drivers/gpio/gpio-mlxbf2.c    | 5 +++++
 drivers/gpio/gpio-xgs-iproc.c | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)
