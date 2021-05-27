Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1289D392575
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 05:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbhE0Db1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 23:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbhE0DbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 23:31:25 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F341C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 20:29:52 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id a7so1653098plh.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 20:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wUSLATuxqwUSkm0n0L/pdOiJHV0rfqOrlM9K+8X4EsU=;
        b=K4cenW2uiZEnsKztxhSgzBxy882yyvg5X2eNPT41iOLyE/qd4b2J5QqsrkCSeKp3NC
         WiJvgVRbHi5ww8DElEaoBCSP8QheeqIEg22ZIc8jm6HyqwWQrsuJuoBqSMO+tSr9kCEj
         +bRF7YcSdweTjdFqVDh/1gFiVboqXZPMiEHgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wUSLATuxqwUSkm0n0L/pdOiJHV0rfqOrlM9K+8X4EsU=;
        b=V+qSN6tq5DSWFypGpm1oqCkeYM1JrGzAHsFdHhhxpWexGHg4w2OGxjTJKPOLjnWyf8
         ezTyaKzmX/YvB2oHsUlyqjFX19F7jjEeo0hvPSH63K+Yv6wHNjR9aWR6iaWnkpSLjLFR
         fzOV/0hDIJoifttdfJ6Xnh1eMpb0lLwShPS/b9Aj5AJ4rUNI5xS2GO1P6JhzITuNxKrV
         u0unhM00dWTBMoUTmTKGG4kidrMpc/UmDRBg5pxP/YrOjydBZXzew0S0FjTJ3ZNTlHg5
         XYlJQeWB2anuxGbAEaqu4j4tf0dBir6unaaajhn4lPPq8MqJ0jvp4o7358gcfcF0UDiA
         bDTw==
X-Gm-Message-State: AOAM532RyJd4jsV13vn/qkUHaax6kv2uvSBUKde+MJYBw6HOL38DiQAT
        tGF8EOkYxswPKHrrHLNC12cT6sUMUALy7w==
X-Google-Smtp-Source: ABdhPJy77wtQquBVeat3/kh1ClOh7dXn8rRbIhPAHzNHr+8iy2kccsIGfvH2rzaBOBpeoeo1o7VPhw==
X-Received: by 2002:a17:902:ec84:b029:fc:e490:ffa0 with SMTP id x4-20020a170902ec84b02900fce490ffa0mr1425048plg.63.1622086191460;
        Wed, 26 May 2021 20:29:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y17sm512421pfb.183.2021.05.26.20.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 20:29:50 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Sargun Dhillon <sargun@sargun.me>, containers@lists.linux.dev,
        Tycho Andersen <tycho@tycho.pizza>,
        "Rodrigo Campos" <rodrigo@kinvolk.io>,
        =?UTF-8?q?Mauricio=20V=C3=A1squez=20Bernal?= <mauricio@kinvolk.io>,
        "Giuseppe Scrivano" <gscrivan@redhat.com>,
        "Christian Brauner" <christian.brauner@ubuntu.com>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
