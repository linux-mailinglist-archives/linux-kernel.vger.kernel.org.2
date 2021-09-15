Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6D1240CAA5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 18:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhIOQmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 12:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbhIOQly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 12:41:54 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195C5C0613D9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 09:40:35 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id a22so4221912iok.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 09:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6Rxb+EQHGqGlKpLXwnxUW51+7Nk9iz0v7oEOEwdl08A=;
        b=B3heCAFAtcC6QryGQYGFjVVPguP6UT62uRvWMrikUSymwViLYD2YEulfooP94KdKym
         yTmfyeKCbtyBv0fu65gMzGbq67vSBFo15bYKVzH31w7PaPB52rtBZUrm/NDugcFv4mPD
         DF9dr3wsY1ErnpmAfgUj5cnWoBi14jl5cZYK+T+Mv7QjqO3dCTY5TS7X/fwMz+n9neoS
         mGQmqg+t6j91x1RIc9POov9tZ4oCae8zbrKltCMZzDZOyC30482Z4Fvyj8Tts4+ySOMH
         SoLUoCp+Ffuo2iRBVtgBPfS7pfs2I2r3ArWMvyHz1kSz7LxTXWckF3O/9sTKktkdtSc0
         KKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Rxb+EQHGqGlKpLXwnxUW51+7Nk9iz0v7oEOEwdl08A=;
        b=NTJA4ASLE14ITYYVqzEYhbkCZeK3+eAuzQoGEm2svJ1tigE0aOMK9L8k1kk7lNlE0f
         rbPJIUGu0W4LNgp/wUva7s3bGMvsjU/ZPdAmkOS+iSjTJrAb8o2uEdyAGvQiLZNaOYVw
         khSsejPB06v/TYW1ut+EkOqX4cgLOGpLVd+QuNA73CJB+H0v5KkPcUeEyaoRNQv61DOu
         jCbgmLFfR7oQN2asnynFLE0FLMrhGNKcUTz6Oe12PRzqqY5zAXQ3f606q8PnX2YJaBAn
         x+PGxX7D2ReDlvkuX84qtFEpfFd6Dp9b3S0zzkMvTVA37N66Z+yJGFVRd2EPhZC4p+Y1
         hCqA==
X-Gm-Message-State: AOAM532EyuyZ7N+eMpm0arXmIZa2A2PT+61XDL9qB0eyxn9YyYIduUpJ
        J4XsuZARI+OKdWIYvBozwPI=
X-Google-Smtp-Source: ABdhPJwUiCq3Y3P8gdIakSpZEu530hrN6NBPP0mUbBFhez/Kq/Mrs4i9Z7NqYhq6FS8kercLVnuDsg==
X-Received: by 2002:a05:6638:14cd:: with SMTP id l13mr789772jak.90.1631724034555;
        Wed, 15 Sep 2021 09:40:34 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id a5sm299540ilf.27.2021.09.15.09.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 09:40:33 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, daniel@ffwll.ch
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v8 05/16] dyndbg: vpr-info on remove-module complete, not starting
Date:   Wed, 15 Sep 2021 10:39:46 -0600
Message-Id: <20210915163957.2949166-6-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210915163957.2949166-1-jim.cromie@gmail.com>
References: <20210915163957.2949166-1-jim.cromie@gmail.com>
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
index eac6c6877277..abc04bf4f765 100644
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

