Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95E4F41E34F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 23:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349776AbhI3VZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 17:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349730AbhI3VZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 17:25:03 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1753C06176C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 14:23:19 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id z6-20020a056214060600b0037a3f6bd9abso11867057qvw.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 14:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wbUrvvm0+MYAPUCF6HQK8A4cSFDFNCfNO8ihEMufpf8=;
        b=DXFhvoYgkBKBGW9TTScr4boM8/R+bDeePetODemKEZwYhJLpOOzrVNl6U0O8viIeqk
         pp2IrEkYyQyq4j2XkKfWQ4VittBUoFL9eK6QgTF8xsJnQegzB1LmqaFt8EgKiCyym1JF
         GE/gxRXqPXWqWaj96T8kz7tdyVHIJtP91uuXP/xkt5uGZ9Ozc/hLHZVAjgDUOulIv5Gj
         JqN+T2CECrPI/0jEt+gTV12f8/TErC9CAukhyWp/vFoE+aRLAIFWUO/ZufY6xbX/VP++
         2SBzxCS4wW06iaipZX8I5I10tTC9VxTqNnPo/gvPYQVZ4WpVfyneUQu3oXKgMzRcQd3o
         zngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wbUrvvm0+MYAPUCF6HQK8A4cSFDFNCfNO8ihEMufpf8=;
        b=fWl1hj+LiDIUAyX2SRe11zttB1wLft+hNnWbRYGfeF/oPuWxNvlSl/dllkEUdJyH8F
         6dOy0gUX4NpT6R9s0l/YPNErZtRDg/lH3yOSkMaid/ELZldbXVSOQC8us916oKB/wTwC
         kSC6ZYQ4sBBMnJIkOvYke41BKozIHCJFVymu2BBQY/gUPcVQnzjKopXAPi2Qdoy8utlx
         q80TPvL0uev6Hix2J0BW1StxC326KuiM7H2UsTOEUCmdobj+gXec7wlFNp0RdBrpWla8
         kUdHHCz0DdeqnnRUVluM+xbSgJKSgfQ7Tih9NCI5rh3Dp5tr2hpJoSzRkTAI4YkVmYCe
         6IsQ==
X-Gm-Message-State: AOAM5303w4agMbJLW2hW4o4r0KsAM6AJmP4UKbPuRTdKVSFgNNbEmZaI
        bLRGsPbn1mIiaxYJJA7Y6gyXILm62sajWeg6Qq6b
X-Google-Smtp-Source: ABdhPJywOpI+b7jm0hToN3nP52PlVum8uravic0hgie7sww9kEWkrOanS+hnSp8P208w/79s1xImwJumjKcifP/pZ7/r
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:fa06:3b29:d3c:37e6])
 (user=axelrasmussen job=sendgmr) by 2002:a05:6214:12af:: with SMTP id
 w15mr5967689qvu.66.1633036999024; Thu, 30 Sep 2021 14:23:19 -0700 (PDT)
Date:   Thu, 30 Sep 2021 14:23:07 -0700
In-Reply-To: <20210930212309.4001967-1-axelrasmussen@google.com>
Message-Id: <20210930212309.4001967-2-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210930212309.4001967-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH v2 1/3] userfaultfd/selftests: don't rely on GNU extensions
 for random numbers
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two arguments for doing this:

First, and maybe most importantly, the resulting code is significantly
shorter / simpler.

Then, we avoid using GNU libc extensions. Why does this matter? It makes
testing userfaultfd with the selftest easier e.g. on distros which use
something other than glibc (e.g., Alpine, which uses musl); basically,
it makes the test more portable.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 26 ++++--------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 10ab56c2484a..2a71a91559a7 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -57,6 +57,7 @@
 #include <assert.h>
 #include <inttypes.h>
 #include <stdint.h>
+#include <sys/random.h>
 
 #include "../kselftest.h"
 
@@ -501,22 +502,10 @@ static void continue_range(int ufd, __u64 start, __u64 len)
 static void *locking_thread(void *arg)
 {
 	unsigned long cpu = (unsigned long) arg;
-	struct random_data rand;
 	unsigned long page_nr = *(&(page_nr)); /* uninitialized warning */
-	int32_t rand_nr;
 	unsigned long long count;
-	char randstate[64];
-	unsigned int seed;
 
-	if (bounces & BOUNCE_RANDOM) {
-		seed = (unsigned int) time(NULL) - bounces;
-		if (!(bounces & BOUNCE_RACINGFAULTS))
-			seed += cpu;
-		bzero(&rand, sizeof(rand));
-		bzero(&randstate, sizeof(randstate));
-		if (initstate_r(seed, randstate, sizeof(randstate), &rand))
-			err("initstate_r failed");
-	} else {
+	if (!(bounces & BOUNCE_RANDOM)) {
 		page_nr = -bounces;
 		if (!(bounces & BOUNCE_RACINGFAULTS))
 			page_nr += cpu * nr_pages_per_cpu;
@@ -524,15 +513,8 @@ static void *locking_thread(void *arg)
 
 	while (!finished) {
 		if (bounces & BOUNCE_RANDOM) {
-			if (random_r(&rand, &rand_nr))
-				err("random_r failed");
-			page_nr = rand_nr;
-			if (sizeof(page_nr) > sizeof(rand_nr)) {
-				if (random_r(&rand, &rand_nr))
-					err("random_r failed");
-				page_nr |= (((unsigned long) rand_nr) << 16) <<
-					   16;
-			}
+			if (getrandom(&page_nr, sizeof(page_nr), 0) != sizeof(page_nr))
+				err("getrandom failed");
 		} else
 			page_nr += 1;
 		page_nr %= nr_pages;
-- 
2.33.0.800.g4c38ced690-goog

