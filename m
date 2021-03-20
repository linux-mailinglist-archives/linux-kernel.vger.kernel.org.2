Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64A0C342DD6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 16:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhCTPiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 11:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhCTPil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 11:38:41 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDFCC061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 08:38:41 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id o2so4362042plg.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 08:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LiWBiutEzHZpuPBq9uETfF28MNV9/guoTvL4IvciDO8=;
        b=SYbOAxT1ly1Ah0IboGGB/F1AtqqKBgS32+flAGu3xorlNvtNwZa6Ma1q30iN4yjJeX
         z7BO0afIYzd1YCQ+Emy6r6vXzx5DMG5CIOuGirTZykC0TMCw9hX0sA2aZet5kOhL6xZx
         b6/lLUfGDQR4EzbpEzhDWjAot7T3/sAw8qPupjnawR/GED6YJ3q/RYYSL6FTUsVTBjZd
         bWHj5NcDp2v6zKAyfnCyB0l1fnNGWARHCeyV/Vslk/sIMSuDZpRuwC1IOLm7VhL/RNDd
         0NqmpcSvITDHaBY05c0C5fSjmpJoUmdoI2LUbrFoEy18AFBTvXyAVkhL0X9SETY3AHEc
         FO1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LiWBiutEzHZpuPBq9uETfF28MNV9/guoTvL4IvciDO8=;
        b=CS9p1dlb9B60awJGgqcXnUH1C9tcKYEsKRGJaNosZmJI0t6FAsyf9QbIgtADrfyEi+
         DP/mPzcA6Aj1K+pOHNRdaPo+B8KfmEAOLQiloZzjkAGAQ+yVWUKU/tc/9YvwuHc8Mkvj
         PMavsf6ZQuuHUDy9ycbe4ZGxklI3ebMAZvgqaYpfantsF4FESX1IjE+aOamDBMd/acue
         Lpz8xhzefAOYI16wqrf5YEKM+AOi1ptnGwvDG7poIrUccIVENSJoEyd0uZpEp06q/4z/
         QhnIVk/Di9d4Jrqr8NrBcWXgekaKStAGffl18PviOfSXrmKGl+IyiM2Drw6bUq8hSn0t
         MPmw==
X-Gm-Message-State: AOAM532dH9r9HhVj/ToEoouOQ5YjIA7KGLdqs1LIJOcZ9rZTsKOey49+
        oHumtnYb+PtdL0W1SHf6fkv7LQ==
X-Google-Smtp-Source: ABdhPJwGN92UbBSXE9WuCydfYARwv4uZ/Ya2yJvBBfUokhMeamR2YNMehKC4U4M3jlAZIqh5XXrg8g==
X-Received: by 2002:a17:90a:bb91:: with SMTP id v17mr4053318pjr.24.1616254720897;
        Sat, 20 Mar 2021 08:38:40 -0700 (PDT)
Received: from localhost.localdomain ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id 2sm8658753pfi.116.2021.03.20.08.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 08:38:40 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org, oleg@redhat.com,
        Jens Axboe <axboe@kernel.dk>,
        Stefan Metzmacher <metze@samba.org>
Subject: [PATCH 1/2] signal: don't allow sending any signals to PF_IO_WORKER threads
Date:   Sat, 20 Mar 2021 09:38:31 -0600
Message-Id: <20210320153832.1033687-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210320153832.1033687-1-axboe@kernel.dk>
References: <20210320153832.1033687-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They don't take signals individually, and even if they share signals with
the parent task, don't allow them to be delivered through the worker
thread.

Reported-by: Stefan Metzmacher <metze@samba.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 kernel/signal.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/signal.c b/kernel/signal.c
index ba4d1ef39a9e..730ecd3d6faf 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -833,6 +833,9 @@ static int check_kill_permission(int sig, struct kernel_siginfo *info,
 
 	if (!valid_signal(sig))
 		return -EINVAL;
+	/* PF_IO_WORKER threads don't take any signals */
+	if (t->flags & PF_IO_WORKER)
+		return -EPERM;
 
 	if (!si_fromuser(info))
 		return 0;
-- 
2.31.0

