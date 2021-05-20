Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 437D9389AF3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 03:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbhETBhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 21:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbhETBhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 21:37:05 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33D2C061760
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 18:35:44 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id b13-20020a17090a8c8db029015cd97baea9so4442456pjo.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 18:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lQOWJqPqhCFkDp+9hhOZDwaBqtzLz23Olys+QM6koX4=;
        b=fNHovEwGGkeFLsJmt5RPUgE6pPjSKBrtL/sjfNc4fAHcC5j1Z54qMl6hhQDTxjTeuo
         liBs7Y3JAsbT6z/erPJdBtW5AAJny5TIOP4fN9LSbZtJbTPTSRDKMXWskWgtF3wis3r3
         c/uHBaS+oGkXGcim33wy5jHzqGm0P3CFQ/Rzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lQOWJqPqhCFkDp+9hhOZDwaBqtzLz23Olys+QM6koX4=;
        b=P/+ZMb0w8BueJEyy27nrvTV3VW5MvwQ8pqunOO373czSS1/tugIJQpRIzlMqsH2pD2
         JN68eHN1PUmAbmmuq6JOf+238jIuF3LRpwjJ6IZXYvPjL6ZUlLpWHroDFbtftgVvBPYc
         47BK7hJr4O+loYo/O+3OxjTlEhi2DOfcuDaVC5NVRRTRXsxZd7TWfu+dLboiCLRQS7Yv
         qc1hm1Fcp+FSe8Q9cMxR6kmCo+6KVSd5B7lhhkyGe9Rhqt5x4FmtyJR0d3dab5K7h++0
         UcPC0nlQkoEFd2HXyDpMaUckLFW2n42Af7IJsZJVIE1B9kWPOEN/+L1g88Fco871Qs+E
         0ASg==
X-Gm-Message-State: AOAM5321LFI6WGo4NmIzaPXnGQloFg1hHnEAQQR9kt0X9SzzGcw3QfoL
        lhUc04H5wRA2INN06a2djXiGqcJ1oENADw==
X-Google-Smtp-Source: ABdhPJxamRbEtn82DfA9aIBe9DH1lgQZtgcRaoTgWKDBreuqJ7W0VqAbKf+VbVpZzqxuznHGoS1YXA==
X-Received: by 2002:a17:90a:d201:: with SMTP id o1mr2459410pju.230.1621474544362;
        Wed, 19 May 2021 18:35:44 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:200b:db75:4e6c:8b96])
        by smtp.gmail.com with ESMTPSA id m20sm5097368pjq.40.2021.05.19.18.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 18:35:44 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org
Subject: [PATCH 3/3] slub: Actually use 'message' in restore_bytes()
Date:   Wed, 19 May 2021 18:35:39 -0700
Message-Id: <20210520013539.3733631-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
In-Reply-To: <20210520013539.3733631-1-swboyd@chromium.org>
References: <20210520013539.3733631-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The message argument isn't used here. Let's pass the string to the
printk message so that the developer can figure out what's happening,
instead of guessing that a redzone is being restored, etc.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 mm/slub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 87eeeed1f369..16e8e8f8dc0c 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -777,7 +777,7 @@ static void init_object(struct kmem_cache *s, void *object, u8 val)
 static void restore_bytes(struct kmem_cache *s, char *message, u8 data,
 						void *from, void *to)
 {
-	slab_fix(s, "Restoring 0x%px-0x%px=0x%x\n", from, to - 1, data);
+	slab_fix(s, "Restoring %s 0x%px-0x%px=0x%x\n", message, from, to - 1, data);
 	memset(from, data, to - from);
 }
 
-- 
https://chromeos.dev

