Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E596D370269
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 22:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236002AbhD3Uug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 16:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbhD3Uug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 16:50:36 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F02C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 13:49:45 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id x27so35148835qvd.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 13:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kzMcg0H4Ti3qN2qd0lkLHgOrmzJ5Bpqu38goX6MXEPc=;
        b=P5MfRrpnRYvIRyuPilC6J6+aHDkJA6ylxSNBLp+fGyYZgSIllWFqWTOFyX8h19DnJT
         lfhcS/FLCKltizJjkg/dyYnObCBXR8fSY6zlg0R0APfb2+i9NdKRbsvSh89PjIC2IHvK
         lqy9pCmAyDqmRBt+yxlGOSyL5Tmf24TNs4zaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kzMcg0H4Ti3qN2qd0lkLHgOrmzJ5Bpqu38goX6MXEPc=;
        b=e0pbI2Pca1lgUyH7XYKIi46fu8yeWg9Oo1TDxCwOYSuo13qkyYoG//3kjw8Cu8pAOR
         DLCldYDujUgsdBZq+WE9P1zgOwebmjTs3EGDn0HR3BBhaYBZeyoP5dJzSP2wg6rwExP8
         IWFBlMjDL+VkHS/ieXWpgDSJK6YXsZrS8kUrf6D7CnYWqCGBFYMHcyPS/jWT51UD6FVe
         FnpgBWtj4PYkBDlMuujCaSHCO2KuaEGBOchP3rxPq5A5yXq83AdruvDImDgkx3dpxJc7
         jpgPNyt+t7fLIpVdG+S4LlUVPAlffaq2JTqimbuQPKgFkyhCgV0/48oNO17EIQ91hwQP
         Dqiw==
X-Gm-Message-State: AOAM5333F2EsZqZnf7T8gbzjsch8yikddfv8X96xm/GyfrmDoTt0i8tC
        e4jPSl3nkWdlBTSjhcdgG0j/IyrfiSqeei8re70=
X-Google-Smtp-Source: ABdhPJzn7AeJ6ME302gS2sD5Ybn4x5HENWIFhTmfZzeYNLmYbnY7LeKn1P5OemsulHSsoDXUfZcz6w==
X-Received: by 2002:a0c:ebc9:: with SMTP id k9mr7342669qvq.32.1619815784502;
        Fri, 30 Apr 2021 13:49:44 -0700 (PDT)
Received: from ubuntu.netflix.com (136-25-20-203.cab.webpass.net. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id z17sm3161960qtf.10.2021.04.30.13.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 13:49:43 -0700 (PDT)
From:   Sargun Dhillon <sargun@sargun.me>
To:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        =?UTF-8?q?Mauricio=20V=C3=A1squez=20Bernal?= <mauricio@kinvolk.io>,
        Rodrigo Campos <rodrigo@kinvolk.io>,
        Tycho Andersen <tycho@tycho.pizza>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 0/5] Handle seccomp notification preemption
Date:   Fri, 30 Apr 2021 13:49:34 -0700
Message-Id: <20210430204939.5152-1-sargun@sargun.me>
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

Changes since v1:
  * Change from a flag, to an ioctl that explicitly sets the killable
    state after reading the notification.
  * Adds some more tests to make sure that fatal signals are handled.

Changes since RFC[1]:
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

 .../userspace-api/seccomp_filter.rst          |  22 +-
 include/uapi/linux/seccomp.h                  |   3 +
 kernel/seccomp.c                              | 146 ++++++++++++--
 tools/testing/selftests/seccomp/seccomp_bpf.c | 190 ++++++++++++++++++
 4 files changed, 335 insertions(+), 26 deletions(-)

-- 
2.25.1

