Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA413E2DB5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 17:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244608AbhHFPXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 11:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244667AbhHFPXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 11:23:10 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FE4C061371;
        Fri,  6 Aug 2021 08:22:13 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id o7-20020a05600c5107b0290257f956e02dso9257660wms.1;
        Fri, 06 Aug 2021 08:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=4hP5EFCo5371tB5JgIut0p+iw6oHDNxFxSxtkYd2mP0=;
        b=UlZnp+lfGGHy4+bRfTqLgXqKXdnc10XVCiL8ICCsf/cLMkFpA+1EnYD4wH2bXHsT57
         nSPdgVl5vcK4nyZebLWtFu2pfRxBPZZrOyNiKngJg6+rwOWNZ2Ve25BBKjJqMMzkTUSL
         QZ6EHsC26K2A3lpaCm+zmWviONfIoHfXsYQvRZ1+Cx3mdwfbeA9Kc/Sb8U/VIysVlntz
         dFPivCDGq5yYzdnvOu+GiKf8G2wo5r/Dpl5lQmOs96oG1uF+y7VSI/ZSaR9GCBWvbHSp
         o6t+ngaestGl7RoeSUBgcUiuNB5CTxZ6sdLJRqHCAHbc/l7W0tbxkfRSctz6HrXNNrgI
         rc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=4hP5EFCo5371tB5JgIut0p+iw6oHDNxFxSxtkYd2mP0=;
        b=fdW2movEq/hKlRXVxN7D+Lw6uHK9WYqVimcB/ocZMf87XDb6t0hdx2tXeTmr4ia0Zo
         1+psQmPrsZ6jmFGG6Bz7BKpnMtlyBYOWKXqQ7y+yRtb8Imhp6kzCSaJaQ9jARCti6VFa
         najC1ivlbEAgczIEN+8lqvGdcNKVPg51Up9bzZwwq8UKCp5yb/XidV5vqhtY9nnyAuFs
         tcOWJkSr7DOK5cPHlkAIYKz8Ae2AyTwKefCjJbW/aljYsmsHxnlKohEioEYf4j9OcI7M
         LrnvDr5GegTpZbWHesP7kqWV608JTaTwPJMwmGLX7FQHuF5vHwZUX/6XRW0kRx4N0kx3
         jlsw==
X-Gm-Message-State: AOAM530MKHLd1+0GIK6g40KY0hcoqhTq5l6hteOA4RhXb2rK68BY2SFE
        yYIIcB2t6z4Zr5I436w40TWSFUmXdyuLCaZD
X-Google-Smtp-Source: ABdhPJyrExZu6DwoTxsC65fugZwJekFV9gpV8k/RTLbJBOCe+a2FR4z1r7FLDq1rJvPlsXMBwj5NLA==
X-Received: by 2002:a1c:208e:: with SMTP id g136mr20873244wmg.142.1628263331754;
        Fri, 06 Aug 2021 08:22:11 -0700 (PDT)
Received: from precision (aftr-62-216-202-158.dynamic.mnet-online.de. [62.216.202.158])
        by smtp.gmail.com with ESMTPSA id h14sm9844922wrp.55.2021.08.06.08.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 08:22:11 -0700 (PDT)
Date:   Fri, 6 Aug 2021 17:22:08 +0200
From:   Mete Polat <metepolat2000@gmail.com>
To:     Michel Lespinasse <michel@lespinasse.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Jesper Nilsson <jesper@jni.nu>, Arnd Bergmann <arnd@arndb.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Subject: [PATCH v2] rbtree: remove unneeded explicit alignment in struct
 rb_node
Message-ID: <YQ1ToK8EMdAO4CyH@precision>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

The rbtree node color is stored in the LSB of '__rb_parent_color'.
Only mask the first bit in '__rb_parent()', otherwise it modifies the
node's parent address on m68k.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: Mete Polat <metepolat2000@gmail.com>
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Mete Polat <metepolat2000@gmail.com>
---
I have tested it on x86, but not on m68k. Can you ack that Geert?

 include/linux/rbtree.h           | 3 +--
 include/linux/rbtree_augmented.h | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

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
diff --git a/include/linux/rbtree_augmented.h b/include/linux/rbtree_augmented.h
index d1c53e9d8c75..94b6a0f4499e 100644
--- a/include/linux/rbtree_augmented.h
+++ b/include/linux/rbtree_augmented.h
@@ -145,7 +145,7 @@ RB_DECLARE_CALLBACKS(RBSTATIC, RBNAME,					      \
 #define	RB_RED		0
 #define	RB_BLACK	1
 
-#define __rb_parent(pc)    ((struct rb_node *)(pc & ~3))
+#define __rb_parent(pc)    ((struct rb_node *)(pc & ~1))
 
 #define __rb_color(pc)     ((pc) & 1)
 #define __rb_is_black(pc)  __rb_color(pc)
-- 
2.32.0

