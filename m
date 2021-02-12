Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E22E31A36A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 18:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbhBLRS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 12:18:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbhBLRSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 12:18:24 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FD3C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 09:17:44 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id n4so282023qte.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 09:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=c27ilmvc3s9n2liXWjp43qscJ0lbHohh395zb9zfzbs=;
        b=dlkmLNSBJy8zKv8IaBxW0+ujicbOu69bxOdMD3jdF6hfTmm6rkI+Dw+vcuqwfRAWxL
         VJpyogT3xjfA1kJ4Wt+D/7TTEwDighDT573mbJIeJ3jlB2w+hGkX1pWZKP6HHn2lBxca
         WB8waVNE4htDellxwZy34grQcNhrYri9oxOhOM1yWk1DH2QvK83E4HeOUkhdSFnX+Rjn
         4u/ANP4PYt2+8wseYdJv8G5aBgMWCf2JVhPPJvg6D4FFY74k13bA/1Q7/QnZzSR11EJ1
         wMJumSSsteELE5USPOQCqZ3FiqFniQIC0k8Tky18HSrNEz8F3CcZ0nVN7zCLv768EDys
         pXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=c27ilmvc3s9n2liXWjp43qscJ0lbHohh395zb9zfzbs=;
        b=Mu8wD1uBvA4Z1SE8Nkwu6vp1eQSBu2PBBz7DjQfefNewNp27hPygrunicF13Eu8IuH
         GCQ95mMgFG9vSKB2MnHoMtDzc+xLXHG0vGfvsIBRmWaXSGZj5990AP1aoEz481fttE6x
         Vi9Yoyee1j7cd+6tuq3IK38k5USMt408udY77SK6fdvLNhp1jZOWfRW0vGrha+Wy0uxY
         EoCEY/KCwLoofbNIiJqQl8n5rGv/mJcLgTiNuuP+s6h9MTlMomVy0pt3Fzgl9sJckWyb
         wp5cVfBmQ/XMIKfieb3O6oI/D+bjg25gpClrPH2jas0oR1lmbqMwwZDn4m404Qx8KLT5
         KNfA==
X-Gm-Message-State: AOAM532G9TrQmiErUFZiSgJ2Ho1MmNAUvu1TWZSzYIADqtkiq3FeSK90
        P0RZ2fmg3f4lH64u2ZcTGol7PAsivktVJgHl
X-Google-Smtp-Source: ABdhPJyBmTazozFSLoWm0G+XY3nGwr4nGozq4yLk3tv0DBpwEeuDlevknO4QOYn8WwVnVo+47oP81HQrStOkcuG1
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:19dd:6137:bedc:2fae])
 (user=andreyknvl job=sendgmr) by 2002:a0c:fdec:: with SMTP id
 m12mr3542611qvu.11.1613150263425; Fri, 12 Feb 2021 09:17:43 -0800 (PST)
Date:   Fri, 12 Feb 2021 18:17:37 +0100
Message-Id: <7f9771d97b34d396bfdc4e288ad93486bb865a06.1613150186.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH 1/3] MAINTAINERS: update KASAN file list
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Account for the following files:

- lib/Kconfig.kasan
- lib/test_kasan_module.c
- arch/arm64/include/asm/mte-kasan.h

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 MAINTAINERS | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 64c7169db617..a58e56f91ed7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9565,10 +9565,11 @@ R:	Dmitry Vyukov <dvyukov@google.com>
 L:	kasan-dev@googlegroups.com
 S:	Maintained
 F:	Documentation/dev-tools/kasan.rst
-F:	arch/*/include/asm/kasan.h
+F:	arch/*/include/asm/*kasan.h
 F:	arch/*/mm/kasan_init*
 F:	include/linux/kasan*.h
-F:	lib/test_kasan.c
+F:	lib/Kconfig.kasan
+F:	lib/test_kasan*.c
 F:	mm/kasan/
 F:	scripts/Makefile.kasan
 
-- 
2.30.0.478.g8a0d178c01-goog

