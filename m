Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88B02410D94
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 00:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbhISWIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 18:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233042AbhISWID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 18:08:03 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D4CC061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 15:06:37 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id s32so13805031qtc.12
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 15:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eNeXjhvCGZPX2nOcWVH9hj3paV16QHjNZaxjtD37JKc=;
        b=bdju8P1JNCtH4FfOsfKw7jhE+FYFlGhixvqUVUw+RqDWnnBJqcVQ7uHC8HY/n67igG
         NmbK0lxIa97y48TrV5uezSA9uY1aLC/7M9ewytY/DgBeWukMZoOB7OBpP1e3qDuUxzUb
         f37HvE6PLVO3RPAUj1vJnOa1F/hWZ2uSscEuaJUJZ/aiMyirrS0zEBuCbt7xAeX/2Mj6
         AC0LZ7Bu50G6OwF4FAAPzp3V5EXNhwUczqT9CfsU52E9pJEaEa/BMHLWwJIbbOU4iFDI
         xWA5VfWik7ivuD4hlfuDZ3Hc22O/5tG0i67yJy088RHZv3FN+8SUDUUgLBvMedDVwPjB
         KT7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eNeXjhvCGZPX2nOcWVH9hj3paV16QHjNZaxjtD37JKc=;
        b=2iubrJh3uI+kwgK5jRnKOX0O6DrP67Mh4fuCsCAPIAb9W0PbUkU6DsVCsfgTY0gF9a
         J10alw2gvidYtRMu+vuAgIhXQcnr0aPc4H2LncPL6u6R5+PQfG0POrF2aMgACaLb5jyQ
         ysj9Ivn38UkYM+undh3DDmB3xghmE1sEAFE8SBHn03CKqbaka4TwlKC3R8800vf+WsBy
         p14GptN2ZTAGJzr07773vBTexhh9NHEjoN/96kXsv/1dnD9BA34R1tBtutKLFnr8JIU1
         YsbzjZLxnmYEJ5ckAQPz50rebwzRsdigNZZfjcz34R/bLoWzTkcyPRbF5wh4Xcrw4Fmt
         kl4w==
X-Gm-Message-State: AOAM532B5GIN64X443k1t4mmblKEDZl653Ly8UbC+BMvl63jSp6bYj4s
        oVrnwaDoJl2dwIqV7V4M3Pg=
X-Google-Smtp-Source: ABdhPJwtILmiTO6cTMW/YTNJdEBI3XfCBQKbiBaQpwYLShtu+IbVkdLRc8b2tAot/kzdA8IX1g3bgw==
X-Received: by 2002:ac8:7c8d:: with SMTP id y13mr638530qtv.27.1632089196296;
        Sun, 19 Sep 2021 15:06:36 -0700 (PDT)
Received: from localhost.localdomain ([191.84.236.195])
        by smtp.gmail.com with ESMTPSA id t23sm246313qkj.31.2021.09.19.15.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 15:06:35 -0700 (PDT)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        stefan.wahren@i2se.com, arnd@arndb.de, dan.carpenter@oracle.com,
        ojaswin98@gmail.com, amarjargal16@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, gascoar@gmail.com
Subject: [PATCH v2 5/7] staging: vchiq_arm: fix quoted strings split across lines
Date:   Sun, 19 Sep 2021 18:59:12 -0300
Message-Id: <20210919215914.539805-6-gascoar@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210919215914.539805-1-gascoar@gmail.com>
References: <20210919215914.539805-1-gascoar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoted strings should not be split across lines. As put it in
Documentation/process/coding-style.rst: "never break user-visible
strings such as printk messages because that breaks the ability to grep
for them."

Reported by checkpatch.pl

Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
---
 .../staging/vc04_services/interface/vchiq_arm/vchiq_arm.c    | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 778540faaa1c..3225f0738ef9 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -1613,9 +1613,8 @@ vchiq_dump_service_use_state(struct vchiq_state *state)
 	read_unlock_bh(&arm_state->susp_res_lock);
 
 	if (only_nonzero)
-		vchiq_log_warning(vchiq_susp_log_level, "Too many active "
-			"services (%d).  Only dumping up to first %d services "
-			"with non-zero use-count", active_services, found);
+		vchiq_log_warning(vchiq_susp_log_level, "Too many active services (%d). Only dumping up to first %d services with non-zero use-count",
+				  active_services, found);
 
 	for (i = 0; i < found; i++) {
 		vchiq_log_warning(vchiq_susp_log_level, "----- %c%c%c%c:%d service count %d %s",
-- 
2.33.0

