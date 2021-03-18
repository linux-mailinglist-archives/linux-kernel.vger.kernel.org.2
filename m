Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B61133FEDC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 06:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbhCRFSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 01:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbhCRFRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 01:17:31 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A8AC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 22:17:31 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id 130so855342qkh.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 22:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dvne1Wiq64R4j+AonMhFQvYnH0536sN6z3oij4WU7oI=;
        b=Wv9Qy0m79eqdXXNb99OPYp3knuzP3vlYrqyZH2lWV99OKteCqgDTDNnU/7K43qyBdO
         KF9fhH9pxfRkDZo0hA6Gc5am7fZe+11ujWvYAp7t/gZ11FKR/HSc8rJtclH/0RtrpWjR
         kxbaBxy1h2Wd8cRjbo5IB222iSWBjxDEiPi6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dvne1Wiq64R4j+AonMhFQvYnH0536sN6z3oij4WU7oI=;
        b=ILC0P022XViRaEq0g2Tk+GrGu9snhPDze841iL+d7Tuzf1OJzsPUkLQ/QKstyTDwCm
         tB50oGmCi1mF4ishUgPcOQ3mN1JyWaFr9O34WCfZ9JX4JJGfjYU/JDwNVYFB4Pw4Vj4A
         amZ0GeqPUvqX8rOG+1rtVWri6bAePywGwVtEYlcgM3oFvrV5XYlBgfyyi3H8uKeOZb5v
         rxj9iF7nENpGm1pRKtcwkCHyc7SzJOajkDP11eHIgZaGc3QK/2I7Ah2Zh5W0FQABMjoQ
         uzFkbPK+ameBWZ5OFBADTmgk3Fum4EBNlCYtwNdlUXt0lcylKN3FRdLM0lM58qMWgUMQ
         lQUw==
X-Gm-Message-State: AOAM532YvEwi8Qvu1BOjBNu+fEx/w6YZ9JX/6XDnVglDxpsvAKkzWxNR
        rUR2ag9VSuLQWQO4xV98kRZaNQ==
X-Google-Smtp-Source: ABdhPJwvwdEKQdlPPCftOKm0+XTbgHo3ayldENMXKWFLwwovmsAqCdH1lOlHJKQS1jSs6gayw3cdXw==
X-Received: by 2002:ae9:e005:: with SMTP id m5mr2649605qkk.61.1616044650180;
        Wed, 17 Mar 2021 22:17:30 -0700 (PDT)
Received: from ubuntu.netflix.com (136-25-20-203.cab.webpass.net. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id f8sm1032345qkk.23.2021.03.17.22.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 22:17:29 -0700 (PDT)
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
Date:   Wed, 17 Mar 2021 22:17:21 -0700
Message-Id: <20210318051726.2488-1-sargun@sargun.me>
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

