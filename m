Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88D70319051
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 17:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbhBKQrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 11:47:47 -0500
Received: from foss.arm.com ([217.140.110.172]:53662 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231178AbhBKPhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 10:37:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5BEBC143B;
        Thu, 11 Feb 2021 07:34:21 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 75B5F3F73D;
        Thu, 11 Feb 2021 07:34:19 -0800 (PST)
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
        Andrey Konovalov <andreyknvl@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v13 7/7] kasan: don't run tests in async mode
Date:   Thu, 11 Feb 2021 15:33:53 +0000
Message-Id: <20210211153353.29094-8-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210211153353.29094-1-vincenzo.frascino@arm.com>
References: <20210211153353.29094-1-vincenzo.frascino@arm.com>
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
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 lib/test_kasan.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index f8c72d3aed64..77a60592d350 100644
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

