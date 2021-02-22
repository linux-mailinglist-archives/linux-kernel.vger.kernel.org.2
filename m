Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1380B321B21
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 16:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhBVPRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 10:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbhBVPNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 10:13:55 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2C8C061797
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 07:12:49 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id x16so13834961wmk.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 07:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S1lCywCtYVxEsnuw6UX2uJMQ5VyTPpsEmxTnLQJHs4w=;
        b=rWf86sGXPcNotlzO6S3Y7LO5Nm2WfrkvTP72KQo9Y1VVv5HcanSJASCmDSQC/FvS4l
         4X+BnIYovgNuWrjBcRMMgByxaJJKo+WuEdB5B4TeeH5KAB/k0o74OaToO8dP5U+NeEuv
         kjZevojzhOKXgUYIqK4jZ7+a8FFI4fyWPiYx976xmPlhyZGLbZFjCJRnjHuPAx0agih+
         CBwler96z49x42STZP1ftWGwflDrYvL5xmIdJrvmSrGhRlJ+bHCMVys2WE6akJcWlLDD
         pN58SYbZPSp/1g7GyQVoqT/QQavBz69bDTBxGFZjGXmlE5vLK087Q62L8G+gsKUJ9TPk
         vUPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S1lCywCtYVxEsnuw6UX2uJMQ5VyTPpsEmxTnLQJHs4w=;
        b=AYv1oU44E+0qzSClGvqXgW8drLk8a+bArYxkBrqbf/o3lLzqVFEK7D5jQmXhg8/FZM
         vr0vleq1Ig7sghyECCg1z9rmzeqEncQWrXuYlgNZ07wgS8+KPDhtJjeGoDjFw3FyRboI
         FED+2DErA46OpSRPIu2JoBrkYo9kVaVbSMjdLmgn23ZnWTtm/eBe2W/9P4LeQxucAHCy
         fqmcFhFcrEWrgRUxRsuHCaASHDy9f4aq2WTBiUK4RYMweugj5qhZ+/yWgejEYFOM6/C4
         7hSEKGLDzqoHxjyPszZEy2Tp/z6oSB2Qc9RZb0Da6w2Fdq9ENwB41+fAWjnNOcTDxQ0u
         E6vA==
X-Gm-Message-State: AOAM531fYieLqI28fm/8+d9KuFW1I2XPs0fpj19sit+ryPIdiMvCPbxz
        F8ZmIryUDQ42feh690uHAS9CyDvRpAnoJM+Bg78=
X-Google-Smtp-Source: ABdhPJxdv2k+gVDTX8PjxaPQz6UiDFMRMwv8LZF9w+l6PKqIasSjklSPneGhJPBCNfwEJDSzCT51jg==
X-Received: by 2002:a7b:c14d:: with SMTP id z13mr14117614wmi.6.1614006768018;
        Mon, 22 Feb 2021 07:12:48 -0800 (PST)
Received: from debby (176-141-241-253.abo.bbox.fr. [176.141.241.253])
        by smtp.gmail.com with ESMTPSA id m17sm24783581wmq.5.2021.02.22.07.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 07:12:47 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Kees Cook <keescook@chromium.org>,
        kernel-hardening@lists.openwall.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Romain Perier <romain.perier@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/20] kobject: Manual replacement of the deprecated strlcpy() with return values
Date:   Mon, 22 Feb 2021 16:12:16 +0100
Message-Id: <20210222151231.22572-6-romain.perier@gmail.com>
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
 lib/kobject_uevent.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
index 7998affa45d4..9dca89b76a22 100644
--- a/lib/kobject_uevent.c
+++ b/lib/kobject_uevent.c
@@ -251,11 +251,11 @@ static int kobj_usermode_filter(struct kobject *kobj)
 
 static int init_uevent_argv(struct kobj_uevent_env *env, const char *subsystem)
 {
-	int len;
+	ssize_t len;
 
-	len = strlcpy(&env->buf[env->buflen], subsystem,
+	len = strscpy(&env->buf[env->buflen], subsystem,
 		      sizeof(env->buf) - env->buflen);
-	if (len >= (sizeof(env->buf) - env->buflen)) {
+	if (len == -E2BIG) {
 		WARN(1, KERN_ERR "init_uevent_argv: buffer size too small\n");
 		return -ENOMEM;
 	}

