Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2BC339DD23
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 14:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbhFGNAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 09:00:02 -0400
Received: from mail-wr1-f74.google.com ([209.85.221.74]:37575 "EHLO
        mail-wr1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbhFGM77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 08:59:59 -0400
Received: by mail-wr1-f74.google.com with SMTP id q15-20020adfc50f0000b0290111f48b865cso7809174wrf.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 05:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kRfxWaVjYRUY5TBuAJktVRLGror0fniACZlCyQAsiGk=;
        b=DV5h1Res/vCGi8e9qFTNxkHV061qt0xPRocmiCxArginyOjnWGDxsH0CgMzIAizjGi
         rbDOB05JjptoucsUxpKvZpkHFRqpbk98qr9XxW2ah+4wH7P4jFUtpZe0QVW/LjroL8ff
         VLkfSOZIUQ33q/9dLv3bggJ/QLdIpvZSmQifSNnKvDf0V9x2tu9UQ58VlgubUDf5/m0C
         tJXgvJLb0EsFtwZje9Nvs8k9NVLufNgcOwWJBylSqc5gtO+r3tZBlgRxWAj/W7DFyCaR
         Pqf8MCZh5jjjF7D7x7CjNhhMh7mVa7uP4mw7ekNHQc5UkX2KHA8kJSSkmtG8UjpLr0XL
         nuKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kRfxWaVjYRUY5TBuAJktVRLGror0fniACZlCyQAsiGk=;
        b=qC3LOv4qXAGXDelKzFfNW8TFlHVbieM1sOCiCu96uY7FrSu+q83a8M7mbX0QAaHMMj
         ySrSLFsvvCoU1iQ4eR82NMghhVn0CoHhvud1kbIyQZLajLL4zo/K8Zrmx7fqw4UdKHqN
         eTymukLP7z4J7xSwjmiF3T8zZh8bWh35ENyDQVfP1VKfjnXkxCCPDt13S8DL7L9wLsBA
         7EO9iZ3F808VOYvm8A2xLDxHkWeYCbJKijU+iYR/RWnUrl7vHCdl8zogCN5pmqRwlfv6
         wYzc+Vit9H3c+2QY4jQnNDOZ1x+c7eco750LSFpAJ96RoDhiXnudNy2A4/8i0xvGRSxB
         fE1A==
X-Gm-Message-State: AOAM530cEFtSSf4GQYIy9pdpvxU3uSBhVsO3Tp2/wzzjCIfznKAS5nmo
        KfZvxSUfuYxnLx3XyKn9NN96csNp4w==
X-Google-Smtp-Source: ABdhPJxzYv1uuNCM8fdZqdq3QzRZy2No3cSxxlSxUCERnfgtyIBjerO2BNxGkQ5x1TktxXhza2OyCepRhw==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:2587:50:741c:6fde])
 (user=elver job=sendgmr) by 2002:a7b:cb0b:: with SMTP id u11mr2583643wmj.0.1623070627116;
 Mon, 07 Jun 2021 05:57:07 -0700 (PDT)
Date:   Mon,  7 Jun 2021 14:56:47 +0200
In-Reply-To: <20210607125653.1388091-1-elver@google.com>
Message-Id: <20210607125653.1388091-2-elver@google.com>
Mime-Version: 1.0
References: <20210607125653.1388091-1-elver@google.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH 1/7] kcsan: Improve some Kconfig comments
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     boqun.feng@gmail.com, mark.rutland@arm.com, will@kernel.org,
        glider@google.com, dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve comment for CC_HAS_TSAN_COMPOUND_READ_BEFORE_WRITE. Also shorten
the comment above the "strictness" configuration options.

Signed-off-by: Marco Elver <elver@google.com>
---
 lib/Kconfig.kcsan | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index 0440f373248e..6152fbd5cbb4 100644
--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -40,10 +40,14 @@ menuconfig KCSAN
 
 if KCSAN
 
-# Compiler capabilities that should not fail the test if they are unavailable.
 config CC_HAS_TSAN_COMPOUND_READ_BEFORE_WRITE
 	def_bool (CC_IS_CLANG && $(cc-option,-fsanitize=thread -mllvm -tsan-compound-read-before-write=1)) || \
 		 (CC_IS_GCC && $(cc-option,-fsanitize=thread --param tsan-compound-read-before-write=1))
+	help
+	  The compiler instruments plain compound read-write operations
+	  differently (++, --, +=, -=, |=, &=, etc.), which allows KCSAN to
+	  distinguish them from other plain accesses. This is currently
+	  supported by Clang 12 or later.
 
 config KCSAN_VERBOSE
 	bool "Show verbose reports with more information about system state"
@@ -169,13 +173,9 @@ config KCSAN_REPORT_ONCE_IN_MS
 	  reporting to avoid flooding the console with reports.  Setting this
 	  to 0 disables rate limiting.
 
-# The main purpose of the below options is to control reported data races (e.g.
-# in fuzzer configs), and are not expected to be switched frequently by other
-# users. We could turn some of them into boot parameters, but given they should
-# not be switched normally, let's keep them here to simplify configuration.
-#
-# The defaults below are chosen to be very conservative, and may miss certain
-# bugs.
+# The main purpose of the below options is to control reported data races, and
+# are not expected to be switched frequently by non-testers or at runtime.
+# The defaults are chosen to be conservative, and can miss certain bugs.
 
 config KCSAN_REPORT_RACE_UNKNOWN_ORIGIN
 	bool "Report races of unknown origin"
-- 
2.32.0.rc1.229.g3e70b5a671-goog

