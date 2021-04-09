Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84593359857
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 10:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbhDIIy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 04:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbhDIIy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 04:54:56 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89DCC061760;
        Fri,  9 Apr 2021 01:54:43 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id z16so3399240pga.1;
        Fri, 09 Apr 2021 01:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oG2G658NtLLa0VJC0f0Y9Kde6tR+vyScuwahw6bMcWQ=;
        b=UdnXpL95mZV98AvOeCHKPOPkZ5KMjeFlk3PnTARizG5psZk+B+7Gk/2AhJjtqsLjLF
         DjPX2nRTgh4F57s2RjgIjjiGHBIWKEm+bWJA9MLJ1zqzM5lxCfK/yrG4lAhKkS7FNbj8
         2d2TjibQHiFyLyZuPTjVbf7KO6teMhrNkosmf3fy6Bmxw4qfNAGVsa4nmYHPYIOgzTXt
         HnjfyrlGTyiv0TXE0z+F9OmrJtwHPmIteVcmHk8YdgRYO4OPyI/iCvMdbH7Xe7GV+UHv
         KyZdzm5olyAM7XXr7axmsrn4T+EX/ikyLo+nG+8Qfy87ci7oXXB/9TrYBmsUQ5iZEqv1
         r1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oG2G658NtLLa0VJC0f0Y9Kde6tR+vyScuwahw6bMcWQ=;
        b=V98qG4FCq+Io/3PgcJy6JFs9uyghAk4fy9SHZ4zEDNHXaMR0ZIGS2Ls2BvojeOtlB3
         osL87CXAhO1p7jYIC8E3el+QJVygAgd8yPRDG8unyIVTJsgQmv7Xz7eRYMvRrMtb5jel
         QmAnFSJNloJmUCOzZw/rgNUjmz+aMWd6rLM0qu9eyM6B+b/spN6L4ltIzDGYFUzuHbwE
         aqWxp0/+LN2YL335eKJQe8Ri/WR0i5AuSMaAb87C8/YtfXlAJ+kAyEHXZoYqU2k9ZYwr
         gTrReakYiFyGNm00yPw2zN3jINOKJA1flKIVneQjSBGqvQnNY92FmUarWe4FP//FY0IN
         vCng==
X-Gm-Message-State: AOAM532pdBhfv8iPuJ4MLuTloBWiWwjyMXvmfxaZYAYBK4yTPlJ6u7bc
        DR5fHlyOsgA9sXCes54Z+sk=
X-Google-Smtp-Source: ABdhPJyTU5x2EgEb3pLMsr2+wz5V+acWJ3AoNRqbdgiU3DWdydfNu1/Q0Xg5rkS99cLwUllGIaY/mA==
X-Received: by 2002:aa7:990a:0:b029:244:f35f:2b8e with SMTP id z10-20020aa7990a0000b0290244f35f2b8emr5948566pff.73.1617958483331;
        Fri, 09 Apr 2021 01:54:43 -0700 (PDT)
Received: from localhost.localdomain ([116.246.26.50])
        by smtp.gmail.com with ESMTPSA id o9sm1643988pjr.43.2021.04.09.01.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 01:54:42 -0700 (PDT)
From:   Youlin Song <syl.loop@gmail.com>
To:     robh+dt@kernel.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org
Cc:     devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Youlin Song <syl.loop@gmail.com>
Subject: [PATCH] [V2]powerpc/dts: fix not include DTC_FLAGS
Date:   Fri,  9 Apr 2021 16:51:35 +0800
Message-Id: <20210409085135.105821-1-syl.loop@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A central rule exists to create `$(obj)/%.dtb` from
`$(src)/%.dts`,DTC_FLAGS flag must be used with it.
See other architecture and Documentation:
arch/microblaze/boot/dts/Makefile
Documentation/kbuild/makefiles.rst +1433

Signed-off-by: Youlin Song <syl.loop@gmail.com>
---
 arch/powerpc/boot/Makefile     | 2 --
 arch/powerpc/boot/dts/Makefile | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 2b8da923ceca..a3bc3aec3c0c 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -72,8 +72,6 @@ endif
 
 BOOTCFLAGS	+= -I$(objtree)/$(obj) -I$(srctree)/$(obj)
 
-DTC_FLAGS	?= -p 1024
-
 $(obj)/4xx.o: BOOTCFLAGS += -mcpu=405
 $(obj)/ebony.o: BOOTCFLAGS += -mcpu=440
 $(obj)/cuboot-hotfoot.o: BOOTCFLAGS += -mcpu=405
diff --git a/arch/powerpc/boot/dts/Makefile b/arch/powerpc/boot/dts/Makefile
index fb335d05aae8..c21165c0cd76 100644
--- a/arch/powerpc/boot/dts/Makefile
+++ b/arch/powerpc/boot/dts/Makefile
@@ -2,5 +2,6 @@
 
 subdir-y += fsl
 
+DTC_FLAGS   ?= -p 1024
 dtstree		:= $(srctree)/$(src)
 dtb-$(CONFIG_OF_ALL_DTBS) := $(patsubst $(dtstree)/%.dts,%.dtb, $(wildcard $(dtstree)/*.dts))
-- 
2.25.1

