Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 063EE316415
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 11:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbhBJKm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 05:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbhBJKlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 05:41:10 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF9FC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 02:40:29 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id o63so960293pgo.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 02:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ujSeNrhwIUb4Pat8q055lQaymIiMVTMfJFrA21hrW/s=;
        b=kNF7byEd3Ut0Yb1SbFuOki76zDSgw/dbIeI2k8kt4Nc4xtDY4vkp+IsZQkflTTYDfG
         pul0ZYJAZILWH5G4i0xrGzHGh+MFdD7ZJ/ujemiCOW6aDMqb1ZPhwZlJdrvyf1ExMywp
         sOBNKbbfrBmZkOQuzsJMOqFO6Phsi58Ow/tJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ujSeNrhwIUb4Pat8q055lQaymIiMVTMfJFrA21hrW/s=;
        b=EKw/B3kz6ceHscj3ttUxye265Xp/WSK33wcdiJfNYP3TIw1VJHX+Kq3+tJHNwX85bo
         QrxGjDZx0cN1o5ugCuAUgtb98/yC94FGM6EL1pKvfU2NEiDwhZc9AzosISVG16qxsuJg
         50Uu16hjJKviO8mTQxNZKALz64ZLrv3UNE2i3yagIYwq50YbC137LVjNe9DW3GOeAJUy
         K/kPfDMQqCBTuTVovejd5AyZowsmwsUWysE6XVUzPYcfUXzKkp/kbTHH2tZMh+tUOogZ
         G4ixzAbzeUvoRmUAddmPuUEkbSayI1ElgB0hVoxz3giqCCgWuVnUwL4aFPEzhTSj95PD
         FTUw==
X-Gm-Message-State: AOAM532waakNm1cOfg4FJ2PW1xAIi8ycdjUzgW/dqP0e/+23KPiFy0rc
        b13xd3sBhcVuyNBvhOYmPyAoiykcZXDGQg==
X-Google-Smtp-Source: ABdhPJyoW8PyH0d9XLYC3OAojIvhPD3+EJbjNDAi5SINSS6ht/nf9hpaCX6vjuPH9tPgvJbJeRapoQ==
X-Received: by 2002:a63:27c5:: with SMTP id n188mr2498524pgn.193.1612953628723;
        Wed, 10 Feb 2021 02:40:28 -0800 (PST)
Received: from hikalium0.c.googlers.com.com (160.131.236.35.bc.googleusercontent.com. [35.236.131.160])
        by smtp.gmail.com with ESMTPSA id j20sm1908729pfe.172.2021.02.10.02.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 02:40:27 -0800 (PST)
From:   Hikaru Nishida <hikalium@chromium.org>
X-Google-Original-From: Hikaru Nishida <hikalium@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     suleiman@google.com, Hikaru Nishida <hikalium@chromium.org>,
        Alexander Graf <graf@amazon.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC PATCH 0/2] Introduce a way to adjust CLOCK_BOOTTIME from userspace for VM guests
Date:   Wed, 10 Feb 2021 19:39:06 +0900
Message-Id: <20210210103908.1720658-1-hikalium@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hikaru Nishida <hikalium@chromium.org>


Hi folks,

We'd like to add a sysfs interface that enable us to advance
CLOCK_BOOTTIME from userspace. The use case of this change is that
adjusting guest's CLOCK_BOOTTIME as host suspends to ensure that the
guest can notice the device has been suspended.
We have an application that rely on the difference between
CLOCK_BOOTTIME and CLOCK_MONOTONIC to detect whether the device went
suspend or not. However, the logic did not work well on VM environment
since most VMs are pausing the VM guests instead of actually suspending
them on the host's suspension.
With following patches, we can adjust CLOCK_BOOTTIME without actually
suspending guest and make the app working as intended.
I think this feature is also useful for other VM solutions since there
was no way to do this from userspace.

As far as I checked, it is working as expected but is there any concern
about this change? If so, please let me know.

Thanks,
Hikaru Nishida


Hikaru Nishida (2):
  timekeeping: Add timekeeping_adjust_boottime
  drivers/virt: introduce CLOCK_BOOTTIME adjustment sysfs interface
    driver

 drivers/virt/Kconfig        |  9 ++++++
 drivers/virt/Makefile       |  1 +
 drivers/virt/boottime_adj.c | 57 +++++++++++++++++++++++++++++++++++++
 include/linux/timekeeping.h |  2 ++
 kernel/time/timekeeping.c   | 26 +++++++++++++++++
 5 files changed, 95 insertions(+)
 create mode 100644 drivers/virt/boottime_adj.c

-- 
2.30.0.478.g8a0d178c01-goog

