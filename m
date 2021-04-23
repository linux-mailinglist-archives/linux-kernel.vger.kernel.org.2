Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 904763699E2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 20:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243642AbhDWSlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 14:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbhDWSlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 14:41:10 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE24FC061574;
        Fri, 23 Apr 2021 11:40:31 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id gv2so14966149qvb.8;
        Fri, 23 Apr 2021 11:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kp0AZqB2LZLp9+dbyTc+UjKsqQvvjs0+ttZldFA/ieM=;
        b=j3Ads+KrGvuDd/qqKKYb+7QN+VZ/Rc9VfNKSe3Al2iJeziQcm98f++TcFnCDq2l4/O
         0hrqTPgwqvXs87RleLZpyTNzomL1Gn9StpF3Oh6TZr+IHOV2rPzpv+QIXBuUIoxw65LG
         nLluB/1pqlNZ4J3y0q735ouSUgesOhA7nNF56bVAguQzefADJZkho5YzWSW2NzooAVyU
         wx6V3MgkSm3PEPZUEKW29XfPiOJ1aHmcIDV47de46351tRUqW0R3prxY8aklbr2Tijj/
         QQLFZqJwB+50ZKhunu4S69PPex1R8A0iiXvq3VV/FGCx5NOZAirstUWOJo61itXRTk4H
         xsQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kp0AZqB2LZLp9+dbyTc+UjKsqQvvjs0+ttZldFA/ieM=;
        b=UpUEG7NzC4ybr2aI7yIWQ03r7bu9iryKb4AhBqckZy1yGVonpQToLbFPjfnIm0ikSl
         R/Rl2iLrfleO7YMuUDQUOrcsCi4iVvKzn3reiOLfY0v0LWcwzirrbA/0qxFhXNZQbgKe
         Fp+BAkjcP9ogRbkLUCYhPG5FhMiWoxh8ceBgDtvRGf5mdBVHN5u2oLQ5sOghaatzHgkj
         U97G4kJgSKT2Art7cy7JP7KJlDXmbhr8hvMqyOAJ7bvgsTDAfvkhoBCL9u2v7B6LbrFz
         Utyz39f1jvC39CMVqjmq79fKTxpeKIcSwpa8Uyn31qHdmZk+vleRtUDVk8a/CNwukHrC
         X9ZA==
X-Gm-Message-State: AOAM531LBY7CFUB2jfTuz4gmsiqRHMfRSCWHx+164QbPVSn3F+fek2nm
        JIU3fZBDshgZAoescEP/udlwjDZ59IM=
X-Google-Smtp-Source: ABdhPJxis5YchZ25UibQEYYcF2sayIZBM4encRUjl9dRKPiTgJCoh/xIiX2OCMfdMBzA280hpKBZmQ==
X-Received: by 2002:a05:6214:1467:: with SMTP id c7mr5691134qvy.7.1619203230822;
        Fri, 23 Apr 2021 11:40:30 -0700 (PDT)
Received: from localhost.localdomain (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id h65sm4832715qkc.128.2021.04.23.11.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 11:40:30 -0700 (PDT)
From:   Trevor Woerner <twoerner@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, Jiri Kosina <trivial@kernel.org>,
        Joe Perches <joe@perches.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Yorick de Wid <yorickdewid@users.noreply.github.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION)
Subject: [PATCH] coding-style.rst: trivial: fix location of driver model macros
Date:   Fri, 23 Apr 2021 14:40:10 -0400
Message-Id: <20210423184012.39300-1-twoerner@gmail.com>
X-Mailer: git-send-email 2.30.0.rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dev_printk()-like functions moved to include/linux/dev_print.h in
commit af628aae8640 ("device.h: move dev_printk()-like functions to
dev_printk.h").

Signed-off-by: Trevor Woerner <twoerner@gmail.com>
---
 Documentation/process/coding-style.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
index 42969ab37b34..44f796ba52c4 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -855,7 +855,7 @@ Kernel messages do not have to be terminated with a period.
 
 Printing numbers in parentheses (%d) adds no value and should be avoided.
 
-There are a number of driver model diagnostic macros in <linux/device.h>
+There are a number of driver model diagnostic macros in <linux/dev_printk.h>
 which you should use to make sure messages are matched to the right device
 and driver, and are tagged with the right level:  dev_err(), dev_warn(),
 dev_info(), and so forth.  For messages that aren't associated with a
-- 
2.30.0.rc0

