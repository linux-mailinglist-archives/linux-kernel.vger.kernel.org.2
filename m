Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0284203DB
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 22:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbhJCUDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 16:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbhJCUDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 16:03:20 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F170C061793
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 13:01:30 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id f73so6716207vkf.6
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 13:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RISxD/viKv7LKWmGTkIKr7KI+2YT0D1VIuZdPYzWbkQ=;
        b=mK35pTDRYFtojim+7uEt2qb/XHjO9IUDlkrkpTyOiCyT/+ut31qa6u2yF6u3X/RpD4
         /sSnSGlP4vR2d5T3uJdemDAdsA37nfGzlmE6C6y6BeNGYKGMaM2Df//aSVwVJB8ysDH7
         8Yf11VrUu0cEzP40wHLn6h2CQi2PRNExp1CiCWT+ylcn6HRd3JSDGL9Y9Pu7EdiWRHaQ
         Q+Ahln10F7uVBh9sZEJGY05amLqaH5zMJSrG0BscWalCvpPPnxzMniOdpKwo+jBmsA3a
         z3To9KfWiirah9Wly8IhfnB3XJ+/KCDpBzjUFaewKhh1mhMQZB2LGKHvq/xzJhyGULua
         gxIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RISxD/viKv7LKWmGTkIKr7KI+2YT0D1VIuZdPYzWbkQ=;
        b=Xw/sEGBjSLVLruO/FJbkjblMbw8ZSEPd4sHfU1v4Y0RCC+h7pzp04qv5bjzclG/sgH
         WArPYCI+1EotZ5WukbMcFj90QU0Jti2Wi/T0uNE9EPp3vDDqwqH7g+ErPoneTtstYfGs
         1O2n5HRAtx7zH5P0CV6Z2C/yO79iIkGt4HUw7zeERllYyPP8wXCg+2RQMPdJXjsSj1eN
         QMEZWCkKYLETYYr450fx3pJ51i+pkCZDITHV1X1ca0CKFyCHQVexdApf6KfzvjnN2J3P
         qk8wx97UGw7Ii6pg+K1nxMVFQVAl5XusqbwSJA7qIwIdNgL2wx8/+I0GFEBM1Gus4Eeh
         fh/A==
X-Gm-Message-State: AOAM533/lQ34sOk4ktpM6z0B+nzq6OwQKGu9py31FO9RCSh5WKwu4bZb
        g63vkPVkoxXp94c/R+DPx/g=
X-Google-Smtp-Source: ABdhPJxHXNALxamC78pDf3kPboNu+0yUjARPw/Vj6beyUnoITXaBEkpTgEC6aMpZkDJxGHqmyzIZFg==
X-Received: by 2002:ac5:c24c:: with SMTP id n12mr7474711vkk.10.1633291289737;
        Sun, 03 Oct 2021 13:01:29 -0700 (PDT)
Received: from localhost.localdomain ([181.23.73.135])
        by smtp.gmail.com with ESMTPSA id x21sm6691019uao.2.2021.10.03.13.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Oct 2021 13:01:29 -0700 (PDT)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        stefan.wahren@i2se.com, arnd@arndb.de, dan.carpenter@oracle.com,
        ojaswin98@gmail.com, amarjargal16@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, gascoar@gmail.com
Subject: [PATCH 8/9] staging: vchiq_core: cleanup unnecessary blank line
Date:   Sun,  3 Oct 2021 16:58:01 -0300
Message-Id: <20211003195758.36572-9-gascoar@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211003195758.36572-1-gascoar@gmail.com>
References: <20211003195758.36572-1-gascoar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove blank line before close brace.

Reported by checkpatch.pl

Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index b4ad68ff42db..416110bf20fa 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -3193,7 +3193,6 @@ vchiq_queue_message(unsigned int handle,
 	if (!size) {
 		VCHIQ_SERVICE_STATS_INC(service, error_count);
 		goto error_exit;
-
 	}
 
 	if (size > VCHIQ_MAX_MSG_SIZE) {
-- 
2.33.0

