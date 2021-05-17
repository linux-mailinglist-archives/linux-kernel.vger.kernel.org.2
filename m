Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61DE03829AF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 12:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236406AbhEQKTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 06:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236389AbhEQKTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 06:19:39 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA1ECC061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 03:18:22 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id y14so3674379wrm.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 03:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FKmSCYeCXTCXzAXQgef1f6UgmeL+ryki0BoEgbsQMUQ=;
        b=pb0bu+XiWB6Yw3CJMMdq5zLMLVmF9E5jPUk09t37+totw+UfkDwpxK5REefEO5Y1vM
         7bBCltGnQiEOgRF9G5ENi/PgT6ugBajw7KCcNIu5CqpBeSHyZtv/0CCogxCfgUEbs1kn
         rt4DjlwNajwzNBM27XICOYzpiqwegfeOBpnh0APdu7z1TNBEk8QTF0eYPb+cBAbZ5Hch
         ZYFN0NLUdd3KBV6lc+OZgldBezhVPPPCMJHl/ung477+iB+7qKcA5dWaUB1lgCjPrdfr
         BcBqpaKcbtdiCRLgAyACDBYFC+TJC+aQloS273DSjsvvI/3qnk7rVAKg/P+MEPBw3Gn0
         fQMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FKmSCYeCXTCXzAXQgef1f6UgmeL+ryki0BoEgbsQMUQ=;
        b=AR1AE6Saa+S0/JGTC2D74CwcRnZg3mUGv8pCvWJnp3hVPEfPpVLdmm5S49cRP2ZpRK
         zq/6r/cLQKZ0Dz75Vz65QvG7sJnUkCbVHuGhHAKguWE4nB6wwyz1+01Un/B8yJ2FjxAG
         6gXa9attjv69Vw2ShlvZBXqMF5KSEQsEWKXwNFTabpVpEUnz0nXOVK4VDbPopK7oJQ4E
         oL5mffuLRDFB8UZevDzXBAx1ZYsYyq6OlxaMgRwIVRZFeEUHx5MPPu/iFYxlAswY85Yi
         AySn1mGhWlByMsx3nnYW9BPs4YIjYkh9RetjFXXUfTKS0BqOr3x/OPlSXJ/PauygMZrt
         gEAA==
X-Gm-Message-State: AOAM530erOMciEtsY/pAL0ualcmbOcMHHX6pDDJjHJXfAQPX9RTA+3Gt
        yPdt3b4W2rz4fKC88gY2PDhnZPebQDU1XA==
X-Google-Smtp-Source: ABdhPJw8QLaXHvbMKpLlmXMyGamqF7qSojzEuXk64f4adSeFh3zv8w+OVXvFk6XyQxfNLGYf6f0A4Q==
X-Received: by 2002:adf:de09:: with SMTP id b9mr31592825wrm.340.1621246701324;
        Mon, 17 May 2021 03:18:21 -0700 (PDT)
Received: from agony.thefacebook.com ([2620:10d:c093:600::2:94b7])
        by smtp.gmail.com with ESMTPSA id a19sm11528244wmb.40.2021.05.17.03.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 03:18:20 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] signal: optimise signal_pending()
Date:   Mon, 17 May 2021 11:18:07 +0100
Message-Id: <a068c25c4c08aa8dbc1141a77614711f80f74b65.1621245687.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Optimise signal_pending() by checking both TIF_SIGPENDING and
TIF_NOTIFY_SIGNAL at once. Saves quite a bit of generated instructions,
e.g. sheds 240B from io_uring alone, some including ones in hot paths.

   text    data     bss     dec     hex filename
  84087   12414       8   96509   178fd ./fs/io_uring.o
  83847   12414       8   96269   1780d ./fs/io_uring.o

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---

Suggestions on how to make it less disruptive to abstractions are most
welcome, as even the one below fails to generated anything sane because
of test_bit()

return unlikely(test_ti_thread_flag(ti, TIF_SIGPENDING) |
		test_ti_thread_flag(ti, TIF_SIGPENDING));

 include/linux/sched/signal.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 3f6a0fcaa10c..97e1963a13fc 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -361,14 +361,14 @@ static inline int task_sigpending(struct task_struct *p)
 
 static inline int signal_pending(struct task_struct *p)
 {
+	struct thread_info *ti = task_thread_info(p);
+
 	/*
 	 * TIF_NOTIFY_SIGNAL isn't really a signal, but it requires the same
 	 * behavior in terms of ensuring that we break out of wait loops
 	 * so that notify signal callbacks can be processed.
 	 */
-	if (unlikely(test_tsk_thread_flag(p, TIF_NOTIFY_SIGNAL)))
-		return 1;
-	return task_sigpending(p);
+	return unlikely(ti->flags & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL));
 }
 
 static inline int __fatal_signal_pending(struct task_struct *p)
-- 
2.31.1

