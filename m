Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31F0B3D720C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 11:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236117AbhG0JcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 05:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235897AbhG0JcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 05:32:04 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3ECC061757;
        Tue, 27 Jul 2021 02:32:04 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id n12so10824099wrr.2;
        Tue, 27 Jul 2021 02:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=w7wZEEL9rZqySe44kDL/q1xR524n0BSWFazCWSLOVKs=;
        b=jUZS6qdAjkTvW7EKlSJ933UWY3bv5y1ZYjKg7R5fg4XiNs5HyWkJM5TJPbqbhm6kgV
         YKCrdUt1H0WJGhfEaGlxvl/zmTvRIY1kcLYry3mhAhOLl3248kgj1TrNEYJOiY9sqmMn
         2XFy+ztYEQAAZwWlrDbJHGATP0iSgKmaixHtRxVdG++jaCseGiYjxE1fbPQ2CZBVHB1Y
         aotK8kwAzx+a1eymvTlnPF0v1AR7o8LxMbQEbWJ1C22+mTc1Jo32gFHuedH7cy9nvlf8
         RtcNUW9hkoMLi7gqYflwVr/xGC+eI3xmNHcALpqunQUw+7LTAXwIan/v77jGrppzYagb
         azXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=w7wZEEL9rZqySe44kDL/q1xR524n0BSWFazCWSLOVKs=;
        b=nuKOjl1l7Buk6jB7tcQc6fyzMw33eUHujcHaoi+fjvcc9m5eyc8IKd4i3QfAFjq5Nx
         u+6SuBSaphi7PAV0HGCflLRr863Cpyxg1dXPzF9X4APTy2NkRo5DUXWPKDCYvldjadFV
         uz6uZbtIlXy7fszJUyLES582PCXa/Xcp3Y8y8ysDWYhGxwCsOEWdlHHJlSUfG7GiDCa0
         jfxY+Jz6D3D5NqD70LSRW+bW934AFC+d7JyqEMjVv+AgIBpoSYLp7CDk2fT7xhR4Bosd
         3lMxVIJvyZMaDAbMNHZ/JLK03FUoIHipGA6SaOZO031D4KnvUhsJe1M2imc/lM1brsEI
         hUhA==
X-Gm-Message-State: AOAM533EMjja3sRkyQvLcYXmQrv7rSWjrQpJPYY0jLLd85qB1r+E1iYV
        6jjzNzkj5PxByfu2D3VkGYk=
X-Google-Smtp-Source: ABdhPJyEmHp9NOgzU8lswOkDOS34Fw8Akpm5TmO0JmiOlgQVSz3lAd5ar94Jb4LtLUWFpV1nC4wd9w==
X-Received: by 2002:adf:f789:: with SMTP id q9mr8156786wrp.380.1627378322615;
        Tue, 27 Jul 2021 02:32:02 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2dbc:0:4075:79fb:1c82:6a65])
        by smtp.gmail.com with ESMTPSA id q5sm2620362wrx.33.2021.07.27.02.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 02:32:02 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: remove section HISILICON STAGING DRIVERS FOR HIKEY 960/970
Date:   Tue, 27 Jul 2021 11:31:54 +0200
Message-Id: <20210727093154.553-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 9bd9e0de1cf5 ("mfd: hi6421-spmi-pmic: move driver from staging")
moves the last driver out of ./drivers/staging/hikey9xx/ and removes that
directory, but missed to adjust the HISILICON STAGING DRIVERS FOR HIKEY
960/970 section in MAINTAINERS.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains:

  warning: no file matches    F:    drivers/staging/hikey9xx/

As the directory ./drivers/staging/hikey9xx/ is gone, remove the section
HISILICON STAGING DRIVERS FOR HIKEY 960/970 in MAINTAINERS as well.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on next-20210726

Mauro, please ack.

Greg, please pick this patch into your staging-next tree.

 MAINTAINERS | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0f548b498eb0..2eb730101689 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8453,11 +8453,6 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
 F:	drivers/mfd/hi6421-spmi-pmic.c
 
-HISILICON STAGING DRIVERS FOR HIKEY 960/970
-M:	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
-S:	Maintained
-F:	drivers/staging/hikey9xx/
-
 HISILICON TRUE RANDOM NUMBER GENERATOR V2 SUPPORT
 M:	Zaibo Xu <xuzaibo@huawei.com>
 S:	Maintained
-- 
2.17.1

