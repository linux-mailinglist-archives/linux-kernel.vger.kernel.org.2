Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B69BD342DD7
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 16:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhCTPiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 11:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbhCTPim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 11:38:42 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C08FC061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 08:38:42 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id cl21-20020a17090af695b02900c61ac0f0e9so9588126pjb.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 08:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wKVl2ZBcEmHdyj651ipa5U538ILekXzuQ5XaJkSKBWg=;
        b=hcmSUymtd4ol6ndWFlOUIzTrMuXFoQcWZtBmoeGtDjHCWUcDbUyWzhxW2tvTneuB4O
         MKnjBWPAWejnO9uaRwoLzCid3UeTrW1u7DTu/CewnliwBDB+zlrXC4NJlX3P0tvHqrWy
         PRlGiNE5jA+jWvyBHJ7hpGRayCrm/Eet5uOV1EBtw1wpC2nejzzvE5PHYqZrNZCtk44c
         d6autgz8z3/1+2r2Rj5XFhPf6Kc2SEXMv8ZvjZM1RFJpj10GDoY0Fxpmni7B/7PaJMi0
         y2kb4w42NoDEwBmuIaTei36bnl7SsXeyjD/fuzMZ6Scr4LWwRpMJffi39Pb9Zk2k4beR
         /PGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wKVl2ZBcEmHdyj651ipa5U538ILekXzuQ5XaJkSKBWg=;
        b=P8i3CfDbGhEdaEFLKYhhMqywjVS2tP3yiGQqDJT3hbs6jr6D8enHw1zkYwYxwETVJp
         x9rONilwP9mQ12tgNqMVXNc0L53cIBIucjY8n/5+7c8KKBiqWmm4/GhOjHFvGfpl13sY
         Vme5OzSJSosC3zzDlAS596YBwH/jU7D8E5/sh7aruvM1tAXsz9fSdY2pCrXEcwCsR9bk
         x/BQavcGZS82vmmzcYbwHj7RozzvR6cQj0iIXwn06SZTDbegJVzErirPtKC05PABjBQR
         yR3wGnz0BhHBR/UxDqN4ZRbLW4ibTvvicd7sSpOUYBZn6nF58ZVAHEYlHXZgcf2kSUwM
         s8Bw==
X-Gm-Message-State: AOAM533cHnmuvvQtQ0jhN3951WwaYGYTbq+qE3lTHGbVtA++9VzrfCHY
        YjGcn7RxY5zx8NyYJGfFkxPtag==
X-Google-Smtp-Source: ABdhPJzn8XtjKLDnDMYfmdUP9IvxAFJFXbrVXThoRCum70urq1LvhUslYyGPkT6tyG8lXns8FROIyA==
X-Received: by 2002:a17:90a:f3cc:: with SMTP id ha12mr4079964pjb.180.1616254722015;
        Sat, 20 Mar 2021 08:38:42 -0700 (PDT)
Received: from localhost.localdomain ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id 2sm8658753pfi.116.2021.03.20.08.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 08:38:41 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     torvalds@linux-foundation.org, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org, oleg@redhat.com,
        Jens Axboe <axboe@kernel.dk>,
        Stefan Metzmacher <metze@samba.org>
Subject: [PATCH 2/2] signal: don't allow STOP on PF_IO_WORKER threads
Date:   Sat, 20 Mar 2021 09:38:32 -0600
Message-Id: <20210320153832.1033687-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210320153832.1033687-1-axboe@kernel.dk>
References: <20210320153832.1033687-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just like we don't allow normal signals to IO threads, don't deliver a
STOP to a task that has PF_IO_WORKER set. The IO threads don't take
signals in general, and have no means of flushing out a stop either.

Reported-by: Stefan Metzmacher <metze@samba.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 kernel/signal.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/signal.c b/kernel/signal.c
index 730ecd3d6faf..b113bf647fb4 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2349,6 +2349,10 @@ static bool do_signal_stop(int signr)
 
 		t = current;
 		while_each_thread(current, t) {
+			/* don't STOP PF_IO_WORKER threads */
+			if (t->flags & PF_IO_WORKER)
+				continue;
+
 			/*
 			 * Setting state to TASK_STOPPED for a group
 			 * stop is always done with the siglock held,
-- 
2.31.0

