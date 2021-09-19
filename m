Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B39410BDC
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 16:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbhISOYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 10:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbhISOYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 10:24:09 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56648C061574;
        Sun, 19 Sep 2021 07:22:44 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id z24so29237178lfu.13;
        Sun, 19 Sep 2021 07:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=U87PmLEulR4GIkAwC4Q7eR5y4RC0U0UQ55s5eDtGOsc=;
        b=QEbyTTSv86EC1cuq8WJnQbl9fi8wdYQDk19PS9ojjFFhUF+MBKPSSSj/GE1O+7lNS7
         z8E/lJJFMHrASUa1Ej3C2yaaBPUuFqeIehR6BTKMbHo2xN3bumDySBBsNJbw8mLGFHDU
         kZpHsuh/spWVGN1y3Jm4gTTeBgVIf6uS9f3DJUXSL1Hoihf7dTyJ2Kmaag0C4uBSsoOt
         4GYrk4mpybu+W1tUMJGrQJbe7s7mCcpHRl3uBZ2RIoeaefl9Y/KyiTwCxxklOzmDp+jL
         S4NGUQYkotV1q2VDyy9whnoIE/nZxWPRehBaSa6NAgzekJcqz25Eb843e7q0hL+HnUTs
         hKaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=U87PmLEulR4GIkAwC4Q7eR5y4RC0U0UQ55s5eDtGOsc=;
        b=tn0d7avifDv8wfXoqls1nQ6VFywN2VARE5CPddJ2fEpdHFoqkA2BthRvj8ZVZgmBTU
         POlPh26rwfj8SNECElNQEOXwIccXv08YpPL296Tgkg6ZFAHgg2fVldS/Hi1ZSXnAi1et
         CBbNYDhCZszjqONeqOPVAPeF9zq9B9HcEsXQoWB1bWxxZ9iWfuM/bFn4Ccd6MGZGv+yj
         20ZEshy8cdZi0FP/K6In0y8rKeG567hY5c6rHydWwlm16CxKVsx9a4QwN7VtlbywLc0u
         vVh+X296Wj0QcQO7uv3phPECcUI0aEro3vs0BqL39U/wfpwPO+Y8SbLVEVYzicDnRyS0
         aCYw==
X-Gm-Message-State: AOAM5309GD9MJr/rNKLxikZ8U0Md5ABypQLCjah7X9QmTT8uh6FQa74l
        rHRheIfym6kFSqfABdr+Au2grKZUfEvhAn/WC6b6lWuvhqQ=
X-Google-Smtp-Source: ABdhPJwjcezA8eWAga8CGggGj+S7hGf6aFLUMhVRA0u/YYHW0V7pVXnTDZDneF5H2oX7pCcYB5A8nev1Yfir3QsQyoM=
X-Received: by 2002:a2e:1652:: with SMTP id 18mr11675790ljw.23.1632061362579;
 Sun, 19 Sep 2021 07:22:42 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sun, 19 Sep 2021 09:22:31 -0500
Message-ID: <CAH2r5mvu5wTcgoR-EeXLcoZOvhEiMR0Lfmwt6gd1J1wvtTLDHA@mail.gmail.com>
Subject: [GIT PULL] ksmbd server security fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull the following changes since commit
bf9f243f23e6623f310ba03fbb14e10ec3a61290:

  Merge tag '5.15-rc-ksmbd-part2' of git://git.samba.org/ksmbd
(2021-09-09 16:17:14 -0700)

are available in the Git repository at:

  git://git.samba.org/ksmbd.git tags/5.15-rc1-ksmbd

for you to fetch changes up to 6d56262c3d224699b29b9bb6b4ace8bab7d692c2:

  ksmbd: add validation for FILE_FULL_EA_INFORMATION of smb2_get_info
(2021-09-18 10:51:38 -0500)

----------------------------------------------------------------
3 ksmbd fixes: including an important security fix for path
processing, and a missing buffer overflow check, and a trivial fix for
incorrect header inclusion

There are three additional patches (and also a patch to improve
symlink checks) for other buffer overflow cases that are being
reviewed and tested.

Regression test results:
http://smb3-test-rhel-75.southcentralus.cloudapp.azure.com/#/builders/8/builds/67
and
https://app.travis-ci.com/github/namjaejeon/ksmbd/builds/237919800
----------------------------------------------------------------
Hyunchul Lee (1):
      ksmbd: prevent out of share access

Mike Galbraith (1):
      ksmbd: transport_rdma: Don't include rwlock.h directly

Namjae Jeon (1):
      ksmbd: add validation for FILE_FULL_EA_INFORMATION of smb2_get_info

 fs/ksmbd/misc.c           | 76 +++++++++++++++++++++++++++++++++++++++++------
 fs/ksmbd/misc.h           |  3 +-
 fs/ksmbd/smb2pdu.c        | 18 +++++++----
 fs/ksmbd/transport_rdma.c |  1 -
 4 files changed, 81 insertions(+), 17 deletions(-)


-- 
Thanks,

Steve
