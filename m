Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B535A35D90F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 09:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241880AbhDMHhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 03:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240983AbhDMHh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 03:37:27 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F302FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 00:37:07 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id b8-20020a17090a5508b029014d0fbe9b64so10234252pji.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 00:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=feIVpLFE1LuKHeWl7tSeE0lvZCEn+UQxw9M1VcpRdeE=;
        b=GpFpHIOws7zBoR17dduUSnimAlwRHvxx/OuefV80lyVH1CZe0awKNyHIfsVLHNeo0X
         3cYDuxCM0eBESd5+9NS1wVaPEROybF9n5jC/N51D+1dtMLh5kXikVKX3H3mCh01yvyGO
         jAmVEYVdniP5cOr0EmV16a9Xy6tPppTM9k9+q5rhENYm09T8dJulUKqIC40sPc3TJKVH
         BRc52Qn7KaFpLG5lElyujBhxUrtk0FdkAmw5uGpRiKBwl3575UV5CSNVAFnVGka20BUf
         asXjwGyUJLaBZPzaLF0mMxpzgMgIzr7NvYrA0epjBCfatBAa8/kXPc2LTw0tlTOTpLWP
         4iXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=feIVpLFE1LuKHeWl7tSeE0lvZCEn+UQxw9M1VcpRdeE=;
        b=XhL1pqNiFb0umqxz4Se6LjEaVQheBhi1gjOF49zTpVrp6h64VBvATU8ENDRpe0RlVh
         0aRtMpfNnewSh7+jgKRRC/0s9aI08hin0xS0htOFuRhvRPftYYg/3KvV969UuetYT5Th
         wgUk0sro9TNdKieQF4Squzf8Uzi+AyQW29ZOMVxcBEt/F8RKMqiuExgGNUorJprmNm3l
         UpgO0nT3jncqlCbVKoSLKYtXnzzSe1b3QxyuyByiDtH74jp6lW4G0lZE4hEru/fxQ53t
         YNUlkmv43d2dBGkQqMApmSNLANI5HmXwXGu1Ux8PmLrSjYN4wum6icpnBUWDFnXEAoBW
         QdsA==
X-Gm-Message-State: AOAM533Vntw1vACXgeQGkJ6hCG+W5Lxlhq60jzB0oxgJo1cvSoxtkS9W
        zn3GU6HjVgG7JVNouuG8U7YePgASkxA=
X-Google-Smtp-Source: ABdhPJzHmfeiAiKreVQUvy1snqhX+SKDUcJq266SGaePzQJQXET5lmmrN6FC8Up4RSArSSb8ZztM9w==
X-Received: by 2002:a17:902:e549:b029:e6:6b3a:49f7 with SMTP id n9-20020a170902e549b02900e66b3a49f7mr31951897plf.52.1618299427630;
        Tue, 13 Apr 2021 00:37:07 -0700 (PDT)
Received: from edumazet1.svl.corp.google.com ([2620:15c:2c4:201:71d7:d843:bfe8:bec7])
        by smtp.gmail.com with ESMTPSA id a3sm1349068pjq.36.2021.04.13.00.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 00:37:07 -0700 (PDT)
From:   Eric Dumazet <eric.dumazet@gmail.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Arjun Roy <arjunroy@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>
Subject: [PATCH 2/3] rseq: remove redundant access_ok()
Date:   Tue, 13 Apr 2021 00:36:56 -0700
Message-Id: <20210413073657.2308450-3-eric.dumazet@gmail.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
In-Reply-To: <20210413073657.2308450-1-eric.dumazet@gmail.com>
References: <20210413073657.2308450-1-eric.dumazet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

After commit 8f2817701492 ("rseq: Use get_user/put_user rather
than __get_user/__put_user") we no longer need
an access_ok() call from __rseq_handle_notify_resume()

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Arjun Roy <arjunroy@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 kernel/rseq.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/rseq.c b/kernel/rseq.c
index d2689ccbb132c0fc8ec0924008771e5ee1ca855e..57344f9abb43905c7dd2b6081205ff508d963e1e 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -273,8 +273,6 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
 
 	if (unlikely(t->flags & PF_EXITING))
 		return;
-	if (unlikely(!access_ok(t->rseq, sizeof(*t->rseq))))
-		goto error;
 	ret = rseq_ip_fixup(regs);
 	if (unlikely(ret < 0))
 		goto error;
-- 
2.31.1.295.g9ea45b61b8-goog

