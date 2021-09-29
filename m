Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2837C41CBFD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 20:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346348AbhI2Sjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 14:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346310AbhI2Sjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 14:39:37 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6BBC061768
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 11:37:54 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id e144so4368078iof.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 11:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y5FCFf0C4oPIZwuqL7lPMiJhEyMaVRPCG7T2XvgpeF0=;
        b=HAbUx5BLsXZ8QXbYdFVdP2m1BzSphksnGorTRCHkXbgqOiZQ4V6ZNj9RTsyENC8tBi
         RX226/a28xdVqC1B0FkZBUu64zZ/W8fBBuW1pSMWPM9RDbRG7mF/26SUUr84IZmdJ/h4
         71EuOjJGngDjehdVcGicU766GRrXxQB5zneVkalJwmx07wDbLignrAWmIXoNNTeDsRlw
         Z5aJAknUuj/erXAzNu9FIucyYjao7Nt7BIFFHlSa1Nsb2/LhEhAwGFHSFRPAarcQVEWI
         X0j6Q50+ZuvbMAwVEYbTUM3qJlLITH3Bulo8oPOa3XnWPp6MiGQev0mQ+yaRDGrvDiMW
         0DiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y5FCFf0C4oPIZwuqL7lPMiJhEyMaVRPCG7T2XvgpeF0=;
        b=yotJrS4w+EamUjQmZdmi0zBohQimJwMR0xhjt+OVR9vVWUzxMndXRBxcCSHoNF01jC
         /B+hY4B964x9KD/3TiknJr+gcHSkjhVz+gcc42up6LlTsdSPZHI7nwOOcLQ4HUMikajv
         dKFMaoGUqlctMmuRsc0yNIfZgJ8NSSkXy1C/tN6PQTZfN+gSYmKKrfRyEV03h4BoiqCz
         PSNDpIriy2exWjIO4mi0MRU7QZcPH5Rryd+2jLqch63JyFMqSimHglauieCNBWe9Ac5d
         WEASbhQe0xt3J6D/XCf7mKv2YLrqNR0WY7WfH59uSKHy+imPrbkSnW3x3nHnBSy8jOve
         exWA==
X-Gm-Message-State: AOAM530pE/yPlF2a+sSgJZ5ZCkOmZlSCV3/3/Ayh4s/ob+UvBoT4NbmC
        cwcFEw4go3EVEmCobDCpohk=
X-Google-Smtp-Source: ABdhPJwo7UkmxpEjltKO6+U+X5ga91qFkEpCfEfZbS3u5niIO5MOYuElzU6Q774bTWyQ4jZp8qjXOQ==
X-Received: by 2002:a05:6602:345:: with SMTP id w5mr900950iou.49.1632940673529;
        Wed, 29 Sep 2021 11:37:53 -0700 (PDT)
Received: from samwise.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id y2sm317041ioj.12.2021.09.29.11.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 11:37:53 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 5/6] dyndbg: vpr-info on remove-module complete, not starting
Date:   Wed, 29 Sep 2021 12:37:34 -0600
Message-Id: <20210929183735.6630-6-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210929183735.6630-1-jim.cromie@gmail.com>
References: <20210929183735.6630-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On qemu --smp 3 runs, remove-module can get called 3 times.
Instead, print once at end, if entry was found and removed.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index d762bf4172f4..8230fdc66d9d 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1030,8 +1030,6 @@ int ddebug_remove_module(const char *mod_name)
 	struct ddebug_table *dt, *nextdt;
 	int ret = -ENOENT;
 
-	v2pr_info("removing module <%s>\n", mod_name);
-
 	mutex_lock(&ddebug_lock);
 	list_for_each_entry_safe(dt, nextdt, &ddebug_tables, link) {
 		if (dt->mod_name == mod_name) {
@@ -1041,6 +1039,8 @@ int ddebug_remove_module(const char *mod_name)
 		}
 	}
 	mutex_unlock(&ddebug_lock);
+	if (!ret)
+		v2pr_info("removed module <%s>\n", mod_name);
 	return ret;
 }
 
-- 
2.31.1

