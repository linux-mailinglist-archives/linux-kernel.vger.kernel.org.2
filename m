Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7884A305938
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 12:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbhA0LHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 06:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234787AbhA0LGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 06:06:16 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC048C061573
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 03:05:32 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id u67so971262pfb.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 03:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=f0uhIYxEP5ACLreEqbTzuHdyKnahqQMCK2iaOeXStuE=;
        b=btrRant1sIf03uhv12RjQI0X/QiKi+FgI519vip/U3v42feIFdMnIzoYnOULiP+35/
         7riP0hml+kY1DxPQAeJakolmkDIPOosMGIkg6bxRMdK+RNBAF5lo0KWiX3x4W8An4wgJ
         ezZE7UaUlGCo57NqtpH65llxh5MLdyY3mEFoDgA1qS13rPRar9mtc9KNVeCXdEvFREsI
         6DmyfzmhY7HwFPpF9O2xNza4/ejHLsr8N/wgn4++85NxUN6OHI0kdsJGijajw70NITWB
         9G6BA3DlKw4dtnlaEedT9gVk/g1N3ApeWkuGnTvf4MoI2PlkVLFWiy3T0j1flvNh84Zt
         JBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=f0uhIYxEP5ACLreEqbTzuHdyKnahqQMCK2iaOeXStuE=;
        b=hepcygtg7Us1coVNE4SlLfU/348pWsKxyVsDgP79HsF0F5vwsVhGDYPKoHFCc1etrN
         EQiuknSg4dsWRx/c2t4Oer8jjlX2OocTE/4hB6mBsbgI9z4aakdOGjBU6KtjoH+vop1q
         kHmkov6/FHI6FvF0CaDrKWiiSxqa7amPskqigPjMxaBqbLCxoGXVA9u5UqFhbACB+GA6
         Br2AHimu7WTAMQ1j0Vj7XsY0T1rD0hChDVmKqH9ZrFE+ZyssNHwSzZyds7Kkw5h/bpP9
         vYjkJdy12qN+6nm5Wub3ua3EokwOPx8zShMwiBdY6xpQN01NQZD6BR3RsnPPxBtoTA9k
         Awpw==
X-Gm-Message-State: AOAM533MjiydblgGTTeMWFsFRyCOhxoMsHnOCgmSVpU8g+cMAdJNa/X1
        l33CJEOGFiNO5SpC4NdaO+8=
X-Google-Smtp-Source: ABdhPJzWvJDVcfQ1pXKDcsGk/OYJBVPeO0D0UYsnE8vQFikUGuNZI+SdRW1qVWMuczVGCeQ3sY2lhA==
X-Received: by 2002:a65:6152:: with SMTP id o18mr10783532pgv.392.1611745532399;
        Wed, 27 Jan 2021 03:05:32 -0800 (PST)
Received: from bj04616pcu01.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id o190sm2184433pga.2.2021.01.27.03.05.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jan 2021 03:05:31 -0800 (PST)
From:   Candle Sun <candlesea@gmail.com>
To:     keescook@chromium.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        natechancellor@gmail.com, ndesaulniers@google.com,
        candle.sun@unisoc.com, David.Laight@aculab.com,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH v2] lkdtm: fix memory copy size for WRITE_KERN
Date:   Wed, 27 Jan 2021 19:05:10 +0800
Message-Id: <20210127110510.24492-1-candlesea@gmail.com>
X-Mailer: git-send-email 2.17.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Candle Sun <candle.sun@unisoc.com>

Though do_overwritten() follows do_nothing() in source code, the final
memory address order is determined by compiler. We can't always assume
address of do_overwritten() is bigger than do_nothing(). At least the
Clang we are using places do_overwritten() before do_nothing() in the
object. This causes the copy size in lkdtm_WRITE_KERN() is *really*
big and WRITE_KERN test on ARM32 arch will fail.

Get absolute value of the address substraction for memcpy() size.

Signed-off-by: Candle Sun <candle.sun@unisoc.com>
---
Changes in v2:
- Use abs() in place of address comparison.
---
 drivers/misc/lkdtm/perms.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
index 2dede2ef658f..fbb7f4554054 100644
--- a/drivers/misc/lkdtm/perms.c
+++ b/drivers/misc/lkdtm/perms.c
@@ -31,13 +31,13 @@ static unsigned long ro_after_init __ro_after_init = 0x55AA5500;
  * This just returns to the caller. It is designed to be copied into
  * non-executable memory regions.
  */
-static void do_nothing(void)
+static noinline void do_nothing(void)
 {
 	return;
 }
 
 /* Must immediately follow do_nothing for size calculuations to work out. */
-static void do_overwritten(void)
+static noinline void do_overwritten(void)
 {
 	pr_info("do_overwritten wasn't overwritten!\n");
 	return;
@@ -113,7 +113,7 @@ void lkdtm_WRITE_KERN(void)
 	size_t size;
 	volatile unsigned char *ptr;
 
-	size = (unsigned long)do_overwritten - (unsigned long)do_nothing;
+	size = (size_t)abs((uintptr_t)do_overwritten - (uintptr_t)do_nothing);
 	ptr = (unsigned char *)do_overwritten;
 
 	pr_info("attempting bad %zu byte write at %px\n", size, ptr);
-- 
2.17.0

