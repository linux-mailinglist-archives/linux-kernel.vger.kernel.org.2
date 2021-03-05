Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6AF732EF33
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 16:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbhCEPml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 10:42:41 -0500
Received: from mail-lf1-f43.google.com ([209.85.167.43]:40060 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbhCEPm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 10:42:28 -0500
Received: by mail-lf1-f43.google.com with SMTP id b1so4348673lfb.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 07:42:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rmo4xTtPsVZhAgC8Ie82NJntVxGNtKAmvuDHq3LzPQs=;
        b=nmorQHqJ3OfggLTpx2pNFAkMcXcB8Th+IFNBEYu0nHx9MLY6Hs4mctoABlF5+raajI
         R3WzFTuhk839eLDxBZiV0w5gtHlomauAkfThINxUnSIitZWqSMotGHAc7yaz5Wy7BVI8
         Ii4PEqTZ1CXyjoM+CvLgxn0ypuoGnXKjy28NSwZwrlNx/ZqluMzowgc8oK8KD3AV44vp
         A+1AfThJko7RuiTU2V+lO8l60j7u5pStjB8nnrx+J5jFb4LUdesNryyAGrH+zRxnMLmK
         jya+/BRa2AQDqbSwVWq2+3Cwp8Y01exBhllfd7+1oa2jmAFyL4p+ek2vti/w2gdq7Rjw
         sE7g==
X-Gm-Message-State: AOAM532plKhYl6Xd4sXc/TqFJEy6k4yJIKEZkBlLfOTgn1RA5MhgSOqi
        +amxcA4oCjYToAj4riKn7GY=
X-Google-Smtp-Source: ABdhPJyT+a5CxAyc21VMmJMw38b0Ki51f28aHY5BVP/nzbSzFaqml/iRq62G7R3pUQG6ka+KcV7ZAQ==
X-Received: by 2002:a05:6512:39c5:: with SMTP id k5mr5745568lfu.478.1614958946897;
        Fri, 05 Mar 2021 07:42:26 -0800 (PST)
Received: from localhost.. (broadband-188-32-236-56.ip.moscow.rt.ru. [188.32.236.56])
        by smtp.googlemail.com with ESMTPSA id u3sm351563lfu.24.2021.03.05.07.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 07:42:26 -0800 (PST)
From:   Denis Efremov <efremov@linux.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Denis Efremov <efremov@linux.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] perf tests: Remove duplicate cpumap test
Date:   Fri,  5 Mar 2021 18:41:58 +0300
Message-Id: <20210305154158.384017-2-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210305154158.384017-1-efremov@linux.com>
References: <20210305154158.384017-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cpu_map_print("1,3-6,8-10,24,35-37") called twice in a row.
Remove the second test.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 tools/perf/tests/cpumap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/tests/cpumap.c b/tools/perf/tests/cpumap.c
index 29c793ac7d10..f906633eae46 100644
--- a/tools/perf/tests/cpumap.c
+++ b/tools/perf/tests/cpumap.c
@@ -116,7 +116,6 @@ int test__cpu_map_print(struct test *test __maybe_unused, int subtest __maybe_un
 	TEST_ASSERT_VAL("failed to convert map", cpu_map_print("1,3,5,7,9,11,13,15,17,19,21-40"));
 	TEST_ASSERT_VAL("failed to convert map", cpu_map_print("2-5"));
 	TEST_ASSERT_VAL("failed to convert map", cpu_map_print("1,3-6,8-10,24,35-37"));
-	TEST_ASSERT_VAL("failed to convert map", cpu_map_print("1,3-6,8-10,24,35-37"));
 	TEST_ASSERT_VAL("failed to convert map", cpu_map_print("1-10,12-20,22-30,32-40"));
 	return 0;
 }
-- 
2.26.2

