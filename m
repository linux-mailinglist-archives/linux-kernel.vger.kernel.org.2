Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5486A32EF32
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 16:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbhCEPmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 10:42:40 -0500
Received: from mail-lj1-f174.google.com ([209.85.208.174]:33488 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbhCEPmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 10:42:08 -0500
Received: by mail-lj1-f174.google.com with SMTP id h4so3344520ljl.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 07:42:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pE3SvJBqWcgpcmVm+JvcgZMOsSAMluw2MXe6gQ5Q+kI=;
        b=B+7u8p+KspuAaIviuSsbtH2Fd9nr0bWbPFNvL3ZaGxGqqkUbU7iVKLxYN8UwCnOPLo
         IHCc2qtypPeKBHf1pWMrbiGUNgrWVp5S2bhcU6GiBgSbY3gJRm9Su+obzu2TC5a+lK+H
         YMtsZqEnI5KoJhXcJvCtXFr7EVehNWrODmJqURnWjeCRH502uSI/1N1GcLkABduUvnHB
         TeUl8RF6HFczPxl5UNuz8JDFLkkT4TwS7YZy1/9ipKLUQh0Kk/Fk/79+Kw1jcqUufzWd
         4b4iwh9SMZm4ao0yoiGeqPQme1sbe8KrlRdAsmLvgKXa3VNwBQj3g0RezT6cpAONmqbQ
         vw9A==
X-Gm-Message-State: AOAM530M2PKqmCISIC/W6nCGwrQiazNCcFUaHJ2/TIKiV+Kl1n9eURMB
        bNv8voUMwj8kCNuZzkTESYE=
X-Google-Smtp-Source: ABdhPJwbiA7nRicjKaVJTi6Ja1yRfJ2siI51u5+Re2r0WrP17nOUMWUloDyltI+AJhKnFaEAPNAjfg==
X-Received: by 2002:a2e:8117:: with SMTP id d23mr5548964ljg.395.1614958927675;
        Fri, 05 Mar 2021 07:42:07 -0800 (PST)
Received: from localhost.. (broadband-188-32-236-56.ip.moscow.rt.ru. [188.32.236.56])
        by smtp.googlemail.com with ESMTPSA id u3sm351563lfu.24.2021.03.05.07.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 07:42:07 -0800 (PST)
From:   Denis Efremov <efremov@linux.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Denis Efremov <efremov@linux.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] perf tests: Remove duplicate bitmap test
Date:   Fri,  5 Mar 2021 18:41:57 +0300
Message-Id: <20210305154158.384017-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

test_bitmap("1,3-6,8-10,24,35-37") called twice in a row.
Remove the second test.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 tools/perf/tests/bitmap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/tests/bitmap.c b/tools/perf/tests/bitmap.c
index 96c137360918..3320613400eb 100644
--- a/tools/perf/tests/bitmap.c
+++ b/tools/perf/tests/bitmap.c
@@ -47,7 +47,6 @@ int test__bitmap_print(struct test *test __maybe_unused, int subtest __maybe_unu
 	TEST_ASSERT_VAL("failed to convert map", test_bitmap("1,3,5,7,9,11,13,15,17,19,21-40"));
 	TEST_ASSERT_VAL("failed to convert map", test_bitmap("2-5"));
 	TEST_ASSERT_VAL("failed to convert map", test_bitmap("1,3-6,8-10,24,35-37"));
-	TEST_ASSERT_VAL("failed to convert map", test_bitmap("1,3-6,8-10,24,35-37"));
 	TEST_ASSERT_VAL("failed to convert map", test_bitmap("1-10,12-20,22-30,32-40"));
 	return 0;
 }
-- 
2.26.2

