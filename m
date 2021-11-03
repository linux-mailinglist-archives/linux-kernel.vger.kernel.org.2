Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77E7C444AE1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 23:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbhKCWdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 18:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbhKCWdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 18:33:32 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3CDC061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 15:30:55 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id z7-20020a63c047000000b0026b13e40309so2197564pgi.19
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 15:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=iebf2W2QZ+CT/VCZU+Hm1RFCYYPaaTgdO1Vs4vFVk/g=;
        b=LJ5ydDCSfe34tiYb1rbrzNQ24lgoT6TOhnin7XQpu/6gmW1kRn4DkScXHuGgBkKCUq
         BkXZucHIe02xQdeU++xd4kRBgeMgmboKM7fXSDejgRwRmzYYjGZqgmpNaw6uzOqP1bZZ
         9tOuUWJ0axdnk88IW+OnOoVs8JaUOkAiOMMlwU6DRAqJuLIZ1NiEnpEsLhspJ/tdigaj
         E9R76pVGNNLPwhEw0rhCfK9skILdmPhjSWWcANMJxS6sbUZHC3eOBJGFyUWQ1q2A6Ger
         KMUfuh9T8BydYeUW+cjVSWIULMbeLTZba4zO5smWeyn88/aJcTURBZqw7C/X60OflDGY
         XsLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=iebf2W2QZ+CT/VCZU+Hm1RFCYYPaaTgdO1Vs4vFVk/g=;
        b=5i9Befs17jDVCC6JYMqndDucvT1T9PuwxTS+OnCaxpGPJBynPnnIujBqRDGpJWdKyw
         e7A23vF5tanYekqAl9aPznOWXDQQO05TeCx8jucOk2jBTIkPZ8SyW7Mq4xHJeDztKDWd
         iCXDmjQZ3KQ39xWIRsMr9E0u5A6o6uVjZv2pbC6N0IbMp6ehA0iTIvAPAu1gYp/ZG61P
         k8p7QNWnfDru0dKlkbI1wR1KHXjeCh8xGiwCQ4aa0vh3pd3l64D92XzcgBkfiz97ACo9
         UE3lj0c4SEAmCKDkQIrHP9CfuijP+fZ7TirmWP2nQFKN0bS8O+OtwJjFAxuyL5Yyjmvg
         LVoQ==
X-Gm-Message-State: AOAM532NY2QkW2lHyhlWlLhwOA3Km1XyWzgd3yKJx7eTdxcqvQP5bKzF
        QBh7M1jxC8GeZ0dqixCZ7iNzQklnCUwarQ==
X-Google-Smtp-Source: ABdhPJwJIgl2hN2/bAUrlr4B5wueJajXtbw28t25Dj1nuV54iYV8938avoAn2/Ie+qSj5LLmk2ycxbYhH8OMbQ==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:8673:8d2f:d693:6af])
 (user=dlatypov job=sendgmr) by 2002:a63:a319:: with SMTP id
 s25mr35997164pge.305.1635978655060; Wed, 03 Nov 2021 15:30:55 -0700 (PDT)
Date:   Wed,  3 Nov 2021 15:30:45 -0700
Message-Id: <20211103223045.725140-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH] Documentation: kunit: fix path to .kunitconfig in start.rst
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>,
        Yifan Yuan <alpc_metic@live.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ddbd60c779b4 ("kunit: use --build_dir=.kunit as default") changed
the default --build_dir, which had the side effect of making
`.kunitconfig` move to `.kunit/.kunitconfig`.

However, the first few lines of kunit/start.rst never got updated, oops.

Fix this by telling people to run kunit.py first, which will
automatically generate the .kunit directory and .kunitconfig file, and
then edit the file manually as desired.

Reported-by: Yifan Yuan <alpc_metic@live.com>
Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 Documentation/dev-tools/kunit/start.rst | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index 1e00f9226f74..65f4ef6c1f4c 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -31,14 +31,15 @@ This file essentially contains the regular Kernel config, with the specific
 test targets as well. The ``.kunitconfig`` should also contain any other config
 options required by the tests.
 
-A good starting point for a ``.kunitconfig`` is the KUnit defconfig:
+If you run KUnit, it'll generate one automatically for you.
 
 .. code-block:: bash
 
 	cd $PATH_TO_LINUX_REPO
-	cp tools/testing/kunit/configs/default.config .kunitconfig
+	./tools/testing/kunit/kunit.py run
+	cat .kunit/.kunitconfig
 
-You can then add any other Kconfig options you wish, e.g.:
+You can then edit that file to add any other Kconfig options you wish, e.g.:
 
 .. code-block:: none
 

base-commit: 52a5d80a2225e2d0b2a8f4656b76aead2a443b2a
-- 
2.33.1.1089.g2158813163f-goog

