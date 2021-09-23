Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D746415481
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 02:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238639AbhIWAQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 20:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234042AbhIWAQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 20:16:17 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917DDC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 17:14:46 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id 134so5795902iou.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 17:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KdmefGt3bNlNy+/4h/zIr3+TEcrP0uqFHWCWgCsURrk=;
        b=CIt0XlW2blkwRYijUlUZYH0jBndiw3PUQ11Et/fKLHMj3Lvek78rjzgpWTmVqS1erQ
         af/jpIuRaIjHMTNykRxs8+68qF2wvZmRfL0XzdgeO9INSrzyXETgw+QOPvbRXlq4/4pr
         s776LarrjWvV+FOlN11Jku9hH+K16NkqdfRYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KdmefGt3bNlNy+/4h/zIr3+TEcrP0uqFHWCWgCsURrk=;
        b=m2znYuMR8APiMCx/GcGwfmCMzVZkyFBtRza5ySv7BvirLTNFW5gb91ha8TpMrQ0KEJ
         rVS4rsAdxeyxd8oW6+HNkQf6JhLDw4YaZY/7MbEqcr7ysemhjFobEs2M0uOpfd4IxgWo
         SZEVr7EgQgDsEX/LdLRyJOKg2AAYFM+8LRt3kfMt5tdBB7Yd8USJZpDfWDRb3qXgdP1o
         k3ccl2SNxcM0BH0hT/61JombmWeMuy5H6I/hcgEfMsZ/HkOts4DGQ+iq+56vVteKsej9
         IXibA2QrZa6QxdvAvkt0SweffTkUGRb5yv24LOCOjHOF/laJ6vGIBZ3PhAswN85orqyv
         f7Ew==
X-Gm-Message-State: AOAM5329qwKCX+/5vj5VQncfURvtpW+7qhMQbTDi9+8ITpzMYISAgnRb
        Z7MVECxPj3gfoCmXN5TiItrPGQ==
X-Google-Smtp-Source: ABdhPJxlL1X4qZmRxNozt+fWTK0Fm3LTnOwmLc7rgcjMW4pCPtqberO7aatizcBPwLWvZlKlRA0uIg==
X-Received: by 2002:a5d:8183:: with SMTP id u3mr1432360ion.67.1632356084737;
        Wed, 22 Sep 2021 17:14:44 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id z6sm1695560iox.28.2021.09.22.17.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 17:14:44 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     mcgrof@kernel.org, jeyu@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] module: fix invalid ELF structure error to print error code
Date:   Wed, 22 Sep 2021 18:14:42 -0600
Message-Id: <20210923001442.58278-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When elf_validity_check() returns error, load_module() prints an
error message without error code. It is hard to determine why the
module ELF structure is invalid without this information. Fix the
error message to print the error code.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 kernel/module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/module.c b/kernel/module.c
index 40ec9a030eec..a0d412d396d6 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3941,7 +3941,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	 */
 	err = elf_validity_check(info);
 	if (err) {
-		pr_err("Module has invalid ELF structures\n");
+		pr_err("Module has invalid ELF structures:errno(%ld)\n", err);
 		goto free_copy;
 	}
 
-- 
2.30.2

