Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBBB3096F2
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 17:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbhA3QyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 11:54:21 -0500
Received: from foss.arm.com ([217.140.110.172]:38408 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231617AbhA3QyN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 11:54:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3BC1150C;
        Sat, 30 Jan 2021 08:52:51 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 130AA3F73D;
        Sat, 30 Jan 2021 08:52:49 -0800 (PST)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v11 5/5] kasan: don't run tests in async mode
Date:   Sat, 30 Jan 2021 16:52:25 +0000
Message-Id: <20210130165225.54047-6-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210130165225.54047-1-vincenzo.frascino@arm.com>
References: <20210130165225.54047-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Asynchronous KASAN mode doesn't guarantee that a tag fault will be
detected immediately and causes tests to fail. Forbid running them
in asynchronous mode.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/test_kasan.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 7285dcf9fcc1..f82d9630cae1 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -51,6 +51,10 @@ static int kasan_test_init(struct kunit *test)
 		kunit_err(test, "can't run KASAN tests with KASAN disabled");
 		return -1;
 	}
+	if (kasan_flag_async) {
+		kunit_err(test, "can't run KASAN tests in async mode");
+		return -1;
+	}
 
 	multishot = kasan_save_enable_multi_shot();
 	hw_set_tagging_report_once(false);
-- 
2.30.0

