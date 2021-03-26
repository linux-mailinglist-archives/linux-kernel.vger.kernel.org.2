Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8575349E29
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 01:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhCZAlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 20:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhCZAks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 20:40:48 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A93C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 17:40:48 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id h25so3483397pgm.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 17:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZraEtUCV2acD7fBa5SEhKvc6Elb2YkSsHkkh6DBvMcc=;
        b=T1YT7oGi1AvvOihv+fkm5Z3HTE537IbIn217/FrN0x7/LGHF5Dn6QWaTmKqj0R1j3l
         vYD3ksC9siVkzR5BmNeCTzIOlM3I0Pqte0ZgpyiMhqx2aCx8ZpK527NlQe/4rHOxrx6i
         XoPm/iERq5TKQHJXpgsn5GV+m2HUtT6PFSuz8XuqgZ75LaPQR1Z9D9jsvc5s21FpYNAH
         feVeoA645Y928amgIXqEadVFe6ARcC+rqyakm2lKiO5IX90lTi4wkjE6rxHzSbH0FO2B
         3lpjxUMaP7laG/qxUOwdp1XahHq1rxvoTkeZ6abPN006MZX7ghrqWdPuY62TOTPoHqc/
         eTmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZraEtUCV2acD7fBa5SEhKvc6Elb2YkSsHkkh6DBvMcc=;
        b=MYiImonQqrYdQnGe5egRnEnmQpOq7mePvXYodVPIIesUMJTkMzzZi/nVKHVxKHV4Cv
         OSAs4mMdNeGyv6qLdBOaOBj5fl8NF21THt1DgygMMESd1jZ+u+GUT/xekB3wefXUm62R
         QTW8Q4bk+RRXo67PMrLcRqP0Q/DwhntFAzplLjXTZ91IMBvTtG7w7rAuAgkvPAcBOpZ5
         O2njyZ557CtYGddibpdN3k0vWxu0QWzeNoApVzDdML3vOtuVA7p8SLMoU2R13ucN0uwK
         VXnOOEyRaMTUa+ptLgS9Q3mmcT46lLJIZqBby/IehlsUmkOy304p7I2zCvQwzvhkyCGW
         fXjQ==
X-Gm-Message-State: AOAM531ekr3Qtdt9M5opJVQcOEZO7WVPAiZli5tpSpw/1j+HJ1IbmXUh
        MBFU76dJF9QJIYhjwJCZg1jk3eob8FA/2Q==
X-Google-Smtp-Source: ABdhPJykhUgOKxnJVjT2PMV4oTuTaxVVA45s05E/Ss0z7un6NKFgyWb9/ADHGfOFLNsXtt8XvpNu2A==
X-Received: by 2002:a63:1b5f:: with SMTP id b31mr9986812pgm.194.1616719247924;
        Thu, 25 Mar 2021 17:40:47 -0700 (PDT)
Received: from localhost.localdomain ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id c128sm6899448pfc.76.2021.03.25.17.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 17:40:47 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     torvalds@linux-foundation.org, ebiederm@xmission.com,
        metze@samba.org, oleg@redhat.com, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/8] kernel: unmask SIGSTOP for IO threads
Date:   Thu, 25 Mar 2021 18:39:25 -0600
Message-Id: <20210326003928.978750-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210326003928.978750-1-axboe@kernel.dk>
References: <20210326003928.978750-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With IO threads accepting signals, including SIGSTOP, unmask the
SIGSTOP signal from the default blocked mask.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 kernel/fork.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index d3171e8e88e5..d5a40552910f 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2435,7 +2435,7 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
 	tsk = copy_process(NULL, 0, node, &args);
 	if (!IS_ERR(tsk)) {
 		sigfillset(&tsk->blocked);
-		sigdelsetmask(&tsk->blocked, sigmask(SIGKILL));
+		sigdelsetmask(&tsk->blocked, sigmask(SIGKILL)|sigmask(SIGSTOP));
 	}
 	return tsk;
 }
-- 
2.31.0

