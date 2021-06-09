Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9B13A1DD6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 21:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbhFITxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 15:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhFITw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 15:52:59 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1DCC061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 12:51:04 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id j7-20020a258b870000b029052360b1e3e2so32696645ybl.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 12:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=3v/xy1vVOy0p+15gYBu2aWN8fdeRRMYWYLro1y/PuTE=;
        b=fVnkgjEZumr/DFopY/S3A/YevSvqaDXOcTq5g/KTwm7eIQg9gSphvVdkxcVdbpgzLT
         lJpP9kWAQZbM3LS38aK3nN13YpgseyU1sKlcNjHWTuL2yVl79MNpmIkUr+wZDUN1BzRR
         1DINZ1J32lKAgfb9kM32SdHYwehf8Yc72xw4w4C+Z/JrjjA034RBaUHaGfd5ChSRhbCy
         xazlARv6wyC8/APKaNMGqfSCMUpYvflh4quVANFV2x39pu8s1+bvwyVuwSkrsn+d9KLV
         2aHjXFJPk7avyqicaOs967Y8kojFdtx5teRh8qLD7h6MiQMM+n/UbgO16L4eWrN6Ijhc
         ACCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=3v/xy1vVOy0p+15gYBu2aWN8fdeRRMYWYLro1y/PuTE=;
        b=s5BGEAbaNWd88TKmXYWwuXJ8EZWpIaf7Jiyx/11NF58FV+f80P7PL2vpOqhw3EsDpr
         EDDG1ZOuK7qovGM/iCapfva5+HV7+0Lti6hQc1Vc6RhRFOsgR2CQAaRV+z9fR1hayS9K
         3GWq00Jsi/W7ABrHMyWfMD5he6WGnFDbQ7U9mU1H2KIJ38e0wb1NCeEgBY8pmA7hg2CP
         GEORhe3gZu0Ec/JZaTeWjw3NjVGFHbHTIEwW1rfNGT9pQPtSyIiJh7y6E1FxY+XMkF1z
         4oAVt0Wf0n0Gl0VPGITY9BrWTrpmpLesLqkz8IzHXrmpk7DB0p0pHuVrBXQjPOosG1mk
         l/rQ==
X-Gm-Message-State: AOAM532zmleSL/3x6acPZ8C6o+G+3YNkzaIgbo5OJ4KfYt/+f0R9F7tc
        y+ZqZcomKFBPs553AL4W2eP078CyWHqwgQ==
X-Google-Smtp-Source: ABdhPJw7vh85Y9sFxAP7377PCT2/FrmEYTd30+tA56N/gxjXEY7UuB+G1tBWK25kYPCwnIObHPDNDRknwOpaHw==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:10:7f:e700:c0a8:b1])
 (user=cmllamas job=sendgmr) by 2002:a25:be44:: with SMTP id
 d4mr2206033ybm.497.1623268264053; Wed, 09 Jun 2021 12:51:04 -0700 (PDT)
Date:   Wed,  9 Jun 2021 19:50:58 +0000
Message-Id: <20210609195058.3518943-1-cmllamas@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
Subject: [PATCH] docs: printk-formats: update size-casting examples
From:   Carlos Llamas <cmllamas@google.com>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Christoph Hellwig <hch@lst.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Carlos Llamas <cmllamas@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 72deb455b5ec ("block: remove CONFIG_LBDAF") sector_t and
blkcnt_t types are no longer variable in size, making them unsuitable
examples for casting to the largest possible type. This patch replaces
such examples with cycles_t and blk_status_t types, whose sizes depend
on architecture and config options respectively.

Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 Documentation/core-api/printk-formats.rst | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index f063a384c7c8..385c0cc52f1f 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -37,14 +37,13 @@ Integer types
 		u64			%llu or %llx
 
 
-If <type> is dependent on a config option for its size (e.g., sector_t,
-blkcnt_t) or is architecture-dependent for its size (e.g., tcflag_t), use a
-format specifier of its largest possible type and explicitly cast to it.
+If <type> is architecture-dependent for its size (e.g., cycles_t, tcflag_t) or
+is dependent on a config option for its size (e.g., blk_status_t), use a format
+specifier of its largest possible type and explicitly cast to it.
 
 Example::
 
-	printk("test: sector number/total blocks: %llu/%llu\n",
-		(unsigned long long)sector, (unsigned long long)blockcount);
+	printk("test: latency: %llu cycles\n", (unsigned long long)time);
 
 Reminder: sizeof() returns type size_t.
 
-- 
2.32.0.272.g935e593368-goog

