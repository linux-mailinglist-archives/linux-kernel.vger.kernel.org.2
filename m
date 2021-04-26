Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCDDD36B8BA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 20:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbhDZSG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 14:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbhDZSG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:06:56 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E004FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 11:06:14 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id h20so29378519plr.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 11:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=crrXl04Pmuu3hnq0cq7H9ljH1hJvjphFD3Ivc9bSiG0=;
        b=KkujWiFEtrvDAwAIA9yFog0WvpXFYbxTqf2G6PUO4jUn/BaScPI3Tya5PV1L/3Cphv
         X1quUztMcdUAqr1aNZoIlFF8shCRsL5iSXKoT8rL4PBYQhGnkwuUnww3FRvMfW4iIBNf
         yqRb+3jdPBjRhm2gSJJjyoJKi8vUJjO8Jgrn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=crrXl04Pmuu3hnq0cq7H9ljH1hJvjphFD3Ivc9bSiG0=;
        b=luZeH2JXkmcCn0rdhZ7viNkkl8uxbISWXc8xkd7fX5ZmUMuDogo/OWAgh6cBv9VKt1
         FPeNJXAolDVtJCnpKTeToferhLybyTcz9cKkja4XZFNUY3z7Ny4RwmL4jXtqJSHCS3UR
         j5tOsIzllD3q29oGQz83M19gLj5EkBPknmSMuDkJPCJGds79xfnOvYrKPwz4Y6Z/dkPv
         vhAqS7T1wNK/cnSsGEg5CzGB3xoOG2xXOZqQ0BmSOyU+VqTjyTDB3vo7Y8pT+4GNtITE
         H6rawZaFaCOsX9hKd9BA+9HdfS+5l9m2V8Tx04XEVoOUPXHuIugYpASKLkZhgAMrwzcw
         EM9A==
X-Gm-Message-State: AOAM530dbitGrv/vKzLycHMmTQt5TU+ZaWGZ7Ffe2SK8mf3YxfY+6FRC
        501zzys2Bcwu1b2LYLYSEP0Uqg==
X-Google-Smtp-Source: ABdhPJy/Na1du6oypewjuRbextqXDjv9/n/HngVaKUqVIV9ZTBLt/a/dxAeeBWwA43q5YE2/pPc8cg==
X-Received: by 2002:a17:90b:3754:: with SMTP id ne20mr4999359pjb.39.1619460374084;
        Mon, 26 Apr 2021 11:06:14 -0700 (PDT)
Received: from ubuntu.netflix.com (136-25-20-203.cab.webpass.net. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id j7sm326835pfd.129.2021.04.26.11.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 11:06:13 -0700 (PDT)
From:   Sargun Dhillon <sargun@sargun.me>
To:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Rodrigo Campos <rodrigo@kinvolk.io>,
        Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        =?UTF-8?q?Mauricio=20V=C3=A1squez=20Bernal?= <mauricio@kinvolk.io>,
        Tycho Andersen <tycho@tycho.pizza>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Alban Crequy <alban@kinvolk.io>
Subject: [PATCH RESEND 0/5] Handle seccomp notification preemption
Date:   Mon, 26 Apr 2021 11:06:05 -0700
Message-Id: <20210426180610.2363-1-sargun@sargun.me>
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

I'm resending after rebasing and testing on v5.12. It turns out this change
also fixed a bug Rodrigo found that could occur with addfd around certain
race conditions[2].

It also follows up on the original proposal from Tycho[3] to allow
for adding an FD and returning that value atomically.

Changes since v1[1]:
 * Fix some documentation
 * Add Rata's patches to allow for direct return from addfd

[1]: https://lore.kernel.org/lkml/20210220090502.7202-1-sargun@sargun.me/
[2]: https://lore.kernel.org/lkml/20210413160151.3301-1-rodrigo@kinvolk.io/
[3]: https://lore.kernel.org/lkml/202012011322.26DCBC64F2@keescook/


Rodrigo Campos (2):
  seccomp: Support atomic "addfd + send reply"
  selftests/seccomp: Add test for atomic addfd+send

Sargun Dhillon (3):
  seccomp: Refactor notification handler to prepare for new semantics
  seccomp: Add wait_killable semantic to seccomp user notifier
  selftests/seccomp: Add test for wait killable notifier

 .../userspace-api/seccomp_filter.rst          |  15 +-
 include/uapi/linux/seccomp.h                  |   4 +
 kernel/seccomp.c                              | 129 ++++++++++++++----
 tools/testing/selftests/seccomp/seccomp_bpf.c | 102 ++++++++++++++
 4 files changed, 220 insertions(+), 30 deletions(-)


base-commit: 9f4ad9e425a1d3b6a34617b8ea226d56a119a717
-- 
2.25.1

