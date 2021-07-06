Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59D963BDB52
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 18:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbhGFQ3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 12:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbhGFQ3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 12:29:07 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6401EC06175F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 09:26:25 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id w74so3303662oiw.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 09:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xNz5hC6gd0RICEGuO8Kja9lfPwHmN+gkPzAwiuNbxcM=;
        b=ZbiaI59teQehGCROuzgxise6D+/ebTp3pHt/2fmm8meseWDiuHBtMb2mFp22SaWCk+
         8Vi3h2u/6cDhasQQk5g/XRBi7a5xNAisj1g+ULwR3lQXwk2f/XXZKAzcyPjYrOeyL8UB
         FjazDuWnZkVDvZt8Y0KUTGNmFXGf2G16vpTFM9Ebz6cUVeO+eKQk/D4neDL1MvCzLLku
         8/qJvq1qEwEKUwcS2k06UjPD4a2+BvNsl1GhMAThANkA15sKsFWdldaAc5BMGGIZpObQ
         RKZj/nGlH8vMLE2gqHoTELipQ7J6j2fCMsNrUIA06jy9DVGL/R4HpTXhC1yBZRWsQYip
         sW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=xNz5hC6gd0RICEGuO8Kja9lfPwHmN+gkPzAwiuNbxcM=;
        b=N2SACNsUor3pMzDmOMnpzYdLUJYGvDuW+BOkNow69E+DmhAJ4x3AM8yMrmIJJCZmHB
         0LUR9IZYz9keON5PSfffMMVsifZvU0uOxyJoMiFWnrHYVV6O8wWHDlTmMP/ZYbYLT1UK
         yoX6tRcgSIjAzPMY8iBnBaW/fKSK7gEd9tFbS0P3Qx1BkHIJVJ13JCxY+c2tAHyscESV
         EJHII8KmOCx4bsjwydmowqU1wKJK9WaCyMZME4BQtA6k4L6v3ktjILOMLQutTVsOjDds
         FnddJQVjUJHXddc5W/lzn0WKwRyOZqW0KLBDY0lxrDuZ258lP+ruSJnDXT+p8veC4FNn
         lJHg==
X-Gm-Message-State: AOAM532MpCbcROWPwacV6L6sMuLszY5niwHPDc4VcrLUod0kHCtu81NK
        /2yXCZdiZyMx5IUeaAD9azA=
X-Google-Smtp-Source: ABdhPJyr0KilJxGDDxi92JYBtK6XSjfvtjCWsUVJDIcARXhdENVebdhJRrNevs2yUdXcyUWTznCK7Q==
X-Received: by 2002:aca:1809:: with SMTP id h9mr1114359oih.4.1625588784716;
        Tue, 06 Jul 2021 09:26:24 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f20sm120586otq.35.2021.07.06.09.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 09:26:24 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH] riscv: Disable STACKPROTECTOR_PER_TASK if GCC_PLUGIN_RANDSTRUCT is enabled
Date:   Tue,  6 Jul 2021 09:26:21 -0700
Message-Id: <20210706162621.940924-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

riscv uses the value of TSK_STACK_CANARY to set
stack-protector-guard-offset. With GCC_PLUGIN_RANDSTRUCT enabled, that
value is non-deterministic, and with riscv:allmodconfig often results
in build errors such as

cc1: error: '8120' is not a valid offset in '-mstack-protector-guard-offset='

Enable STACKPROTECTOR_PER_TASK only if GCC_PLUGIN_RANDSTRUCT is disabled
to fix the problem.

Fixes: fea2fed201ee5 ("riscv: Enable per-task stack canaries")
Cc: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 469a70bd8da6..3afb84fa2190 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -486,6 +486,7 @@ config CC_HAVE_STACKPROTECTOR_TLS
 
 config STACKPROTECTOR_PER_TASK
 	def_bool y
+	depends on !GCC_PLUGIN_RANDSTRUCT
 	depends on STACKPROTECTOR && CC_HAVE_STACKPROTECTOR_TLS
 
 config PHYS_RAM_BASE_FIXED
-- 
2.25.1

