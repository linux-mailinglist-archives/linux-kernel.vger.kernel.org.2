Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB4CB367645
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 02:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343921AbhDVAeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 20:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234856AbhDVAeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 20:34:11 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B0BC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 17:33:37 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id u16so26877096oiu.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 17:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5anI/NXYTXPc6QlVmDdhNDGTBQi8MGmFJDhiLx8OSK0=;
        b=VuNLC0cq7QH4kru4+rsMqAkmEPfY1MpdOawVw2P9SmmLWDEiWhQJA89D/TqsUgUT6w
         SPZo+AFmcHGW3paCPQ9jIriPgzfzKFuL8ZihgsHOdj6Ymh432uAMM6kaMU6YfEHTGcz4
         xkCm+bhYkZtgjoJZdO6eDQlJq0hZvx26kC6ZBOQpRSlig06LhvQIM1W+ve4J6kKlmcmb
         I7El6hcATloklhpNTV+dz51TqwoLFTFLAQEF4hwa/iyZ4nDjTra9QFFb0v3HFWQmXfWR
         cwhDzkPjS6l3aztxp3Dst3cOUoeeGaVZfG7V2uTLX020Lj4w4rPmyyP6kOeFMY8mQdVB
         exQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=5anI/NXYTXPc6QlVmDdhNDGTBQi8MGmFJDhiLx8OSK0=;
        b=FT+IoNBKJOPo4oy7qypcZZLSkt2bV87c6bMGTlL3n3PJd04/15KUmvIYEOQIbh+FUc
         yITO1bMwHOY0X1CwdW98jsC9XLyZY7ra+25pipl44AWM+mIv9PzHDLLYWUlwkkEK3Nhi
         NAWR99HxTvJK9G+4YrY+zcZXVHRqEKnQNTBttAkbTPCNZyTrZxdFcJQRFjzFB1MxPx+O
         ZLdotZDpLTP8Jol5a568/FiJ5TNN794LybObMHcbsin98cUew9/bpRgxVcxf+5esQokU
         8l2BftKj3fbSDSuZncFIsZwcvA/1VBVxez7T4uRznntrfgTWOFZ2rWxxxTffvPytLbQF
         P2tg==
X-Gm-Message-State: AOAM531FnZmS0itQkjf4qoHyqoR4mB7ZNX0Xnpae0NhAaIG4RxtgCRLJ
        yHfDvNUUtz3PV0iohNlRwcs=
X-Google-Smtp-Source: ABdhPJymyEDZUBbVY8VDDSJNtOTWxddKBtLRGFXnxA0T1tuhO1geG6JIZYVxMhwQ3A1XHrTx5tzWxg==
X-Received: by 2002:a05:6808:606:: with SMTP id y6mr8448742oih.3.1619051617427;
        Wed, 21 Apr 2021 17:33:37 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q24sm283921otg.81.2021.04.21.17.33.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Apr 2021 17:33:36 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] static_call: Fix unused variable warning
Date:   Wed, 21 Apr 2021 17:33:34 -0700
Message-Id: <20210422003334.139452-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_MODULES=n, the following build warning is reported.

kernel/static_call.c: In function ‘__static_call_update’:
kernel/static_call.c:153:18: warning: unused variable ‘mod’

Mark the variable as __maybe_unused to fix the problem.

Fixes: 9183c3f9ed71 ("static_call: Add inline static call infrastructure")
Reported-by: Zach Reizner <zachr@google.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 kernel/static_call.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/static_call.c b/kernel/static_call.c
index 2c5950b0b90e..8211a34251f8 100644
--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -150,7 +150,7 @@ void __static_call_update(struct static_call_key *key, void *tramp, void *func)
 
 	for (site_mod = &first; site_mod; site_mod = site_mod->next) {
 		bool init = system_state < SYSTEM_RUNNING;
-		struct module *mod = site_mod->mod;
+		struct module __maybe_unused *mod = site_mod->mod;
 
 		if (!site_mod->sites) {
 			/*
-- 
2.17.1

