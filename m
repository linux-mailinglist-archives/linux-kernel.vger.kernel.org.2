Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8431370958
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 01:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbhEAXwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 19:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbhEAXwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 19:52:46 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F41C06174A
        for <linux-kernel@vger.kernel.org>; Sat,  1 May 2021 16:51:55 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id m6-20020a17090a8586b02901507e1acf0fso1276002pjn.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 May 2021 16:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0lUNxaUJl6Yd72eQ/ceTu1VGr/whuj2iIRmqcIYOSuo=;
        b=L7XWDb1FDzFrM+LuztTXDjz9rsk+7xH8YTOAdNH6gICruJwbW5FWdgcaNQYg9jWxqV
         vgTDD2jeflDnyfYexi1+SK3tsglyrU8Xld6cnCTjYFrs3yXIPoUAOIUdmhftudpoaTk5
         YsiaSwKaG0AvDWqPYGaRHxlKoSNA/cJ+T6NNAAeyueSw7relOucLtvwNEfj7THhXoWeX
         YsfB993BMMsCs6zhegQ+ChmIitREQPmTV7irrtQv4vPHSnd3bsdl8KbX6+9bBko0SV1+
         N4rjtwuzGU1JAQkbvSG/Lv7E15Z8K69Ucq4w6GwX7TK6kE+P1qCxT7T/2cPtVcMQcbge
         I0Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0lUNxaUJl6Yd72eQ/ceTu1VGr/whuj2iIRmqcIYOSuo=;
        b=gZlpSobYlQrXII5XKBtQkudcHzKF0LgMId7HnyPc1X3HdO4yTZq3OK/8lxHo8qOi7x
         S+wgdbsvGi1ez/X5GVDyesUswK03rzfyiCzRYB1psTkpG3vHsxOoZy9rqq+0+r9Z5P1s
         Qv7YZhwTn0oYJwglrdVMqgUjPgyFh6J/T1mZQBANH4qGHf4kUWqo536gP1ovr58Cemxq
         MGp75RuY3RpQmrBjkUH+LkcdPsMM/ZWoHHf3vnq4eVKZ4WIiAqwL6quZP7Go5NaMdAav
         Js6Zozxgi6oJxOBXSaUhCLZfCi1jXW7R8hDm/3TL6QHXEfXTg4cZCqkABZg7tbA3d6TZ
         cgJg==
X-Gm-Message-State: AOAM5316Yu9EtfI8f88dyqAH48SkzoOEGzzSZOvKC0c+f6qp/qi9tp0V
        7jN0fcL8IuD6eoq5G/I9JO6f2INnP8g=
X-Google-Smtp-Source: ABdhPJw3ihSkv0YS89o2AyaxlKxj4jHTzGNTf8MmucMACjtno3SeF72Jj+lozAclB/g0NSyNpHTdSA==
X-Received: by 2002:a17:902:eb14:b029:ed:6fc3:a42c with SMTP id l20-20020a170902eb14b02900ed6fc3a42cmr12492593plb.26.1619913114663;
        Sat, 01 May 2021 16:51:54 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id l10sm5107780pfc.125.2021.05.01.16.51.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 May 2021 16:51:54 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] trace: replace WB_REASON_FOREIGN_FLUSH with a string
Date:   Sun,  2 May 2021 07:51:51 +0800
Message-Id: <1619913111-18873-1-git-send-email-brookxu.cn@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunguang Xu <brookxu@tencent.com>

Now WB_REASON_FOREIGN_FLUSH is displayed as a number, maybe a
string is better.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 include/trace/events/writeback.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index 1efa463..7c78c04 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -36,7 +36,8 @@
 	EM( WB_REASON_PERIODIC,			"periodic")		\
 	EM( WB_REASON_LAPTOP_TIMER,		"laptop_timer")		\
 	EM( WB_REASON_FS_FREE_SPACE,		"fs_free_space")	\
-	EMe(WB_REASON_FORKER_THREAD,		"forker_thread")
+	EM( WB_REASON_FORKER_THREAD,		"forker_thread")	\
+	EMe(WB_REASON_FOREIGN_FLUSH,            "foreign_flush")
 
 WB_WORK_REASON
 
-- 
1.8.3.1

