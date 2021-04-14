Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7200B35F28A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 13:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350493AbhDNL3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 07:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbhDNL3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 07:29:06 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5354C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 04:28:44 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id o22-20020a1ca5160000b0290126af94672aso1974298wme.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 04:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=btwVZVIkoVW0S9+I18X0VVI6S1SmB7cJxLrTXtQjEgc=;
        b=rmfzsKjsORQVG0A/P/4DnlOPiA7eHUncCKQJCktEmlUFXyCptqgaqhH9bipn2+9zrE
         F/Qv1LBsK4qsbejl+B6IH86V50xLS3FeGBsryPt3ghht+hkbdUX6B3KH9PCO1Gz4UgvS
         Lg7OQklvavKlay2jZ6pqkRuDJy8Ecf4LJq0u+oORcImoRvo9B51f7Rkoq7lXILcENAke
         6dBzxPAi3A8zfjIUaqdlkYFA2QrsIaYtARYh0DBqc4nq+zIAemy8KSgZvtATdniS8hYb
         JILaSacNoySwkBd9pHvB+nba0yO7OOT7irX/sFDgtZW9fKxipqXXaF10R67lPE/UOuGZ
         DeDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=btwVZVIkoVW0S9+I18X0VVI6S1SmB7cJxLrTXtQjEgc=;
        b=n5mzTp0MBLlxDCruNCbQodGPSZvLtzsZIyG91bnSsP3bqfz+6CJ/CjgYXMMKym448H
         c6ujqvTx1tWhRcD+B7eJBIs1YNItR+JEzrnG5PGav6PpOshsbvKiT3GXGPttzMULeDng
         NpM4DH/s+/1/oLfCx2FaRnN8RrS3e0XRSohgeWzhFu0XS22JA9xLG7Yi2e5HWUlCek3P
         5YCdROsp/mdhEF4tQtDLcTFDG/qPr6YSVmYJ2k7U/23wOpnXRA2VQkmFy3btP1qeZYdh
         8Z3FrafXSa3wxaWiWdXWofYbm/ZOxug1yKypU5Ipx9D57N6TkD1uP5rQEbLnOhDrfENA
         sMTg==
X-Gm-Message-State: AOAM530sT6NttstWKXXyUBf8X5jzhERd+P600j3speJ9tBZ6As1jgbCz
        0JRvKp2KL3nxl3qPqu5UJtZ5D11rDg==
X-Google-Smtp-Source: ABdhPJwx/YUJHGP9FFwM9nMy7yp0o2uDWVADgFjefOG962tU4yuO7IQUBOq9g2y1ty3xUnZ3so9IZVyGtA==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:4051:8ddb:9de4:c1bb])
 (user=elver job=sendgmr) by 2002:a05:600c:3641:: with SMTP id
 y1mr2603071wmq.65.1618399723368; Wed, 14 Apr 2021 04:28:43 -0700 (PDT)
Date:   Wed, 14 Apr 2021 13:28:16 +0200
Message-Id: <20210414112825.3008667-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH 0/9] kcsan: Add support for reporting observed value changes
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     mark.rutland@arm.com, will@kernel.org, dvyukov@google.com,
        glider@google.com, boqun.feng@gmail.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for showing observed value changes in reports.
Several clean up and refactors of KCSAN reporting code are done as a
pre-requisite. An example of the new KCSAN reports:

	==================================================================
	BUG: KCSAN: data-race in test_kernel_read / test_kernel_write

	write to 0xffffffffc009a628 of 8 bytes by task 487 on cpu 0:
	 test_kernel_write+0x1d/0x30
	 access_thread+0x89/0xd0
	 kthread+0x23e/0x260
	 ret_from_fork+0x22/0x30

	read to 0xffffffffc009a628 of 8 bytes by task 488 on cpu 6:
	 test_kernel_read+0x10/0x20
	 access_thread+0x89/0xd0
	 kthread+0x23e/0x260
	 ret_from_fork+0x22/0x30

	value changed: 0x00000000000009a6 -> 0x00000000000009b2

	Reported by Kernel Concurrency Sanitizer on:
	CPU: 6 PID: 488 Comm: access_thread Not tainted 5.12.0-rc2+ #1
	Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-2 04/01/2014
	==================================================================

On one hand this will help better understand "race of unknown origin"
(one stack trace only) reports, but also provides more information to
better understand normal data race reports like above where KCSAN also
detected a value change.

Changelog
---------

This series was originally prepared courtesy of Mark Rutland in
September 2020. Because KCSAN had a few minor changes since the original
draft of the series, it required a rebase and re-test. To not be
forgotten and get these changes in sooner than later, Mark kindly agreed
to me adopting the series and doing the rebase, a few minor tweaks, and
finally re-test.

Marco Elver (1):
  kcsan: Document "value changed" line

Mark Rutland (8):
  kcsan: Simplify value change detection
  kcsan: Distinguish kcsan_report() calls
  kcsan: Refactor passing watchpoint/other_info
  kcsan: Fold panic() call into print_report()
  kcsan: Refactor access_info initialization
  kcsan: Remove reporting indirection
  kcsan: Remove kcsan_report_type
  kcsan: Report observed value changes

 Documentation/dev-tools/kcsan.rst |  88 +++++++---------
 kernel/kcsan/core.c               |  53 ++++------
 kernel/kcsan/kcsan.h              |  39 ++++---
 kernel/kcsan/report.c             | 169 ++++++++++++++++--------------
 4 files changed, 162 insertions(+), 187 deletions(-)

-- 
2.31.1.295.g9ea45b61b8-goog

