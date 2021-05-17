Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 333A2382D73
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 15:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237336AbhEQNbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 09:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236084AbhEQNbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 09:31:44 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F424C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 06:30:26 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id y184-20020a1ce1c10000b02901769b409001so2216124wmg.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 06:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9O8W3rz1KO2SFRi/t5MPcaskWe6+ULpCPpMNyYW5dpc=;
        b=uQIeASEfbEUF22Lqomf2HCTnKeHIknIx9/7ERVyg6ZxqbRmx06uXnxJHvU49NnFD3B
         Rd87Yy3cVphLyXAGOI061wFTVNqW2DSuVJwR2b5Fhl0x58xNz6sGA23+tZzYoMuLVmjW
         wdJVPwi4ibe/Dw66XsWQjtfC4sbLM1aiOUjzw6JRXtqGQruSf+goQzzzUBqYHEh6y6LY
         Ik5gGx6OmAUyo7bYFRnuwHNGqQzeQzhsn3UaWJqLUHKnat6wRiUBwgVEEDCLjlHRe+cR
         9TenuOvl831VlX/HreD+aH3bGoJUXY631Igg62LXgoiK3eR+HuTT7agnq8ev3LHW4FFb
         Sz2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9O8W3rz1KO2SFRi/t5MPcaskWe6+ULpCPpMNyYW5dpc=;
        b=TeUh9XJgNoY8p8EL2VXCauKu5lfYLa8GjMoGO8GcFC7q5gsZ8xI6JgxZhNNJXzNrE8
         0iIlIRNoyWx36j3v8W/XgPv91ozW6xQcw/dYyZIb1k/J0qRMImO6BKPNv96yW7kXlC0S
         /rIelttrdJoplY34v+JISYyVcYNJQykrfnsaTUaBQOAfd/pqD+m76glLJ4mPk2jTrI5w
         BQxBdXiMmPwse57NZFD0kj5JyDLLjumvaI/YeFru4v7Pm8t31W0dP6PU0VzsDbekJK3X
         r6T/1HdC8BocJ3Q/AjwOHXzfMS6lIohlayAyDvRa2BjshQyQg2zjC1VkE0DNglkkXE1h
         7rEg==
X-Gm-Message-State: AOAM532SPfvPFiVpXN2XycPkyleSgNdCRWpbDXh9Vx7vSpPVrXJCRLLB
        dPCj2ZgyMyW3kkKGYpwZBTt7WJ+Xe23Wcw==
X-Google-Smtp-Source: ABdhPJx67lyrN8fX/XTTb+1B52wiQm9vjaistcgTq+Lwnaoz+zinOMaT6u7zPCBTGz3Bwm0vIJ8m2w==
X-Received: by 2002:a05:600c:2310:: with SMTP id 16mr6675857wmo.17.1621258225016;
        Mon, 17 May 2021 06:30:25 -0700 (PDT)
Received: from agony.thefacebook.com ([2620:10d:c093:600::2:e1e0])
        by smtp.gmail.com with ESMTPSA id f26sm13374613wmj.30.2021.05.17.06.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 06:30:24 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH for-next] futex: deduplicate resched in futex_wake_op()
Date:   Mon, 17 May 2021 14:30:12 +0100
Message-Id: <9b2588c1fd33c91fb01c4e348a3b647ab2c8baab.1621258128.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After pagefaulting in futex_wake_op() both branches do cond_resched()
before retry. Help to deduplicate it as many compilers can't cope with
it.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 kernel/futex.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index c98b825da9cf..54ed232b2553 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1728,12 +1728,9 @@ futex_wake_op(u32 __user *uaddr1, unsigned int flags, u32 __user *uaddr2,
 				return ret;
 		}
 
-		if (!(flags & FLAGS_SHARED)) {
-			cond_resched();
-			goto retry_private;
-		}
-
 		cond_resched();
+		if (!(flags & FLAGS_SHARED))
+			goto retry_private;
 		goto retry;
 	}
 
-- 
2.31.1

