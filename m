Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB1F039C1F7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 23:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbhFDVLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 17:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231183AbhFDVLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 17:11:20 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6503EC061767;
        Fri,  4 Jun 2021 14:09:33 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id z8so10532069wrp.12;
        Fri, 04 Jun 2021 14:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jwr4pqYVJVTXgSaj9RyCCBtkW5+6pm/zrCBK13WpZL4=;
        b=FSZdo9iPadT6850kuxLVCdvfxgEYWXzHErjNsP/9dbJ0P7F/UOQ5hQ1r8jTnE62Qwt
         1f8ZouOGPqYtPueiPuY/MVA3C6PIyp8hI3OgO3kn8TavgR+SEHaNzeS1DpQd7g/znZ0Q
         D3qMgUbRP9QkCaYqyL+wO+vGlwsbP4lm9UHSb/6LRcYRcDp8bLyvvL19jT3YWELVBzjN
         nHynr/Jjm6Z6DndMLCg0YmpgrpqOElWnLuCABJ0wVU/pVr4Nap+/225xtpbu+dCXQ0Sy
         V5o+9nBXjosTHrHl+KodgqqJdJs0nZzl8grtH3Hks5ogvmLmS1s2d+TFmXuZujinpDUA
         m1fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jwr4pqYVJVTXgSaj9RyCCBtkW5+6pm/zrCBK13WpZL4=;
        b=XkkTfP8qckMqptqeX0BDdZShpzXupyD3WyOOY+l8v0f7ABkcM5neIGDVJYawaoXg55
         Jgr2Lo4VTVtHvfXam3s9BOPeenBqCbDgqbgbWJ7RKrRwN6Wa4mQuFehmb3nRzsZbmCLk
         qgzH7dik+pAHCjpMOm9s4RPoQsQJ20S7bJhmMhGqFzzGYbEi4RnFNWVIPdVFasNeaSO6
         Yqu414K6koscHJabUxgdOPta2UtI4198Va6RKmc6+GyMj5DfifnY42+epWNOXswuCB+r
         zyw7rBVtswDBtMCwyCoH6/6jYD9x9bxY1nsWp424x1Sz5Kr+iSt1XJkE7MDDFt6GhG9T
         6nCQ==
X-Gm-Message-State: AOAM533RDlfvgCBUlBvlXJZdBq8BvoLCDGfG8IJVAn++HPnuZxDELeGB
        kzSXtlPqIwvF5IsoXWptEZg=
X-Google-Smtp-Source: ABdhPJymazygBQaXu5lnJW9WbD5kRmU96PK3PGH2pPkfjR7Jzc40c472A+aX4eo1tC7vsKCi/xrW0g==
X-Received: by 2002:adf:fc90:: with SMTP id g16mr5719893wrr.183.1622840971988;
        Fri, 04 Jun 2021 14:09:31 -0700 (PDT)
Received: from xws.localdomain (pd9e5aba0.dip0.t-ipconnect.de. [217.229.171.160])
        by smtp.gmail.com with ESMTPSA id l5sm9478853wmi.46.2021.06.04.14.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 14:09:31 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH 2/2] platform/surface: aggregator: Drop unnecessary variable initialization
Date:   Fri,  4 Jun 2021 23:09:07 +0200
Message-Id: <20210604210907.25738-3-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210604210907.25738-1-luzmaximilian@gmail.com>
References: <20210604210907.25738-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The status variable in ssam_controller_event_disable() is always set, no
need to initialize it.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/platform/surface/aggregator/controller.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/surface/aggregator/controller.c b/drivers/platform/surface/aggregator/controller.c
index 634399387d76..b8c377b3f932 100644
--- a/drivers/platform/surface/aggregator/controller.c
+++ b/drivers/platform/surface/aggregator/controller.c
@@ -2464,7 +2464,7 @@ int ssam_controller_event_disable(struct ssam_controller *ctrl,
 	u16 rqid = ssh_tc_to_rqid(id.target_category);
 	struct ssam_nf *nf = &ctrl->cplt.event.notif;
 	struct ssam_nf_refcount_entry *entry;
-	int status = 0;
+	int status;
 
 	if (!ssh_rqid_is_event(rqid))
 		return -EINVAL;
-- 
2.31.1

