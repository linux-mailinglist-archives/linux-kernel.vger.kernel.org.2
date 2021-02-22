Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52E35321B49
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 16:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbhBVPWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 10:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbhBVPPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 10:15:12 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D298DC061A2D
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 07:13:02 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id a207so14717150wmd.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 07:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6uS/mI0aatEHqUL9B1S+eTlivdmOLrwoS7EuJ7+U7Sw=;
        b=XZEw/mrXSku5Su9sqZev/RiL5oSE4cCOxgVcpsEgG3Aw0XC5XGMbZ8sqOGMu46zW6Y
         pmk88rgk0w35uM+iQ/W6ggkpxsWUssIP76jHTKw/m5goS80GD3UFMggz0J3zCrZw4T1n
         vxKoG4KOwfSNVFSUKqDil3BAlxJzyV+NzDxhrbyXbGisNTL1SGQQ+XWbAVPjU4Ob+Z8c
         /8NUJtdfz+cwhHOsdwZbuOZzN2zDOt3EN1OuU2jiw/fI7WxiG6MfHss0L9zX1ekkKH5c
         dVDq4bEHmLsJWf1chDh4fUhoveUKBxqfznRpEoUzR8fBgahyCZVNbvKcQK3A5oSFQ9l8
         uqEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6uS/mI0aatEHqUL9B1S+eTlivdmOLrwoS7EuJ7+U7Sw=;
        b=ubiNVNEvKMdcuYPZ4ve3TLAeaoVj2rvM1z2pyLZLVIGrtCqBvDCrJ0IeNXECWUzCYr
         aDx9jnFShsiuXyOubsHd+19MN6n8zBWm/gtZ4Akbiob1Tq4U7d6nV/7n/akSVcXfREMt
         9rIwvpjG6Ei8thMUoUN9DezN7uLe/knJjNp+VIchhKgA1rtLCDka21tBpGJqoAwbv+he
         iQmTqD11dJSe0CkSzF62dGCZTquWpSoNvQ2k/jFx1rUgVq2zfDebkIc+YuwdE5+jLq//
         APJgyIr2A7J70KMIzBGijQklSIpiORN2LUI1f1XLPahzCNdU6JxgfmAzesyvers/Rqh/
         Dlfw==
X-Gm-Message-State: AOAM532itDh0ogjuBLNhvIPXbrwt4AtqHMi3oS+hs1edKG6PNJw0YGO6
        Ig5jGq8KnlkoAF5ZNi2Buv8J+l/Un5fipuZfv2A=
X-Google-Smtp-Source: ABdhPJwt7aFnIwDsl4dI/alqogWDhoC64RsfiBRWaspWMkuciWBaudkzHyUrd8ywtQbTILnHc6eO5Q==
X-Received: by 2002:a7b:ce14:: with SMTP id m20mr13614858wmc.12.1614006781358;
        Mon, 22 Feb 2021 07:13:01 -0800 (PST)
Received: from debby (176-141-241-253.abo.bbox.fr. [176.141.241.253])
        by smtp.gmail.com with ESMTPSA id c62sm27221087wme.16.2021.02.22.07.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 07:13:01 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Kees Cook <keescook@chromium.org>,
        kernel-hardening@lists.openwall.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Romain Perier <romain.perier@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 16/20] tracing/probe: Manual replacement of the deprecated strlcpy() with return values
Date:   Mon, 22 Feb 2021 16:12:27 +0100
Message-Id: <20210222151231.22572-17-romain.perier@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210222151231.22572-1-romain.perier@gmail.com>
References: <20210222151231.22572-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The strlcpy() reads the entire source buffer first, it is dangerous if
the source buffer lenght is unbounded or possibility non NULL-terminated.
It can lead to linear read overflows, crashes, etc...

As recommended in the deprecated interfaces [1], it should be replaced
by strscpy.

This commit replaces all calls to strlcpy that handle the return values
by the corresponding strscpy calls with new handling of the return
values (as it is quite different between the two functions).

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 kernel/trace/trace_uprobe.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 3cf7128e1ad3..f9583afdb735 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -154,12 +154,11 @@ fetch_store_string(unsigned long addr, void *dest, void *base)
 	u8 *dst = get_loc_data(dest, base);
 	void __user *src = (void __force __user *) addr;
 
-	if (unlikely(!maxlen))
-		return -ENOMEM;
-
-	if (addr == FETCH_TOKEN_COMM)
-		ret = strlcpy(dst, current->comm, maxlen);
-	else
+	if (addr == FETCH_TOKEN_COMM) {
+		ret = strscpy(dst, current->comm, maxlen);
+		if (ret == -E2BIG)
+			return -ENOMEM;
+	} else
 		ret = strncpy_from_user(dst, src, maxlen);
 	if (ret >= 0) {
 		if (ret == maxlen)

