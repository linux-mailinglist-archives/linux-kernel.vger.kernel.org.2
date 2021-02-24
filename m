Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40BC832401C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 16:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237619AbhBXOjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 09:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235406AbhBXNT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 08:19:56 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160B8C0617AB
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 05:18:39 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id r19so2105266otk.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 05:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=COjV3N0ToYDZxDDGk/b79HOkWGjdIOUR0bjGwTUhLI4=;
        b=FoyWNq//WVhTJNg+Cpr51IOfa9z17QiYZLALQW0f/kG6rg+oBWmK3JxCAJZ83J2RgC
         Gy+UAXdqSurDT79Kfau4ONhRWfhcCqVYaig1RGeSpRc2KuOotWRre+69+f55OBION/Ru
         fzbfF4XxgqNCsvPhBRhQdj0L7E27w0s3qGUto3G/kIdmOBfdV7XhXyWrsXvMR/BZ1Bn7
         FN940rXOjKL/zHPmYPTYoCr6HeV57nFjHuIk/9BDHeYq8YDXPq746ZK+f1wpnwP9RQ4q
         XpeyLxjGb2r/Bf+o7pIRfcUeFZ4zm05V7lsgpw37owDcW6DypcDt9hn0buW++QNLbS4h
         GCIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=COjV3N0ToYDZxDDGk/b79HOkWGjdIOUR0bjGwTUhLI4=;
        b=udfcHdUaaMdjhdgYx7vsE5a2lflsd6gWqyN3J7f/GzFlVulXodQJ7O9uP3k4B2bF9j
         NtYnF0MZHMspymKr/Wj7KZmsdE6+X9jubR5kmeXv2esXHvSK8zNJ2PgB7sZYn0MdnFL2
         WWJPKqEfe/tSPikQpWFgZrIrJ+PWM5LmPj1YSSHdmY+uMLB8z3ebPCbuIvbKCYotd5By
         W6ImMTQ67jebbqcSKMvoYT7AHqd/BiaK0SMGwFkAa1SdttKSlKQFbtx50kihD/TfqLq+
         NqooZDOlDJ4ueaDsFjumG2oH/SxiKiukXjYAJaAc8fkzHzn2sdDGh60xG9oXZp/Vq70u
         OBqA==
X-Gm-Message-State: AOAM533YLAFF1paxWA8GyVFku42pxCNGmMrrlpDUDFCqy/zAh/BYX6C5
        F1zGY2CmtwJ3b2yC1LhKzwlVHQ==
X-Google-Smtp-Source: ABdhPJwSvAWrC7SF1Ki0wbLNl8L/MA7aKQkO20w/rnGGKFIGkAu5rn/ynt6NDxGrgRQ3Xu9C9k5rgg==
X-Received: by 2002:a9d:5cc3:: with SMTP id r3mr1089483oti.0.1614172718548;
        Wed, 24 Feb 2021 05:18:38 -0800 (PST)
Received: from winterfell.papolivre.org (winterfell.papolivre.org. [2600:3c00::f03c:91ff:fe69:3960])
        by smtp.gmail.com with ESMTPSA id b21sm380069oot.34.2021.02.24.05.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 05:18:38 -0800 (PST)
Received: from localhost (unknown [IPv6:2001:1284:f016:4cfd:27e0:441e:870:6787])
        by winterfell.papolivre.org (Postfix) with ESMTPSA id 580871C2F43;
        Wed, 24 Feb 2021 10:18:37 -0300 (-03)
From:   Antonio Terceiro <antonio.terceiro@linaro.org>
To:     linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH] Documentation: kselftest: fix path to test module files
Date:   Wed, 24 Feb 2021 10:06:05 -0300
Message-Id: <20210224130605.347728-1-antonio.terceiro@linaro.org>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The top-level kselftest directory is not called kselftest, but
selftests.

Signed-off-by: Antonio Terceiro <antonio.terceiro@linaro.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/dev-tools/kselftest.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index a901def730d9..dcefee707ccd 100644
--- a/Documentation/dev-tools/kselftest.rst
+++ b/Documentation/dev-tools/kselftest.rst
@@ -239,8 +239,8 @@ using a shell script test runner.  ``kselftest/module.sh`` is designed
 to facilitate this process.  There is also a header file provided to
 assist writing kernel modules that are for use with kselftest:
 
-- ``tools/testing/kselftest/kselftest_module.h``
-- ``tools/testing/kselftest/kselftest/module.sh``
+- ``tools/testing/selftests/kselftest_module.h``
+- ``tools/testing/selftests/kselftest/module.sh``
 
 How to use
 ----------
-- 
2.30.1

