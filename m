Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F724332188
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 10:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbhCIJDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 04:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbhCIJC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 04:02:29 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024FBC061760
        for <linux-kernel@vger.kernel.org>; Tue,  9 Mar 2021 01:02:29 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id w7so2749908pll.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Mar 2021 01:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=u8ArZQ+KHFSvmT08uvy27XesXoPhuLhAZbHVQzDz71U=;
        b=TTMen7rmz9A5cwnAhB1I1c3j/wk9evkRPeSQQGW+a3khDM1AnhEVP2EX5mHXYn7+3W
         +MWTIlYiaixVr7fWXU7O+9Ur72ieA1NaYAbJzjAjHGRzJ+ad+T+0PAyIdeROL5Tbtken
         WuPBVa3QHKQ0bfopO/dIyPXLu3/d8ZOUME10Ui3i1YHS9dyadoSDR/aFGQIf/BAf539t
         lvSXhV0rgGxjEQuZDOkWG2Fzs1UdlLmftPjsKk7lf8QUwHnX+KYIAUtjcBhDtRz+i5Xp
         DtT5De+c/cYyhdIWuorCuQLEXfD1nF9ijPKuCrrID6L3KjEveRLE17YHFfjMGOQxbUM5
         J0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=u8ArZQ+KHFSvmT08uvy27XesXoPhuLhAZbHVQzDz71U=;
        b=SlkvwMH/8NUd4ryw4Zj+QFgqIa0AamowSL6g1ExvJ/DHrtOHiFXVPaZHhZ7Vf2Uhvb
         xnUvH5ZTvCjEx6+AyLBFpp2ECprEu32EIj3OT8GwSx0o4kV5Rq9PgCmvg419R5Qc149j
         OoRR6o/io2ZN0oEwrduX2CiQ7TrUWaB1eizfIwnvVGu3wImL50X7yNSjNYHz//NjH8+n
         /rPNy8nVK0zIs+C9GD9wiaJ3KyNQy5Xse+DOqnzQpWNv+sXRpCnDZLO9RCvchyxrMJPW
         NnqG7ZyjJTkul1PPJczg3Ia3RyWe2Xr2hwyZceWgezttbUOYPW+RW0G5p2jK/O62GIie
         GKTw==
X-Gm-Message-State: AOAM533w0tloQCMoEISwWs1c2+jAGtDP5XmHA/kEXbA9cEVNP4SIFr2e
        8qx8QI44FJ48khavFvaVqXs=
X-Google-Smtp-Source: ABdhPJyshDQSFkreK/47GHrolspCwwxZDlmp4r7dRsLECu5plzyAoQXxM2XYGHyyiZRxl1JrPbnO3A==
X-Received: by 2002:a17:90a:16d6:: with SMTP id y22mr3739120pje.55.1615280548564;
        Tue, 09 Mar 2021 01:02:28 -0800 (PST)
Received: from localhost.localdomain ([45.135.186.97])
        by smtp.gmail.com with ESMTPSA id b14sm12469114pfi.74.2021.03.09.01.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 01:02:28 -0800 (PST)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     bigeasy@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] kernel: profile: fix error return code of create_proc_profile()
Date:   Tue,  9 Mar 2021 01:02:15 -0800
Message-Id: <20210309090215.25669-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When proc_create() returns NULL to entry, no error return code of
create_proc_profile() is assigned.
To fix this bug, err is assigned with -ENOMEM in this case.

Fixes: e722d8daafb9 ("profile: Convert to hotplug state machine")
Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 kernel/profile.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/profile.c b/kernel/profile.c
index 6f69a4195d56..65bf03bb8a5e 100644
--- a/kernel/profile.c
+++ b/kernel/profile.c
@@ -549,8 +549,10 @@ int __ref create_proc_profile(void)
 #endif
 	entry = proc_create("profile", S_IWUSR | S_IRUGO,
 			    NULL, &profile_proc_ops);
-	if (!entry)
+	if (!entry) {
+		err = -ENOMEM;
 		goto err_state_onl;
+	}
 	proc_set_size(entry, (1 + prof_len) * sizeof(atomic_t));
 
 	return err;
-- 
2.17.1

