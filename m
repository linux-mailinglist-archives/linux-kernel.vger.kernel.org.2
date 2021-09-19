Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B37BF410D91
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 00:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbhISWIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 18:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbhISWIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 18:08:01 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E0CC061768
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 15:06:34 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id a14so2180092qvb.6
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 15:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b700IZOvcmDVrq+0HZ+RP1WwJQWxcExsUcbv+nvnXKY=;
        b=Vp8vCU0BfQKHWL7fU64lnVUwpF1PWnTE97HCEbS8ZbUW2Y3rSjVbgVoYwrPtbyKs4l
         VB3ncPyVjF7MwxRIMgjllDLrZ3EY5D8bRiWQy1StUdgvFxmbKurFt+m52GG4uVlhyX99
         l7nN4e+pK8BwYfbrbU/B2Y5JbVpesXCuHwcEiiPksMRFMvsqZ8mO8v/AQxaZH/UGOxFm
         HcXLre04c6B8lgTJETWEVs86rdcwll8EKBxGLBacSE+Be8DCcWkx/4WWQ+KOvfLpQplu
         JvLJUYNuB0y7LPCKa7OvpPNGawJNZ3U7HeZS+YLgpvOdfuhcWeO/0YhD19aeQ1qkgIcK
         5ftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b700IZOvcmDVrq+0HZ+RP1WwJQWxcExsUcbv+nvnXKY=;
        b=WC2s7+4isz9QMShz+2C9TCY8BIOpvIRRMyqK2WMkfQc2BsvWUsKY4RyOwbHu/m7YUm
         hXUn2juc1YKhDyPgcn7pJsOcDhZ6nLUwKTReIZugULGEFyznsT0UApMVg57XKBu0L/pl
         6HsNv5iweOxXalTdgXPt3LTb/I2eYdnDjXQEBFiGJ4nR+0d9Za3ySJs04otj/HAjSiXK
         gO8m+q2h9kCa6CHnZUsWXBgICCU95Nfue9z44LT4/9teJcUzyFyhe10g952xO7ece7zd
         Af2quoOATvbK19kGvWYvJJQ6KzHJNVxoeQ7FQYUk0FgUsIgEIgo2ctevTcu+XoZ8t1sd
         ctWg==
X-Gm-Message-State: AOAM5327asMYXPbJGMp+Fy+MT7ShAz1q8y3+zaZrWYRr0Zu3PeI1aduR
        1lXkCdo7QBd40GfmLbl3wyM=
X-Google-Smtp-Source: ABdhPJyvkDxySbpKskXmjexAAElJnXfWuNwqFgXqy/i6V9jE8lprk/H9LTY87IBm7g1/8+7a1D0KKw==
X-Received: by 2002:ad4:45c3:: with SMTP id v3mr22656038qvt.41.1632089193618;
        Sun, 19 Sep 2021 15:06:33 -0700 (PDT)
Received: from localhost.localdomain ([191.84.236.195])
        by smtp.gmail.com with ESMTPSA id t23sm246313qkj.31.2021.09.19.15.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 15:06:33 -0700 (PDT)
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     linux-staging@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, nsaenz@kernel.org,
        stefan.wahren@i2se.com, arnd@arndb.de, dan.carpenter@oracle.com,
        ojaswin98@gmail.com, amarjargal16@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, gascoar@gmail.com
Subject: [PATCH v2 4/7] staging: vchiq_arm: cleanup blank lines
Date:   Sun, 19 Sep 2021 18:59:11 -0300
Message-Id: <20210919215914.539805-5-gascoar@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210919215914.539805-1-gascoar@gmail.com>
References: <20210919215914.539805-1-gascoar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary blank lines after open braces and before close
braces.

Reported by checkpatch.pl

Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 9464a4777ff6..778540faaa1c 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -1218,7 +1218,6 @@ int vchiq_dump_platform_service_state(void *dump_context,
 struct vchiq_state *
 vchiq_get_state(void)
 {
-
 	if (!g_state.remote)
 		pr_err("%s: g_state.remote == NULL\n", __func__);
 	else if (g_state.remote->initialised != 1)
@@ -1339,7 +1338,6 @@ vchiq_arm_init_state(struct vchiq_state *state,
 
 		arm_state->state = state;
 		arm_state->first_connect = 0;
-
 	}
 }
 
-- 
2.33.0

