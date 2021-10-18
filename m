Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEDA43129A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 10:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbhJRI7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 04:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbhJRI6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 04:58:52 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D1BC06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 01:56:33 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id o133so14192426pfg.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 01:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=knBzRmQ82wPdv3CuzyNBZ63kKmOlweb7N5lkXGqcdto=;
        b=ThV8u8nE6/op0as+vpJv6SCHnqUa3k0SQHjDCmgu5hJVhhnBaOM6pZ3uqnLp7ZXzKr
         5sprIwzqFdi18LEZY/kj43TvPe1aAs7vfUuL78UopxPGdUg/QZ661hpJiwvFBC1GHwYM
         zvPbfSSmSbpspxZziZspBupYJaz36C8wesdXlY4ecDIRXdD7MVUHfWHohrtUenl+J5mU
         /oyKaqr8qeGhPBwhsOdtoTKkhppvuN6Lynhh0Y3amxgS44nmwQ+gVTbDTJ4IKWe0Vmmh
         JofGCd1CHIGgXq8sE3WldpJTEDB5QFqT2lakAYu9AnP/sdDwD0VWDsMI4X40SfvaP91E
         R9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=knBzRmQ82wPdv3CuzyNBZ63kKmOlweb7N5lkXGqcdto=;
        b=b1h/sUCtolQlQtdT1tZ2Pzie2J97LxERmTomXuG4nbIfof4GLkw1m3azeUf3vn+f9n
         XBfwKCaKM5e0iwJJiW36AUUYi7JUTqKXfFu7iAufK5H/byLoi3tH6mmH5Ns/kYi8eLYt
         GNpRktgKq/zzrV9Tl85iWdDS1oKDOWta+dGN1GuDyT60DzRUQrLe1+ofC3hxGtGT0Vhf
         rK2Y/vw0WoZJxPNaYmTURP8hSupUB4uehuI9Kc68zwVDjMKjPvGMjOEZcoEfNF2YgXpu
         QhthKvhCgVSUKZEEfGrmbIk9Q0sdk8m8+BxemlYKt0Fk6tIWMSaPzFuGqOyWMYc8Cmv3
         z6iA==
X-Gm-Message-State: AOAM533FUIrMToFLwO739y+YFihoKJw+FNduEFKJd248ECwoWxy/ihYY
        soxGxCEZth9voCENzRiwXxU=
X-Google-Smtp-Source: ABdhPJyZ2yMKEB34DEqhQtO2hw2tMAo/GopxrqYeicStZZA8cpUanjNJ9fy2g3WQJjJ4XQHjVP4thw==
X-Received: by 2002:a65:6288:: with SMTP id f8mr22308343pgv.81.1634547392672;
        Mon, 18 Oct 2021 01:56:32 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d60sm18323659pjk.49.2021.10.18.01.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 01:56:32 -0700 (PDT)
From:   luo penghao <cgel.zte@gmail.com>
X-Google-Original-From: luo penghao <luo.penghao@zte.com.cn>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-kernel@vger.kernel.org, luo penghao <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] lib: Remove redundant statement
Date:   Mon, 18 Oct 2021 08:56:27 +0000
Message-Id: <20211018085627.854672-1-luo.penghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regardless of whether the next if condition causes the function to return,
the assignment operation is meaningless.

The clang_analyzer complains as follows:

lib/assoc_array.c:97:3 warning:
lib/assoc_array.c:409:3 warning:

Value stored to 'cursor' is never read.

Reported-by: Zeal Robot <zealci@zte.com.cn>>
Signed-off-by: luo penghao <luo.penghao@zte.com.cn>
---
 lib/assoc_array.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/assoc_array.c b/lib/assoc_array.c
index 079c72e..2743bca 100644
--- a/lib/assoc_array.c
+++ b/lib/assoc_array.c
@@ -94,7 +94,6 @@ static int assoc_array_subtree_iterate(const struct assoc_array_ptr *root,
 
 	if (assoc_array_ptr_is_shortcut(parent)) {
 		shortcut = assoc_array_ptr_to_shortcut(parent);
-		cursor = parent;
 		parent = READ_ONCE(shortcut->back_pointer); /* Address dependency. */
 		slot = shortcut->parent_slot;
 		if (parent == stop)
@@ -406,7 +405,6 @@ static void assoc_array_destroy_subtree(struct assoc_array_ptr *root,
 	if (assoc_array_ptr_is_shortcut(parent)) {
 		shortcut = assoc_array_ptr_to_shortcut(parent);
 		BUG_ON(shortcut->next_node != cursor);
-		cursor = parent;
 		parent = shortcut->back_pointer;
 		slot = shortcut->parent_slot;
 		pr_devel("free shortcut\n");
-- 
2.15.2


