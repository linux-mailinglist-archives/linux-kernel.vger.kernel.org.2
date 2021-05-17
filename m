Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3D20383D99
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 21:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbhEQTkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 15:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234485AbhEQTkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 15:40:39 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB4FC061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 12:39:22 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id pf4-20020a17090b1d84b029015ccffe0f2eso229324pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 12:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z1mz9PlfYEOhntUBF4HuAgZ54MFnxLx8NEndufo+JXI=;
        b=nDlzVHCmeHw1qXb4ontaMW5zMt/9+gZdA4vt7JBNS8rurtKIRqdSGaWbmrcold0Dlx
         OvnXWKU/ZuZvEAmPd7KO2DbW3dPd54mxnNqakVfV7lushgPihuX81cyqvYkr2atg89sf
         Xg3B6Fv8v1cuwj3jocwekApC9VjDaLKIghgpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z1mz9PlfYEOhntUBF4HuAgZ54MFnxLx8NEndufo+JXI=;
        b=fdy7+4PFOsJ4EOVDP2+fcZJnLaObc3dGTSZT15nmsR96uUjrM2s3+mI2XXkSwPBF5M
         wj3/4G+tXbCCD2NRUebweW+DmTCZOiZU64x+xOvKS5s9pmvhc5U4ip/GABG8EmRtkc0d
         /+9n27WgLYtuTGttccvnVfoB5n2cYZ621XYa/9xJjmq0qT9Ja5adQRDYgIVIfnzCdOQW
         eWT/mj5ZhWp7mL4LgcB1Ez1wc+RXCOWUx0LiDVduNo3sT9Qk2OeGL2lT1aktawW7Y4Nc
         KO/6M97g7k+kb65avx8DOv1bn+IvtZyNXWJGDGGzg0KK2fKSY9vd7VyD1iDoBDzktE+e
         Jskw==
X-Gm-Message-State: AOAM532Wfxs21P61pgvn/yvyuXBktpLM4GcGkwyUW/9KZa/Z+PH6+O/T
        9vaHLoAynae5L7RPpGegha52BA==
X-Google-Smtp-Source: ABdhPJw7M3mVzYORwM+TIxIL9dcKP+j6c3DnN1b+J626B6lAgwKaLR3+ZGneR0r6evspU9rFdgiCJA==
X-Received: by 2002:a17:90a:df8d:: with SMTP id p13mr731355pjv.67.1621280361506;
        Mon, 17 May 2021 12:39:21 -0700 (PDT)
Received: from ubuntu.netflix.com (136-25-20-203.cab.webpass.net. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id r11sm11132110pgl.34.2021.05.17.12.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 12:39:20 -0700 (PDT)
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
Subject: [PATCH v2 0/4] Atomic addfd send and reply
Date:   Mon, 17 May 2021 12:39:04 -0700
Message-Id: <20210517193908.3113-1-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is somewhat of a respin of "Handle seccomp notification preemption"
but without the controversial parts.


This patchset addresses a race condition we've dealt with recently with
seccomp. Specifically programs interrupting syscalls while they're in
progress. This was exacerbated by Golang's recent adoption of "async
preemption", in which they try to interrupt any syscall that's been running
for more than 10ms during GC. During certain syscalls, it's non-trivial to
write them in a reetrant manner in userspace (socket).

It focuses on one use cases, which is adding file descriptors to a process
"atomically" during the seccomp reply, as opposed to discretizing the calls
which may result in a potential file descriptor leak and inconsistent
program state.

Changes since v1:
 * Clarifcation to commit comments

Rodrigo Campos (2):
  seccomp: Support atomic "addfd + send reply"
  selftests/seccomp: Add test for atomic addfd+send

Sargun Dhillon (2):
  Documentation: seccomp: Fix user notification documentation
  seccomp: Refactor notification handler to prepare for new semantics

 .../userspace-api/seccomp_filter.rst          | 28 +++++--
 include/uapi/linux/seccomp.h                  |  1 +
 kernel/seccomp.c                              | 79 ++++++++++++++-----
 tools/testing/selftests/seccomp/seccomp_bpf.c | 38 +++++++++
 4 files changed, 120 insertions(+), 26 deletions(-)

-- 
2.25.1

