Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA54B34ABE7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 16:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbhCZPwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 11:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbhCZPwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 11:52:06 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC034C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 08:52:05 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id u2so5433491ilk.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 08:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hMymc1XEJnHboewJHBELgaGAh0vm6Ei5t+AwJJuno7Y=;
        b=PWMIzL4AReCIo7P6ZLE4Puv968iq2t+WZ9f03chcHWKV2bOEOm8cnJUcLmm8kzZqz+
         RJJknnGQ6dJFVKU2z6KD8HU3vEE0UrcFBx1gZcMB6rMFhdw9wb1/Qr8RamYQrtEuiqsg
         a4LoPm/eZ7u1XZ2md5ozJJV6/kge6wQQJD8IqynIbm3vG+Cu5KN6k695psVZtVaEbDzU
         8QW9ZaXq+uggqOJoLvmRHZoyBYis1B7JwL6VKxVoEZ/sWlM9EEGGg0YHGJajz8vQLFhI
         jzPN94wQPazNHVh2aQ5spQO6RfJDgS1+9NeO1py8N0RhCKMr6/2k9XB9+D2YRG8v9zF9
         B/HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hMymc1XEJnHboewJHBELgaGAh0vm6Ei5t+AwJJuno7Y=;
        b=QZqxDDm2qXp9CaFd7raLxzIZFt+Vm1eOSIVGcEZErdFJJAkfx1iLS4gxH1GE2mi2vF
         ipRX9O25O6b7cufCDBQUQ5AS0fXQtSrulQgsFkNOEOlSCC4/ywL0xGpeDhekHRqSn7vt
         VvciLbFEE60bMULjUeKpr89Wr+I8L8OjjX7iY1gUowHQN8k7maBRTs1p0rnKMnpxJ211
         RVI8/Pwpal9uQKSayT8XCpwgbF62QQvNXASmLgEqT7j62QjP4bivT/a7tCe+jLpdQAs9
         jrq0a71W6hi1OB9j3+AvpUMBGMVKyVffDZEsw6kpb8r2A5WkzmuC/8ML7nEBJ7OwOtCV
         c6PA==
X-Gm-Message-State: AOAM532BFT/qq5gp8hE9HB7UvCesbBTWbCuduzN1GIMn7PlAHPMsR7GB
        Kz+d/6jRVMv0nhFZO70yIetadg==
X-Google-Smtp-Source: ABdhPJwKRPA+P4hY5sdmIqs505YO+U1mCaz3WcrQ2M6OLnhntwgJA4iotDi5JroibR4I5azV3MY1hw==
X-Received: by 2002:a05:6e02:1848:: with SMTP id b8mr11225378ilv.122.1616773925443;
        Fri, 26 Mar 2021 08:52:05 -0700 (PDT)
Received: from p1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id a7sm4456337ilj.64.2021.03.26.08.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 08:52:05 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     torvalds@linux-foundation.org, ebiederm@xmission.com,
        metze@samba.org, oleg@redhat.com, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 03/10] Revert "signal: don't allow sending any signals to PF_IO_WORKER threads"
Date:   Fri, 26 Mar 2021 09:51:16 -0600
Message-Id: <20210326155128.1057078-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210326155128.1057078-1-axboe@kernel.dk>
References: <20210326155128.1057078-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 5be28c8f85ce99ed2d329d2ad8bdd18ea19473a5.

IO threads now take signals just fine, so there's no reason to limit them
specifically. Revert the change that prevented that from happening.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 kernel/signal.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index e3e1b8fbfe8a..af890479921a 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -834,9 +834,6 @@ static int check_kill_permission(int sig, struct kernel_siginfo *info,
 
 	if (!valid_signal(sig))
 		return -EINVAL;
-	/* PF_IO_WORKER threads don't take any signals */
-	if (t->flags & PF_IO_WORKER)
-		return -ESRCH;
 
 	if (!si_fromuser(info))
 		return 0;
-- 
2.31.0

