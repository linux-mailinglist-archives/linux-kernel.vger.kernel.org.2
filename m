Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0845370965
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 02:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbhEBAUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 20:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbhEBATz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 20:19:55 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB50C06174A
        for <linux-kernel@vger.kernel.org>; Sat,  1 May 2021 17:19:03 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id i17so1903857qki.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 May 2021 17:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YFrHuiCgVxuk3VucJdjHQohm6Nqxsi7Fn/b9oyEwGz0=;
        b=FoAUu8AC6MTunvQ8yarUmTFUe5rHqCGRgvUD0UYyeUlF4ZAbQmfZZQHt2WGb3+sX+Z
         DACsq6VP9hE39GEHjzoljku5KgxAxA1pzP24nNCoJnvHUXBZW5VjA7bse7e9935VczCP
         SY4Vl6fldwrS0Fbp4kCSOlZ4xUOAQn51kJoys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YFrHuiCgVxuk3VucJdjHQohm6Nqxsi7Fn/b9oyEwGz0=;
        b=ig9J7bbQDZC4+1j0nOIJq72Z14iC4zEWj26sik9tizFNnHcQgAynqLibIixRw9jGq8
         sMLykCzUJR9x1xC2yBzGU1M9ytDjIxb/CfvQaPry5QWDmlks/XbyYqvQk9c9XpYcLLyh
         mDjOGm04chaJ8psEVW6DIjQvxA7ELCiPWjgpkn41sQ1rFTzi75ZgAtMIX0IprYlirKXt
         cf6G7Oi+jevefuUbPfTC53B4cCoTMcngJYcT6s12l4Jdw0dg78h8brOmxNa2W1xuO64G
         go0a/ZolLBEelcn2ilFqy5UBu+EwGTOmS5AnL9F6kQ50+uoAgP2cE9kxXUwd3XoJMTFS
         Bqjw==
X-Gm-Message-State: AOAM533EroKRemH9Lvt/fpgnuBAVXDdfkbV+i5x9cjdli3RlbKWR9Im3
        gs48khaZrDqiBjD7bWEOp3q+Iw==
X-Google-Smtp-Source: ABdhPJypwSf8TS50lZmHuge623bTNQIf81qG1QW2YfGdO+acApuR7mmBjkWsugo3NrXpKYyzCSiObg==
X-Received: by 2002:a37:7782:: with SMTP id s124mr12425117qkc.305.1619914742997;
        Sat, 01 May 2021 17:19:02 -0700 (PDT)
Received: from ubuntu.netflix.com (136-25-20-203.cab.webpass.net. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id p5sm5146067qkh.135.2021.05.01.17.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 May 2021 17:19:02 -0700 (PDT)
From:   Sargun Dhillon <sargun@sargun.me>
To:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>,
        Tycho Andersen <tycho@tycho.pizza>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        =?UTF-8?q?Mauricio=20V=C3=A1squez=20Bernal?= <mauricio@kinvolk.io>,
        Rodrigo Campos <rodrigo@kinvolk.io>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>
Subject: [PATCH 1/4] Documentation: seccomp: Fix user notification documentation
Date:   Sat,  1 May 2021 17:18:48 -0700
Message-Id: <20210502001851.3346-2-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210502001851.3346-1-sargun@sargun.me>
References: <20210502001851.3346-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation had some previously incorrect information about how
userspace notifications (and responses) were handled due to a change
from a previously proposed patchset.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
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

