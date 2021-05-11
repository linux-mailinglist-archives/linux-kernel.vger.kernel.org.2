Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCA637AEBC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 20:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbhEKSwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 14:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbhEKSwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 14:52:34 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DB5C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:51:28 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id p15so18077792iln.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 11:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pNVEKTV+bvX9RYRh1tpVpNIQOxEufSB06uqOG2WwH4Q=;
        b=a5o/kgEGGAE9GtWt+aT2/FVLQzbZlWlMuA82ZmTbVDKaRdPdnRB6JjdNn1PzNRoG0p
         uAirF11C6ytPQhCoETeJ50hKUY8JO6L3q7FCuxLPNSNHqlGQmeQRUfuzXYgJorWul0a5
         5x+7v5NmxvEWcMEkDm2zS8iJgWUxFS9bjyKT7AtEy5A4ROf7uvjMhZR+DZV6J0GlEAsR
         WiQYZOP7az0fOBjHp89siBspatBjwY2OolcmebzeBY27FA+fkNILDsFM4voXiEqBcBRP
         mL4MWeer41/WpdfiajXCcbQzMnEt3IjrzLRPnNj1WzRnzdSI9xITakte7M9+emqSibml
         yKOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pNVEKTV+bvX9RYRh1tpVpNIQOxEufSB06uqOG2WwH4Q=;
        b=lClg8ZN3/gpKFEtzquPfT1ofzM3eJLE5sLbK+FwW+Xp0xEcZtFUlOc1vHioBT2ffTv
         9UNZr7jLJTI86uTgU1SL0aQRXx7vvfLuZmzZJhxnKB+cOivhQxsB7nYJPqja102LwaQg
         WsKtBiMCpOLsj0/d0UCMY3B0d4zznARN/Q6qDANMWD/DkUGp0ocIOXpvQKIcEuG0wju6
         dcyGYH+vk4aeK27v9Bt/Dv1+dg4zLlkaw5ccvewj5q4mKtre+2cspFD4k4dwiLkgJOvB
         X4534BkySzW6q1Edp3l4MumaetUfejgle/Ve6FRohWPidryWtliXGAm+M6SxLV3RKgch
         DqOw==
X-Gm-Message-State: AOAM531wjCfSjpbTfIIBTW/+I3Tm81y44dNCa1L9VjBi8CFqlm1qqPBk
        /TYoTY8ocZUYIwnsRaEyK6M=
X-Google-Smtp-Source: ABdhPJw8w6k8eSf/FzYnXUHbsHEhp5PxB2/26GnevLxHvuWwhqTmTCXwYS/ZqRxeHjytBZrv1bd36g==
X-Received: by 2002:a05:6e02:12b3:: with SMTP id f19mr28257289ilr.219.1620759087554;
        Tue, 11 May 2021 11:51:27 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t10sm405096ils.36.2021.05.11.11.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 11:51:27 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     Jason Baron <jbaron@akamai.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v5 08/28] dyndbg: accept null site in ddebug_change
Date:   Tue, 11 May 2021 12:50:37 -0600
Message-Id: <20210511185057.3815777-9-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210511185057.3815777-1-jim.cromie@gmail.com>
References: <20210511185057.3815777-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix a debug-print that includes site info, by adding an alternate
debug message that does not.

no functional changes.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 0896c681db40..fa89d69dad4e 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -235,10 +235,17 @@ static int ddebug_change(const struct ddebug_query *query,
 				static_branch_enable(&dp->key.dd_key_true);
 #endif
 			dp->flags = newflags;
-			v2pr_info("changed %s:%d [%s]%s =%s\n",
-				 trim_prefix(dc->filename), dp->lineno,
-				 dt->mod_name, dc->function,
-				 ddebug_describe_flags(dp->flags, &fbuf));
+
+			if (dc)
+				v2pr_info("changed %s:%d [%s]%s =%s\n",
+					  trim_prefix(dc->filename), dp->lineno,
+					  dt->mod_name, dc->function,
+					  ddebug_describe_flags(dp->flags, &fbuf));
+			else
+				v2pr_info("changed %s:%d =%s \"%s\"\n",
+					  dt->mod_name, dp->lineno,
+					  ddebug_describe_flags(dp->flags, &fbuf),
+					  dp->format);
 		}
 	}
 	mutex_unlock(&ddebug_lock);
-- 
2.31.1

