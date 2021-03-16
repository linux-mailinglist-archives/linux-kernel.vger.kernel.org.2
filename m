Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9CD633CCED
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 06:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235252AbhCPFJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 01:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233773AbhCPFI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 01:08:26 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00C7C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 22:08:25 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id g9so11586863ilc.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 22:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6StBCK2sKeNyTuk1kSCbfyJqQXg2zhDg9WydesT4oWo=;
        b=EqYyxqkWusoc4ys7M+9B2WJr8bmqdvLzUNDeS2vowChKUoP0lFf5Qzg2/LZVQQHX98
         Et50fATAPyZfoXiLsIAKgtEY96LOPnLDoB223uLVz7UKojmvLShmbAonHGF/BqXWODJV
         Z4e412atPdc6kzlcuvDIGr2op96nDUg8v6Dv1pM0PIYELX2iaDuQ8GFASlCZ2eT+f+Yu
         qo5Pr87y67RLTRBhRKZlsudhwFXV1nG621F/mhUDpVk/YNg7MBingGITeREJq2ZdyJ8Q
         0nx5EvXvqvxR9kY4VfLC+ViVQDVlyNaVVNuwVUd8e7dqIUt4KNbGkN90/4sa7LrGCbvX
         RFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6StBCK2sKeNyTuk1kSCbfyJqQXg2zhDg9WydesT4oWo=;
        b=KjiSvgn5O3tf+azWeO8sXrIKxWH5cYrH8SnU4mPLt7QL8nXek6ZIsDgLqwGSRgh1BP
         b/s5GKHvc8S6SzLx795bD+9tJTFF1Soi7YT9PFLN62BcGkeZaP9n9SpReWXuihR7bgr3
         BIgIPP4o+DTmNO/AsT85M0UilOwA2HoaPiC9J+pwrnVd8EiAzDlpAXsHvp/ygQH86zeW
         YICIsdWJHCcs8Aka1S3+jO+wfFhsUz7LlIokSO31rjHslpA4yU7W+sOAC1MzChJx1kd7
         cniwsU2rDrlQd7o7c0bedY+HeGyHprqwDuMLpcgZy6ypzy0DUjWyJGd47q2VTEm2aYKf
         v7og==
X-Gm-Message-State: AOAM530nnDGJ40RkeY/60H5AKRqAU34yjq/545aztK/V8xBJJ1YsLFMz
        mP5X/OiVf4CetpoYMYKqHqo=
X-Google-Smtp-Source: ABdhPJwNT7YdaXTHGaKmbApxViO3BY+iVkX+ahgvLyUKdL+3YuMoDAW6hLvHdfEjTI/hbDJTKmDFHg==
X-Received: by 2002:a05:6e02:dcd:: with SMTP id l13mr2251537ilj.271.1615871305401;
        Mon, 15 Mar 2021 22:08:25 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id y9sm8587469ill.15.2021.03.15.22.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 22:08:24 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v3 06/18] dyndbg: accept null site in ddebug_change
Date:   Mon, 15 Mar 2021 23:07:49 -0600
Message-Id: <20210316050801.2446401-7-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210316050801.2446401-1-jim.cromie@gmail.com>
References: <20210316050801.2446401-1-jim.cromie@gmail.com>
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
index abe3382aabd5..151e55ab6bb5 100644
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
2.29.2

