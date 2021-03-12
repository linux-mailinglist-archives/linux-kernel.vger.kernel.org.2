Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78C11338A26
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 11:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbhCLKa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 05:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbhCLKad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 05:30:33 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42A9C061761
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 02:30:32 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id bf3so7212827edb.6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 02:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XECRIur2x6+f+ush3/3hqdqZ/DZoK8/+Xw6JDZbJb1s=;
        b=iXvvKsG0wwejL/9UQzwbegY9itSH0rJIMH9NW8E0Bd8mu9bUC7lTJQRmIh/1oKHpxT
         g5+5j676vZ9R30LLMLRGd+VKznf5heED0LVWtUv0UjCgC+H0DO+hjbwoB2ov3Kgjjy16
         yBxVQWDc3xO5v6h4TkWMaqzO9gNmwPJgxNTmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XECRIur2x6+f+ush3/3hqdqZ/DZoK8/+Xw6JDZbJb1s=;
        b=fCKBO2Rz8jX9tM9/9N/hsGa/jOKIJrvIfmQ5//xuzwcJ6LoO1fqlZpJ+IKNxZXPvd+
         3pC7kH2h87H7bI/lhoG7Ki0j3yb2z2OLTwldt0cmoh2XWJNaHSDtPw5MuoNLEaL13U0E
         MM4WT2z/B4NptGi4FfvZhF0RfSpmYe3xiUbeiUEMti9mbjdvDf4tz6vf/67P6DKTsHBX
         mNncdtKJwY7ef1JDGu5m/e81nFzRGcQPJdXitoX3YICIWZxFwOmsOHf/SagMlCBl8Fki
         tXrlrofSCxFb4WqVyuEdwWlXkGZEeY+NWfXivymtuS02BzvEdVNdnctyT8TpMvqzFaLS
         CuUA==
X-Gm-Message-State: AOAM531gn/0RTyNOCwkvTox95Sm8D4ivLGfh99WruMLL9lpD1HtI+g1v
        9L/jqVf5womubxFwWN0WhuN5yw==
X-Google-Smtp-Source: ABdhPJzrvVKFIULeVmjdc6YpmB1AKfTtEkoIb4q4Pf0o0D9KFAULkluIcOcTLoAMVPzKtGKu1hBfHA==
X-Received: by 2002:a05:6402:35c9:: with SMTP id z9mr13277763edc.94.1615545031488;
        Fri, 12 Mar 2021 02:30:31 -0800 (PST)
Received: from prevas-ravi.prevas.se ([80.208.71.248])
        by smtp.gmail.com with ESMTPSA id r13sm2735729edy.3.2021.03.12.02.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 02:30:31 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] devtmpfs: actually reclaim some init memory
Date:   Fri, 12 Mar 2021 11:30:27 +0100
Message-Id: <20210312103027.2701413-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210312103027.2701413-1-linux@rasmusvillemoes.dk>
References: <20210312103027.2701413-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently gcc seems to inline devtmpfs_setup() into devtmpfsd(), so
its memory footprint isn't reclaimed as intended. Mark it noinline to
make sure it gets put in .init.text.

While here, setup_done can also be put in .init.data: After complete()
releases the internal spinlock, the completion object is never touched
again by that thread, and the waiting thread doesn't proceed until it
observes ->done while holding that spinlock.

This is now the same pattern as for kthreadd_done in init/main.c:
complete() is done in a __ref function, while the corresponding
wait_for_completion() is in an __init function.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/base/devtmpfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index aedeb2dc1a18..8be352ab4ddb 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -371,7 +371,7 @@ int __init devtmpfs_mount(void)
 	return err;
 }
 
-static DECLARE_COMPLETION(setup_done);
+static __initdata DECLARE_COMPLETION(setup_done);
 
 static int handle(const char *name, umode_t mode, kuid_t uid, kgid_t gid,
 		  struct device *dev)
@@ -405,7 +405,7 @@ static void __noreturn devtmpfs_work_loop(void)
 	}
 }
 
-static int __init devtmpfs_setup(void *p)
+static noinline int __init devtmpfs_setup(void *p)
 {
 	int err;
 
-- 
2.29.2

