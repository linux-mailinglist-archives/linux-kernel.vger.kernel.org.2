Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6102D33FED8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 06:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhCRFSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 01:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbhCRFRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 01:17:38 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE99C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 22:17:38 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id f12so3232339qtq.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 22:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dvne1Wiq64R4j+AonMhFQvYnH0536sN6z3oij4WU7oI=;
        b=BoUqbf3cZLg3qFUwWWqEUwJVuQOHaZQ7m0KpH72xR4G9zVv6ZTGyXH/5BAO5o/PNx4
         ujzaI6M7W0Ro92j3FgNhqeqKpgu9IKTEzLYeb6owKJxDs1hAw1pYiVAzOUG4acdrS6dq
         GK3pZumXBKM72LJ+iA54H6g8QJo3yKkXDVI7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dvne1Wiq64R4j+AonMhFQvYnH0536sN6z3oij4WU7oI=;
        b=s9MnqCpet2wuJS9QfhREUUzKHspIUyG2rvAMVfTgCBwZ56GZZrR5rVLToGd4MPXFMc
         ND6nuV8AyZJ0J/VaHU/43/1rpxQ6Q+boA2GHvuB/SmXYoBAsHNKMZaZvj3ZbsgbYTyBY
         YzlxafYMwzKtVksfQr3RcO0qXiaKjjBt+aQvLpfV1kylNBjQKxSS19U+BPkHI/oaqhqx
         3pZCbgEDx7XH5nQl4rpJO37JbJ0cIJcNbPhn0CkMUCvtvIIn0271IVyO4ufwoYA32wlz
         +wDh/LVwrCWeekr833doyR8nMMvLi8NAY9vUWLxUxXRVyVZJYChlnv60+q1YS7sZNXXP
         NgyQ==
X-Gm-Message-State: AOAM531CMqPTyCuYjJe2ic3+jmIsmDvx0Hy58b7q4RIJXFJm7vh+aJSS
        TaxjF74lUSzIG2aJHoMMkJWfnzTfcvbwkJ7y
X-Google-Smtp-Source: ABdhPJwytlGS/bDJZFsU53lfvc4ZqkgTL2PoYKatFygd5a8aIbB0TnGDRoS71WcXBoF7akK9D6rtnQ==
X-Received: by 2002:ac8:3a42:: with SMTP id w60mr2244046qte.307.1616044657380;
        Wed, 17 Mar 2021 22:17:37 -0700 (PDT)
Received: from ubuntu.netflix.com (136-25-20-203.cab.webpass.net. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id m16sm937852qkm.100.2021.03.17.22.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 22:17:36 -0700 (PDT)
From:   Sargun Dhillon <sargun@sargun.me>
To:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        =?UTF-8?q?Mauricio=20V=C3=A1squez=20Bernal?= <mauricio@kinvolk.io>,
        Rodrigo Campos <rodrigo@kinvolk.io>,
        Tycho Andersen <tycho@tycho.pizza>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 0/5] Handle seccomp notification preemption
Date:   Wed, 17 Mar 2021 22:17:28 -0700
Message-Id: <20210318051733.2544-1-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This patchset addresses a race condition we've dealt with recently with
seccomp. Specifically programs interrupting syscalls while they're in
progress. This was exacerbated by Golang's recent adoption of "async
preemption", in which they try to interrupt any syscall that's been
running for more than 10ms during GC. During certain syscalls, it's
non-trivial to write them in a reetrant manner in userspace (mount).

This has a couple semantic changes, and relaxes a check on seccomp_data, and
changes the semantics with ordering of how addfd and notification replies
in the supervisor are handled.

It also follows up on the original proposal from Tycho[2] to allow
for adding an FD and returning that value atomically.

Changes since v1[1]:
 * Fix some documentation
 * Add Rata's patches to allow for direct return from addfd

[1]: https://lore.kernel.org/lkml/20210220090502.7202-1-sargun@sargun.me/
[2]: https://lore.kernel.org/lkml/202012011322.26DCBC64F2@keescook/

Rodrigo Campos (1):
  seccomp: Support atomic "addfd + send reply"

Sargun Dhillon (4):
  seccomp: Refactor notification handler to prepare for new semantics
  seccomp: Add wait_killable semantic to seccomp user notifier
  selftests/seccomp: Add test for wait killable notifier
  selftests/seccomp: Add test for atomic addfd+send

 .../userspace-api/seccomp_filter.rst          |  15 +-
 include/uapi/linux/seccomp.h                  |   4 +
 kernel/seccomp.c                              | 129 ++++++++++++++----
 tools/testing/selftests/seccomp/seccomp_bpf.c | 102 ++++++++++++++
 4 files changed, 220 insertions(+), 30 deletions(-)

-- 
2.25.1

