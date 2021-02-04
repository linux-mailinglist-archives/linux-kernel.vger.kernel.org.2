Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF56C30EA15
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 03:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234556AbhBDCWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 21:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234520AbhBDCWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 21:22:04 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57D5C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 18:21:23 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id e62so1921436yba.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 18:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=g/42xScXFf5XR9eMr0xLh0b+pVsAWUjZtArYlETXels=;
        b=n7ZfzsEU5707Jb8IFDf1sI6TC1bWTqzNHAeSUUfZo6+TTa4G+zkrE+jq7EeB9rXt8b
         bc8UrkS2HbhCKerZqsCgGukMrXyUy15p5GKBgj6kDkjwZ/Hjjxkv94K7l+CGf3FCnK5R
         S/HcjwlI2u5ouqdYw8+yKCGfqROfXbjDVF/5UYAAVWQRb5kMzKxfbFwMe3UokrSa2b9C
         q74Aw9KeYtT6BAab5JJuBH35KlcFsNmyNeeNMjrRbh8MmjL71ZTagaC7rpxW1sihQDPN
         jtqdSBf4q1Wfc6R4fr+qQKvlaMi34nkMhOAr+IgDgeJb6fATQdaFd2hxB1OWqjlcNlH2
         wE7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=g/42xScXFf5XR9eMr0xLh0b+pVsAWUjZtArYlETXels=;
        b=DxEYhzGOom6uw4SLAXXvI7D39xLBIFA266LW24kAaaiczKrXZCD5KP4zqHJ8OchfPg
         sDyN/OIscIH/oy+YPJjbVuRlO9H9dspV1ChU9aYEUcNOTn1kP5hUsyrrMKGDQUeXB2yh
         meyumwUXD+FZ0oVoFAnAJ2ZDpg233XR5FXQHQWzHA0WFnyEGMn7JVvMvUpsWbWNr+lcd
         6O94GvwCmDP4ihWyf0MBUJ30xB8y0NPHrKJLtGnAUNJm3w/U/wQvH5l6qwdXrZHj6uIz
         wdy3OzL2eyoH9ya9kIUvuq65JsP5UOoEFZ04BLlZrJaRZ/JwDmd8AFohoyBYLTUoYCqI
         e2qg==
X-Gm-Message-State: AOAM530ar9kZYNp80mBD05xndUY42clpNsG1N6Hs6RtG5z/bx0Ym4j6c
        IcZ5v4OREMKX9ahaA4sEp+Tqf2C/VlAc
X-Google-Smtp-Source: ABdhPJwu2ZA9n2+TLDL/NzAiymCCkQ4vvqclLSJOsQaXBxoEArD/6YeR3BBlGNb705W0/KCS8ThQ+e2pD+ec
Sender: "amistry via sendgmr" <amistry@nandos.syd.corp.google.com>
X-Received: from nandos.syd.corp.google.com ([2401:fa00:9:14:91f5:1565:43df:748a])
 (user=amistry job=sendgmr) by 2002:a25:8311:: with SMTP id
 s17mr8883399ybk.259.1612405283198; Wed, 03 Feb 2021 18:21:23 -0800 (PST)
Date:   Thu,  4 Feb 2021 13:21:09 +1100
Message-Id: <20210204132043.1.I2392cf11fb353d10459958100b69d93346fa167c@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH] x86: Add a prompt for HPET_EMULATE_RTC
From:   Anand K Mistry <amistry@google.com>
To:     x86@kernel.org
Cc:     Anand K Mistry <amistry@google.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This does two things:
1. Makes the option visible in menuconfig, allowing the user to easily
   disable this option
2. Allows olddefconfig to respoct the option if it is set in the old
   .config file

It's not clear exactly why the second consequence is true, but it
appears to be because when the conf tool reads the config file, it only
respects the existing setting if the option is "visible" (see
scripts/kconfig/symbol.c:381).

Signed-off-by: Anand K Mistry <amistry@google.com>
---

 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 21f851179ff0..28f814493c7b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -890,6 +890,7 @@ config HPET_TIMER
 
 config HPET_EMULATE_RTC
 	def_bool y
+	prompt "HPET RTC emulation"
 	depends on HPET_TIMER && (RTC=y || RTC=m || RTC_DRV_CMOS=m || RTC_DRV_CMOS=y)
 
 config APB_TIMER
-- 
2.30.0.365.g02bc693789-goog

