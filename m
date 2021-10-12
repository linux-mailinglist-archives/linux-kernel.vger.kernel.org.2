Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B34EC42AC0F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 20:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbhJLSg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 14:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234040AbhJLSg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 14:36:57 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC617C061745
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 11:33:41 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id w10so35731ilc.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 11:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=trSs1PSgTrmZz2ICAnT37i8p7I84Yyq/W/0tnWDyux0=;
        b=ncROOvRHEYZruIaKhKZhc+uH94FSS0k95F93uF3y5KwPz/dq+bFik/9HtiScuq32fn
         r7UVfixVQsDwrj9/eFi4pMpkjmIqDH9HnnMFZhxlPizCBdetR3qnL0Au1gSaUsyWhvfV
         /jV5uv6eaDelQ6UXEZCNyZcxz+tiWce4Eh8jTsJR6p4K5RwnWebtNJw1xsiq8b/gFivy
         1rGJf0zKRRbLLmzOlcMzL14fsrAnVtOIA8n94rZzEuwblxk0083FQHIyMyJx7iZe5nlD
         +PDZQHKWkbczN+P82E5g0axZBQxOKWZgKP8Wu9a8fO/OjVR52bvNSSgZUsMtgL7CT3/g
         qHcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=trSs1PSgTrmZz2ICAnT37i8p7I84Yyq/W/0tnWDyux0=;
        b=Lj8WAWS+H3IJ6AWTjHmu4aAW3E4KjYnD9POEoXzBk6vLtmF598NK082YQTuUdAA/r6
         kzvwyEQLmV42A3sOhcFrZvLyY8TrhLPM8Td4GLgCYVF3UDYfBRBPbzkF7pEUNKb/N3OZ
         vj39qZqkg7CRQHRDN8iFVFiNvJSrWWf7kPBZn7ljTAgitzUvmZIQG9LEZ39wA5Ax2Y2G
         Zk0yR6lwfj+fRpGAMQjmwXC3C3k1oxIVq019N5yQqtVPmS4Op8RgS2e4JXG7hhbhKTdz
         Wd5J6PSiLiKMxL6CZXYyh3fGXWfavcn17g/6E5Y/tVg9Pr16UbR9RrbYDJ41AuuNCncd
         fleA==
X-Gm-Message-State: AOAM533o2Vpf3zQDxToNTfKKTwTBHD9ptf9UwGcgYoTF0QZvpevyi6JE
        PZ3yeNx2qQVVePEAYjvi4iVdvNANaB8=
X-Google-Smtp-Source: ABdhPJxUgsLiTmbWo/GdNGFD/wKiKSwVYC37UlgporueRf8gL+D+acOhhI5sAHSuoCH8tSr50s+qWQ==
X-Received: by 2002:a05:6e02:1521:: with SMTP id i1mr26107851ilu.16.1634063610569;
        Tue, 12 Oct 2021 11:33:30 -0700 (PDT)
Received: from samwise.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id x5sm2257999ioh.23.2021.10.12.11.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 11:33:30 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH 4/5] dyndbg: vpr-info on remove-module complete, not starting
Date:   Tue, 12 Oct 2021 12:33:09 -0600
Message-Id: <20211012183310.1016678-5-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211012183310.1016678-1-jim.cromie@gmail.com>
References: <20211012183310.1016678-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On qemu --smp 3 runs, remove-module can get called 3 times.
So don't print on entry; instead print "removed" after entry is
found and removed, so just once.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 75e702223730..18235de37f25 100644
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

