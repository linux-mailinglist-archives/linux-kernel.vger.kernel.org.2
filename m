Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A133A7D79
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 13:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhFOLr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 07:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbhFOLru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 07:47:50 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD151C061767
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 04:45:45 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id g20so22164035ejt.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 04:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LgeZ2JYile0wfxLPa3/QdjQOXfOnyTEQN34yF3jCqoE=;
        b=trM+NhcbmRP9RJgrenAhxF7nzko6KTtLGzPc2c5XaV5oOzh1aCLtjzvGvC1EgayEjx
         /v484YFqFxNa/rQ3jvGABzaO7aRifefOAfQd/dIdS+Nsaz7jpGQXtshRaQ85r6Qul2HD
         w2mg6NJ4VnybL8tYrjpjbI5gkavp676v7Wc5+1g4HaQZ2QOb0vGBoh86JwZTA1SpQvMx
         fbVHRpi3vBXjy2PEaDMpNULi8iDModmotqK71BHHx1jbW8GSbXh6ivHsBruyVIsm2qMY
         Ms3+twAZjM71yugkoZBwFMGMe2nL0M6OcBx0m4ru2jBzaj7KCcJRJYiUKloW33FAMn0G
         lCaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LgeZ2JYile0wfxLPa3/QdjQOXfOnyTEQN34yF3jCqoE=;
        b=MlY6QMZezaCjM7m9/S4kKqJcP3ZMpOCB6/4faSMxSvatZZ7YBE3YB+OUojbvHBwaH7
         BNcKbOM9bZUEevWPb1RyzgP7kfbiCDWUm5dpv2JQBYL+5BOyJ4LKzIo4l0gxdhsmJ299
         8vdaKAOglwX1hCeRfbd7SFt61+B/NCyhJNn05kMCvlzeCDLV9dkZJlqlsqwoNhay258J
         rz5dM3j75uU3N2foVeXTvKSt66Bi5n/Qc7cHjpOlKrA5H23HiFuIAJfWakXObikElK2J
         YaLpIyVGPPMyt4smKr220U/+nfR51cHmbbqOp+awAzp4ckZ+Ne9kdh5DaDixXUPoOztS
         /21A==
X-Gm-Message-State: AOAM530ngKHZvT7LiniI7wbL1c5dR9MgIsPMMrmIYmP5osRk9hH0RtSX
        yN0Y/JFgbZmsZiGGgBlTy8mZpIsmvuHgNA==
X-Google-Smtp-Source: ABdhPJx2AxTVMle/ivxhdSo2pBV3++Uo+aHcLMQRiVRi2yKr6dZxos8WU86W1dDvwqk3GvXd3WuraQ==
X-Received: by 2002:a17:906:9706:: with SMTP id k6mr20175851ejx.456.1623757544388;
        Tue, 15 Jun 2021 04:45:44 -0700 (PDT)
Received: from agape ([5.171.72.142])
        by smtp.gmail.com with ESMTPSA id cz14sm11385069edb.84.2021.06.15.04.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 04:45:44 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] staging: rtl8723bs: remove unused WAKEUP_GPIO_IDX macro definition
Date:   Tue, 15 Jun 2021 13:45:33 +0200
Message-Id: <6bf5ddf3e4465840cdfcca79a524645cdaf0104d.1623756906.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1623756906.git.fabioaiuto83@gmail.com>
References: <cover.1623756906.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused WAKEUP_GPIO_IDX macro definition.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/autoconf.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/autoconf.h b/drivers/staging/rtl8723bs/include/autoconf.h
index 4b2cf86b8aa4..eab934229789 100644
--- a/drivers/staging/rtl8723bs/include/autoconf.h
+++ b/drivers/staging/rtl8723bs/include/autoconf.h
@@ -25,8 +25,3 @@
 	#define HAL_BB_ENABLE		1
 	#define HAL_RF_ENABLE		1
 #endif
-
-/*
- * Platform dependent
- */
-#define WAKEUP_GPIO_IDX	12	/* WIFI Chip Side */
-- 
2.20.1

