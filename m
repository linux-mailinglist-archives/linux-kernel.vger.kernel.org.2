Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0187C3B4C14
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 04:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbhFZCum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 22:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhFZCuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 22:50:40 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3432EC061574;
        Fri, 25 Jun 2021 19:48:19 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id o35-20020a05600c5123b02901e6a7a3266cso4619769wms.1;
        Fri, 25 Jun 2021 19:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=W4W0h5ZxQxl/maMOY4I4A6dXT+t4265XjPPnKLXbiPM=;
        b=kS0WaHZLnlCZEzUnM+F+QCEHop05C1M+Gec9M9TfnT0oSiUzBmBbiCH8jp2OZZ9V0w
         lUcgNT60VGBD2ji6tyiTi2djcWbX1AvJB65vfRTPAnv0buDbYFimBi7xmKDoGnDVmRhp
         OHehkk5gjMaIsBUhw/2ftdcKNUob2UUfbVpO+T35s8GU0gJxxYKb+LVroYB00jqOJUPD
         rN35mvNBhJ/XtSFUhDcuDVKg9qRlyB0DrVG1+qz00Xz0FHRb2dPbS4Cv62gNrUh3ZbP+
         KQAgNp40wcjzC89MnrXt/VeeZmnNelcDjWOjmYEMzuVOVGOZW8/QMYu3/q8HuZ4CnNT2
         Nuww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=W4W0h5ZxQxl/maMOY4I4A6dXT+t4265XjPPnKLXbiPM=;
        b=tArmvKcLnJcQ5pQxzkoxXXE+P7oU4lGzJ2/D1427FhTD8LHpE2XQ9QCtP3C+WVzP7x
         3s87Ht7znvXCHJO4m0cVdBXiFLqFTIIydUCVAaVKItV05Z4XkSB+17GUcwAjHotHLhsL
         Yo6fgqllp+/533xP0ckadACcziSHlZn0pVKvrIE0H1ac3MGg17sODRrtJLErI8mDsx1I
         omAn7wdtIs7AlbH1nLPxOQlNYCVvTJbl95JtBDKr0SdntJdlpVLFlyCfPKn+8qt5EQVi
         JvQ5UHmq4z2R18n2AAqgbYgtfjpxFS8qyU2HYhi+ft12uQurv7i5DuIoSdwQZqwn3sMz
         I9Cw==
X-Gm-Message-State: AOAM532MXEApGm+wdGB8xzqleduLvkH2j3BsV9zFQ7SrU12AnqhTJoSc
        ZWvQqAbjFHnJW1vD2DxiD4FYasaCaUY=
X-Google-Smtp-Source: ABdhPJxIsB5gyjNwrNP2c758iV0ZUCwEifSyRWCsks3vgkdh9iffOqvYJZaMA3GMJhuiyntRS5CDfA==
X-Received: by 2002:a7b:ce0a:: with SMTP id m10mr14400982wmc.149.1624675696703;
        Fri, 25 Jun 2021 19:48:16 -0700 (PDT)
Received: from localhost.localdomain ([197.2.60.97])
        by smtp.gmail.com with ESMTPSA id v5sm12689422wml.26.2021.06.25.19.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 19:48:16 -0700 (PDT)
From:   Khaled Romdhani <khaledromdhani216@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Khaled Romdhani <khaledromdhani216@gmail.com>
Subject: [PATCH-next] samples/kobject: Fix spelling mistake "tree" -> "three"
Date:   Sat, 26 Jun 2021 03:44:31 +0100
Message-Id: <20210626024431.7252-1-khaledromdhani216@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling mistake in the comment block. Fix it.

Signed-off-by: Khaled Romdhani <khaledromdhani216@gmail.com>
---
 samples/kobject/kset-example.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/kobject/kset-example.c b/samples/kobject/kset-example.c
index c8010f126808..48589740346f 100644
--- a/samples/kobject/kset-example.c
+++ b/samples/kobject/kset-example.c
@@ -15,7 +15,7 @@
 /*
  * This module shows how to create a kset in sysfs called
  * /sys/kernel/kset-example
- * Then tree kobjects are created and assigned to this kset, "foo", "baz",
+ * Then three kobjects are created and assigned to this kset, "foo", "baz",
  * and "bar".  In those kobjects, attributes of the same name are also
  * created and if an integer is written to these files, it can be later
  * read out of it.
-- 
2.17.1

