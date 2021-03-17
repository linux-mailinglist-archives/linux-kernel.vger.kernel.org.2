Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED7E33EA3F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 07:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbhCQGzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 02:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbhCQGya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 02:54:30 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5296FC061762
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 23:54:30 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id z9so507145ilb.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 23:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lfjb2KQKpfPI/NczuRnwqBHpFb27gzw1bs7orOVs/n0=;
        b=cDP+DEjYTO4B8TbudXenl4KxL5PGqLn4iuVMhP4U5nju7spgyO167/kcPJ5Bip6w2T
         oG96BjQoNj4x8PiD0HanfkIwdA6dHdM8Uot+CRWpHRKby86mX3kUIDDh0OAUKCoY5fpk
         j6Y0OM7or05cSeNHIWbOOnqXnUu7FPEOVGMJAMDaU6lIhetxfIgE/AlvTpDxC37ksejy
         /VBDpgjYpGuJOjjw1aWt1fmyg6fKjTjblNkOSPTML3AdjvPNPzS6QFUDigZOoGdsP/l6
         seY4s+hQkH3j80VnpfRdD7BVhWRV0adNekDLpby+ukBoX00LXF8QWouyfkUaGKv2KAmc
         g1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lfjb2KQKpfPI/NczuRnwqBHpFb27gzw1bs7orOVs/n0=;
        b=VT8+xESytdT7+3zdKUrSjb4iL/OE7BUyFeKDBF1pYYBRdnjU9iiv2G71G2/0bwE9mz
         9ZyTR7svqZPPFv2geqYhInwmkBOjg2z1e3ulP//LkFdoVZrYB6nrc78haQ4cEEmKtHDd
         qcE9/emAv70EAmpicZGPE38EToOEwigEutzP2bEWLKYHKii8Le86aGO22vNni9yu3GGm
         1BzUznAKmKsaM7JMyV/CqiSbctrR5Q5IEIUqgrsR/utbpLgNx5pZITbJcvgISdOZOGtI
         zHBVpoDBAh6H9IDXyEozgqWpAAxqMuGCmLsYTlGx0bE6QAznbgRM32Pd3z22QK5NIdiw
         bIRQ==
X-Gm-Message-State: AOAM533dMsD48YCedyo2lW0S635Lq72AgkDtFAwZb+JIJpe8fclov60V
        /rdBbdxckl8reVtELQLG9qs=
X-Google-Smtp-Source: ABdhPJzufUvTWuBhTDljH3HCHWdjUWW+8g5qXt/7lV6FJGrPa/OLY+ZfEVYDEjF6cpSKaY5clczuLw==
X-Received: by 2002:a05:6e02:1aa8:: with SMTP id l8mr6355597ilv.233.1615964069833;
        Tue, 16 Mar 2021 23:54:29 -0700 (PDT)
Received: from frodo.mearth (c-24-9-77-57.hsd1.co.comcast.net. [24.9.77.57])
        by smtp.googlemail.com with ESMTPSA id w13sm10583057ilg.48.2021.03.16.23.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 23:54:29 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [RFC PATCH v4 10/19] dyndbg: avoid calling dyndbg_emit_prefix when it has no work
Date:   Wed, 17 Mar 2021 00:54:03 -0600
Message-Id: <20210317065412.2890414-11-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210317065412.2890414-1-jim.cromie@gmail.com>
References: <20210317065412.2890414-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wrap function in a static-inline one, which checks flags to avoid
calling the function unnecessarily.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index af9cf97f869b..2d011ac3308d 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -615,7 +615,7 @@ static int remaining(int wrote)
 	return 0;
 }
 
-static char *dynamic_emit_prefix(const struct _ddebug *dp, char *buf)
+static char *__dynamic_emit_prefix(const struct _ddebug *dp, char *buf)
 {
 	int pos_after_tid;
 	int pos = 0;
@@ -655,6 +655,13 @@ static char *dynamic_emit_prefix(const struct _ddebug *dp, char *buf)
 	return buf;
 }
 
+static inline char *dynamic_emit_prefix(struct _ddebug *dp, char *buf)
+{
+	if (unlikely(dp->flags & _DPRINTK_FLAGS_INCL_ANY))
+		return __dynamic_emit_prefix(dp, buf);
+	return buf;
+}
+
 void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...)
 {
 	va_list args;
-- 
2.29.2

