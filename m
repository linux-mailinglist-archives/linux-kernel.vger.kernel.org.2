Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7BCE40DD08
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 16:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238680AbhIPOmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 10:42:37 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:52704
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238671AbhIPOmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 10:42:35 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7A61F3FE09
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 14:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631803273;
        bh=sXPKIv1Z5blwcAQur9L48AooSj2mfgTEzoX9n61thXY=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=otlLfJpaMdoB8RAvk4PlL2sJvbDgrcXli09EPpALNJ6w7LRceUN2wddUWfcNu2S6K
         tjb0vXQv7fapBaUQUfrLHU/owfH/TQP5du1HURCNBuB3mTY91XUo5urcFFe8MNT/vl
         qlRsScIYbCFJYfLwi84ed22Agun2LHqr9bcsgL4FLmwySt6C+iToFIxqujksDr3zCI
         j2KJ/nq95MgMKrBJZEQ4N7vhzEqY7h//zukc+Mii7dI7+O8MnJE07XRSN4MumguBUe
         1FrHFdJhEaZ0Dcm8JqqIlEhLuVDFg7Rr0lhjy/gXGLK4EpvlSofRKZSLaMwlldaQQB
         X9aXGzZqQKXnQ==
Received: by mail-wr1-f70.google.com with SMTP id x2-20020a5d54c2000000b0015dfd2b4e34so2518955wrv.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 07:41:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sXPKIv1Z5blwcAQur9L48AooSj2mfgTEzoX9n61thXY=;
        b=1it67HCqr+u1vpFghqYAezN6KHhdAOCFCQQoL3Z64aJwqpp0/2PHeTCscLfAhk/o+k
         YOremzul4HlbBQT3LLWTdonsLZjwsUaFLwIgL3KT4bwafrSYZzfbUmvD9vEzAtD/1aSt
         nzxxbf+ANw2Z5wcaNetIQ+iDAdkxLpvj/bFswvXdIy+P6NRDj4UxmJ/5JrMQCcocBpAe
         0kJP1NLT1VbnyaHx8EjVFYW8LE9PSXhKPb4e1mkW692TU0NOkq/Zi67B7g3tptN/xlI4
         WtmNudlEdIllt/tSAXnX/KV7HGHF8Fr181p01S8P0YXwj7yfEHgwimpiYJfyyVKYL8TG
         Ofow==
X-Gm-Message-State: AOAM532aGQD566+4OQBOrD+1x+YfMz2WWy6/HJ1ffGoEfQnCgk9d2OMe
        HsRR1iFQhKC+FUkEr3X1mJx6wGowCTSoEQlCjLmdgUuS9MYsJQYZmJNa8JR/o2tmLOkDfFCahPn
        MyvwJFcdV7CZT+Btd5qssP8B/D7JYoVPRKJyGYiQVtA==
X-Received: by 2002:adf:eb02:: with SMTP id s2mr6626645wrn.294.1631803273237;
        Thu, 16 Sep 2021 07:41:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJylucwgzoEGxTQLoEP8E/uaGJMZjuIkjzwRPGytc8aksHOsXXDtMiwWfOrzuySnVSRyt8Xatg==
X-Received: by 2002:adf:eb02:: with SMTP id s2mr6626629wrn.294.1631803273061;
        Thu, 16 Sep 2021 07:41:13 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id u25sm7741432wmj.10.2021.09.16.07.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 07:41:12 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: [RFT][PATCH] regulator: max14577: Revert "regulator: max14577: Add proper module aliases strings"
Date:   Thu, 16 Sep 2021 16:41:02 +0200
Message-Id: <20210916144102.120980-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 0da6736ecd10b45e535b100acd58df2db4c099d8.

The MODULE_DEVICE_TABLE already creates proper alias.  Having another
MODULE_ALIAS causes the alias to be duplicated:

  $ modinfo max14577-regulator.ko

  alias:          platform:max77836-regulator
  alias:          platform:max14577-regulator
  description:    Maxim 14577/77836 regulator driver
  alias:          platform:max77836-regulator
  alias:          platform:max14577-regulator

Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Fixes: 0da6736ecd10 ("regulator: max14577: Add proper module aliases strings")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

Not tested. Please test/comment.  This is an RFT also because reverted
commit said to fix autoloading issue which I even reviewed... but really
it should not be needed - alias gets duplicated.
---
 drivers/regulator/max14577-regulator.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/regulator/max14577-regulator.c b/drivers/regulator/max14577-regulator.c
index 1d78b455cc48..e34face736f4 100644
--- a/drivers/regulator/max14577-regulator.c
+++ b/drivers/regulator/max14577-regulator.c
@@ -269,5 +269,3 @@ module_exit(max14577_regulator_exit);
 MODULE_AUTHOR("Krzysztof Kozlowski <krzk@kernel.org>");
 MODULE_DESCRIPTION("Maxim 14577/77836 regulator driver");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:max14577-regulator");
-MODULE_ALIAS("platform:max77836-regulator");
-- 
2.30.2

