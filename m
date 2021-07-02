Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 576913B9BB4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 06:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbhGBE5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 00:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233691AbhGBE5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 00:57:50 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2370C061764
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 21:55:18 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id 61-20020aed21430000b029024e7e455d67so4866319qtc.16
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 21:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=r2Kq6aGqAuq4Pv1SlGhd10LnvnYS6xXKFusVet9luSw=;
        b=JfAxOM3uFhUKSQ+6IHdpuH1wCPcfMx7QAM5TmlyH9yNnFf7nHDROzrQZE0Tp5G0FXM
         gZ0E0cvA84Glaovbt4ER/tvR/eiPtxxqm4vzQ2rLpGfeeuOSLxpusNhdGJSh0VHCqM9w
         /Thyv6X48Jkpk+GqV3rnJoAnomd+a27SqEJUTiPwYbD30dooKFGvgTvbN+XIHZ6MPWOO
         nCTLokvjBCE5wUIZG6Tk8kNaywDnJ/7UWvRIFV44wRjcsbU6aXaeAwaLa2W1fn0QE4uc
         0I6OZn6sGZRa8V0W58b89ca7EHct0MPCrvMeBHdwahUdn09+pykAJX91hza4+D0eo5Zc
         65Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=r2Kq6aGqAuq4Pv1SlGhd10LnvnYS6xXKFusVet9luSw=;
        b=gKIeMyoI9dfEwA2HuK8HFt7855OsjHJjomt4stK/ZDdu5YC3aa2txlRYojWQ6fEkzg
         yz56hz1Dg1sdvMijQJki2hrnGHdvQMskFjF6fyD0Pm2TYGLJ6+7cFxG4Li+YYS9cQq4w
         FJqsbPuRj2piijEnE2MumUUSM6StqCSxLw6UF3E8rPcr0kJL5gXngI95Q0m/6tI0bNx/
         EAOtJ9rvX3QrsRTxJWPfdgosptiPMHVvdnBE2+MQC1WlhCVoBaAiZ2d8FwfGjaB4kk4v
         uXh0BiMcgeHevlecd/YweEqOI8DRggnSPO/oKK7yCyBz6n619nW3cH6WcJJzQH9enqFW
         dRUQ==
X-Gm-Message-State: AOAM531XjfMpYEu9g4bCGjdQ044Uf7/JLBPTwmoxJEkH+bownN6MR8Jy
        cTYAWnUWY1mMqGcMhdF30qaF5qVjJ1GL
X-Google-Smtp-Source: ABdhPJyabafndSiPzXuzqRurfZ+C7hfuGXB2Gz7DP8fpH4wfzuldifH3K52owDZeo9bYaOMrRVSvK7PvuilC
X-Received: from gthelen2.svl.corp.google.com ([2620:15c:2cd:202:81c6:dd12:da9f:dd72])
 (user=gthelen job=sendgmr) by 2002:a05:6214:d49:: with SMTP id
 9mr3502901qvr.30.1625201717833; Thu, 01 Jul 2021 21:55:17 -0700 (PDT)
Date:   Thu,  1 Jul 2021 21:55:09 -0700
Message-Id: <20210702045509.1517643-1-gthelen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH] selftests/memfd: remove unused variable
From:   Greg Thelen <gthelen@google.com>
To:     Shuah Khan <shuah@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 544029862cbb ("selftests/memfd: add tests for F_SEAL_FUTURE_WRITE
seal") added an unused variable to mfd_assert_reopen_fd().

Delete the unused variable.

Fixes: 544029862cbb ("selftests/memfd: add tests for F_SEAL_FUTURE_WRITE seal")
Signed-off-by: Greg Thelen <gthelen@google.com>
---
 tools/testing/selftests/memfd/memfd_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index 74baab83fec3..192a2899bae8 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -56,7 +56,7 @@ static int mfd_assert_new(const char *name, loff_t sz, unsigned int flags)
 
 static int mfd_assert_reopen_fd(int fd_in)
 {
-	int r, fd;
+	int fd;
 	char path[100];
 
 	sprintf(path, "/proc/self/fd/%d", fd_in);
-- 
2.32.0.93.g670b81a890-goog

