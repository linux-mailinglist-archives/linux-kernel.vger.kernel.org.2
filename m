Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C33348603
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 01:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235107AbhCYApl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 20:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239203AbhCYApT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 20:45:19 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB4FC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 17:45:18 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id w18so567133edc.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 17:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=78gVuHXHDhgUAsuHKhq6na1FW+3Q+1UNIvqkPJBYgDI=;
        b=UiSvzpWPtFKE2cMhF4j52v4B1BxSZPYImlISFN9MZQ7wY1ctyWQOO+yqIalxnc78kY
         Jd5gy7F5j3SJRMaIIxH2HsaI4V5u0jNzu0g1YsAa1eSBmzytlDeNGP2uu3pI4kktZoC+
         z9SDraxfmKZr5ZVh1EEwOb7bX/Kj54TVYlNKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=78gVuHXHDhgUAsuHKhq6na1FW+3Q+1UNIvqkPJBYgDI=;
        b=NLdiFn8LjGwQko4Ufpzzn18IkQDiU6ynZGGEwN5Toy+cW8z84e2mIXBXjZbD0ctW+8
         KByWODs88S+5W3oZagKrZyyuaZVXAWn+HbbROsYN7WfjFW2KRjoIozopWGWdZPB3u+in
         KZGQavFJKweulg2PSr/XsCkSOEti/5twWt6+q/l8uS7jZK9r9/24Llm6WhkNRepIUWV/
         v3JclCeVYIOGiRg7cSUHymZa0gej7ImqTNI0IjICPBv2yQz6u/3rpwlmWNRk4u9J6dX/
         gd8HCykcg49yZa54ZAyos5Hq/Z8/6CLlzjnyLBe2Td92UB5Me8iuBmrmESpSqaAwHiGJ
         n70g==
X-Gm-Message-State: AOAM532NY9Zwc6tBm4eRhavplJGCUA20WwWCpPzc0F5yLIKNa5ZnI/nx
        3qYhkoDSJR/UrjNSEMqOo7fD0fDVNwjd/f7s
X-Google-Smtp-Source: ABdhPJwa4Pv8u4ZaYoWfBv/PViaffhl9Tzaz7+Znv+qsi+LgDTy8442xlc8f36n0iTYqjgsw56lUlw==
X-Received: by 2002:a05:6402:1342:: with SMTP id y2mr6274664edw.285.1616633117578;
        Wed, 24 Mar 2021 17:45:17 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id jx22sm1657623ejc.105.2021.03.24.17.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 17:45:17 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 1/2] sched: stop using magic values in sched_dynamic_mode
Date:   Thu, 25 Mar 2021 01:45:14 +0100
Message-Id: <20210325004515.531631-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the enum names which are also what is used in the switch() in
sched_dynamic_update().

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 kernel/sched/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 98191218d891..3959481261bb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5370,13 +5370,13 @@ static int preempt_dynamic_mode = preempt_dynamic_full;
 static int sched_dynamic_mode(const char *str)
 {
 	if (!strcmp(str, "none"))
-		return 0;
+		return preempt_dynamic_none;
 
 	if (!strcmp(str, "voluntary"))
-		return 1;
+		return preempt_dynamic_voluntary;
 
 	if (!strcmp(str, "full"))
-		return 2;
+		return preempt_dynamic_full;
 
 	return -1;
 }
-- 
2.29.2

