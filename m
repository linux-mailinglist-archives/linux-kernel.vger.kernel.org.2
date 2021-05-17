Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3470F383D9A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 21:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234780AbhEQTkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 15:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234750AbhEQTkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 15:40:40 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22C5C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 12:39:23 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 6so5356140pgk.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 12:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=50KkGnCJU7bKH+8peMyZ5115bieY/zEQkJMPARq00Ko=;
        b=oohbAFG2twd1Yfo6ENRfQUAdk1DgUcxI1o5MD2Kr56au4JkxdsaSptXJNUI52pnQ5a
         LoJC3F6Jj9GJepnCwLxr3eZCx5JA/WZKI0BLZpOgwpl1XwFkl65/PnxbdBnj8zApgijL
         lCWcsaKCcYbN0zdvssR5wpseplH3NhxtcWPmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=50KkGnCJU7bKH+8peMyZ5115bieY/zEQkJMPARq00Ko=;
        b=hdpqzx++t8ITkiP9L7fzMuhZ+AinBaINphzEqU+sexOyNCZx3zsgOczRMhUk4rAI+g
         Uo93lb8+nXA+XcTtrfHBMg9w4PdWKSqT9RnSeA9vV3dX3s2o8gd3xogxOBSPalMH4hSs
         tcqp/FZaR9nMb0M7T7JFpEcQwcsz0GCXtFO9oElLH0XiO9gwxPwBOEOkTobPq7sbWDWv
         OJZOKuUmTrMO+z1PnTWxZg4h5Vzh6F2mfXawNwddanBQvtETQ3rme5b9kFNGCwhvucN9
         lOKc2uWd6f0RWCGi2nus+/UaS+tU/iC70VX+DESwhra3oHivEM1qgtY8WKx7DT3rDBYO
         rkrA==
X-Gm-Message-State: AOAM531Isp1TkFAH4sOtQVj8Y+98URS/gAXKG/Kbkf2KA6nMhcBVvoia
        5RaUcs79Cwj0jodS9EJSO8B1WQ==
X-Google-Smtp-Source: ABdhPJwAzUdkATlZL7dJYe5rK/nwiwJ4JX0LVe1jFwoqZjhABLEGGFqZF+Rkf66Xb1ARMx5ZHvC7sw==
X-Received: by 2002:aa7:8501:0:b029:2cf:c0b8:4b88 with SMTP id v1-20020aa785010000b02902cfc0b84b88mr1173746pfn.61.1621280363227;
        Mon, 17 May 2021 12:39:23 -0700 (PDT)
Received: from ubuntu.netflix.com (136-25-20-203.cab.webpass.net. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id r11sm11132110pgl.34.2021.05.17.12.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 12:39:22 -0700 (PDT)
From:   Sargun Dhillon <sargun@sargun.me>
To:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, containers@lists.linux.dev,
        Tycho Andersen <tycho@tycho.pizza>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        =?UTF-8?q?Mauricio=20V=C3=A1squez=20Bernal?= <mauricio@kinvolk.io>,
        Rodrigo Campos <rodrigo@kinvolk.io>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>
Subject: [PATCH v2 1/4] Documentation: seccomp: Fix user notification documentation
Date:   Mon, 17 May 2021 12:39:05 -0700
Message-Id: <20210517193908.3113-2-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517193908.3113-1-sargun@sargun.me>
References: <20210517193908.3113-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation had some previously incorrect information about how
userspace notifications (and responses) were handled due to a change
from a previously proposed patchset.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
Acked-by: Tycho Andersen <tycho@tycho.pizza>
---
 Documentation/userspace-api/seccomp_filter.rst | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/userspace-api/seccomp_filter.rst b/Documentation/userspace-api/seccomp_filter.rst
index bd9165241b6c..6efb41cc8072 100644
--- a/Documentation/userspace-api/seccomp_filter.rst
+++ b/Documentation/userspace-api/seccomp_filter.rst
@@ -250,14 +250,14 @@ Users can read via ``ioctl(SECCOMP_IOCTL_NOTIF_RECV)``  (or ``poll()``) on a
 seccomp notification fd to receive a ``struct seccomp_notif``, which contains
 five members: the input length of the structure, a unique-per-filter ``id``,
 the ``pid`` of the task which triggered this request (which may be 0 if the
-task is in a pid ns not visible from the listener's pid namespace), a ``flags``
-member which for now only has ``SECCOMP_NOTIF_FLAG_SIGNALED``, representing
-whether or not the notification is a result of a non-fatal signal, and the
-``data`` passed to seccomp. Userspace can then make a decision based on this
-information about what to do, and ``ioctl(SECCOMP_IOCTL_NOTIF_SEND)`` a
-response, indicating what should be returned to userspace. The ``id`` member of
-``struct seccomp_notif_resp`` should be the same ``id`` as in ``struct
-seccomp_notif``.
+task is in a pid ns not visible from the listener's pid namespace). The
+notification also contains the ``data`` passed to seccomp, and a filters flag.
+The structure should be zeroed out prior to calling the ioctl.
+
+Userspace can then make a decision based on this information about what to do,
+and ``ioctl(SECCOMP_IOCTL_NOTIF_SEND)`` a response, indicating what should be
+returned to userspace. The ``id`` member of ``struct seccomp_notif_resp`` should
+be the same ``id`` as in ``struct seccomp_notif``.
 
 It is worth noting that ``struct seccomp_data`` contains the values of register
 arguments to the syscall, but does not contain pointers to memory. The task's
-- 
2.25.1

