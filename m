Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B2145735C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 17:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236770AbhKSQsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 11:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236677AbhKSQsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 11:48:07 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BA6C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 08:45:05 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id w33-20020a17090a6ba400b001a722a06212so9253324pjj.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 08:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=XVDzNl5P4QbzIYx/RkvDJ3xwFO1wfoLlk0Fo30BJPkI=;
        b=w+LQmyRAZkZrbqIBM7nvAvs3Z346eAzu5bMdTRDbICl47c4BayUT7sbCU4Yg29klim
         BCC4W7GlnS4obt7mvj8XjZzdTaf9Z5w6Z1uOvmL59OIEZi14lM1xg9ATgRwjCpWwbWHe
         CtxBpQAQoGnbC8lzvvzxLfBvwrg7q4//8zuJHf12qb5i4Ftr+LdBR9x5gDOmmoyMh/QZ
         bADwvbynDYnGLkrHkhyx+saSAJSm2EXXzHR9gUhBkCfs4mpLQz7YJukFHy5Y98mhbp1v
         4sRN+kkGfbi8BUIlX2dyei7SCPwIbHZvB2dYGf+DjRfCTQ8TNPrxv4ivECdPGzA1Hc6J
         k4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=XVDzNl5P4QbzIYx/RkvDJ3xwFO1wfoLlk0Fo30BJPkI=;
        b=r1tMChauWYlq/YejDu4C54zvXmYjuAIvM0Rz4FBSJb3RgD5IemVeqbWCBbM/DXUO3a
         9CaJ2ABXav2wzaOlROarVdvzNzz3pL4xmw1aBJcX5nUyITkZ2Sw3ia/U+BJMMwnZrGKH
         VYY73jv6go9HhT8R3xfpAS1T86q9/qzsxlWjkdS9td+LFFmRlE2d5qnaVrO1IDbSwNAc
         r1uhum6H1DvKI6vy4GKUkD4xUBk0ajCRlj6pCztFWN0tJua8KTd0WE/ufUa4xnI2EYLX
         cOq5Gf5yeblXR4h7L7Z51jns784jQFxjLvX+HZ9MGIWiIO9cYQ2LYvdUKo1n9Ap0m2h8
         gYGg==
X-Gm-Message-State: AOAM532sb2nxOw2agPpyr3fam4fVUQNVaeSai6u1CRIq3gtxq/IXsagD
        0O5IpVPdOW+nZRixrk9VqXVPTA==
X-Google-Smtp-Source: ABdhPJyy4gAQ08NUgm/LC6JyiF7yQwuEfYBbqCDVVXx/a5iu9/1PwjiKlJJUKsSFiz3Yuh66waG5qg==
X-Received: by 2002:a17:902:9692:b0:143:d9ad:d151 with SMTP id n18-20020a170902969200b00143d9add151mr30611268plp.40.1637340304995;
        Fri, 19 Nov 2021 08:45:04 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id y18sm216925pgh.18.2021.11.19.08.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 08:45:04 -0800 (PST)
Subject: [PATCH 11/12] RISC-V: defconfigs: Remove redundant CONFIG_EFI=y
Date:   Fri, 19 Nov 2021 08:44:12 -0800
Message-Id: <20211119164413.29052-12-palmer@rivosinc.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211119164413.29052-1-palmer@rivosinc.com>
References: <20211119164413.29052-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        anup.patel@wdc.com, heinrich.schuchardt@canonical.com,
        atish.patra@wdc.com, bin.meng@windriver.com,
        sagar.kadam@sifive.com, damien.lemoal@wdc.com, axboe@kernel.dk,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:         linux-riscv@lists.infradead.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

We've always had CONFIG_EFI as "def_bool y" so this has always been
redundant.  It's removed by savedefconfig, so drop it to keep things
clean.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/configs/defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index a72dbd74b93d..f120fcc43d0a 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -143,4 +143,3 @@ CONFIG_RCU_EQS_DEBUG=y
 # CONFIG_FTRACE is not set
 # CONFIG_RUNTIME_TESTING_MENU is not set
 CONFIG_MEMTEST=y
-CONFIG_EFI=y
-- 
2.32.0

