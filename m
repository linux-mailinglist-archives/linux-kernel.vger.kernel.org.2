Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDD06321B57
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 16:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbhBVPZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 10:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbhBVPPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 10:15:15 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E88C061A2E
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 07:13:04 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id b3so19449477wrj.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 07:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pNjPP+R6G1ipZtLvtiVHNIvTPKhMwdVdBohHcYREKCw=;
        b=czOh/H+hJtEMAW7bl45eaYyPl+SGuDPrp1yzUjcGmgfimbF7FpaKsatvBqaQUE58IY
         jfsa9jO6Ofi087FELMZ11LHCvRWx3NK3RJUAn3er32i1wS0cqrT77H6x6GUN9bocNpqp
         E9Cb+6ioqmICjpIY+SIou+1IR3oqvxXuCmFutIF3HUV6FfCE9Q2g/WeKY9GRaDNpWOM3
         3XpNLC+Vnqr5cAIC74JQ76tuVnjyo+VHImkVdAY1PsVKKfkNi8BE0qufn02lx90c29uv
         4dM5NF+hrClmTRgOpJLK3nwnzKqarm8Tq3D5O9iN8RBz4Bi8rJDPi2jiapbOSzblwcjD
         dkXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pNjPP+R6G1ipZtLvtiVHNIvTPKhMwdVdBohHcYREKCw=;
        b=dgtg1QRwGJDMWFnsT/aZQ0rhuoWBUgz4lxUum6EuKTPvnmTqVB/vVjOB+BlppgZ0iP
         O0PcWy956Tg9uc+F+2Z4QQdUlQ+nwA1R4nqnW7dT8ott+G8VnwKdv0oZb9jC6iB5jNMt
         BkOuHsL8NuSx1a6LADuyLxZTpYMTaJrsHaJijVDXY+aiJJRQTtGc2aCEcGUzVMQPmowG
         jD1NsGq+kyPtMIWGLi4ZVRpznMao7Wg4KFciMXmn/JUOhAyPkNXK4B+RAD/oD+fCMbLZ
         Dm5v3CpJ3NSsRDZf2BVRbGvn0hEr8eLYBIclpDj+ht6DNQ8XV/J6h4cEm2kv8IPwBvlp
         Rhcg==
X-Gm-Message-State: AOAM531qIzAste0Ret1CX21++3cLEi7UwDruQ5iG5nX0SCZBM8bf1j+D
        7mjYfKv4xt1diAKTHQr0Gs2Ukf5vWKld19FbOu4=
X-Google-Smtp-Source: ABdhPJxELjftRjbjQ8QfUGGO1yRJpXVaKOsjxszlBPDZ6XpG6SXTXprLGU2UGpUASnlugQFQNk7gkw==
X-Received: by 2002:a5d:540d:: with SMTP id g13mr22002512wrv.143.1614006782504;
        Mon, 22 Feb 2021 07:13:02 -0800 (PST)
Received: from debby (176-141-241-253.abo.bbox.fr. [176.141.241.253])
        by smtp.gmail.com with ESMTPSA id t23sm6092359wmn.13.2021.02.22.07.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 07:13:02 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Kees Cook <keescook@chromium.org>,
        kernel-hardening@lists.openwall.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Romain Perier <romain.perier@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 17/20] vt: Manual replacement of the deprecated strlcpy() with return values
Date:   Mon, 22 Feb 2021 16:12:28 +0100
Message-Id: <20210222151231.22572-18-romain.perier@gmail.com>
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
 drivers/tty/vt/keyboard.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 77638629c562..5e20c6c307e0 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -2067,9 +2067,12 @@ int vt_do_kdgkb_ioctl(int cmd, struct kbsentry __user *user_kdgkb, int perm)
 			return -ENOMEM;
 
 		spin_lock_irqsave(&func_buf_lock, flags);
-		len = strlcpy(kbs, func_table[kb_func] ? : "", len);
+		len = strscpy(kbs, func_table[kb_func] ? : "", len);
 		spin_unlock_irqrestore(&func_buf_lock, flags);
 
+		if (len == -E2BIG)
+			return -E2BIG;
+
 		ret = copy_to_user(user_kdgkb->kb_string, kbs, len + 1) ?
 			-EFAULT : 0;
 

