Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B31440313
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 21:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhJ2T1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 15:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbhJ2T1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 15:27:14 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE1CC061714
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 12:24:45 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id m21so10730161pgu.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 12:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4QSxhE5r/ZgGfaD75aNjGarCFi6+5alziBCSKa958aU=;
        b=ZnRBubYecE2jp7wawPeqf/8TidZUhbRkgqVxwO2ap7/vROnjkIGUt7ejft0sAYQVsr
         7XhvsrJm7ien9kMIwTjciAMaJXK/XSp4KChmSlu3j+9WUocHmmLt10ocTLwg53a6ZR4s
         vSEI5kygt/0EvapJ08VR1kcnriVth9TlJtRJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4QSxhE5r/ZgGfaD75aNjGarCFi6+5alziBCSKa958aU=;
        b=D+40h4+sfHB5rKGPyr6PjCixzj51KAmHNbay1pnlp3iUon5v6fFLzTGsSbOglpIC1R
         TuMAHjACnbvFxhg+LWnT7rlSBKLf6h7IMLKilibMmRI1q6EWa4brRpHmRJwUF0G5MHhT
         FwKSfRl7kKqhqr9TVrEmii8ras64rWM/lwTXY3o/PtEo7LMwRhzPygM3G9CrkjCfC5tz
         LV+D7BZdHDmuGiBptxFgeQCPcxJRhEk8Pvv5comqWTbjwFhOgH1EiaB8Tn0C5n9RSBuP
         fP3wT+KCHSbVHwmd7GtJl/2dppsh34HMYYQlMhpbBcSX7l8WmFwSwfziIARue4QkEp6p
         TMGw==
X-Gm-Message-State: AOAM532llB+2g2rchbGpAjEVw/qdlye2mewZfJ0oMAU9x/GD8MG6iHSD
        AP8sZ2o5T1CJXf0HXUEL0wPdIQ==
X-Google-Smtp-Source: ABdhPJyhCmbPKiOFMh9Z48rlxvioHBI5YSAgRoSyK9zemZZxBIizZ5InFQJ8XdcUYZSh9zHXevCv8A==
X-Received: by 2002:a05:6a00:1a8d:b0:480:203b:4ccb with SMTP id e13-20020a056a001a8d00b00480203b4ccbmr260068pfv.25.1635535484778;
        Fri, 29 Oct 2021 12:24:44 -0700 (PDT)
Received: from evgreen-glaptop.lan ([2601:646:c780:5ba8:ee49:1984:f0a3:a0bd])
        by smtp.gmail.com with ESMTPSA id c22sm7518317pfv.69.2021.10.29.12.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 12:24:44 -0700 (PDT)
From:   Evan Green <evgreen@chromium.org>
To:     Pavel Machek <pavel@ucw.cz>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Evan Green <evgreen@chromium.org>, Len Brown <len.brown@intel.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH] PM / hibernate: Fix snapshot partial write lengths
Date:   Fri, 29 Oct 2021 12:24:22 -0700
Message-Id: <20211029122359.1.I1e23f382fbd8beb19fe1c06d70798b292012c57a@changeid>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

snapshot_write() is inappropriately limiting the amount of data that can
be written in cases where a partial page has already been written. For
example, one would expect to be able to write 1 byte, then 4095 bytes to
the snapshot device, and have both of those complete fully (since now
we're aligned to a page again). But what ends up happening is we write 1
byte, then 4094/4095 bytes complete successfully.

The reason is that simple_write_to_buffer()'s second argument is the
total size of the buffer, not the size of the buffer minus the offset.
Since simple_write_to_buffer() accounts for the offset in its
implementation, snapshot_write() can just pass the full page size
directly down.

Signed-off-by: Evan Green <evgreen@chromium.org>
---

 kernel/power/user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/user.c b/kernel/power/user.c
index 740723bb388524..ad241b4ff64c58 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -177,7 +177,7 @@ static ssize_t snapshot_write(struct file *filp, const char __user *buf,
 		if (res <= 0)
 			goto unlock;
 	} else {
-		res = PAGE_SIZE - pg_offp;
+		res = PAGE_SIZE;
 	}
 
 	if (!data_of(data->handle)) {
-- 
2.31.0

