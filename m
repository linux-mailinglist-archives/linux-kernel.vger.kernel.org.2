Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 871543E15BE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 15:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241713AbhHENcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 09:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241105AbhHENck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 09:32:40 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE72C061765;
        Thu,  5 Aug 2021 06:32:25 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id j2so6546227wrx.9;
        Thu, 05 Aug 2021 06:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dHJuAB+xH7J0mncxBxd5BocIPg1XkQeb/gIAfBL3s+U=;
        b=n6j6tdNshoCHO7CTjpjun0anYAB2neTObKuk4IDrMJNM4F1YakP/K7SO1wDsu/ptMk
         8lQ+uGQq6JlDec/wNIV22I+OmgBgWtp8BqdzpgxAMmVgN1jrZZ70dbrouOo3kW5dJEL5
         F22uMKwqe0aZFVw05p2kqc8l4PRIqRBihfcqrBmrb8oBN0KHm21dJqfoZNFasvnkyxc3
         BEgq5GZX+OyL40btin4wrN9V1coYhKsMix3w7tANMy/lvoCiGKuK5W48tzWA9qyi1JkD
         FgLGQXXhKx3cyG6TlsbIAkGVitrzOTPcoDJhVpl6D1p29hb2i51ZZPeMLnz9HSP/a9Tm
         EnPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dHJuAB+xH7J0mncxBxd5BocIPg1XkQeb/gIAfBL3s+U=;
        b=ecsNVadLqYv5R0/MPMVM0Kc325N/xZttxf2tCNtNofm2ZIrwAIQlI+cbfIWeGFe+w4
         lYeBf18hct1BZ3OpYc0D5eBCoxPfGZn2mhfDnaezgBdrcfQkAq6GlUIcDJDhzprNuLuP
         6l5BLLAny42k9kGEALL+65o0nCnBuu5+pRHtMf+dhF7mDBt4L46rimRpqL6YXADOxUJ8
         44KM2QrIkjNrgvtepf/9HvoxFhzgBg7n9oIIBKH14DxBa6JNK79F3qkVTuxeNe3m1Ocy
         NrOQlXgb1ZMtHJ5GswyZyjzdmEihPw7Dhf6+sgmxdO1je2rBryGUl63RDyO58qF5V0gR
         bBbA==
X-Gm-Message-State: AOAM530UL3GgNb4nOJNRikMa+yoQnJ94ydnD4H1i9lpdQ4tiz6OLW4rM
        0EjpjXT2IvfjFnwFdy/daKE=
X-Google-Smtp-Source: ABdhPJxoWV7qwbvb3z3P2LC52eAOK7PjxTI1IJY5Sy2LLR+SCMUkEvQ71G/KfSiUTazlJBeYcKobjg==
X-Received: by 2002:adf:fe89:: with SMTP id l9mr5496502wrr.396.1628170344007;
        Thu, 05 Aug 2021 06:32:24 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2df9:c900:f529:5713:68f8:707e])
        by smtp.gmail.com with ESMTPSA id y197sm9578759wmc.7.2021.08.05.06.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 06:32:23 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Michel Lespinasse <michel@lespinasse.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mete Polat <metepolat2000@gmail.com>
Cc:     Jesper Nilsson <jesper@jni.nu>, Arnd Bergmann <arnd@arndb.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] rbtree: remove unneeded explicit alignment in struct rb_node
Date:   Thu,  5 Aug 2021 15:32:13 +0200
Message-Id: <20210805133213.700-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit e977145aeaad ("[RBTREE] Add explicit alignment to sizeof(long) for
struct rb_node.") adds an explicit alignment to the struct rb_node due to
some speciality of the CRIS architecture.

The support for the CRIS architecture was removed with commit c690eddc2f3b
("CRIS: Drop support for the CRIS port")

So, remove this now unneeded explicit alignment in struct rb_node as well.

This basically reverts commit e977145aeaad ("[RBTREE] Add explicit
alignment to sizeof(long) for struct rb_node.").

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: Mete Polat <metepolat2000@gmail.com>
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on next-20210804, but only x86 compile-checked.

Michel, Davidlohr, Jesper, David, please ack.

Mete, you might want to re-run your RBT test suite for this change.

Andrew, once acked, please pick this minor cleanup into your tree.

 include/linux/rbtree.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/rbtree.h b/include/linux/rbtree.h
index d31ecaf4fdd3..e9390be1ba67 100644
--- a/include/linux/rbtree.h
+++ b/include/linux/rbtree.h
@@ -25,8 +25,7 @@ struct rb_node {
 	unsigned long  __rb_parent_color;
 	struct rb_node *rb_right;
 	struct rb_node *rb_left;
-} __attribute__((aligned(sizeof(long))));
-    /* The alignment might seem pointless, but allegedly CRIS needs it */
+};
 
 struct rb_root {
 	struct rb_node *rb_node;
-- 
2.17.1

