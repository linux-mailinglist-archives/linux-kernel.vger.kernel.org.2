Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1B83AC949
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 12:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233897AbhFRLBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 07:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhFRLBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 07:01:18 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751D7C061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 03:59:09 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id t13so7481725pgu.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 03:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=e545N6sFNQ6o79pBREpnT2Z+rEdK47XJm3J1l9SSnV0=;
        b=PywNZv5oi2BMbkcjOdv2KlT7vdwGp0KQdL1nxl9N3ltb49XYhfcTPAbKLzn4dcKvqn
         pnNbI7b8+ijH5BN+/geLZ5d0qWeUmSHzwx8twoXuVia2N9NxXvvYun5OSzmp43SngELj
         pKIygsWCZW9250VVbnFuJNjkKLQriDJkRNmi0wvkWiEw9y7T3XGIbyDJZ6DBg6J1o7Wf
         se4LC5x6D8QscrjiI+mB81ky5t2efGL9BHCpJ1ktsFDqn1VAgKHDCCW4byKON4OFMpPB
         U7CcSvP5AFlvITGutA50N/htaNba/JNKws6P49bEJmaNEbbPfDC9TY30oiAR2gegRdFV
         Di5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=e545N6sFNQ6o79pBREpnT2Z+rEdK47XJm3J1l9SSnV0=;
        b=RCe5bCjuAn8XwSPWdtWRkaraeiQMBmEXWs2BuV516U3mMx9HNgVUZy3xOGNAb2vDTr
         inn65w/XDrX9eQxObOXRL96mqOlYhm9Uk24O++ZeBP5VflKp+Mu4VcK79NaGgBRzWkb0
         XqzsttcZkZyvG9JxJvNwFae7ivtOfoTyT6XjLr7nS6uwvHH3oQ3VD1QKXbUXNHDa6W7V
         I4zrEv6Ca2e0K7Yc4kd/sA7VB2XNegV8KIZyDpsHPkk1MYAl60Bz7Nm6KKOb6nMKjUv8
         g89Qc0iMpRbYywJDvmju10K6jAP/7S7g1B3vUDSPhb9AH9MIWApXBImb5zhM/P0k4GXz
         cl9Q==
X-Gm-Message-State: AOAM530l+Uzxkg/4/pzuO+gky9Nh/vOMvUjLv5DvMsk7end3xBcZNk+X
        ZaxnoW2pMwJ9kOQuZf59yzI=
X-Google-Smtp-Source: ABdhPJxsAX8Jb/zRhXLLXhqEft2ZcEQdqM7H8qc+grZNHVz5zkAc3K15f9v4OElku2XQcuIH8COFcg==
X-Received: by 2002:aa7:829a:0:b029:2e9:e53:198d with SMTP id s26-20020aa7829a0000b02902e90e53198dmr4488637pfm.72.1624013948969;
        Fri, 18 Jun 2021 03:59:08 -0700 (PDT)
Received: from localhost ([209.9.72.215])
        by smtp.gmail.com with ESMTPSA id a11sm7859380pfl.168.2021.06.18.03.59.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jun 2021 03:59:08 -0700 (PDT)
From:   gumingtao <gumingtao1225@gmail.com>
X-Google-Original-From: gumingtao <gumingtao@xiaomi.com>
To:     cl@linux.com
Cc:     penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz, nathan@kernel.org,
        ndesaulniers@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        gumingtao <gumingtao@xiaomi.com>
Subject: [PATCH] slab: Use %s instead of function name
Date:   Fri, 18 Jun 2021 18:59:03 +0800
Message-Id: <1624013943-13935-1-git-send-email-gumingtao@xiaomi.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is better to replace the function name with %s.

Signed-off-by: gumingtao <gumingtao@xiaomi.com>
---
 mm/slab_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index a4a5714..36127dc 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -381,8 +381,8 @@ kmem_cache_create_usercopy(const char *name,
 			panic("kmem_cache_create: Failed to create slab '%s'. Error %d\n",
 				name, err);
 		else {
-			pr_warn("kmem_cache_create(%s) failed with error %d\n",
-				name, err);
+			pr_warn("%s(%s) failed with error %d\n",
+				__func__, name, err);
 			dump_stack();
 		}
 		return NULL;
-- 
2.7.4

