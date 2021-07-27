Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C39923D7592
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 15:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236606AbhG0NGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 09:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbhG0NGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 09:06:38 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9FAC061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 06:06:38 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id f18-20020a05600c4e92b0290253c32620e7so1596993wmq.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 06:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K0/Yb+S87jKk77G9N+ILt8qivB60vtqT5eIoZMR8Bn0=;
        b=Xkk6i0fSYnPf2+QOqapNJN20IzzjDr4RuijqPaIZ5J/m/0DbaI5TOFXxRR13b24qYi
         QKhShzzvL38JKeWOjyuqTTnllIKxnc/vNkSiU0xOwCHPIh6uYyY6vW5NMshl9AvDg62e
         CFddZoXal1HoBZrPqh4ZJ/7XRWZUwMKy+6+vFCArFlj8ctNwJM1Ysf3tnNiRGzMMN2xC
         ALw4xlidVGnZGNQuIvcxT639NuC6OWLsBL+/wOFXsowEIXo7Tn//EeJ+RijEU0urzOKD
         x3fVWWIBeN6eB4RKS4nmrElfAsk6kRc9F67lRGNbtWYDUy/sg14N3E7KJOMJvUZw5y42
         Zc3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K0/Yb+S87jKk77G9N+ILt8qivB60vtqT5eIoZMR8Bn0=;
        b=eMTgrCF+5JFWz3PKcwvuF7I2PgR6uKQ90TcvZCWtUZLtkUjW6LQgWA27Uvu/dIdBF5
         05WkTsiQLlNxjxAawZ4nRwN3SSP6q1hPGOw6V1vvkk6xaKiVxcRWQQqq1zHlRqRFyjwM
         2CVxYOOXia2Ls6qYmm5JNlx/QRRJIkDZpBVe/up/si4Ssq2JO4vsa76Mrf2j9hTDu0o/
         rzw2DqbcUq/EkbLlUCj9wlohXsbOzK7qy7AhzM7ykpHnHaJECF3egF1MBFXnxEVAfxhV
         zaMxDm6SRPGni04RYYxpDUwqaPdQEv2A+Eq02HwAv14zUjYH5ZpogV5YqP0mvhzOny7u
         h2EQ==
X-Gm-Message-State: AOAM532ioic9uFPeH2wBs7+xUq1IimZWdux8qqVPLP0YVYzLfBUjFgKt
        V0jQqpj1uYQ/RqxNFk+i9R1RCQtVYydNjCea
X-Google-Smtp-Source: ABdhPJyCGqO4DC8f9jaRRZjPf/KILY5RSpu6Lk099nDnmgnSSpOEpez7C/wGB5NbrnoNcVmUYxcD5g==
X-Received: by 2002:a05:600c:4285:: with SMTP id v5mr4058608wmc.189.1627391196891;
        Tue, 27 Jul 2021 06:06:36 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id 104sm3421034wrc.4.2021.07.27.06.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 06:06:36 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v3 0/2] printk: Add printk.no_console_auto_verbose boot param
Date:   Tue, 27 Jul 2021 14:06:33 +0100
Message-Id: <20210727130635.675184-1-dima@arista.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2 to v3 Changes:
- Renamed printk.console_verbose to printk.console_no_auto_verbose
  (as suggested by Petr)
- Moved console_verbose() to printk.c and exported it instead (Petr)
- Added Reviewed-by and also Suggested-by Petr

v1 to v2 Changes:
- Add printk.console_verbose boot parameter instead of compile-time
  CONFIG_CONSOLE_LOGLEVEL_PANIC (see v1 discussion with Petr)
- I didn't rename console_verbose() to console_verbose_panic() as
  I need it to be always disabled regardless oops/panic/lockdep.
- I noticed console_silent() which is unused for long time, remove it.

v1: https://lore.kernel.org/lkml/20210622143350.1105701-1-dima@arista.com/
v2: https://lore.kernel.org/lkml/20210713011511.215808-1-dima@arista.com/

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Steven Rostedt <rostedt@goodmis.org>

Dmitry Safonov (2):
  printk: Remove console_silent()
  printk: Add printk.console_no_auto_verbose boot parameter

 Documentation/admin-guide/kernel-parameters.txt |  9 +++++++++
 include/linux/printk.h                          | 11 +----------
 kernel/printk/printk.c                          | 12 ++++++++++++
 3 files changed, 22 insertions(+), 10 deletions(-)


base-commit: e73f0f0ee7541171d89f2e2491130c7771ba58d3
-- 
2.32.0

