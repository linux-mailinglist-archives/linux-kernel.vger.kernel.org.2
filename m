Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74F5132409C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 16:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbhBXPP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 10:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbhBXOcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 09:32:32 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1B5C061794
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 06:29:40 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id w21so2742862edc.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 06:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pk1g4YWzo6VwJKO38vFnTY5sBug7k2N7+iy6yJchA38=;
        b=AtV2Mti+arEONOj6IkYoOLOU39J3eSG6sV+Y2CgdKyW7qlsUDWH4UTCzdQHjyr7oZw
         jYy799awSQHnOC8tBB9D0W4H0+Uol0Tislkp1nNMsVTcfSFSkEQSYM5/aLHjFGaI5Ow7
         /a0iaL5TdDnDXewofuR4ACnzuRcmWC+swrexY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pk1g4YWzo6VwJKO38vFnTY5sBug7k2N7+iy6yJchA38=;
        b=fhxqRSIyFzvTClWi6yu49Jn8IfIjpGiq1O8IWN5JUWA0reuuhcyg9jrAGrE0ZQZlmA
         OgO/3tbfAxPkxNAofetDb2+6La+ejsf/c5wzD4NFykRqHz3c+RCtArvUmvGr8iVaHB5L
         ovJDoogU3YCcoQ5Juqic2hkt3E7gjKZ3at7CykAnAWHLVLA65HT5SDcBcbFfqWYbaxQh
         kB6uyw7E3EwaTsVBSz4RD9Z4m7kX1kPleNf4iSun6gnIWpDhnpc+CnFiTykqwtpoFfv4
         S/d03bFicrtSma75mQ3h9hA58x8J/m2+YgWcYFBO19WU5lHcipzhD3pmG2Vfq++wGsnC
         cVzw==
X-Gm-Message-State: AOAM530t/hAg9nBP0/+9nYOV7n2O5/DxK55krTUtQCgiTeTYMYkWyW4R
        ZwsprR+DlRmZC3UcVf1JrVUhk/366/ab8g==
X-Google-Smtp-Source: ABdhPJy002PwwVJ91nV7U/8hILf+8atfkd7Sqz0P7heviYkTxfMFXbSJ4Rsw2e4eWWvqWePBzMwDlQ==
X-Received: by 2002:a05:6402:4ce:: with SMTP id n14mr33624345edw.309.1614176978588;
        Wed, 24 Feb 2021 06:29:38 -0800 (PST)
Received: from prevas-ravi.prevas.se ([80.208.71.141])
        by smtp.gmail.com with ESMTPSA id f1sm1493651ejt.21.2021.02.24.06.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 06:29:38 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     linux-kernel@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH/RFC 0/2] background initramfs unpacking, and CONFIG_MODPROBE_PATH
Date:   Wed, 24 Feb 2021 15:29:07 +0100
Message-Id: <20210224142909.2092914-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two patches are independent, but better-together.

The second is a rather trivial patch that simply allows the developer
to change "/sbin/modprobe" to something else - e.g. the empty string,
so that all request_module() during early boot return -ENOENT early,
without even spawning a usermode helper.

The first patch allows delegating decompressing the initramfs to a
worker thread, allowing do_initcalls() in main.c to proceed to the
device_ and late_ initcalls without waiting for that decompression
(and populating of rootfs) to finish. Obviously, some of those later
calls may rely on the initramfs being available, so I've added
synchronization points in the firmware loader and usermodehelper paths
- there might be other places that would need this.

There's not much to win if most of the functionality needed during
boot is only available as modules. But systems with a custom-made
.config and initramfs can boot faster, partly due to utilizing more
than one cpu earlier, partly by avoiding known-futile modprobe calls
(which would still trigger synchronization with the initramfs
unpacking, thus eliminating most of the first benefit).

Rasmus Villemoes (2):
  init/initramfs.c: allow asynchronous unpacking
  modules: add CONFIG_MODPROBE_PATH

 .../admin-guide/kernel-parameters.txt         | 12 +++++
 drivers/base/firmware_loader/main.c           |  2 +
 include/linux/initrd.h                        |  7 +++
 init/Kconfig                                  | 12 +++++
 init/initramfs.c                              | 51 ++++++++++++++++++-
 init/main.c                                   |  1 +
 kernel/kmod.c                                 |  2 +-
 kernel/umh.c                                  |  2 +
 usr/Kconfig                                   | 10 ++++
 9 files changed, 97 insertions(+), 2 deletions(-)

-- 
2.29.2

