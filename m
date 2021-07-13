Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3BC3C67F6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 03:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbhGMBSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 21:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbhGMBSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 21:18:04 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1E6C0613DD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 18:15:15 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id l4-20020a05600c4f04b0290220f8455631so1175727wmq.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 18:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=11uDCiH91eJk41TnunaKFp7rxMRxo3/pVX2V/JGNeP4=;
        b=gRQgOjU1FOiOXpXU5qflF4ODXVn6gwBKV8aTkBuH30aji3u6dhCXSisKDNsxHA2GIv
         NOBXB5gNtYWleSNk5nhwV0pVrsDxROzOPN9L70btXOZ+5qUfObjUhpgSB8/hYc9Xm2uR
         V5WKYTb4uEOpp8T6Q2Ks7Q1Lo/ZJwH2h2EfcIR14kb+NNGKxC3DN6HbtWzQ4tGATi3bB
         WNuSm6bBQzTj9MijMyAH2D07Gat5o5Wwbes7kIKKdrLWOv/CdlJqAVRtB5UWdC5WSdTF
         Cko8NnOhwIg9Sc28/L95pmJ5m+qILZgFu5vBYvqjSIS2iaruELBAyMpRRMEtzk/GMEyK
         I0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=11uDCiH91eJk41TnunaKFp7rxMRxo3/pVX2V/JGNeP4=;
        b=JZNyyfTJZuPtzMZzJyyHi7pHDJTM1XAao1+EkXd6wOeDw0Bfa7fSWkxe+cLFFKkmuf
         nmjLObxfeh0OfXS0CZo5BNXq4OoSCSr8jcQtWvnzNjMtPqgPRYB6t5RW+1Lm8RpM/eal
         YtY6uP8UnDietilQGDGfDhotEX6UmyOVD8tG6slCq/m93Rrn6I7jKtIYtBHhCUYL5mJY
         OolWfxxpavXjsr8BVATdsO4tYQNi1tlGTv0M3MqnSmaTMTcZcAexenMsrwuBbvvMs7FW
         8c+A9fuCOFDki3RMmF0fZ/Lb2ZbfJQLa1LqgfZWVqTNSkM1lF4NxnJZa+CGSkgK4hSVk
         nRlQ==
X-Gm-Message-State: AOAM532RA6o2KmfM6NlfUs1+FOBdk6Z8YKBpoFNkpc9MO2kEG7/pRVAJ
        q2wQj2aJrJboGlX3nGALhyOxb6Ex0oghtQ==
X-Google-Smtp-Source: ABdhPJxnl8bcCN8H8kwGeGkKYI2R1W6yHfvlNcIDT/Le0IdjT8xv9pbphA5qCzJX65EdLrYSoCXWlw==
X-Received: by 2002:a05:600c:19d1:: with SMTP id u17mr1952880wmq.177.1626138913434;
        Mon, 12 Jul 2021 18:15:13 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id x8sm8479566wrt.93.2021.07.12.18.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jul 2021 18:15:12 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 0/2] printk: Add printk.console_verbose boot param
Date:   Tue, 13 Jul 2021 02:15:09 +0100
Message-Id: <20210713011511.215808-1-dima@arista.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1 to v2 Changes:
- Add printk.console_verbose boot parameter instead of compile-time
  CONFIG_CONSOLE_LOGLEVEL_PANIC (see v1 discussion with Petr)
- I didn't rename console_verbose() to console_verbose_panic() as
  I need it to be always disabled regardless oops/panic/lockdep.
- I noticed console_silent() which is unused for long time, remove it.

v1: https://lore.kernel.org/lkml/20210622143350.1105701-1-dima@arista.com/

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Steven Rostedt <rostedt@goodmis.org>

Dmitry Safonov (2):
  printk: Remove console_silent()
  printk: Add printk.console_verbose boot parameter

 Documentation/admin-guide/kernel-parameters.txt | 9 +++++++++
 include/linux/printk.h                          | 7 ++-----
 kernel/printk/printk.c                          | 6 ++++++
 3 files changed, 17 insertions(+), 5 deletions(-)


base-commit: e73f0f0ee7541171d89f2e2491130c7771ba58d3
-- 
2.32.0

