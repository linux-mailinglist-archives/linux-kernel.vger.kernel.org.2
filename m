Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06DFC322589
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 06:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbhBWFuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 00:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbhBWFuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 00:50:16 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1104C061786
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 21:49:36 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id x8so8571280pfm.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 21:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=7nwUfi6KIjUP86InROw8rezoggekF6NyvMMzvhEEfuc=;
        b=DdOC52yIOgIVLVqy8L6geNt6kv4oQHZ+0stdaEngdr1Pye0W8QrZeTNXPbURhvnd4H
         MV3AopjkbFvWVImM0k2cxPrdXxJj6N1VCceXHHnjjC0KJdEwS0LsnSjd8RvvTEMRkQY3
         FHf4uuuFKChbmvTs2tjeYyzMKK1+eC9w7PryHZMQ9tjm85QrNoFovn4yyVVqPbRk+Zru
         TnqgvSnII/+SJ1VLxizjfgRFh8wdtT/Yp0WMRWdKkLobs6QjQcvW/dQp/DVYnUpWlX16
         dgPj1t5sWBst4Qx5D5LiwlKlWjAiK2EHuRxPiHRhZHl9McNSOrB76M0BhGYWuNKnWsd2
         DuWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=7nwUfi6KIjUP86InROw8rezoggekF6NyvMMzvhEEfuc=;
        b=HpT3xH09Ea37Bbyuarme5P5K+BXkIVZYp6nxDRWCkPhdQt90wN1z6vi1mE984Nk/aX
         FdIh3AJ+fG7T38KVnAI4qFrk6G50esfYeKY+dQLohPqfSbeaAM+6V06qpV5zfsL/y3KA
         uJzicnWD7Tq16bikB1PK6Mgquq1/CtcsolR4PoTMsre1iu1r66FxbiILKniigIAVqNhG
         UtXndAdMLXJQsAI+ckQ5YFkBNOUJ3oefuhDHFpNA5MAATRqQttswg7ulKQdUOFlqqrcw
         hXFuqN119dAjtbqKXplAfu66z1UlBCuDaQP5sHPvtw58JpKnTTWnF0GCB7q7siQq8OIe
         QZbQ==
X-Gm-Message-State: AOAM533aWbAuT+S3+Kbejj61tDAoMHM8UbrAeNjw5su9O9Afo0+2MoQV
        vljo8uY1ZfR0JDPsLp+Bi1i398o+uvWP0Q==
X-Google-Smtp-Source: ABdhPJwAvKCuH2qeLRwQU63G6ZDF8lDWeVx5XsfZ/09EMAh51iJizxA7XPlCxfW7ayvniPe4PoJSbcX96tq+oQ==
Sender: "davidgow via sendgmr" <davidgow@spirogrip.svl.corp.google.com>
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:4d9f:f9a0:2f68:6a44])
 (user=davidgow job=sendgmr) by 2002:aa7:96cc:0:b029:1e7:c46b:2954 with SMTP
 id h12-20020aa796cc0000b02901e7c46b2954mr837722pfq.68.1614059376187; Mon, 22
 Feb 2021 21:49:36 -0800 (PST)
Date:   Mon, 22 Feb 2021 21:49:30 -0800
Message-Id: <20210223054930.2345555-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [PATCH] kunit: tool: Fix a python tuple typing error
From:   David Gow <davidgow@google.com>
To:     Daniel Latypov <dlatypov@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     David Gow <davidgow@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        linux-kselftest@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first argument to namedtuple() should match the name of the type,
which wasn't the case for KconfigEntryBase.

Fixing this is enough to make mypy show no python typing errors again.

Fixes 97752c39bd ("kunit: kunit_tool: Allow .kunitconfig to disable config items")
Signed-off-by: David Gow <davidgow@google.com>
---
 tools/testing/kunit/kunit_config.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/kunit/kunit_config.py b/tools/testing/kunit/kunit_config.py
index 0b550cbd667d..1e2683dcc0e7 100644
--- a/tools/testing/kunit/kunit_config.py
+++ b/tools/testing/kunit/kunit_config.py
@@ -13,7 +13,7 @@ from typing import List, Set
 CONFIG_IS_NOT_SET_PATTERN = r'^# CONFIG_(\w+) is not set$'
 CONFIG_PATTERN = r'^CONFIG_(\w+)=(\S+|".*")$'
 
-KconfigEntryBase = collections.namedtuple('KconfigEntry', ['name', 'value'])
+KconfigEntryBase = collections.namedtuple('KconfigEntryBase', ['name', 'value'])
 
 class KconfigEntry(KconfigEntryBase):
 
-- 
2.30.0.617.g56c4b15f3c-goog

