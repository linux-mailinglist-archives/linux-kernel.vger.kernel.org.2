Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD07533CCF3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 06:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235303AbhCPFJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 01:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235194AbhCPFI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 01:08:28 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FC6C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 22:08:28 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id h18so11570584ils.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 22:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ue7qb6UKVXaBOoNqVYxg8dDCH0ql0uLI78PzAQH/VF4=;
        b=aE3sirUHgxDiB/2IxyCas/W9huAeFUCVCtfSx9eqzsLr+ueesat4A1rPDAnzGNVrus
         t9zecn3Asn5Dz0D+EyzRqg0zaSl3QsHA0t/TSc3ttH9nZimclZkSJ+TuSTsUGXvdSYQJ
         hYesqeikihpAz7Na7i+rIrOBXHpeNDY5reViF+TQXpN6RYEdcvTRqScF86Jhxu427uJu
         DWrhTDbM5FJPH7noquwyMyAdbdHcERUpWmPJNHsjAKEIUUClDXdjb4yXfHk6UbIIj04x
         MmqMOt2qe1T0mHD0meRu6i9y7iIAKfAyjp8uT3Iea3QlvpVz+V09P08GnCzNLtaeByPo
         K0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ue7qb6UKVXaBOoNqVYxg8dDCH0ql0uLI78PzAQH/VF4=;
        b=ihj/CKNkDeOlfHKKcauPx9vQs5MIkbA7HMHNTr9wkmBu8JaR9lXPuah23riw6Y5KKA
         ZwvRlGrYWIXorzqn0w4HruvjWVKMiClw++iUIot8Q+el1gACSxAGQE1dFE6n1NoTimVH
         yoRzLhDq4oqk1JtGsp2PMuymY1t4SKUgH6D6OBTozK8DSFtbIKAS3trqjJzCVdb9ZkNj
         YpnWk/83zXUKSUN3q9iewUJp6A03PWndqPAvvzogmjkrfOmHIMHLsj+bH5x4UBGKxuoi
         Qq+HMNCO2nthVq/E9lzj015otsw6AyGZ+yPdFPHcwUdu24eHw7+qlerBN7GX3ckUv7D2
         rJbg==
X-Gm-Message-State: AOAM533spUfh0bTKHA3cp5J9+0WPj55Lb9KUsMZ/sWsiAkaXcwxLnV+x
        gkV7r/D/47XKcqVH94A48FGBWoYBhqVliQ==
X-Google-Smtp-Source: ABdhPJwLZFXfXdxhUxPS5boYBatzITSRemiMu2rji3V84m3XpxMADSzT3HeJBG7+Kt+sFBkK272roA==
X-Received: by 2002:a92:ce02:: with SMTP id b2mr2564118ilo.182.1615871307978;
        Mon, 15 Mar 2021 22:08:27 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id y9sm8587469ill.15.2021.03.15.22.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 22:08:27 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v3 09/18] dyndbg: optimize ddebug_emit_prefix
Date:   Mon, 15 Mar 2021 23:07:52 -0600
Message-Id: <20210316050801.2446401-10-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210316050801.2446401-1-jim.cromie@gmail.com>
References: <20210316050801.2446401-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add early return if no callsite info is specified in site-flags.
This avoids fetching site info that isn't going to be printed.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 9 +++++++++
 lib/dynamic_debug.c           | 3 +++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index bc8027292c02..aa4a3f5d8d35 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -40,6 +40,15 @@ struct _ddebug {
 #define _DPRINTK_FLAGS_INCL_FUNCNAME	(1<<2)
 #define _DPRINTK_FLAGS_INCL_LINENO	(1<<3)
 #define _DPRINTK_FLAGS_INCL_TID		(1<<4)
+
+#define _DPRINTK_FLAGS_INCL_ANYSITE		\
+	(_DPRINTK_FLAGS_INCL_MODNAME		\
+	 | _DPRINTK_FLAGS_INCL_FUNCNAME		\
+	 | _DPRINTK_FLAGS_INCL_LINENO)
+#define _DPRINTK_FLAGS_INCL_ANY			\
+	(_DPRINTK_FLAGS_INCL_ANYSITE		\
+	 | _DPRINTK_FLAGS_INCL_TID)
+
 #if defined DEBUG
 #define _DPRINTK_FLAGS_DEFAULT _DPRINTK_FLAGS_PRINT
 #else
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 1f0cac4a66af..af9cf97f869b 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -632,6 +632,9 @@ static char *dynamic_emit_prefix(const struct _ddebug *dp, char *buf)
 	}
 	pos_after_tid = pos;
 
+	if (!(dp->flags & _DPRINTK_FLAGS_INCL_ANYSITE))
+		return buf;
+
 	if (desc) {
 		if (dp->flags & _DPRINTK_FLAGS_INCL_MODNAME)
 			pos += snprintf(buf + pos, remaining(pos), "%s:",
-- 
2.29.2

