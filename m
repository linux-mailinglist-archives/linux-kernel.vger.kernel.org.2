Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C683E534C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 08:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237755AbhHJGO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 02:14:26 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:58522
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230243AbhHJGOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 02:14:24 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPS id DA5E13F23A
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 06:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628576041;
        bh=MU763fmLMazZScBz9AM5kFRHaPtpqcj/azSfoVGQWxI=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=lpPKOAYV+61CRKH6jIEVaRh5S0+PWNA3Oh5u9wiK3TITIeYg/Wj3AJBkIOxlvuxVT
         Pb47SV/ikBm0NsRD5LoK33ln3hYT/48hTs9AvDOqUG3gMrpg66XyG2+Z3uacTV7Jei
         K2BTSyxtQzPPLyVuLKpzBpHPodogB0cZK6WMNQm/GUBb0y8Q5u1/OdXCb2eEyHmntw
         p/KyDO9CdOZvhE9IZDnivFlyVA3ugaXM+eu8mOYTl/InKfYNRYNnQsKzrKYWaE5QBt
         aelOppvHz14lDTaqq1mDZG4E9QlF5e+Ey1cOqjABTeqXrrdqFKEUVo0XnX7hnw/8ee
         JgPvT4FIVHT+A==
Received: by mail-wr1-f71.google.com with SMTP id m5-20020a5d6a050000b0290154e83dce73so1764536wru.19
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 23:14:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MU763fmLMazZScBz9AM5kFRHaPtpqcj/azSfoVGQWxI=;
        b=pykz0ufNnNgzsGjMS63+bRQUJT1TsMekVjrVAHF5WQOP7DxS7zV+Ld2SARegEriG1m
         i9it+FitfGb9n+CxSlOvZce5XNlBPPN0R0epqid4FXRp7jXxzzOhBsL51YRVCQyYmQ/2
         xSCCxXM2LNTqnfAJpVTXs7UrVVEBqBQfnb7DCUgQSAmX8Lc13SfUHCU9FxMlj12oTvQy
         lnCI4KlRz09luESInXYy1e1GAHVla93WXQwceDfJROesFDJDRgYowF5UPq+3SVL0rY1K
         M5uFOzr6LmzrItMMBseq+qLDwjrP0IJlLrY3QJ4bu2/vViPxQJ4H7t1r4tEnBcSC4mr4
         xwiA==
X-Gm-Message-State: AOAM533bUryEAoiwEHfpO8j+/aXBUv12WZVohyJmIl9hH5XKPpAnGnjs
        wDfp+c1Mxl8B9GK1SbYgOpUx09RuaQIHdk3B0XvOAkzRLcyV/E33W/uTRoXTksQA95DHKybNwc+
        QHWlL9xBCqQZM9ZMPBGJFLO0p6soM1RVYynF5ILf0TQ==
X-Received: by 2002:a7b:c7d1:: with SMTP id z17mr2817590wmk.50.1628576041458;
        Mon, 09 Aug 2021 23:14:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhBp7kqsbGZEA1dlKWoW0xLul7DAphDoiACSkpW5Vk2Une8bWIombRspvg8SL44s9TMrGitQ==
X-Received: by 2002:a7b:c7d1:: with SMTP id z17mr2817569wmk.50.1628576041270;
        Mon, 09 Aug 2021 23:14:01 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id h11sm14676563wrq.64.2021.08.09.23.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 23:14:00 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@canonical.com>
To:     linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: [PATCH] ARM: Fix instruction set selection for GCC 11
Date:   Tue, 10 Aug 2021 08:13:50 +0200
Message-Id: <20210810061350.754134-1-juergh@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC 11 on ARM now complains like the following when trying to determine if
an arch is supported. Presumably because it enforces the default option
'--with-float=hard' which GCC 10 didn't do?

  $ arm-linux-gnueabihf-gcc-11 -march=armv7-a -c -x c /dev/null
  cc1: error: ‘-mfloat-abi=hard’: selected architecture lacks an FPU

Due to that, the kernel build system selects the wrong compiler options
which throws errros like this during the build:

  /tmp/ccrHfZPj.s: Assembler messages:
  /tmp/ccrHfZPj.s:116: Error: selected processor does not support `dmb ish' in ARM mode
  /tmp/ccrHfZPj.s:150: Error: selected processor does not support `isb ' in ARM mode
  /tmp/ccrHfZPj.s:160: Error: selected processor does not support `mrrc p15,1,r4,r5,c14' in ARM mode
  /tmp/ccrHfZPj.s:245: Error: selected processor does not support `dmb ish' in ARM mode
  /tmp/ccrHfZPj.s:503: Error: selected processor does not support `dmb ish' in ARM mode
  /tmp/ccrHfZPj.s:527: Error: selected processor does not support `dmb ish' in ARM mode
  /tmp/ccrHfZPj.s:698: Error: selected processor does not support `dmb ish' in ARM mode
  /tmp/ccrHfZPj.s:731: Error: selected processor does not support `isb ' in ARM mode

Fix that by adding '-msoft-float' to KBUILD_CFLAGS before the definition of
the 'arch-$(CONFIG_CPU_<foo>)' instruction selection macros.

Signed-off-by: Juerg Haefliger <juergh@canonical.com>
---
 arch/arm/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 173da685a52e..d21198833997 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -56,6 +56,9 @@ endif
 #
 KBUILD_CFLAGS	+= $(call cc-option,-fno-ipa-sra)
 
+# Need -msoft-float for gcc 11 for the below instruction set selection
+KBUILD_CFLAGS	+= -msoft-float
+
 # This selects which instruction set is used.
 # Note that GCC does not numerically define an architecture version
 # macro, but instead defines a whole series of macros which makes
@@ -125,7 +128,7 @@ AFLAGS_ISA	:=$(CFLAGS_ISA)
 endif
 
 # Need -Uarm for gcc < 3.x
-KBUILD_CFLAGS	+=$(CFLAGS_ABI) $(CFLAGS_ISA) $(arch-y) $(tune-y) $(call cc-option,-mshort-load-bytes,$(call cc-option,-malignment-traps,)) -msoft-float -Uarm
+KBUILD_CFLAGS	+=$(CFLAGS_ABI) $(CFLAGS_ISA) $(arch-y) $(tune-y) $(call cc-option,-mshort-load-bytes,$(call cc-option,-malignment-traps,)) -Uarm
 KBUILD_AFLAGS	+=$(CFLAGS_ABI) $(AFLAGS_ISA) $(arch-y) $(tune-y) -include asm/unified.h -msoft-float
 
 CHECKFLAGS	+= -D__arm__
-- 
2.30.2

