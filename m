Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7808F321E0D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 18:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbhBVRZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 12:25:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbhBVRZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 12:25:08 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D73C06178A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 09:24:28 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id v1so19905874wrd.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 09:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=WNFKIIU7i+VoUA+RJn2HCqv7Dgcv69h0RbQpQNJXApo=;
        b=CzKUxd5UUvz2JZ7QNLj/YnAtevriJdfR9zChFMjWdn8G2rRCY+f16tQHqIhljcL5sm
         HD1myFiHet1L4ci3AdC//zUnPjDC9t2MEDRFsp+2iA03vGOkOWjeywHqC6mUwctsa1Bh
         55dcb8TIcSgYNiOxwS4Ziz85HSG6JuhBNu5rzBxlR0XFRLMbatT+Ep300Q6aOzWKBOFK
         BTQETwfSdEj6MGuwMF29uKdVYYOzGwsXxFIPDGFPP8zXVP1590IMpx9EAHoGn6ot/A8o
         oTMqcnmXc7x96Esh4G4NmxqKgvyyJbGzM7hGEoNKv6PLmDc1Xcs6BR/oBf+TA1QehiCr
         bABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=WNFKIIU7i+VoUA+RJn2HCqv7Dgcv69h0RbQpQNJXApo=;
        b=DeV1a2pwTMK/NieLu09huoHyl6VchzX+NMm4ND0gILTfEzF2V9+4VARj2qMzgqxI1S
         LwidJq6T7b+/+PCzrvwfY1JpVjJNM51lSsaay7XKI2cZzsWLuXu+1an7d4lQwUlNAZhR
         wxUwFqLwBbrHuy31jE7FNwjOoGM5hyLTJIEOPCylQCtjQq4SgQYvVci/5Y5GVtZnxmN0
         p08PhsdpoM9fIJJOu32e3aCg1xXFVO3xngGpKmqj4cCtUg/v02lBNt7yWxclKyAS6qjM
         xevBNPBqd3OLghw6WPWz0YaH+u+Z1dk78syArz4WqxEiLlvRuSx1+cEV3tiqwFe8Ocxi
         QiSg==
X-Gm-Message-State: AOAM533oyKig7GYy2+Ij6f/SeGO/QCvAMWnpS3/9wOQXmj1wAXTCNGHf
        fHpDtMCvVvd2RFkN0dIOD5EDVA==
X-Google-Smtp-Source: ABdhPJyWJ6Mi1cLpnrJHha+szSbie6AMhN/qxwSzq2GJr6sCO38+y5bVXBVTuAEjVJtZOZlIjEO0kg==
X-Received: by 2002:adf:fdd0:: with SMTP id i16mr22282771wrs.215.1614014666916;
        Mon, 22 Feb 2021 09:24:26 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id t11sm18485201wmb.32.2021.02.22.09.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 09:24:26 -0800 (PST)
Date:   Mon, 22 Feb 2021 17:24:24 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Sumit Garg <sumit.garg@linaro.org>,
        Stephen Zhang <stephenzhangzsd@gmail.com>,
        wengjianfeng@yulong.com, Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [GIT PULL] kgdb changes for v5.12
Message-ID: <20210222172424.yw5nvfuadr5m5max@maple.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 19c329f6808995b142b3966301f217c831e7cf31:

  Linux 5.11-rc4 (2021-01-17 16:37:05 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-5.12-rc1

for you to fetch changes up to f11e2bc682cc197e33bfd118178cadb61326dc0e:

  kgdb: Remove kgdb_schedule_breakpoint() (2021-02-11 10:51:56 +0000)

----------------------------------------------------------------
kgdb patches for 5.12

Another fairly small set of changes of changes this cycle. The most
significant functional change is a fix to better manage the flags
when allocating memory.

Additionally there is the removal of some unused code (which is
slightly more dramatic than it sounds given it means there are now no
tasklets in kgdb) together with a tidy up of the debug prints and some
spelling corrections for the documentation.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>

----------------------------------------------------------------
Daniel Thompson (1):
      kgdb: Remove kgdb_schedule_breakpoint()

Lukas Bulwahn (1):
      kgdb: rectify kernel-doc for kgdb_unregister_io_module()

Stephen Zhang (1):
      kdb: kdb_support: Fix debugging information problem

Sumit Garg (1):
      kdb: Make memory allocations more robust

wengjianfeng (1):
      kernel: debug: fix typo issue

 include/linux/kgdb.h           |  1 -
 kernel/debug/debug_core.c      | 28 +---------------------
 kernel/debug/gdbstub.c         |  4 ++--
 kernel/debug/kdb/kdb_private.h | 12 +++++++++-
 kernel/debug/kdb/kdb_support.c | 53 ++++++++++++++++--------------------------
 5 files changed, 34 insertions(+), 64 deletions(-)
