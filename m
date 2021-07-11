Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 188373C3B33
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 10:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbhGKIsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 04:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhGKIsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 04:48:37 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5672C0613DD
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 01:45:50 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id v14so475139plg.9
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 01:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IOD01bDapMoHs0kjtThMN4wey/sA+HYWQBSL1w7djts=;
        b=kUFy5PzJLP5o2Lfv8+0HrQm47CiII/qtVAjxcsbr4dc1u5Id4wFOnB/u0L2V6cjalM
         Ej6/9CZ5AjUHxwXJxIGYFiZ0HjMfkAvNJXzXLbwbM1yFbNF/7hRCUgNhzuGKUEr9nxxB
         CGbeDoNxfVkNF0EN7cK4m3Oj6EfyaWMnjvku6Yg2ABOYWLCA8pZy2CY2piM7WEU7QddU
         mEtSrHX8+jrk8LHtymJ5GbOJCT7aiYnnET+nt6KsK2X5spzWYWHD+WxL39dhuICiofZv
         Wbd3o2TpQEbf4GOHp5Q4VVeRMDNGAhHxSrMvfm+1PyH3sZK23YDQ34h7xhwMYqll9+PY
         DDyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IOD01bDapMoHs0kjtThMN4wey/sA+HYWQBSL1w7djts=;
        b=e0Z95Qa8qwEyFkAsazyH5IMeJQiNv7MuISJrIrM1KrKLyMrZoXssW7ge7DT8rjhsKZ
         tZOPoVl4arEKHyXj5L1ab7So/B9Lqnl2vUL6i3WEyizLEBcTF0zOLSaek7KsU9foMxCG
         UMDXzrqQegMmUiZ8sRVb2thfSazlHU8ZKDq6paezq0Nuk/awOqRaH/I9Ct/bHwj6V8w+
         6QQgyFWGVwcNjzGEhAiIOcm2JNQlLlLe9KpKTPNXYstTCbkP9Bx1NWdZirFzjYhUl386
         yvQIWKyJY7R36qVof2Gd877ZQULhwgpI6tXsfA7neVQAyLHnkKt4QE49H6GKPMmin09h
         1fGQ==
X-Gm-Message-State: AOAM532gxJxUiUqO2QzPRhW8uPnKFApC+EgrBtipDfbd5Nwr6OrWy8S8
        nUOlaB34aAaBTd6lRMvd2vY=
X-Google-Smtp-Source: ABdhPJyCAuNiPmfuGbeOtJsa7jM2AN9jr+M1bzmq0RMzzPmmvJspQGy1EyQySlSXk+rmjYtxxNnkng==
X-Received: by 2002:a17:903:244f:b029:12a:f0f9:19a3 with SMTP id l15-20020a170903244fb029012af0f919a3mr5365973pls.42.1625993150306;
        Sun, 11 Jul 2021 01:45:50 -0700 (PDT)
Received: from localhost.localdomain ([49.37.51.242])
        by smtp.gmail.com with ESMTPSA id k9sm11663601pfu.100.2021.07.11.01.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 01:45:49 -0700 (PDT)
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com, Dwaipayan Ray <dwaipayanray1@gmail.com>
Subject: [PATCH] arch:powerpc:mm: cleanup __FUNCTION__ usage
Date:   Sun, 11 Jul 2021 14:15:36 +0530
Message-Id: <20210711084536.95394-1-dwaipayanray1@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__FUNCTION__ exists only for backwards compatibility reasons
with old gcc versions. Replace it with __func__.

Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
---
 arch/powerpc/mm/numa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index f2bf98bdcea2..3d3f570c925c 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1236,7 +1236,7 @@ int find_and_online_cpu_nid(int cpu)
 #endif
 	}
 
-	pr_debug("%s:%d cpu %d nid %d\n", __FUNCTION__, __LINE__,
+	pr_debug("%s:%d cpu %d nid %d\n", __func__, __LINE__,
 		cpu, new_nid);
 	return new_nid;
 }
-- 
2.28.0