Subject: [PATCH] selftests/seccomp: More closely track fds being assigned
Date:   Wed, 26 May 2021 20:29:48 -0700
Message-Id: <20210527032948.3730953-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; g=7afcc5fc33dccc110e627e132fe64664e55dcb29; i=PALtmrbA7QkmXrXcpfM46QoGaA1mIVejaurYGuKYKo8=; m=3hqOsFdiMQcNDUxhvpqgKs5YrZM13Cs9hPxopbXCKYg=; p=BJHnadUHWUYcvHacF23OIMxXn3NG2MSYsF/ScRDBebA=
X-Patch-Sig: m=pgp; i=keescook@chromium.org; s=0x0x8972F4DFDC6DC026; b=iQIzBAABCgAdFiEEpcP2jyKd1g9yPm4TiXL039xtwCYFAmCvEisACgkQiXL039xtwCaz3Q/8CmB g7jGmUsnWFX0K/gyget7x9xeVWr+t7XfkDFgRKv9AxgzrYwJD8Xr1dGBCKNVNGhVqS3lKCRXAr+d/ IKTvXMlio2g/Uy4yMjCAX9HuARA/zwXNCUhCnaFtNKHCcAwXCPuqo72Sw5GJcPY3A44coxYsUfnyE 0Nfh1pFW1fL9g8I2KwW6yasvhAhwbTd4Gn+dktvMCh9a1kzABmFfGKy78shAh3g9PUnVaQnJmhg3R Pdo4DHOu+MxpGLnPGFrRc59tFzcg8Ol4rrMWMlaqOcxtubuqRs12VNFmiZxWgjiAyTTr9mMDmgNDl oRCuuCNpUL5hLeyoP7qzJ7BIpC8sUW/XLuDFEm7iyZGU26F9WFPl/C3PP1FPoh0/cWe/ghrppl2rI HhtybP/HeujA/jG5yL1P1JYix3Ww4F8wC+Yjaw8uLx20qMKeevzpC1jJb8Nwwvh8Bbveh2vvw/+DC W5vSA+nr5BlxecUHdiEj2OCZPq3WYuRVVDePERpyB2Dj21AYU8bJBxGHoFbpDRZq8NqB5e5FgHEJK kPU+lGO0sLmz4fFix8L8Hh59RGAHHzmtzBVVHt/vBwsrX8O5Z82KygelBXE0a0f8TgbfWsNtunw7X YzCchxJBzeMdAN5bRtF8/MyvWDJZMlUkTF4gvHlqN01S4gl51PktqBBPN6R/9C3g=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the open fds might not always start at "4" (especially when
running under kselftest, etc), start counting from the first assigned
fd, rather than using the more permissive EXPECT_GE(fd, 0).

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index e2ba7adc2694..03b37e660965 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -3954,7 +3954,7 @@ TEST(user_notification_addfd)
 {
 	pid_t pid;
 	long ret;
-	int status, listener, memfd, fd;
+	int status, listener, memfd, fd, nextfd;
 	struct seccomp_notif_addfd addfd = {};
 	struct seccomp_notif_addfd_small small = {};
 	struct seccomp_notif_addfd_big big = {};
@@ -3963,18 +3963,21 @@ TEST(user_notification_addfd)
 	/* 100 ms */
 	struct timespec delay = { .tv_nsec = 100000000 };
 
+	/* There may be arbitrary already-open fds at test start. */
 	memfd = memfd_create("test", 0);
 	ASSERT_GE(memfd, 0);
+	nextfd = memfd + 1;
 
 	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
 	ASSERT_EQ(0, ret) {
 		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
 	}
 
+	/* fd: 4 */
 	/* Check that the basic notification machinery works */
 	listener = user_notif_syscall(__NR_getppid,
 				      SECCOMP_FILTER_FLAG_NEW_LISTENER);
-	ASSERT_GE(listener, 0);
+	ASSERT_EQ(listener, nextfd++);
 
 	pid = fork();
 	ASSERT_GE(pid, 0);
@@ -4029,14 +4032,14 @@ TEST(user_notification_addfd)
 
 	/* Verify we can set an arbitrary remote fd */
 	fd = ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd);
-	EXPECT_GE(fd, 0);
+	EXPECT_EQ(fd, nextfd++);
 	EXPECT_EQ(filecmp(getpid(), pid, memfd, fd), 0);
 
 	/* Verify we can set an arbitrary remote fd with large size */
 	memset(&big, 0x0, sizeof(big));
 	big.addfd = addfd;
 	fd = ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD_BIG, &big);
-	EXPECT_GE(fd, 0);
+	EXPECT_EQ(fd, nextfd++);
 
 	/* Verify we can set a specific remote fd */
 	addfd.newfd = 42;
@@ -4070,9 +4073,11 @@ TEST(user_notification_addfd)
 	addfd.newfd = 0;
 	addfd.flags = SECCOMP_ADDFD_FLAG_SEND;
 	fd = ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd);
-
-	/* Child has fds 0-6 and 42 used, we expect the lower fd available: 7 */
-	EXPECT_EQ(fd, 7);
+	/*
+	 * Child has earlier "low" fds and now 42, so we expect the next
+	 * lowest available fd to be assigned here.
+	 */
+	EXPECT_EQ(fd, nextfd++);
 	EXPECT_EQ(filecmp(getpid(), pid, memfd, fd), 0);
 
 	/*
-- 
2.25.1

