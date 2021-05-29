Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29765394E06
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 22:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbhE2UES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 16:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbhE2UEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 16:04:01 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36512C061574
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:24 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so6980159oth.8
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 13:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P+ejOKG5S1i8FowLBXnyA6cfXFOfEuMSLPIIumnhzJA=;
        b=fDpd8K+N8M7WbgA9Uax4+y/IYc5c61ZRiWe1e5vKveChe67ckrO8K3jPwt35wn63qQ
         xUbQ637Y4UwN4yNy+3lIGF8uednU5YiFayx0aacFvEb/beOrYod0pHDZ6LsLAKynTba+
         8j1jEHj8wZWOdHYYkl3W85uJEOzFqqA91AXkb1kRV+24RJdQACgufuPSb2379tZ0XZq5
         T3xiTCYbbs4w3MAQQkXnvk1oPG9qhdywkjj2y2G0Tu8xy3z0dD4q+E0FyrOSsNEAbh41
         oP3WK1JB0Fef0w+cwm6rHH2Q5+W6IgsRu5XzvfRYQZQMEc8QEAgQGZg1gWdP5gBfg2Tc
         AAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P+ejOKG5S1i8FowLBXnyA6cfXFOfEuMSLPIIumnhzJA=;
        b=JH40bZdCt1VPVU2jLBJh49VOqP4LNzYjsImcoqSuXtKbH5jW3ZXzR143hhYc1sS4/m
         PF9nFRbD+PgGzk9JVeo5clyOxWirk2fLJEwmURP9rc0uQPIvPlPlex2EIrbsZN+o5tJw
         FN40w/VxxISdG1/xYayGvfvy6Ig3HwyhRXvdVtHjKH+inUhyIk3LC2SBOH1n86NTccWh
         LTbfc38m4RlR/ZSsddkJq6TgiTPycMQ8nAFsCPIxDyf1MBAeF1ooia7FhP5bIPnx+YJI
         F0B/2SRTyTrtuNatc+0hf9/j10+FTEnJnwHyk7JYo2LJ5C+61og9taeweRSZaGY6nJqx
         bzVA==
X-Gm-Message-State: AOAM532t8Z8gAInfMuOZDCWeaUfPr+mL44UmcRTLT9QMVv3SvA8qt+1/
        wk7dgVn5Fg1Q0zngfUxZD7vzY2VZhaINmg==
X-Google-Smtp-Source: ABdhPJzjb3jlFL2Mn3F+69IKwLX6Ct5jIxA93dF1b09peBpwYhm4Zkj0b6fLPFcS6WOqfW6HYsFx5A==
X-Received: by 2002:a05:6830:14d:: with SMTP id j13mr11582817otp.232.1622318543629;
        Sat, 29 May 2021 13:02:23 -0700 (PDT)
Received: from frodo.. (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id t39sm1868064ooi.42.2021.05.29.13.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 13:02:23 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v6 10/34] dyndbg: accept null site in ddebug_change
Date:   Sat, 29 May 2021 14:00:05 -0600
Message-Id: <20210529200029.205306-11-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210529200029.205306-1-jim.cromie@gmail.com>
References: <20210529200029.205306-1-jim.cromie@gmail.com>
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
index e40ce438636a..b2fd7c181bd5 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -236,10 +236,17 @@ static int ddebug_change(const struct ddebug_query *query,
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

