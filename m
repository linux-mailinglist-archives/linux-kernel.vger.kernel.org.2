Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCD743C4E1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 10:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238766AbhJ0IRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 04:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbhJ0IRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 04:17:49 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BEAC061570;
        Wed, 27 Oct 2021 01:15:24 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id t184so2054871pfd.0;
        Wed, 27 Oct 2021 01:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FkeGV2X5Ht4WOcxwzPnDHzustbz4fUY6SlFH5mmZHhA=;
        b=YgZkNKac6ZilncgALhUCR3GWw5DlAyr1rgpcGY/OZ/j6V2TlgJ+eu0mkSaAQp0n86m
         T305RAeK1fb5JVUI07auNsfLZdKdFOZMBC/6kjHsAU/WuBnpoTmN0b1roF4YG5yq2Zi6
         aKJw9u/ozRIxWqCPlWN4MOH2puSrvkNZe024iEq1O/0/u/AlR5XR2pJxps1YrD7BOJ9U
         PoboJjAselSPyLy3AUO6hNdsIB0z6AaxY+jk8MXJOVR68gqnavYkCDYpde6JShMjzRx6
         QOdQQv8dpGAOpARFxbjtSxgcku57dTerqlc0/8QYCHs/yGDREhAlbLh4GwmgSQHYJHwZ
         8xpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FkeGV2X5Ht4WOcxwzPnDHzustbz4fUY6SlFH5mmZHhA=;
        b=X5Ha/se+vog67USiK/TS1rOn+8REk2TL2SCeZmfz+15oIDg5vSmwKy5dsXSoZt7pij
         SsXz7+6IElA/OzZpzxEVuLE9u2bXNOpCL+Qetl5CKZUWYz25OZMsUO50wRAMbB1NIZDP
         e2f20uD4FYoRSlXm8Ya264L7tCLkbyw//RO0fowrH78ZWRMRveCKt+P2hyTdmEoTKOy5
         /+LMB2o3O2PViJ5QR9XQLnfmxJ3yRyQXMOKRkYBeiI6Rd6iZiko2puBiVKQNJX7IeWT/
         zgWl8trhzj0jtEsJsnOF75dQb1eDVkVQUzw3t3I1ZNj0JCQPdPtNlx67daE5LJZeZANy
         5ogw==
X-Gm-Message-State: AOAM530eFJ51wKEI6V13Ot3Ti5E2qeOeD3U916zBzkwJQ53BcOHZOojw
        EtiIJwCu8ew9sHQyyiH4ad3weYXdrWE=
X-Google-Smtp-Source: ABdhPJxEGe6edu9vJN3Nt4OkuncWrQlJBs0g/XkpZ3pk2RyKGskWlM4F95JezYN/NDE8RBQXQK0k9g==
X-Received: by 2002:a05:6a00:a1d:b0:44d:aa2d:9665 with SMTP id p29-20020a056a000a1d00b0044daa2d9665mr30903369pfh.24.1635322523557;
        Wed, 27 Oct 2021 01:15:23 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id h4sm3274622pjm.14.2021.10.27.01.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 01:15:23 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ran.jianping@zte.com.cn
To:     santoshkumar.yadav@barco.com
Cc:     peter.korsgaard@barco.com, hdegoede@redhat.com,
        markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ran jianping <ran.jianping@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] platform/x86: remove duplicate include in barco-p50-gpio.c
Date:   Wed, 27 Oct 2021 08:15:16 +0000
Message-Id: <20211027081516.1865-1-ran.jianping@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ran jianping <ran.jianping@zte.com.cn>

'linux/io.h' included in 'drivers/platform/x86/barco-p50-gpio.c'
 is duplicated.It is also included on the 17 line.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ran jianping <ran.jianping@zte.com.cn>
---
 drivers/platform/x86/barco-p50-gpio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/platform/x86/barco-p50-gpio.c b/drivers/platform/x86/barco-p50-gpio.c
index f5c72e33f9ae..bb8ed8e95225 100644
--- a/drivers/platform/x86/barco-p50-gpio.c
+++ b/drivers/platform/x86/barco-p50-gpio.c
@@ -14,7 +14,6 @@
 #include <linux/delay.h>
 #include <linux/dmi.h>
 #include <linux/err.h>
-#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/leds.h>
 #include <linux/module.h>
-- 
2.25.1

