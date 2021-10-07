Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F41284260B5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 01:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbhJGXvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 19:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbhJGXvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 19:51:05 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB3EC061570
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 16:49:10 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id z20so29022926edc.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 16:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=6e39aL4HLnRACkqXPdSOU02ep3H9ltSIfuFtoAOZeqE=;
        b=OOAyfAz1BBcaxtO0aWdjutrTQ/sat7LfWu4imx/Yrr+QnoTt6nR/vi48nebxdF4B7G
         yFa0m5bIIPVeNnpFPyoiUnkoS0BLzXOrF1MNZ2tpp6TOxe1RL+XCxEp8CF7fA1kKzUjO
         rRPNlOrGNKuiFlIRnZO3NHGd0iL0AsLNDznctjUWcL/INqy9gw4trwdx/EjPsRyX9aOm
         iWVSMrieMz0B9ibHYdXf1fRDL9Gr3Pd+O7NlXQGEmwsYmmBz3/8bH0Za6Qj7JfLj2yuW
         19QuWfMPuEpFdQCkEFOpjuaQMu6tS2Ryi4jAYJ44Qnd60J0F+CbQ2Ko3DLF8z/uzWMRX
         3V+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6e39aL4HLnRACkqXPdSOU02ep3H9ltSIfuFtoAOZeqE=;
        b=PwJgz29SdpWzgFDioDQJ1KplL+QAiYxu6ZRWD7+zcY2eGSGAnLHWI//kKE9V34NS6W
         4MCL/I3WahOVWiSj8k37kiRNVBRFTD38By0qgZwYw0AsN5PYRMQVdCzjNImqKnBwnCU9
         OCPA3qmpyUoRTDIhnd8odq+F17HuD1bhlFYKHox1ZoUCNJpz0NZXRQBNd8hb+aKDHUtr
         FkQ0nOjbUU63+KTm9NACOqQcy5myZPP+OFQ/YwRv5O4CzoXV3lrhvA6l+7EKhCNo5TJR
         HtOjBpCqLGRtHgk7nTaflNBPC0gv63/LI+jXh0v4IgRh7XbmTB3SSt3Fr6VJcTkhSzNa
         6qZg==
X-Gm-Message-State: AOAM531pSxfFKh8PdcwWmBkI89kZ8YikRSmBfz9dJRkEGCnQAPUPhRRV
        cHYkrgtbquhPEUXHYJOY1DE=
X-Google-Smtp-Source: ABdhPJyNKUswlS5x/VnZKIhpayeiajXIiJCLF0ShkeFc7ptetTpkUC0i3VMFOQMKVuDjxtTzV/I/JA==
X-Received: by 2002:a05:6402:2712:: with SMTP id y18mr8428679edd.116.1633650549129;
        Thu, 07 Oct 2021 16:49:09 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id s24sm333820edy.38.2021.10.07.16.49.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Oct 2021 16:49:08 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     kuba@kernel.org, gregkh@linuxfoundation.org, neilb@suse.com,
        mojha@codeaurora.org, jkosina@suse.cz
Cc:     linux-kernel@vger.kernel.org, Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH] hashtable: add documentation for hash_for_each[_xxx]
Date:   Thu,  7 Oct 2021 23:48:07 +0000
Message-Id: <20211007234807.4292-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hash_for_each[_xxx] introduce a new loop command constructed from 2
nested loops. To make it work like normal loop, 'obj == NULL' is
explicitly put in loop check to break out not only inner loop but also
the outer loop.

This patch adds a documentation to clarify this behavior.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Reviewed-by: NeilBrown <neilb@suse.de>
---
 include/linux/hashtable.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/hashtable.h b/include/linux/hashtable.h
index f6c666730b8c..355681c632ff 100644
--- a/include/linux/hashtable.h
+++ b/include/linux/hashtable.h
@@ -122,6 +122,10 @@ static inline void hash_del_rcu(struct hlist_node *node)
  * @bkt: integer to use as bucket loop cursor
  * @obj: the type * to use as a loop cursor for each entry
  * @member: the name of the hlist_node within the struct
+ *
+ * Note: It is safe to 'break' out of this loop even though it is a two nested
+ * loops.  The 'obj == NULL' test ensures that when the inner loop is broken,
+ * the outer loop will break too.
  */
 #define hash_for_each(name, bkt, obj, member)				\
 	for ((bkt) = 0, obj = NULL; obj == NULL && (bkt) < HASH_SIZE(name);\
@@ -134,6 +138,8 @@ static inline void hash_del_rcu(struct hlist_node *node)
  * @bkt: integer to use as bucket loop cursor
  * @obj: the type * to use as a loop cursor for each entry
  * @member: the name of the hlist_node within the struct
+ *
+ * Note: It is safe to 'break' out of this loop.
  */
 #define hash_for_each_rcu(name, bkt, obj, member)			\
 	for ((bkt) = 0, obj = NULL; obj == NULL && (bkt) < HASH_SIZE(name);\
@@ -148,6 +154,8 @@ static inline void hash_del_rcu(struct hlist_node *node)
  * @tmp: a &struct hlist_node used for temporary storage
  * @obj: the type * to use as a loop cursor for each entry
  * @member: the name of the hlist_node within the struct
+ *
+ * Note: It is safe to 'break' out of this loop.
  */
 #define hash_for_each_safe(name, bkt, tmp, obj, member)			\
 	for ((bkt) = 0, obj = NULL; obj == NULL && (bkt) < HASH_SIZE(name);\
-- 
2.23.0

